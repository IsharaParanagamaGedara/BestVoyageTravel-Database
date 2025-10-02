-- ========================================================
-- Task 1.6 : Queries, Joins, Stored Procedures, and Views
-- Database: BestVoyageTravel
-- ========================================================

USE BestVoyageTravel;

-------------------------------------------------------
-- (01) Aggregate Functions with GROUP BY
-------------------------------------------------------

-- 1. Total number of passengers for each voyage
SELECT v.voyage_number,
       v.name AS voyage_name,
       SUM(bd.num_of_passengers) AS total_passengers
FROM Voyage v
JOIN Boat b 
    ON v.voyage_number = b.voyage_number
JOIN Boat_Details bd 
    ON b.registration_number = bd.registration_number
GROUP BY v.voyage_number, v.name;

-- 2. Total number of sailors from 'Batticaloa'
SELECT sa.address_city,
       COUNT(s.employee_number) AS total_sailors
FROM Sailor s
JOIN Sailor_Address sa 
    ON s.employee_number = sa.employee_number
WHERE sa.address_city = 'Batticaloa'
GROUP BY sa.address_city;

-- 3. Average salary of sailors per city
SELECT sa.address_city,
       AVG(s.salary) AS avg_salary
FROM Sailor s
JOIN Sailor_Address sa ON s.employee_number = sa.employee_number
GROUP BY sa.address_city;

-- 4. Maximum voyage cost per duration (to compare pricing trends)
SELECT duration,
       MAX(cost) AS max_cost
FROM Voyage
GROUP BY duration;

-- 5. Count of boats per voyage (fleet allocation report)
SELECT v.voyage_number,
       v.name AS voyage_name,
       COUNT(b.registration_number) AS total_boats
FROM Voyage v
LEFT JOIN Boat b ON v.voyage_number = b.voyage_number
GROUP BY v.voyage_number, v.name;
