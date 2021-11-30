DROP DATABASE IF EXISTS green_fleet_management;
CREATE DATABASE green_fleet_management;
USE green_fleet_management;



DROP TABLE IF EXISTS powertrain;
CREATE TABLE powertrain (
  id SERIAL PRIMARY KEY,
  name VARCHAR(10) COMMENT 'Powertrain name',
  description VARCHAR(255) COMMENT 'Powertrain full description'
) COMMENT = 'Car powertrains';

INSERT INTO powertrain VALUES
(DEFAULT, 'BEV','Battery Electric Vehicles'),
(DEFAULT, 'PHEV','Plug-In Hybrid Electric Vehicles'),
(DEFAULT, 'HEV','Hybrid Electric Vehicles'),
(DEFAULT, 'CNG','Compressed Natural Gas Vehicles'),
(DEFAULT, 'LPG','Liquefied Petroleum Gas Vehicles'),
(DEFAULT, 'ICE','Internal Combustion Engine Vehicles');

DROP TABLE IF EXISTS car_models;
CREATE TABLE car_models (
  id SERIAL PRIMARY KEY,
  OEM VARCHAR(255) COMMENT 'Original Equipment Manufacturer - car manufacturer',
  model VARCHAR(255) COMMENT 'Car model',
  description VARCHAR(255) COMMENT 'Car model exact description',
  engine_power INT UNSIGNED COMMENT 'Car engine power in HP',
  `year` INT UNSIGNED COMMENT 'Car production year',
  powertrain_id BIGINT UNSIGNED NOT NULL COMMENT 'Car powertrain',
  fuel_consumption FLOAT UNSIGNED COMMENT 'Fuel consumption of car l/100km',
  energy_consumption FLOAT UNSIGNED COMMENT 'Energy consumption of car kWh/100km',
  INDEX index_OEM (OEM),
  INDEX index_model (model),
  INDEX index_powertrain_id_cm (powertrain_id),
  CONSTRAINT fk_powertrain_id_cm FOREIGN KEY (powertrain_id) REFERENCES powertrain (id)
) COMMENT = 'Car models';

INSERT INTO car_models VALUES
(DEFAULT, 'Kia', 'e-Niro', 'Kia e-Niro 150 kW Long Range', 204, 2020, 1, 0, 18.1),
(DEFAULT, 'Tesla', 'Model 3', 'Tesla Model 3 Long Range', 259, 2021, 1, 0, 15.4),
(DEFAULT, 'BMW', 'i3', 'BMW i3 Medium Range', 169, 2019, 1, 0, 17.4),
(DEFAULT, 'Renault', 'Megane', 'Renault Megane 250 HP', 250, 2019, 2, 5, 3.6),
(DEFAULT, 'Renault', 'Captur', 'Renault Captur 200 HP', 200, 2019, 2, 4.5, 3.3),
(DEFAULT, 'Renault', 'Captur 2.0', 'Renault Captur 2.0 200 HP', 200, 2020, 2, 4, 3.5),
(DEFAULT, 'Toyota', 'Corolla', 'Toyota Corolla HEV', 140, 2019, 3, 4.7, 0),
(DEFAULT, 'Kia', 'Niro', 'Kia Niro HEV', 200, 2020, 3, 5.6, 0),
(DEFAULT, 'Hyundai', 'Kona', 'Hyundai Kona HEV', 180, 2021, 3, 4.3, 0),
(DEFAULT, 'VW', 'Golf', 'VW Golf mega-cool CNG', 130, 2021, 4, 5, 0),
(DEFAULT, 'VW', 'Caddy', 'VW Caddy mega-cool CNG', 120, 2018, 4, 4.5, 0),
(DEFAULT, 'Skoda', 'Kamiq', 'Skoda Kamiq CNG', 150, 2019, 4, 4.5, 0),
(DEFAULT, 'Skoda', 'Fabia', 'Skoda Fabia LPG', 160, 2020, 5, 6, 0),
(DEFAULT, 'Renault', 'Clio', 'Renault Clio LPG', 190, 2020, 5, 6.7, 0),
(DEFAULT, 'VW', 'Polo', 'VW Polo mega-cool LPG', 200, 2021, 5, 5, 0),
(DEFAULT, 'VW', 'Passat', 'VW Passat mega-cool', 210, 2021, 6, 8, 0),
(DEFAULT, 'BMW', 'X5', 'BMW X5', 240, 2021, 6, 10.7, 0),
(DEFAULT, 'BMW', 'X3', 'BMW X3', 220, 2021, 6, 7.7, 0);

DROP TABLE IF EXISTS lease_co;
CREATE TABLE lease_co (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Leasing  company name'
) COMMENT = 'Leasing companies';

INSERT INTO lease_co VALUES
(DEFAULT, 'Audi/VW'),
(DEFAULT, 'AMD'),
(DEFAULT, 'Best LeaseCo'),
(DEFAULT, 'Worst LeaseCo'),
(DEFAULT, 'I am puppy');

