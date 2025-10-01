-- ========================================================
-- Task 1.5 : Database Creation, Tables, and Insert Records
-- Database: BestVoyageTravel
-- ========================================================

-- Drop database if exists
DROP DATABASE IF EXISTS BestVoyageTravel;

-- Create new database
CREATE DATABASE BestVoyageTravel;
USE BestVoyageTravel;

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

-------------------------------------------------------
-- 2. BOAT Table
-------------------------------------------------------
CREATE TABLE Boat (
    registration_number VARCHAR(20) NOT NULL PRIMARY KEY,
    voyage_number VARCHAR(20) NOT NULL,
    FOREIGN KEY (voyage_number) REFERENCES Voyage(voyage_number)
);

-------------------------------------------------------
-- 3. BOAT_DETAILS Table
-------------------------------------------------------
CREATE TABLE Boat_Details (
    registration_number VARCHAR(20) NOT NULL PRIMARY KEY,
    num_of_passengers INT NOT NULL CHECK (num_of_passengers BETWEEN 10 AND 55),
    FOREIGN KEY (registration_number) REFERENCES Boat(registration_number)
);

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

-------------------------------------------------------
-- INSERT SAMPLE DATA (10 per table)
-------------------------------------------------------

-- VOYAGE
INSERT INTO Voyage VALUES
('V001', 'Colombo Sunset', 'Evening coastal voyage', 12000.00, 2),
('V002', 'Galle Heritage', 'Day trip to Galle Fort', 25000.00, 8),
('V003', 'Jaffna Explorer', 'Northern cultural voyage', 30000.00, 10),
('V004', 'Trinco Dolphin Ride', 'Morning dolphin watching', 15000.00, 3),
('V005', 'Batticaloa Lagoon', 'Scenic lagoon cruise', 18000.00, 4),
('V006', 'Negombo Sail', 'Fishing village tour', 10000.00, 3),
('V007', 'Hambantota Safari', 'Wildlife and sea adventure', 28000.00, 6),
('V008', 'Mannar Pearl Tour', 'Historic pearl diving sites', 32000.00, 7),
('V009', 'Kalpitiya Kite Voyage', 'Adventure voyage in Kalpitiya', 20000.00, 5),
('V010', 'Colombo City Cruise', 'City lights and dinner', 22000.00, 2);

-- BOAT
INSERT INTO Boat VALUES
('B001', 'V001'), ('B002', 'V002'), ('B003', 'V003'),
('B004', 'V004'), ('B005', 'V005'), ('B006', 'V006'),
('B007', 'V007'), ('B008', 'V008'), ('B009', 'V009'),
('B010', 'V010');

-- BOAT_DETAILS
INSERT INTO Boat_Details VALUES
('B001', 25), ('B002', 40), ('B003', 35), ('B004', 20), ('B005', 30),
('B006', 50), ('B007', 45), ('B008', 28), ('B009', 55), ('B010', 18);

-- SAILOR
INSERT INTO Sailor VALUES
('E001', 'Nimal', 'Perera', '0771234567', '0112233445', '2020-01-05', 5, 30, 75000.00),
('E002', 'Sunil', 'Silva', '0772345678', '0113344556', '2019-03-12', 10, 40, 95000.00),
('E003', 'Kamal', 'Fernando', '0773456789', '0114455667', '2021-07-20', 3, 28, 65000.00),
('E004', 'Ruwan', 'Jayasinghe', '0774567890', '0115566778', '2018-11-15', 8, 35, 88000.00),
('E005', 'Ajith', 'Bandara', '0775678901', '0116677889', '2022-02-01', 2, 26, 60000.00),
('E006', 'Chamara', 'Karunaratne', '0776789012', '0117788990', '2017-06-10', 12, 45, 120000.00),
('E007', 'Mahesh', 'Gunasekara', '0777890123', '0118899001', '2016-09-25', 15, 50, 130000.00),
('E008', 'Saman', 'Weerasinghe', '0778901234', '0119900112', '2021-01-30', 4, 29, 70000.00),
('E009', 'Roshan', 'Dias', '0779012345', '0111001223', '2019-05-18', 7, 33, 82000.00),
('E010', 'Pradeep', 'Edirisinghe', '0770123456', '0112102334', '2020-08-09', 6, 31, 78000.00);

-- SAILOR_ADDRESS
INSERT INTO Sailor_Address VALUES
('E001', '12A', '45', 'Colombo'),
('E002', '5B', '67', 'Galle'),
('E003', '22C', '89', 'Jaffna'),
('E004', '7D', '34', 'Kandy'),
('E005', '15E', '12', 'Negombo'),
('E006', '18F', '56', 'Trincomalee'),
('E007', '9G', '78', 'Matara'),
('E008', '20H', '23', 'Kurunegala'),
('E009', '3I', '90', 'Batticaloa'),
('E010', '11J', '11', 'Anuradhapura');

-- CAPTAIN
INSERT INTO Captain VALUES
('V001', 'E002', '2022-01-10'),
('V002', 'E004', '2022-03-15'),
('V003', 'E006', '2021-07-01'),
('V004', 'E001', '2022-08-20'),
('V005', 'E009', '2021-09-25'),
('V006', 'E003', '2023-01-05'),
('V007', 'E007', '2020-12-10'),
('V008', 'E005', '2022-02-14'),
('V009', 'E010', '2021-11-18'),
('V010', 'E008', '2023-04-12');

-- BOAT_SAILOR
INSERT INTO Boat_Sailor VALUES
('B001', 'E001', 6.5),
('B002', 'E002', 8.0),
('B003', 'E003', 7.0),
('B004', 'E004', 5.5),
('B005', 'E005', 6.0),
('B006', 'E006', 9.0),
('B007', 'E007', 8.5),
('B008', 'E008', 7.5),
('B009', 'E009', 6.0),
('B010', 'E010', 5.0);
