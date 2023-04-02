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