DROP TABLE IF EXISTS lease_co_fleet;
CREATE TABLE lease_co_fleet (
  id SERIAL PRIMARY KEY,
  lease_co_id BIGINT UNSIGNED NOT NULL COMMENT 'Lease Co of the car',
  car_id BIGINT UNSIGNED NOT NULL COMMENT 'Lease Co of the car',
  leasing_duration INT UNSIGNED,
  mileage INT UNSIGNED,
  price FLOAT UNSIGNED COMMENT 'Leasing price without decimals',
  INDEX index_lease_co_id_lcf (lease_co_id),
  INDEX index_car_id_lcf (car_id),
  CONSTRAINT fk_lease_co_id_lcf FOREIGN KEY (lease_co_id) REFERENCES lease_co (id),
  CONSTRAINT fk_car_id_lcf FOREIGN KEY (car_id) REFERENCES car_models (id)
) COMMENT = 'Leasing companies';

INSERT INTO lease_co_fleet VALUES
(DEFAULT, 1, 1, 36, 30000, 500000), (DEFAULT, 1, 1, 60, 30000, 500000),(DEFAULT, 1, 1, 36, 60000, 500000), (DEFAULT, 1, 1, 60, 60000, 500000),
(DEFAULT, 1, 2, 36, 30000, 520000), (DEFAULT, 1, 2, 60, 30000, 520000),(DEFAULT, 1, 2, 36, 60000, 520000), (DEFAULT, 1, 2, 60, 60000, 520000),
(DEFAULT, 1, 3, 36, 30000, 530000), (DEFAULT, 1, 3, 60, 30000, 530000),(DEFAULT, 1, 3, 36, 60000, 530000), (DEFAULT, 1, 3, 60, 60000, 530000),
(DEFAULT, 1, 4, 36, 30000, 540000), (DEFAULT, 1, 4, 60, 30000, 540000),(DEFAULT, 1, 4, 36, 60000, 540000), (DEFAULT, 1, 4, 60, 60000, 540000),
(DEFAULT, 1, 5, 36, 30000, 550000), (DEFAULT, 1, 5, 60, 30000, 550000),(DEFAULT, 1, 5, 36, 60000, 550000), (DEFAULT, 1, 5, 60, 60000, 550000),
(DEFAULT, 2, 6, 36, 30000, 400000), (DEFAULT, 2, 6, 60, 30000, 400000),(DEFAULT, 2, 6, 36, 60000, 400000), (DEFAULT, 2, 6, 60, 60000, 400000),
(DEFAULT, 2, 7, 36, 30000, 400000), (DEFAULT, 2, 7, 60, 30000, 400000),(DEFAULT, 2, 7, 36, 60000, 400000), (DEFAULT, 2, 7, 60, 60000, 400000),
(DEFAULT, 2, 8, 36, 30000, 400000), (DEFAULT, 2, 8, 60, 30000, 400000),(DEFAULT, 2, 8, 36, 60000, 400000), (DEFAULT, 2, 8, 60, 60000, 400000),
(DEFAULT, 2, 9, 36, 30000, 400000), (DEFAULT, 2, 9, 60, 30000, 400000),(DEFAULT, 2, 9, 36, 60000, 400000), (DEFAULT, 2, 9, 60, 60000, 400000),
(DEFAULT, 2, 10, 36, 30000, 300000), (DEFAULT, 2, 10, 60, 30000, 300000),(DEFAULT, 2, 10, 36, 60000, 300000), (DEFAULT, 2, 10, 60, 60000, 300000),
(DEFAULT, 3, 11, 36, 30000, 300000), (DEFAULT, 3, 11, 60, 30000, 300000),(DEFAULT, 3, 11, 36, 60000, 300000), (DEFAULT, 3, 11, 60, 60000, 300000),
(DEFAULT, 3, 12, 36, 30000, 300000), (DEFAULT, 3, 12, 60, 30000, 300000),(DEFAULT, 3, 12, 36, 60000, 300000), (DEFAULT, 3, 12, 60, 60000, 300000),
(DEFAULT, 3, 13, 36, 30000, 300000), (DEFAULT, 3, 13, 60, 30000, 300000),(DEFAULT, 3, 13, 36, 60000, 300000), (DEFAULT, 3, 13, 60, 60000, 300000),
(DEFAULT, 3, 14, 36, 30000, 300000), (DEFAULT, 3, 14, 60, 30000, 300000),(DEFAULT, 3, 14, 36, 60000, 300000), (DEFAULT, 3, 14, 60, 60000, 300000),
(DEFAULT, 3, 15, 36, 30000, 300000), (DEFAULT, 3, 15, 60, 30000, 300000),(DEFAULT, 3, 15, 36, 60000, 300000), (DEFAULT, 3, 15, 60, 60000, 300000),
(DEFAULT, 4, 16, 36, 30000, 300000), (DEFAULT, 4, 16, 60, 30000, 300000),(DEFAULT, 4, 16, 36, 60000, 300000), (DEFAULT, 4, 16, 60, 60000, 300000),
(DEFAULT, 4, 17, 36, 30000, 300000), (DEFAULT, 4, 17, 60, 30000, 300000),(DEFAULT, 4, 17, 36, 60000, 300000), (DEFAULT, 4, 17, 60, 60000, 300000),
(DEFAULT, 4, 18, 36, 30000, 300000), (DEFAULT, 4, 18, 60, 30000, 300000),(DEFAULT, 4, 18, 36, 60000, 300000), (DEFAULT, 4, 18, 60, 60000, 300000),
(DEFAULT, 4, 1, 36, 30000, 460000), (DEFAULT, 4, 1, 60, 30000, 460000),(DEFAULT, 4, 1, 36, 60000, 460000), (DEFAULT, 4, 1, 60, 60000, 460000),
(DEFAULT, 4, 2, 36, 30000, 460000), (DEFAULT, 4, 2, 60, 30000, 460000),(DEFAULT, 4, 2, 36, 60000, 460000), (DEFAULT, 4, 2, 60, 60000, 460000),
(DEFAULT, 5, 3, 36, 30000, 460000), (DEFAULT, 5, 3, 60, 30000, 460000),(DEFAULT, 5, 3, 36, 60000, 460000), (DEFAULT, 5, 3, 60, 60000, 460000),
(DEFAULT, 5, 4, 36, 30000, 460000), (DEFAULT, 5, 4, 60, 30000, 460000),(DEFAULT, 5, 4, 36, 60000, 460000), (DEFAULT, 5, 4, 60, 60000, 460000),
(DEFAULT, 5, 16, 36, 30000, 700000), (DEFAULT, 5, 16, 60, 30000, 700000),(DEFAULT, 5, 16, 36, 60000, 700000), (DEFAULT, 5, 16, 60, 60000, 700000),
(DEFAULT, 5, 17, 36, 30000, 700000), (DEFAULT, 5, 17, 60, 30000, 700000),(DEFAULT, 5, 17, 36, 60000, 700000), (DEFAULT, 5, 17, 60, 60000, 700000),
(DEFAULT, 5, 18, 36, 30000, 700000), (DEFAULT, 5, 18, 60, 30000, 700000),(DEFAULT, 5, 18, 36, 60000, 700000), (DEFAULT, 5, 18, 60, 60000, 700000);

