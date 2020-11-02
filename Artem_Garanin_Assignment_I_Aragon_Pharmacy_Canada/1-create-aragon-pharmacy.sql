-- switch to the master database
USE master
;
GO -- include end of the batch marker

CREATE DATABASE Aragon2020
 ON PRIMARY
 ( 
     NAME = Aragon2020_mdf,
     FILENAME = '/var/opt/mssql/data/Aragon202.mdf',
     SIZE = 12MB,
     MAXSIZE = 500MB,
     FILEGROWTH = 6MB 
     )
 LOG ON
 ( 
     NAME = Aragon2020_log,
     FILENAME = '/var/opt/mssql/data/Aragon202.ldf',
     SIZE = 12MB,
     MAXSIZE = 50MB,
     FILEGROWTH = 5MB 
     ) 
;
GO