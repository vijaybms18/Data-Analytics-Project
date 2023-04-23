## creation of database
create database my_data;
use my_data;

## posing rules to reflect the changes in the dashboard
UPDATE insurance
SET sex = 
    CASE 
        WHEN sex = 'male' THEN 'female' 
        ELSE sex 
    END;


## posing rules to reflect the changes in the dashboard
UPDATE insurance
SET children = 
    CASE 
        WHEN age < 30 THEN 0
        WHEN age BETWEEN 30 AND 40 THEN 1
        ELSE children 
    END;


    ## addition of data into the existing table
    INSERT INTO 
	insurance ( age , sex , bmi , children , smoker , region , expenses )
    values ( 30, 'female' , 36 , 1 ,  'no' , 'northwest' , 1997),
    ( 25, 'female' , 31 , 0,  'yes' , 'southwest' , 14663),
    ( 23, 'male' , 29 , 1 ,  'no' , 'northeast' , 2124),
    ( 29, 'male' , 29 , 0 ,  'no' , 'southeast' , 1798),
    ( 32, 'female' , 29 , 0 ,  'yes' , 'northeast' , 15887),
    ( 34, 'female' , 29 , 1 ,  'no' , 'northwest' , 1899),
    ( 19, 'male' , 29 , 1 ,  'yes' , 'southwest' , 10560);
  
  
## identifying details by region wise 
SELECT * FROM insurance WHERE region IN ('southwest' , 'northeast');
SELECT * FROM insurance WHERE region = 'southeast';

## eliminating age less than 25yrs of age
SELECT * FROM  insurance WHERE age > 25 ORDER BY age DESC ;

## identifying the female smokers 
SELECT * FROM insurance WHERE smoker = 'yes' and gender = 'female';

## filtering out the bmi in the range of 30 to 35
SELECT * FROM insurance WHERE bmi BETWEEN 30 AND 35 ;

## filtering out rounded off expenses for non smokers
SELECT age , sex , smoker , ROUND(expenses) as charges FROM insurance WHERE smoker = 'no';

## filtering out people with children 
DELETE from insurance WHERE children = 0 ;

## filtering out people above 60 years
DELETE from insurance WHERE age > 60 ;

## STORED PROCEDURES
## age-wise filtering 
DELIMITER $$
CREATE PROCEDURE find_patients( IN ages INT )
BEGIN
	SELECT * 
    FROM insurance
    WHERE age = ages;
END $$
DELIMITER ;

## calling the stored procedure 1
CALL find_patients(32);

## region-wise filtering 
DELIMITER $$
CREATE PROCEDURE find_region ( IN regions VARCHAR(10))
BEGIN
	SELECT * 
    FROM insurance
    WHERE region = regions;
END $$
DELIMITER ;

## calling the stored procedure 2
CALL find_region( "southwest");

## VIEW operations
CREATE OR REPLACE VIEW V1 AS 
	SELECT * 
    FROM insurance
	WHERE age = 23;

SELECT * FROM V1;

## Trigger Operations for Hospital Patients 

CREATE TABLE ICU ( pat_id int , pat_name varchar(10) , btype varchar(10));
CREATE TABLE GEN ( pat_id int , pat_name varchar(10), btype varchar(10));

INSERT INTO ICU values (1001, 'santhesh', 'Bpositive');
SELECT * FROM ICU;

delimiter $$
CREATE TRIGGER SHIFT
AFTER DELETE ON ICU
FOR EACH ROW 
BEGIN 
INSERT INTO GEN values ( 2001 , 'santhesh', 'bpositive');
END $$
DELIMITER ;

# Execution - Triggers
DELETE FROM ICU;
SELECT * FROM ICU;
SELECT * FROM GEN;