DROP TABLE IF EXISTS cch_bu;
CREATE TABLE cch_bu (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Business unit name'
) COMMENT = 'Business units';

INSERT INTO cch_bu VALUES
(1, 'Adria'),
(2, 'Austria'),
(3, 'Belarus'),
(4, 'Bulgaria'),
(5, 'Czech&Slovakia'),
(6, 'Greece&Cyprus'),
(7, 'Hungary'),
(8, 'IOI'),
(9, 'Italy'),
(10, 'Nigeria'),
(11, 'North Macedonia'),
(12, 'Poland&Baltics'),
(13, 'Romania'),
(14, 'Russia'),
(15, 'Serbia&Montenegro&Kosovo'),
(16, 'Switzerland'),
(17, 'Ukraine&Moldova&Armenia');

DROP TABLE IF EXISTS cch_regions;
CREATE TABLE cch_regions (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Regions name'
) COMMENT = 'Regions';

INSERT INTO cch_regions VALUES
(DEFAULT, 'Region 1'),
(DEFAULT, 'Region 2'),
(DEFAULT, 'Large BU');

DROP TABLE IF EXISTS cch_countries;
CREATE TABLE cch_countries (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Country name',
  bu_id BIGINT UNSIGNED NOT NULL COMMENT 'business unit',
  region_id BIGINT UNSIGNED NOT NULL COMMENT 'region',
  INDEX index_bu (bu_id),
  INDEX index_region (region_id),  
  CONSTRAINT fk_bu_id FOREIGN KEY (bu_id) REFERENCES cch_bu (id),
  CONSTRAINT fk_region_id FOREIGN KEY (region_id) REFERENCES cch_regions (id)
) COMMENT = 'CCH countries';

INSERT INTO cch_countries VALUES
(DEFAULT, 'Bosnia',1,2),
(DEFAULT, 'Croatia',1,2),
(DEFAULT, 'Slovenia',1,2),
(DEFAULT, 'Austria',2,1),
(DEFAULT, 'Belarus',3,1),
(DEFAULT, 'Bulgaria',4,2),
(DEFAULT, 'Czech Republic',5,1),
(DEFAULT, 'Czech&Slovakia',5,1),
(DEFAULT, 'Greece',6,2),
(DEFAULT, 'Cyprus',6,2),
(DEFAULT, 'Hungary',7,1),
(DEFAULT, 'Nothern Ireland',8,1),
(DEFAULT, 'Republic of Ireland',8,1),
(DEFAULT, 'Italy',9,3),
(DEFAULT, 'Nigeria',10,3),
(DEFAULT, 'North Macedonia',11,2),
(DEFAULT, 'Poland',12,1),
(DEFAULT, 'Estonia',12,1),
(DEFAULT, 'Latvia',12,1),
(DEFAULT, 'Lithuania',12,1),
(DEFAULT, 'Romania',13,2),
(DEFAULT, 'Russia',14,3),
(DEFAULT, 'Russia Multon',14,3),
(DEFAULT, 'Serbia',15,2),
(DEFAULT, 'Montenegro',15,2),
(DEFAULT, 'Kosovo',15,2),
(DEFAULT, 'Switzerland',16,1),
(DEFAULT, 'Ukraine',17,2),
(DEFAULT, 'Moldova',17,2),
(DEFAULT, 'Armenia',17,2);

