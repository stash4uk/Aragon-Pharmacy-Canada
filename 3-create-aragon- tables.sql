-- switch to the Aragon2020 database
USE Aragon2020
;
GO

            -- Artem Garanin part

/***** Table No. 1 - Employee.tblClass ****/
create table Employee.tblClass
(
	-- column_name data_type constraint_type(s)
	ClassID int not null,
    Description nvarchar(40) not null,
    Cost decimal(5,2) not null,
    Renewal int not null,
    Required nvarchar(5),
    Provider nvarchar(40),
	-- constraint constraint_name constraint_type
	constraint pk_tblClass primary key clustered 
		(ClassID asc)
)
;
go

/***** Table No. 2 - Employee.tblJobTitle ****/
create table Employee.tblJobTitle
(
	-- column_name data_type constraint_type(s)
	JobID int not null,
    Title nvarchar(30),
	-- constraint constraint_name constraint_type
	constraint pk_tblJobTitle primary key clustered 
		(JobID asc)
)
;
go

/***** Table No. 3 - Employee.tblEmployee ****/

/***** Table No. 4 - Employee.tblEmployeeTraining ****/

            -- Vladimir Tocari part

/***** Table No. 5 - Customer.tblHealthPlan ****/

/***** Table No. 6 - Customer.tblHousehold ****/

/***** Table No. 7 - Customer.tblCustomer ****/

            -- Ihor Stashchuk part

/***** Table No. 8 - Prescription.tblClinic ****/

/***** Table No. 9 - Prescription.tblDoctor ****/

/***** Table No. 10 - Prescription.tblDrug ****/

/***** Table No. 11 - Prescription.tblRx ****/

/***** Table No. 12 - Prescription.tblRefill ****/