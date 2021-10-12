-- Lesson 1
-- Exercise 1
/* In my.cnf file >>
 * 	[client]
	user=root
	password=
 */

-- Exercise 2

show databases;
create DATABASE example;
use example;
create table users (id INT, name VARCHAR(40));
insert into users values (1, 'Ivan'), (2, 'Petya'), (3, 'Masha');

-- Exercise 3

/* In terminal >>
 * mysqldump example > C:\Users\"Vladislav Divak"\Desktop\GeekBrains\MySQL\myqsl_gb_local\exampledump.sql
 * mysql
 * CREATE DATABASE sample
 * exit
 * mysql sample<C:\Users\"Vladislav Divak"\Desktop\GeekBrains\MySQL\myqsl_gb_local\exampledump.sql
 * mysql
 * show databases
    -> ;
+--------------------+
| Database           |
+--------------------+
| example            |
| information_schema |
| mysql              |
| performance_schema |
| sample             |
| sys                |
+--------------------+
*/

-- Exercise 4
/* In terminal >>
 * mysqldump mysql help_keyword --where="true limit 100" > help_keyword_dump > C:\Users\"Vladislav Divak"\Desktop\GeekBrains\MySQL\myqsl_gb_local\help_keyword100_dump.sql
 */