DROP TABLE IF EXISTS cch_fleet_cat;
CREATE TABLE cch_fleet_cat (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Fleet Category name',
  `size` VARCHAR(255) COMMENT 'Car size'
) COMMENT = 'CCH fleet categories';

INSERT INTO cch_fleet_cat VALUES
(DEFAULT, 'Sales cars', 'Small'),
(DEFAULT, 'Sales cars', 'Medium'),
(DEFAULT, 'Sales cars', 'Large'),
(DEFAULT, 'Benefit cars', 'Small'),
(DEFAULT, 'Benefit cars', 'Medium'),
(DEFAULT, 'Benefit cars', 'Large'),
(DEFAULT, 'LCV cars', 'Small'),
(DEFAULT, 'LCV cars', 'Medium'),
(DEFAULT, 'LCV cars', 'Large'),
(DEFAULT, 'Own trucks', 'Small'),
(DEFAULT, 'Own trucks', 'Medium'),
(DEFAULT, 'Own trucks', 'Large'),
(DEFAULT, '3rd party trucks', 'Small'),
(DEFAULT, '3rd party trucks', 'Medium'),
(DEFAULT, '3rd party trucks', 'Large');

DROP TABLE IF EXISTS cch_fleet;
CREATE TABLE cch_fleet (
  id SERIAL PRIMARY KEY,
  country_id BIGINT UNSIGNED NOT NULL COMMENT 'CCH Country',
  category_id BIGINT UNSIGNED NOT NULL COMMENT 'Fleet category',
  lease_co_fleet_id BIGINT UNSIGNED NOT NULL COMMENT 'Car model of LeaseCo',
  licence_num VARCHAR(255) COMMENT 'Licence number',
  contract_start DATE,
  electricity_usage FLOAT COMMENT 'Electricity usage value from 0.0 to 1.0',
  INDEX index_country_id_cf (country_id),
  INDEX index_category_id_cf (category_id),
  INDEX index_lease_co_fleet_id_cf (lease_co_fleet_id),
  INDEX index_contract_start (contract_start),
  CONSTRAINT fk_country_id_cf FOREIGN KEY (country_id) REFERENCES cch_countries (id),
  CONSTRAINT fk_category_id_cf FOREIGN KEY (category_id) REFERENCES cch_fleet_cat (id),
  CONSTRAINT fk_lease_co_fleet_id_cf FOREIGN KEY (lease_co_fleet_id) REFERENCES lease_co_fleet (id)
) COMMENT = 'CCH fleet';

INSERT INTO cch_fleet VALUES
(DEFAULT, 1, 1, 1, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 2, 1, 2, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 3, 1, 3, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 4, 1, 4, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 5, 2, 5, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 6, 2, 7, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 7, 2, 8, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 8, 2, 9, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 9, 3, 10, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 10, 3, 11, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 1, 3, 12, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 2, 3, 13, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 3, 4, 14, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 4, 4, 15, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 5, 4, 16, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 6, 4, 17, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 7, 5, 18, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 8, 5, 19, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 9, 5, 20, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 10, 5, 21, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 1, 6, 22, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 2, 6, 23, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 3, 6, 24, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 4, 6, 25, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 5, 1, 26, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 6, 1, 27, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 7, 1, 28, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 8, 1, 29, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 9, 2, 30, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 10, 2, 31, 'XXX123X', '2020-11-01', 0),
(DEFAULT, 1, 2, 32, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 2, 2, 33, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 3, 3, 34, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 4, 3, 35, 'XXX123X', '2020-05-01', 0),
(DEFAULT, 5, 3, 36, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 6, 3, 37, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 7, 4, 38, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 8, 4, 39, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 9, 4, 40, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 10, 4, 41, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 1, 5, 42, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 2, 5, 43, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 3, 5, 44, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 4, 5, 45, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 5, 6, 46, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 6, 6, 47, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 7, 6, 48, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 8, 6, 49, 'XXX123X', '2020-07-01', 0),
(DEFAULT, 9, 1, 50, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 10, 1, 51, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 1, 1, 52, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 2, 1, 53, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 3, 2, 54, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 4, 2, 55, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 5, 2, 56, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 6, 2, 57, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 7, 3, 58, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 8, 3, 59, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 9, 3, 60, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 10, 3, 61, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 1, 4, 62, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 2, 4, 63, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 3, 4, 64, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 4, 4, 65, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 5, 5, 66, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 6, 5, 67, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 7, 5, 68, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 8, 5, 69, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 9, 6, 70, 'XXX123X', '2020-02-01', 0),
(DEFAULT, 10, 6, 71, 'XXX123X', '2020-11-01', 0),
(DEFAULT, 1, 6, 72, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 2, 6, 73, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 3, 1, 74, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 4, 1, 75, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 5, 1, 76, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 6, 1, 77, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 7, 2, 78, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 8, 2, 79, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 9, 2, 80, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 10, 2, 81, 'XXX123X', '2020-11-01', 0),
(DEFAULT, 1, 3, 82, 'XXX123X', '2020-03-01', 0),
(DEFAULT, 2, 3, 83, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 3, 3, 84, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 4, 3, 85, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 5, 4, 86, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 6, 4, 87, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 7, 4, 88, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 8, 4, 89, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 9, 5, 90, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 10, 5, 91, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 1, 5, 92, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 2, 5, 93, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 3, 6, 94, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 4, 6, 95, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 5, 6, 96, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 6, 6, 97, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 7, 6, 98, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 8, 1, 99, 'XXX123X', '2020-01-01', 0),
(DEFAULT, 9, 1, 100, 'XXX123X', '2020-01-01', 0);

