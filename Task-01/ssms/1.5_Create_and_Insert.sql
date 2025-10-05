-- ========================================================
-- Task 1.5 : Database Creation, Tables, and Insert Records
-- Database: BestVoyageTravel
-- ========================================================

-- Drop database if it already exists
USE master;
GO

IF DB_ID('BestVoyageTravel') IS NOT NULL
BEGIN
    ALTER DATABASE BestVoyageTravel SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE BestVoyageTravel;
END
GO

-- Create new database
CREATE DATABASE BestVoyageTravel;
GO
USE BestVoyageTravel;
GO

-------------------------------------------------------
-- 1. VOYAGE Table
-------------------------------------------------------
CREATE TABLE Voyage (
    voyage_number VARCHAR(20) NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    cost DECIMAL(10,2) NOT NULL CHECK (cost > 0),
    duration INT NOT NULL CHECK (duration > 0)
);
GO

-------------------------------------------------------
-- 2. BOAT Table
-------------------------------------------------------
CREATE TABLE Boat (
    registration_number VARCHAR(20) NOT NULL PRIMARY KEY,
    voyage_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (voyage_number) REFERENCES Voyage(voyage_number)
);
GO

-------------------------------------------------------
-- 3. BOAT_DETAILS Table
-------------------------------------------------------
CREATE TABLE Boat_Details (
    registration_number VARCHAR(20) NOT NULL PRIMARY KEY,
    num_of_passengers INT NOT NULL CHECK (num_of_passengers BETWEEN 10 AND 55),
    FOREIGN KEY (registration_number) REFERENCES Boat(registration_number)
);
GO

-------------------------------------------------------
-- 4. SAILOR Table
-------------------------------------------------------
CREATE TABLE Sailor (
    employee_number VARCHAR(20) NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    mobile_number VARCHAR(15) NOT NULL UNIQUE,
    home_phone_number VARCHAR(15),
    joined_date DATE NOT NULL,
    experience INT NOT NULL CHECK (experience >= 0),
    age INT NOT NULL CHECK (age >= 18),
    salary DECIMAL(10,2) NOT NULL CHECK (salary > 0)
);
GO

-------------------------------------------------------
-- 5. SAILOR_ADDRESS Table
-------------------------------------------------------
CREATE TABLE Sailor_Address (
    employee_number VARCHAR(20) NOT NULL PRIMARY KEY,
    address_apartment_number VARCHAR(10),
    address_street_number VARCHAR(10) NOT NULL,
    address_city VARCHAR(50) NOT NULL,
    FOREIGN KEY (employee_number) REFERENCES Sailor(employee_number)
);
GO

-------------------------------------------------------
-- 6. CAPTAIN Table
-------------------------------------------------------
CREATE TABLE Captain (
    voyage_number VARCHAR(20) NOT NULL,
    captain_employee_number VARCHAR(20) NOT NULL,
    captain_appointed_date DATE NOT NULL,
    PRIMARY KEY (voyage_number, captain_employee_number, captain_appointed_date),
    FOREIGN KEY (voyage_number) REFERENCES Voyage(voyage_number),
    FOREIGN KEY (captain_employee_number) REFERENCES Sailor(employee_number)
);
GO

-------------------------------------------------------
-- 7. BOAT_SAILOR Table
-------------------------------------------------------
CREATE TABLE Boat_Sailor (
    registration_number VARCHAR(20) NOT NULL,
    employee_number VARCHAR(20) NOT NULL,
    working_hours DECIMAL(4,2) NOT NULL CHECK (working_hours > 0),
    PRIMARY KEY (registration_number, employee_number),
    FOREIGN KEY (registration_number) REFERENCES Boat(registration_number),
    FOREIGN KEY (employee_number) REFERENCES Sailor(employee_number)
);
GO
