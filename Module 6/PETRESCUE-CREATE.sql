update pg_database set encoding = pg_char_to_encoding('UTF8')

drop table if exists PETRESCUE;

create table PETRESCUE (
	ID INTEGER NOT NULL,
	ANIMAL VARCHAR(20),
	QUANTITY INTEGER,
	COST DECIMAL(6,2),
	RESCUEDATE DATE,
	PRIMARY KEY (ID)
	);

insert into PETRESCUE values 
	(1,'Cat',9,450.09,'2018-05-29'),
	(2,'Dog',3,666.66,'2018-06-01'),
	(3,'Dog',1,100.00,'2018-06-04'),
	(4,'Parrot',2,50.00,'2018-06-04'),
	(5,'Dog',1,75.75,'2018-06-10'),
	(6,'Hamster',6,60.60,'2018-06-11'),
	(7,'Cat',1,44.44,'2018-06-11'),
	(8,'Goldfish',24,48.48,'2018-06-14'),
	(9,'Dog',2,222.22,'2018-06-15')
;

SELECT SUM(COST) FROM PETRESCUE;

SELECT MAX(QUANTITY) FROM PETRESCUE;

SELECT MIN(QUANTITY) FROM PETRESCUE;

SELECT AVG(COST) FROM PETRESCUE;

SELECT ROUND(COST, 0) FROM PETRESCUE;

SELECT ROUND(COST, 2) FROM PETRESCUE;

SELECT animal, LENGTH(ANIMAL) FROM PETRESCUE;
/*UCASE = SELECT UCASE(ANIMAL) FROM PETRESCUE */
SELECT UPPER(ANIMAL) FROM PETRESCUE;
/*LCASE = SELECT LCASE(ANIMAL) FROM PETRESCUE */
SELECT LOWER(ANIMAL) FROM PETRESCUE;

/*DAY = SELECT DAY(RESCUEDATE) FROM PETRESCUE  */
SELECT EXTRACT(DAY FROM RESCUEDATE) as Days FROM PETRESCUE;
/*MONTH = SELECT MONTH(RESCUEDATE) FROM PETRESCUE  */
SELECT EXTRACT(MONTH FROM RESCUEDATE) as Months FROM PETRESCUE;
/*YEAR = SELECT YEAR(RESCUEDATE) FROM PETRESCUE */
SELECT EXTRACT(YEAR FROM RESCUEDATE) as Years FROM PETRESCUE;

/* Los animales rescatados deben ver al veterinario dentro de los tres días posteriores a su llegada. Escribe una consulta que muestre el tercer día de cada rescate.
SELECT DATE_ADD(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE*/
select rescuedate + interval '3 days' from petrescue;

/* Si la pregunta era añadir 2 meses a la fecha, la consulta cambiaría a
SELECT DATE_ADD(RESCUEDATE, INTERVAL 2 MONTH) FROM PETRESCUE */
select rescuedate + interval '2 months' from petrescue;

/*  la siguiente consulta proporcionaría la fecha 3 días antes del rescate.
SELECT DATE_SUB(RESCUEDATE, INTERVAL 3 DAY) FROM PETRESCUE*/
select rescuedate - interval '3 days' from petrescue;

/* Escribe una consulta que muestre la duración del tiempo que los animales han sido rescatados, por ejemplo, la diferencia entre la fecha actual y la fecha de rescate
SELECT DATEDIFF(CURRENT_DATE, RESCUEDATE) FROM PETRESCUE*/
select current_date - rescuedate as Rescue_Date from petrescue;

select  as today, rescuedate from petrescue;

SELECT TO_DATE('30/03/2019', 'DD/MM/YYYY');

select (current_date::date) - (rescuedate::date) from petrescue;

/*SELECT FROM_DAYS(DATEDIFF(CURRENT_DATE, RESCUEDATE)) FROM PETRESCUE*/
select extract((current_date::date) - (rescuedate::date)) from petrescue;