DROP TABLE IF EXISTS lease_co_agreements;
CREATE TABLE lease_co_agreements(
  id SERIAL PRIMARY KEY,
  country_id BIGINT UNSIGNED NOT NULL COMMENT 'CCH Country',
  lease_co_id BIGINT UNSIGNED NOT NULL COMMENT 'Lease Co of the car',
  total_discount FLOAT UNSIGNED DEFAULT 0 COMMENT 'Discount value from 0.0 to 1.0',
  INDEX index_country_id (country_id),
  INDEX index_lease_co_id (lease_co_id),
  CONSTRAINT fk_country_id_lca FOREIGN KEY (country_id) REFERENCES cch_countries (id),
  CONSTRAINT fk_lease_co_id_lca FOREIGN KEY (lease_co_id) REFERENCES lease_co (id)
) COMMENT = 'Agreed discounts between CCH countries and LeaseCos';

INSERT INTO lease_co_agreements VALUES
(DEFAULT, 1, 1, 0.1),
(DEFAULT, 1, 2, 0.1),
(DEFAULT, 1, 3, 0.1),
(DEFAULT, 1, 4, 0.1),
(DEFAULT, 1, 5, 0.1),
(DEFAULT, 2, 1, 0.2),
(DEFAULT, 2, 2, 0.2),
(DEFAULT, 2, 3, 0.2),
(DEFAULT, 2, 4, 0.2),
(DEFAULT, 2, 5, 0.2),
(DEFAULT, 2, 1, 0.2),
(DEFAULT, 3, 1, 0.1),
(DEFAULT, 3, 2, 0.1),
(DEFAULT, 3, 3, 0.1);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
  id SERIAL PRIMARY KEY,
  country_id BIGINT UNSIGNED NOT NULL COMMENT 'CCH Country',
  lease_co_fleet_id BIGINT UNSIGNED NOT NULL COMMENT 'Car model of LeaseCo',
  lease_co_agreement_id BIGINT UNSIGNED NOT NULL,
  TCO INT UNSIGNED COMMENT 'TCO incl. fuel and VAT without decimals',
  volume INT UNSIGNED DEFAULT 1 COMMENT 'Number of ordered cars',
  order_date DATE,
  delivery_date DATE,
  INDEX index_country_id_o (country_id),
  INDEX index_lease_co_fleet_id_o (lease_co_fleet_id),
  INDEX index_lease_co_agreement_id_o (lease_co_agreement_id),
  INDEX index_order_date (order_date),
  INDEX index_delivery_date (delivery_date),
  CONSTRAINT fk_country_id_o FOREIGN KEY (country_id) REFERENCES cch_countries (id),
  CONSTRAINT fk_lease_co_fleet_id_o FOREIGN KEY (lease_co_fleet_id) REFERENCES lease_co_fleet (id),
  CONSTRAINT fk_lease_co_agreement_id_o FOREIGN KEY (lease_co_agreement_id) REFERENCES lease_co_agreements (id)
) COMMENT = 'Orders of cars';

