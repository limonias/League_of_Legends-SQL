use p01;
Create table countries (
country_ID varchar(2),
country_name varchar(40),
region_ID decimal(10,0)
);
Create table if NOT exists dup_counties
LIKE countries;