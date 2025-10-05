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

-------------------------------------------------------
-- (03) Selection with Conditions
-------------------------------------------------------

-- 1. Boats with >15 passengers AND voyage cost < 25,000
SELECT b.registration_number,
       bd.num_of_passengers,
       v.cost
FROM Boat b
JOIN Boat_Details bd 
    ON b.registration_number = bd.registration_number
JOIN Voyage v 
    ON b.voyage_number = v.voyage_number
WHERE bd.num_of_passengers > 15 
  AND v.cost < 25000;

-- 2. Sailors with >5 years experience AND salary > 50,000
SELECT employee_number, first_name, last_name, experience, salary
FROM Sailor
WHERE experience > 5 
  AND salary > 50000;

-- 3. Voyages with duration >5 days AND cost < 35,000
SELECT voyage_number, name, duration, cost
FROM Voyage
WHERE duration > 5 
  AND cost < 35000;
  
-- 4. Sailors earning between 40,000 and 70,000
SELECT employee_number, first_name, last_name, salary
FROM Sailor
WHERE salary BETWEEN 40000 AND 70000;

-- 5. Voyages with cost > 20,000 but duration <= 5
SELECT voyage_number, name, duration, cost
FROM Voyage
WHERE cost > 20000 AND duration <= 5;

-- 6. Boats with passenger capacity between 20 and 40
SELECT registration_number, num_of_passengers
FROM Boat_Details
WHERE num_of_passengers BETWEEN 20 AND 40;
GO

-------------------------------------------------------
-- (04) Inner Joins
-------------------------------------------------------

-- 1. Names of all sailors working on boat 'B003'
SELECT s.employee_number, s.first_name, s.last_name
FROM Sailor s
INNER JOIN Boat_Sailor bs 
    ON s.employee_number = bs.employee_number
WHERE bs.registration_number = 'B003';

-- 2. Boats and their assigned voyages
SELECT b.registration_number, v.name AS voyage_name
FROM Boat b
INNER JOIN Voyage v 
    ON b.voyage_number = v.voyage_number;

-- 3. Boats with their assigned sailors and working hours
SELECT b.registration_number,
       s.first_name,
       s.last_name,
       bs.working_hours
FROM Boat b
INNER JOIN Boat_Sailor bs 
    ON b.registration_number = bs.registration_number
INNER JOIN Sailor s 
    ON bs.employee_number = s.employee_number;
    
-- 4. Captains with their voyages and appointment dates
SELECT c.voyage_number,
       v.name AS voyage_name,
       s.first_name AS captain_first,
       s.last_name  AS captain_last,
       c.captain_appointed_date
FROM Captain c
JOIN Voyage v ON c.voyage_number = v.voyage_number
JOIN Sailor s ON c.captain_employee_number = s.employee_number;

-- 5. Sailors and the boats they are working on (including hours)
SELECT s.employee_number, s.first_name, s.last_name,
       b.registration_number, bs.working_hours
FROM Sailor s
JOIN Boat_Sailor bs ON s.employee_number = bs.employee_number
JOIN Boat b ON bs.registration_number = b.registration_number;
GO