INSERT INTO orders VALUES
(DEFAULT, 1, 10, 1, 800000, 10, '2022-01-01', '2022-03-01'),
(DEFAULT, 2, 20, 6, 820000, 11, '2022-01-01', '2022-03-01'),
(DEFAULT, 3, 30, 11, 830000, 12, '2022-01-01', '2022-03-01'),
(DEFAULT, 4, 40, 1, 840000, 13, '2022-01-01', '2022-03-01'),
(DEFAULT, 5, 50, 1, 850000, 14, '2022-01-01', '2022-03-01'),
(DEFAULT, 6, 60, 1, 860000, 15, '2022-01-01', '2022-03-01'),
(DEFAULT, 7, 70, 1, 870000, 16, '2022-01-01', '2022-03-01'),
(DEFAULT, 8, 80, 1, 880000, 17, '2022-01-01', '2022-03-01'),
(DEFAULT, 9, 90, 1, 890000, 18, '2022-01-01', '2022-03-01'),
(DEFAULT, 10, 15, 1, 900000, 19, '2022-01-01', '2022-03-01'),
(DEFAULT, 11, 10, 1, 800000, 10, '2022-01-01', '2022-03-01'),
(DEFAULT, 12, 20, 1, 820000, 11, '2022-01-01', '2022-03-01'),
(DEFAULT, 13, 30, 1, 830000, 12, '2022-01-01', '2022-03-01'),
(DEFAULT, 14, 40, 1, 840000, 13, '2022-01-01', '2022-03-01'),
(DEFAULT, 15, 50, 1, 850000, 14, '2022-01-01', '2022-03-01'),
(DEFAULT, 16, 60, 1, 860000, 15, '2022-01-01', '2022-03-01'),
(DEFAULT, 17, 70, 1, 870000, 16, '2022-01-01', '2022-03-01'),
(DEFAULT, 18, 80, 1, 880000, 17, '2022-01-01', '2022-03-01'),
(DEFAULT, 19, 90, 1, 890000, 18, '2022-01-01', '2022-03-01'),
(DEFAULT, 20, 15, 1, 900000, 19, '2022-01-01', '2022-03-01'),
(DEFAULT, 21, 10, 1, 800000, 10, '2022-01-01', '2022-03-01'),
(DEFAULT, 22, 20, 1, 820000, 11, '2022-01-01', '2022-03-01'),
(DEFAULT, 23, 30, 1, 830000, 12, '2022-01-01', '2022-03-01'),
(DEFAULT, 24, 40, 1, 840000, 13, '2022-01-01', '2022-03-01'),
(DEFAULT, 25, 50, 1, 850000, 14, '2022-01-01', '2022-03-01'),
(DEFAULT, 26, 60, 1, 860000, 15, '2022-01-01', '2022-03-01'),
(DEFAULT, 27, 70, 1, 870000, 16, '2022-01-01', '2022-03-01'),
(DEFAULT, 28, 80, 1, 880000, 17, '2022-01-01', '2022-03-01'),
(DEFAULT, 29, 90, 1, 890000, 18, '2022-01-01', '2022-03-01'),
(DEFAULT, 30, 15, 1, 900000, 19, '2022-01-01', '2022-03-01');

DROP TABLE IF EXISTS co2_emissions_factors;
CREATE TABLE co2_emissions_factors (
  id SERIAL PRIMARY KEY,
  powertrain_id BIGINT UNSIGNED NOT NULL COMMENT 'Powertrain',
  emissions FLOAT UNSIGNED COMMENT 'Emissions kg CO2/l',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX index_powertrain_id_cef (powertrain_id),
  CONSTRAINT fk_powertrain_id_cef FOREIGN KEY (powertrain_id) REFERENCES powertrain (id)
) COMMENT = 'CO2 Emissions Factors for fuel cars';

INSERT INTO co2_emissions_factors VALUES
(DEFAULT, 2, 2.271432, now()),
(DEFAULT, 3, 2.271432, now()),
(DEFAULT, 4, 2.846112, now()),
(DEFAULT, 5, 1.611, now()),
(DEFAULT, 6, 2.676394, now());

DROP TABLE IF EXISTS co2_emissions_electric_grid;
CREATE TABLE co2_emissions_electric_grid (
  id SERIAL PRIMARY KEY,
  country_id BIGINT UNSIGNED NOT NULL COMMENT 'CCH Country',
  electric_grid FLOAT UNSIGNED COMMENT 'Emissions kg CO2/kWh',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX index_country_id_ceeg (country_id),
  CONSTRAINT fk_country_id_ceeg FOREIGN KEY (country_id) REFERENCES cch_countries (id)
) COMMENT = 'CO2 Emissions Factors for electric cars';

INSERT INTO co2_emissions_electric_grid VALUES
(DEFAULT, 1, 0.208, now()),
(DEFAULT, 2, 0.308, now()),
(DEFAULT, 3, 0.408, now()),
(DEFAULT, 4, 0.208, now()),
(DEFAULT, 5, 0.308, now()),
(DEFAULT, 6, 0.408, now()),
(DEFAULT, 7, 0.218, now()),
(DEFAULT, 8, 0.218, now()),
(DEFAULT, 9, 0.218, now()),
(DEFAULT, 10, 0.308, now()),
(DEFAULT, 11, 0.208, now()),
(DEFAULT, 12, 0.218, now()),
(DEFAULT, 13, 0.228, now()),
(DEFAULT, 14, 0.238, now()),
(DEFAULT, 15, 0.248, now()),
(DEFAULT, 16, 0.258, now()),
(DEFAULT, 17, 0.268, now()),
(DEFAULT, 18, 0.278, now()),
(DEFAULT, 19, 0.288, now()),
(DEFAULT, 20, 0.298, now()),
(DEFAULT, 21, 0.108, now()),
(DEFAULT, 22, 0.128, now()),
(DEFAULT, 23, 0.228, now()),
(DEFAULT, 24, 0.238, now()),
(DEFAULT, 25, 0.218, now()),
(DEFAULT, 26, 0.248, now()),
(DEFAULT, 27, 0.258, now()),
(DEFAULT, 28, 0.268, now()),
(DEFAULT, 29, 0.288, now()),
(DEFAULT, 30, 0.208, now());

