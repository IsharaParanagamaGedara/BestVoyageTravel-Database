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

-------------------------------------------------------
-- INSERT SAMPLE DATA (Records 1–10)
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
GO

-- BOAT
INSERT INTO Boat VALUES
('B001', 'V001'), ('B002', 'V002'), ('B003', 'V003'),
('B004', 'V004'), ('B005', 'V005'), ('B006', 'V006'),
('B007', 'V007'), ('B008', 'V008'), ('B009', 'V009'),
('B010', 'V010');
GO

-- BOAT_DETAILS
INSERT INTO Boat_Details VALUES
('B001', 25), ('B002', 40), ('B003', 35), ('B004', 20), ('B005', 30),
('B006', 50), ('B007', 45), ('B008', 28), ('B009', 55), ('B010', 18);
GO

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
GO

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
GO

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
GO

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
GO

-------------------------------------------------------
-- DEMONSTRATE DATA
-------------------------------------------------------
SELECT * FROM Voyage;
SELECT * FROM Boat;
SELECT * FROM Boat_Details;
SELECT * FROM Sailor;
SELECT * FROM Sailor_Address;
SELECT * FROM Captain;
SELECT * FROM Boat_Sailor;
GO

-------------------------------------------------------
-- ADDITIONAL INSERTS (Records 11–20 for each table)
-------------------------------------------------------

-- VOYAGE
INSERT INTO Voyage VALUES
('V011', 'Pasikudah Bay Ride', 'Crystal clear waters of Pasikudah', 15000.00, 3),
('V012', 'Wilpattu Coast Safari', 'Wildlife and coastal exploration', 27000.00, 6),
('V013', 'Arugam Surf Voyage', 'Surf and sail in Arugam Bay', 22000.00, 4),
('V014', 'Puttalam Lagoon', 'Bird watching cruise', 16000.00, 3),
('V015', 'Dondra Point Sail', 'Southernmost point of Sri Lanka', 18000.00, 4),
('V016', 'Ella Scenic Lake Tour', 'Lake-side voyage with mountain views', 24000.00, 5),
('V017', 'Kilinochchi Explorer', 'Northern inland water tour', 21000.00, 4),
('V018', 'Polonnaruwa Heritage Voyage', 'Ancient city by water', 26000.00, 6),
('V019', 'Bentota River Cruise', 'Mangrove forest and lagoon', 14000.00, 2),
('V020', 'Hikkaduwa Coral Voyage', 'Snorkeling and coral reef view', 20000.00, 3);
GO

-- BOAT
INSERT INTO Boat VALUES
('B011', 'V011'), ('B012', 'V012'), ('B013', 'V013'),
('B014', 'V014'), ('B015', 'V015'), ('B016', 'V016'),
('B017', 'V017'), ('B018', 'V018'), ('B019', 'V019'),
('B020', 'V020');
GO

-- BOAT_DETAILS
INSERT INTO Boat_Details VALUES
('B011', 22), ('B012', 48), ('B013', 33), ('B014', 19), ('B015', 27),
('B016', 42), ('B017', 31), ('B018', 50), ('B019', 24), ('B020', 36);
GO

-- SAILOR
INSERT INTO Sailor VALUES
('E011', 'Tharindu', 'Ranasinghe', '0771111111', '0111111111', '2021-03-15', 4, 29, 70000.00),
('E012', 'Lakshan', 'Wijesinghe', '0772222222', '0112222222', '2020-07-01', 6, 32, 82000.00),
('E013', 'Kasun', 'Abeywardena', '0773333333', '0113333333', '2019-05-20', 8, 36, 90000.00),
('E014', 'Dineth', 'Ratnayake', '0774444444', '0114444444', '2022-10-10', 2, 25, 58000.00),
('E015', 'Isuru', 'Dissanayake', '0775555555', '0115555555', '2018-04-12', 9, 39, 97000.00),
('E016', 'Sandun', 'Gunawardena', '0776666666', '0116666666', '2017-11-05', 12, 44, 115000.00),
('E017', 'Chathura', 'Rajapaksha', '0777777777', '0117777777', '2016-06-18', 14, 48, 128000.00),
('E018', 'Dulaj', 'Herath', '0778888888', '0118888888', '2019-08-25', 7, 34, 86000.00),
('E019', 'Rashmi', 'Senanayake', '0779999999', '0119999999', '2020-12-01', 5, 31, 79000.00),
('E020', 'Gayan', 'Wickramasinghe', '0711231234', '0111231234', '2021-09-09', 3, 27, 67000.00);
GO

-- SAILOR_ADDRESS
INSERT INTO Sailor_Address VALUES
('E011', '21K', '45', 'Badulla'),
('E012', '10L', '33', 'Polonnaruwa'),
('E013', '8M', '72', 'Ratnapura'),
('E014', '14N', '19', 'Kalutara'),
('E015', '7O', '28', 'Kegalle'),
('E016', '3P', '54', 'Chilaw'),
('E017', '19Q', '88', 'Vavuniya'),
('E018', '6R', '41', 'Puttalam'),
('E019', '11S', '29', 'Monaragala'),
('E020', '4T', '61', 'Hambantota');
GO

-- CAPTAIN
INSERT INTO Captain VALUES
('V011', 'E011', '2022-05-11'),
('V012', 'E012', '2021-07-22'),
('V013', 'E013', '2020-09-30'),
('V014', 'E014', '2023-01-12'),
('V015', 'E015', '2020-03-08'),
('V016', 'E016', '2019-11-14'),
('V017', 'E017', '2021-04-18'),
('V018', 'E018', '2022-09-27'),
('V019', 'E019', '2021-02-05'),
('V020', 'E020', '2023-03-21');
GO

-- BOAT_SAILOR
INSERT INTO Boat_Sailor VALUES
('B011', 'E011', 6.0),
('B012', 'E012', 7.5),
('B013', 'E013', 8.0),
('B014', 'E014', 5.0),
('B015', 'E015', 6.5),
('B016', 'E016', 9.0),
('B017', 'E017', 8.5),
('B018', 'E018', 7.0),
('B019', 'E019', 6.5),
('B020', 'E020', 5.5);
GO

-------------------------------------------------------
-- Database Backup (Full Backup)
-------------------------------------------------------
BACKUP DATABASE BestVoyageTravel
TO DISK = 'D:\Projects\Git repo\BestVoyageTravel-Database\Task-01\backups\BestVoyageTravel_full.bak'
WITH FORMAT, INIT,  
     NAME = 'BestVoyageTravel-Full Backup',
     STATS = 10;
GO