-- switch to the Aragon2020 database
USE Aragon2020
;
GO

-- 1) create Employee schema
CREATE SCHEMA Employee AUTHORIZATION dbo
;
GO

-- 2) create Customer schema
CREATE SCHEMA Customer AUTHORIZATION dbo
;
GO

-- 3) create Prescription schema
CREATE SCHEMA Prescription AUTHORIZATION dbo
;
GO