DROP TABLE IF EXISTS job_grades;
CREATE TABLE job_grades (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
) COMMENT = 'Drivers job grades';

INSERT INTO job_grades VALUES
(DEFAULT, 'JG1'),
(DEFAULT, 'JG2'),
(DEFAULT, 'JG3'),
(DEFAULT, 'JG4'),
(DEFAULT, 'JG5'),
(DEFAULT, 'JG6'),
(DEFAULT, 'JG7'),
(DEFAULT, 'JG8'),
(DEFAULT, 'JG9'),
(DEFAULT, 'JG10'),
(DEFAULT, 'JG11'),
(DEFAULT, 'JG12'),
(DEFAULT, 'JG13'),
(DEFAULT, 'JG14'),
(DEFAULT, 'JG15'),
(DEFAULT, 'JG16'),
(DEFAULT, 'JG17'),
(DEFAULT, 'JG18'),
(DEFAULT, 'JG19'),
(DEFAULT, 'JG20');

DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  job_grade_id BIGINT UNSIGNED NOT NULL COMMENT 'Drivers job grade',
  country_id BIGINT UNSIGNED NOT NULL COMMENT 'CCH Country',
  city VARCHAR(255),
  INDEX index_job_grade_id (job_grade_id),
  INDEX index_country_id_d (country_id),
  CONSTRAINT fk_job_grade_id FOREIGN KEY (job_grade_id) REFERENCES job_grades (id),
  CONSTRAINT fk_country_id_d FOREIGN KEY (country_id) REFERENCES cch_countries (id)
) COMMENT = 'CCH drivers';

INSERT INTO drivers (first_name, last_name, job_grade_id, country_id, city) VALUES
  ("Quemby","Gould",4,21,"Doñihue"),
  ("Kylan","Craft",19,29,"Port Blair"),
  ("Wyatt","Woodward",18,9,"Yeosu"),
  ("Myra","Wiley",11,23,"Belfast"),
  ("Nissim","Harrell",1,24,"Puno"),
  ("Hyacinth","Webb",12,27,"Rajanpur"),
  ("Noble","Preston",10,28,"Antofagasta"),
  ("Alisa","Kent",7,25,"Chulucanas"),
  ("Brady","Johnston",13,8,"Terme"),
  ("Martina","Dawson",15,10,"Santa Rita"),
  ("Donovan","Whitney",19,28,"Guizhou"),
  ("Margaret","Kim",1,25,"Alès"),
  ("Hermione","Jenkins",5,25,"Campotosto"),
  ("Kadeem","Becker",2,23,"Cork"),
  ("Lamar","Vega",7,13,"Puntarenas"),
  ("Wayne","Shepard",4,16,"Gravataí"),
  ("Grady","Mcintyre",9,26,"Vị Thanh"),
  ("Jermaine","Cotton",16,4,"Yogyakarta"),
  ("Sharon","Simmons",10,24,"Valenciennes"),
  ("Bo","Greene",4,23,"Ajaccio");
  
DROP TABLE IF EXISTS usage_by_drivers;
CREATE TABLE usage_by_drivers (
  id SERIAL PRIMARY KEY,
  driver_id BIGINT UNSIGNED NOT NULL,
  cch_car_id BIGINT UNSIGNED NOT NULL,
  starting_date DATE,
  end_date DATE,
  INDEX index_driver_id_ubd (driver_id),
  INDEX index_cch_car_id_ubd (cch_car_id),
  CONSTRAINT fk_driver_id_ubd FOREIGN KEY (driver_id) REFERENCES drivers (id),
  CONSTRAINT fk_cch_car_id_ubd FOREIGN KEY (cch_car_id) REFERENCES cch_fleet (id)  
) COMMENT = 'Usage of cars by drivers';

INSERT INTO usage_by_drivers VALUES
(DEFAULT, 1, 1, now(), now()),
(DEFAULT, 2, 2, now(), now()),
(DEFAULT, 3, 3, now(), now()),
(DEFAULT, 4, 4, now(), now()),
(DEFAULT, 5, 5, now(), now()),
(DEFAULT, 6, 6, now(), now()),
(DEFAULT, 7, 7, now(), now()),
(DEFAULT, 8, 8, now(), now()),
(DEFAULT, 9, 9, now(), now()),
(DEFAULT, 10, 10, now(), now());

DROP TABLE IF EXISTS training_types;
CREATE TABLE training_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
) COMMENT = 'Drivers training types';

INSERT INTO training_types VALUES
(DEFAULT, 'Classroom'),
(DEFAULT, 'E-learning'),
(DEFAULT, 'On-road');

