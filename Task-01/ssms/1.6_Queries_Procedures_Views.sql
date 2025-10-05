-- ========================================================
-- Task 1.6 : Queries, Joins, Stored Procedures, and Views
-- Database: BestVoyageTravel
-- ========================================================

USE BestVoyageTravel;
GO

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

-- 4. Maximum voyage cost per duration (pricing trends)
SELECT duration,
       MAX(cost) AS max_cost
FROM Voyage
GROUP BY duration;

-- 5. Count of boats per voyage (fleet allocation)
SELECT v.voyage_number,
       v.name AS voyage_name,
       COUNT(b.registration_number) AS total_boats
FROM Voyage v
LEFT JOIN Boat b ON v.voyage_number = b.voyage_number
GROUP BY v.voyage_number, v.name;
GO

-------------------------------------------------------
-- (02) Wildcard Searches
-------------------------------------------------------

-- 1. Sailors whose last name starts with 'Sil'
SELECT employee_number, first_name, last_name
FROM Sailor
WHERE last_name LIKE 'Sil%';

-- 2. Sailors whose first name starts with N, M, or P
SELECT employee_number, first_name, last_name
FROM Sailor
WHERE first_name LIKE 'N%' 
   OR first_name LIKE 'M%' 
   OR first_name LIKE 'P%';

-- 3. Voyages with names starting with 'C', 'K', or 'T'
SELECT voyage_number, name, description, cost, duration
FROM Voyage
WHERE name LIKE 'C%' 
   OR name LIKE 'K%' 
   OR name LIKE 'T%';

-- 4. Sailors with phone numbers starting with '0771' (mobile prefix)
SELECT employee_number, first_name, last_name, mobile_number
FROM Sailor
WHERE mobile_number LIKE '0771%';

-- 5. Voyages whose description contains the word 'adventure'
SELECT voyage_number, name, description
FROM Voyage
WHERE description LIKE '%adventure%';
GO
