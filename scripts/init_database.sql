/*
====================================================================
Create DATABASE and SCHEMAS
====================================================================
Script Purpose:
  Creates new database named 'DataWarehouse' after checking if it already exists. if database exists, it is dropped & recreated.
  Additionally, the script sets up three schemas within the database- bronze, silver, gold

WARNING:
  Running this script will drop the entire 'DataWarehouse' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution.
*/

If Exists (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO
-- Create Database 'DataWarehouse'
Create DATABASE DataWarehouse;
Go

use DataWarehouse;
Go

-- Create Schemas for bronze, silver & gold stage
Create Schema bronze;
Go
Create Schema silver;
Go
Create Schema gold;
go

