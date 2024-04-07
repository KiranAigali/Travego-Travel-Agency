# TRAVEGO SQL PROJECT

-- TASK-1

-- 1. Creating the schema and required tables using sql script or using MySQL workbench

-- a. Create a schema named Travego.
-- b. Create the tables mentioned above with the mentioned column names.

create database Travego;
use travego;
CREATE TABLE Passenger (
    Passenger_id INT PRIMARY KEY,
    Passenger_name VARCHAR(20),
    Category VARCHAR(20),
    Gender VARCHAR(20),
    Boarding_city VARCHAR(20),
    Destination_city VARCHAR(20),
    Distance INT,
    Bus_type VARCHAR(20)
);

CREATE TABLE Price (
    id INT PRIMARY KEY,
    Bus_type VARCHAR(20),
    Distance INT,
    Price INT
);

-- c. Insert the data in the newly created tables using sql script.

insert into Passenger (Passenger_id, Passenger_name, Category, Gender,
Boarding_city, Destination_city, Distance, Bus_type)
values
(1, 'Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper'),
(2, 'Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting'),
(3, 'Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper'),
(4, 'Khusboo', 'AC', 'F', 'Channai', 'Mumbai', 1500, 'Sleeper'),
(5, 'Udit', 'Non-AC', 'M', 'Trivandrum', 'Panaji', 1000, 'Sleeper'),
(6, 'Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting'),
(7, 'Hemant', 'Non-AC', 'M', 'Panaji', 'Mumbai', 700, 'Sleeper'),
(8, 'Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting'),
(9, 'Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');

SELECT * FROM Passenger;

insert into Price (Id, Bus_type, Distance, Price)
values
(1, 'Sleeper', 350, 770),
(2, 'Sleeper', 500, 1100),
(3, 'Sleeper', 600, 1320),
(4, 'Sleeper', 700, 1540),
(5, 'Sleeper', 1000, 2200),
(6, 'Sleeper', 1200, 2640),
(7, 'Sleeper', 1500, 2700),
(8, 'Sitting', 500, 620),
(9, 'Sitting', 600, 744),
(10, 'Sitting', 700, 868),
(11, 'Sitting', 1000, 1240),
(12, 'Sitting', 1200, 1488),
(13, 'Sitting', 1500, 1860);

select * from price;

-- TRAVEGO SQL PROJECT
-- TASK-2

-- 2. Perform read operation on the designed table created in the above task using SQL script. 

-- a. How many females and how many male passengers traveled a minimum distance of 600 KMs?

SELECT 
    gender, COUNT(*) AS passenger_count
FROM
    passenger
WHERE
    distance >= 600
GROUP BY 1;

-- b. Find the minimum ticket price of a Sleeper Bus. 

SELECT 
    MIN(price) AS min_ticket_price, bus_type
FROM
    price
WHERE
    bus_type = 'Sleeper';
    
    -- c. Select passenger names whose names start with character 'S' 
SELECT 
    passenger_name
FROM
    passenger
WHERE
    passenger_name LIKE 's%';
    
-- d. Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, 
-- Price in the output.

SELECT 
    passenger_name,
    boarding_city,
    destination_city,
    bus_type,
    price
FROM
    passenger p
JOIN
    price pr USING(bus_type,distance);

-- e. What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus?  
SELECT 
    passenger_name, price AS ticket_price
FROM
    passenger p
JOIN
    price pr ON p.bus_type = pr.bus_type
		AND p.distance = pr.distance
WHERE
    p.distance = 1000
		AND p.bus_type = 'Sitting';

-- f. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
SELECT
    Bus_type, price
FROM
    price
WHERE
    distance = (SELECT 
					distance
				FROM
					passenger
				WHERE
					boarding_city = 'Bangaluru' 
					AND destination_city = 'Panaji');
                    
-- g. List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. 

SELECT DISTINCT
    distance
FROM
    Passenger
ORDER BY
    distance DESC; 
    
-- h. Display the passenger name and percentage of distance traveled by that passenger from the total distance 
-- traveled by all passengers without using user variables 
SELECT
    passenger_name,
    (distance / total_distance) * 100 AS distance_percentage
FROM
    Passenger p
JOIN
    (SELECT SUM(distance) AS total_distance FROM Passenger) t;
    
