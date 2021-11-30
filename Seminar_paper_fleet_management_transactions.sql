USE green_fleet_management;

-- Выборка всех автомобилей по странам с лизинговыми данными, контракт по котрым заканчивается в течении слеующих 3-х лет

SELECT cc.name, p.name, CONCAT(cm.OEM, ' ', cm.model) AS car_model, 
cf.contract_start , lcf.leasing_duration, 
lcf.mileage, lcf.price FROM cch_fleet cf 
JOIN cch_countries cc ON cf.country_id = cc.id
JOIN lease_co_fleet lcf ON cf.lease_co_fleet_id = lcf.id 
JOIN car_models cm ON cm.id = lcf.car_id 
JOIN powertrain p ON cm.powertrain_id = p.id 
WHERE datediff(DATE_ADD(cf.contract_start, INTERVAL lcf.leasing_duration MONTH), NOW()) < 3*365
ORDER BY cc.name, p.name;

-- Выборка лучших 3 неэлектрических моделей авто по показателю кг СО2 на 100 км

SELECT CONCAT(cm.OEM, ' ', cm.model) AS car_model, round(cm.fuel_consumption * cef.emissions, 2) AS emissions_100km
FROM car_models cm, powertrain p, co2_emissions_factors cef 
WHERE p.id = cm.powertrain_id AND p.id = cef.powertrain_id AND 
(p.name = 'BEV' OR p.name = 'HEV' OR p.name = 'ICE')
ORDER BY emissions_100km
LIMIT 3;

-- Выборка с подсчётом количества авто в компании по категориям
	
SELECT COUNT(*) AS cnt, (SELECT CONCAT(name, ' ', `size` ) FROM cch_fleet_cat cfc WHERE id = cf.category_id) AS car_category
FROM cch_fleet cf GROUP BY cf.category_id;

-- Имена сотрудников компании, которые пользовались авто без CONCAT(d.first_name, ' ', d.last_name) 
-- прохождения тренинга и имена сотрудников, прошедших тренинг, но не воспользовались авто

SELECT CONCAT(d.first_name, ' ', d.last_name) FROM drivers d 
JOIN usage_by_drivers ubd ON d.id = ubd.driver_id 
LEFT JOIN drivers_trainings dt ON d.id = dt.driver_id
WHERE dt.driver_id IS NULL
UNION
SELECT CONCAT(d.first_name, ' ', d.last_name) FROM drivers d
LEFT JOIN usage_by_drivers ubd ON d.id = ubd.driver_id 
JOIN drivers_trainings dt ON d.id = dt.driver_id
WHERE ubd.driver_id IS NULL;

-- Представление всех автомобилей по всем странам компании

CREATE OR REPLACE VIEW view_cch_cars AS
SELECT cc.name AS country, p.name AS powertrain, cm.OEM, cm.model, cm.fuel_consumption, cm.energy_consumption,
cf.contract_start, lcf.leasing_duration, lcf.mileage, lcf.price FROM cch_fleet cf 
JOIN cch_countries cc ON cf.country_id = cc.id
JOIN lease_co_fleet lcf ON cf.lease_co_fleet_id = lcf.id 
JOIN car_models cm ON cm.id = lcf.car_id 
JOIN powertrain p ON cm.powertrain_id = p.id 
ORDER BY cc.name, p.name;

SELECT * FROM view_cch_cars;

-- Представление сотрудников компании и использованных авто

CREATE OR REPLACE VIEW view_cch_cars_usage AS
SELECT cc.name AS country, CONCAT(d.first_name, ' ', d.last_name) AS driver, 
CONCAT(cm.OEM, ' ', cm.model) AS car,
ubd.starting_date, ubd.end_date FROM drivers d
JOIN usage_by_drivers ubd ON d.id = ubd.driver_id 
JOIN cch_fleet cf ON cf.id = ubd.cch_car_id
JOIN cch_countries cc ON cc.id = cf.country_id 
JOIN lease_co_fleet lcf ON cf.lease_co_fleet_id = lcf.id 
JOIN car_models cm ON lcf.car_id = cm.id;

SELECT * FROM view_cch_cars_usage;

-- Процедура сбора информации по использованию автопарка с рассчётом общих выбросов СО2

DROP PROCEDURE IF EXISTS sp_fleet_performance;

DELIMITER //

CREATE PROCEDURE sp_fleet_performance(IN reporting_month BIGINT UNSIGNED, reporting_year BIGINT UNSIGNED)
BEGIN
	SELECT fp.`month`, fp.`year`, cc.name AS country, CONCAT(cm.OEM, ' ', cm.model) AS car, p.name,
	fp.fuel_consumed, fp.electricity_consumed, fp.km_driven,
	ROUND(ceeg.electric_grid*fp.electricity_consumed + IF(cef.emissions IS NULL, 0, cef.emissions)*fp.fuel_consumed,3) AS total_emissions
	FROM fleet_performance fp 
	JOIN cch_fleet cf ON cf.id = fp.cch_car_id 
	JOIN cch_countries cc ON cc.id = cf.country_id 
	JOIN lease_co_fleet lcf ON cf.lease_co_fleet_id = lcf.id 
	JOIN car_models cm ON lcf.car_id = cm.id
	JOIN powertrain p ON p.id = cm.powertrain_id
	LEFT JOIN co2_emissions_electric_grid ceeg ON ceeg.country_id = cc.id 
	LEFT JOIN co2_emissions_factors cef ON cef.powertrain_id = p.id
	WHERE fp.`month` = reporting_month AND fp.`year` = reporting_year;
END//

DELIMITER ;

CALL sp_fleet_performance(1, 2021);


-- Процедура рассчёта состава автопарка на будущее с учётом даты поставки заказанных автомобилей

DROP PROCEDURE IF EXISTS sp_future_fleet;

DELIMITER //

CREATE PROCEDURE sp_future_fleet(IN for_date DATE, for_country VARCHAR(255))
BEGIN
	SELECT * FROM view_cch_cars
	WHERE DATE_ADD(contract_start, INTERVAL leasing_duration MONTH) > for_date
	AND country = for_country
	UNION
	SELECT cc.name AS country, p.name AS powertrain, cm.OEM, cm.model, cm.fuel_consumption, cm.energy_consumption,
	o.order_date , lcf.leasing_duration, lcf.mileage, lcf.price FROM orders o 
	JOIN cch_countries cc ON o.country_id = cc.id
	JOIN lease_co_fleet lcf ON o.lease_co_fleet_id = lcf.id 
	JOIN car_models cm ON cm.id = lcf.car_id 
	JOIN powertrain p ON cm.powertrain_id = p.id
	WHERE o.delivery_date < for_date
	AND DATE_ADD(o.delivery_date, INTERVAL lcf.leasing_duration MONTH) > for_date
	AND cc.name = for_country;
END//

DELIMITER ;

CALL sp_future_fleet('2023-01-01', 'Austria');

-- Триггер для контроля ввода данных по расходу топлива

DROP TRIGGER IF EXISTS check_fuel_energy;

DELIMITER //

CREATE TRIGGER check_fuel_energy BEFORE INSERT ON car_models
FOR EACH ROW
BEGIN 
	IF NEW.fuel_consumption IS NULL AND NEW.energy_consumption IS NULL THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. The car must consume fuel or energy!';
	END IF;
END//

DELIMITER ;

INSERT INTO car_models VALUES 
(DEFAULT, 'BMW', 'i8', 'BMW i8 electric', '300', '2021', 1, NULL, NULL);