DROP TABLE IF EXISTS drivers_trainings;
CREATE TABLE drivers_trainings (
  id SERIAL PRIMARY KEY,
  driver_id BIGINT UNSIGNED NOT NULL,
  training_type_id BIGINT UNSIGNED NOT NULL,
  training_date DATE,
  INDEX index_driver_id_dt (driver_id),
  INDEX index_training_type_id (training_type_id),
  CONSTRAINT fk_driver_id_dt FOREIGN KEY (driver_id) REFERENCES drivers (id),
  CONSTRAINT fk_training_type_id FOREIGN KEY (training_type_id) REFERENCES training_types (id)  
) COMMENT = 'Drivers completed training';

INSERT INTO drivers_trainings VALUES
(DEFAULT, 1, 1, now()),
(DEFAULT, 2, 1, now()),
(DEFAULT, 3, 1, now()),
(DEFAULT, 4, 1, now()),
(DEFAULT, 5, 1, now()),
(DEFAULT, 6, 1, now()),
(DEFAULT, 7, 1, now()),
(DEFAULT, 8, 1, now()),
(DEFAULT, 9, 1, now()),
(DEFAULT, 11, 2, now()),
(DEFAULT, 12, 2, now()),
(DEFAULT, 13, 2, now()),
(DEFAULT, 14, 2, now()),
(DEFAULT, 15, 2, now()),
(DEFAULT, 16, 2, now()),
(DEFAULT, 17, 2, now()),
(DEFAULT, 18, 2, now()),
(DEFAULT, 19, 2, now());


DROP TABLE IF EXISTS accidents;
CREATE TABLE accidents (
  id SERIAL PRIMARY KEY,
  driver_id BIGINT UNSIGNED NOT NULL,
  cch_car_id BIGINT UNSIGNED NOT NULL,
  if_accident BOOL COMMENT '0 or 1 if it is T1&T3 accident',
  if_crash BOOL COMMENT '0 or 1 if it is crash',
  accident_date DATE,
  description VARCHAR(255),
  damage_cost FLOAT UNSIGNED,
  INDEX index_driver_id_a (driver_id),
  INDEX index_cch_car_id_a (cch_car_id),
  CONSTRAINT fk_driver_id_a FOREIGN KEY (driver_id) REFERENCES drivers (id),
  CONSTRAINT fk_cch_car_id_a FOREIGN KEY (cch_car_id) REFERENCES cch_fleet (id)  
) COMMENT = 'Accidents';

INSERT INTO accidents VALUES
(DEFAULT, 1, 1, 1, 0, now(), 'Small bump n the left side', 500),
(DEFAULT, 2, 2, 0, 1, now(), 'Big crash', 5000);

DROP TABLE IF EXISTS fleet_performance;
CREATE TABLE fleet_performance (
  id SERIAL PRIMARY KEY,
  `month` VARCHAR(15),
  `year` INT,
  cch_car_id BIGINT UNSIGNED NOT NULL,
  fuel_consumed FLOAT UNSIGNED,
  electricity_consumed FLOAT UNSIGNED,
  km_driven INT UNSIGNED,
  INDEX index_month (`month`),
  INDEX index_year (`year`),
  INDEX index_cch_car_id_fp (cch_car_id),
  CONSTRAINT fk_cch_car_id_fp FOREIGN KEY (cch_car_id) REFERENCES cch_fleet (id)  
) COMMENT = 'Fleet performance on a monthly basis';

INSERT INTO fleet_performance VALUES
(DEFAULT, 1, 2021, 1, 0, 5000, 1000),
(DEFAULT, 1, 2021, 2, 0, 5000, 1010),
(DEFAULT, 1, 2021, 3, 0, 5000, 1020),
(DEFAULT, 1, 2021, 4, 0, 5000, 1030),
(DEFAULT, 1, 2021, 5, 0, 5000, 1040),
(DEFAULT, 1, 2021, 6, 0, 5000, 1050),
(DEFAULT, 1, 2021, 7, 0, 5000, 1060),
(DEFAULT, 1, 2021, 8, 0, 5000, 1070),
(DEFAULT, 1, 2021, 9, 0, 5000, 1080),
(DEFAULT, 1, 2021, 10, 0, 5000, 1100),
(DEFAULT, 1, 2021, 11, 0, 5000, 1200),
(DEFAULT, 1, 2021, 12, 0, 5000, 1000),
(DEFAULT, 1, 2021, 13, 110, 500, 1000),
(DEFAULT, 1, 2021, 14, 110, 500, 1000),
(DEFAULT, 1, 2021, 15, 110, 500, 1000),
(DEFAULT, 1, 2021, 16, 110, 500, 1000),
(DEFAULT, 1, 2021, 17, 110, 500, 1000),
(DEFAULT, 1, 2021, 18, 110, 500, 1000),
(DEFAULT, 1, 2021, 19, 110, 500, 1000),
(DEFAULT, 1, 2021, 20, 110, 500, 1000);









