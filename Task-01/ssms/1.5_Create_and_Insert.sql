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