-- switch to the Aragon2020 database
USE Aragon2020
;
GO

            -- Artem Garanin part

/***** Table No. 1 - Employee.tblClass ****/
create table Employee.tblClass
(
	-- column_name data_type constraint_type(s)
	ClassID int not null, -- The class identification number, field store numbers with no decimal places.
    Description nvarchar(40) not null, -- Description
    Cost decimal(5,2) not null, -- Cost 
    Renewal int not null, -- Renewal requirement (in years)
    Required nvarchar(5), -- A field to indicate whether the class is required
    Provider nvarchar(40), -- Provider
	-- constraint constraint_name constraint_type
	constraint pk_tblClass primary key clustered -- Clustered primary key
		(ClassID asc)
)
;
go

/***** Table No. 2 - Employee.tblJobTitle ****/
create table Employee.tblJobTitle
(
	-- column_name data_type constraint_type(s)
	JobID int not null, -- Job identification numbers are whole numbers
    Title nvarchar(30), -- Title field stores 30 characters
	-- constraint constraint_name constraint_type
	constraint pk_tblJobTitle primary key clustered 
		(JobID asc)
)
;
go

/***** Table No. 3 - Employee.tblEmployee ****/
create table Employee.tblEmployee
(
	-- column_name data_type constraint_type(s)
	EmpID int not null, -- assigned by the pharmacy using unique numbers
    EmpFirst nvarchar(30) not null, -- Employee First Name, field do not exceed 30 characters
    EmpMI nvarchar(2) null, -- Employee Middle Initials, field stores up to two characters
    EmpLast nvarchar(30) not null, -- Employee Last Name, field do not exceed 30 characters
    SIN nchar(11) null, -- Social Insurance numbers. An SIN is a nine- digit number displayed with the following format: ###-###-###.
    DOB date not null, -- Date Of Birth. Fields should store two-digit months and days and four-digit years in the format ##/##/####.
    StartDate date not null, -- Start Date. Fields should store two-digit months and days and four-digit years in the format ##/##/####.
    EndDate date null, -- Termination date (if applicable). Fields should store two-digit months and days and four-digit years in the format ##/##/####.
    Address nvarchar(40) not null, -- Canadian addresses include a street address. Fields cannot exceed 40 characters
    City nvarchar(40) not null, -- City. Fields cannot exceed 40 characters
    Province nchar(2) not null, -- Provinces are abbreviated using two uppercase letters.
    PostalCode nvarchar(7) not null, -- Postal codes in Canada have the following format: uppercase letter, number, uppercase letter, space, number, uppercase letter, number (for example, T6H 8U7)
    JobID int not null, -- Job identification number (Foreign key JobID in  table Employee.tblJobTitle)
    Memo ntext null, -- Memo to store miscellaneous information about the employee, such as being part time or bilingual.
    Phone nvarchar(15) null, -- Phone Number. Should store 15 characters in the format of (###) ###-####. Area code entry is required.
    Cell nvarchar(15) null, -- Cell Phone Number. Should store 15 characters in the format of (###) ###-####. Area code entry is required.
    Salary decimal(15,2) null, -- Annual Salary
    HourlyRate decimal(15,2) null, -- Hourly Rate
    Review date null,  -- Next personnel review date. There is an annual review date for each employee based on his or her hire date.
	-- constraint constraint_name constraint_type
	constraint pk_tblEmployee primary key clustered -- Clustered Primary key
		(EmpID asc)
)
;
go

/***** Table No. 4 - Employee.tblEmployeeTraining ****/
create table Employee.tblEmployeeTraining
(
	-- column_name data_type constraint_type(s)
	EmpID int not null, -- Field store numbers with no decimal places. (Foreign key EmpID in  table Employee.tblEmployee)
    Date date not null, -- The Date field stores the date of the training session. Display the date using the format ##/##/####.
    ClassID int not null, -- Field store numbers with no decimal places. (Foreign key ClassID in  table Employee.tblClass)
	-- constraint constraint_name constraint_type
	constraint pk_tblEmployeeTraining primary key clustered -- Clustered Composite Primary Key
		(EmpID, Date, ClassID)
)
;
go

            -- Vladimir Tocari part

/***** Table No. 5 - Customer.tblHealthPlan ****/

/***** Table No. 6 - Customer.tblHousehold ****/

/***** Table No. 7 - Customer.tblCustomer ****/

            -- Ihor Stashchuk part

/***** Table No. 8 - Prescription.tblClinic ****/

create table Prescription.tblClinic
(
	ClinicID int identity(1,1) not null,
	ClinicName nvarchar(30) not null,
	Address1 nvarchar(40) not null,
	Address2 nvarchar(40) not null,
	City nvarchar(40) not null,
	Province nchar(2) not null,
	PostalCode nvarchar(7) not null,
	Phone nvarchar(15) not null,
	constraint pk_tblClinic primary key clustered 
	(ClinicID asc)
)
;
go

/***** Table No. 9 - Prescription.tblDoctor ****/

create table Prescriptions.tblDoctor
(
	DoctorID int IDENTITY(1,1) not null,
	DoctorFirst nvarchar(30) not null,
	DoctorLast nvarchar(30) not null,
	Phone nvarchar(15) not null,
	Cell nvarchar(15) not null,
	ClinicID int not null,
	CONSTRAINT pk_tblDoctor primary key clustered 
	(DoctorID ASC)
)
;
go

/***** Table No. 10 - Prescription.tblDrug ****/

create table Prescription.tblDrug
(
	DIN nvarchar(8) not null,
	Name nvarchar(30) not null,
	Generic nchar(3) not null,
	Description nvarchar(100) not null,
	Unit nvarchar(10) not null,
	Dosage nvarchar(10) not null,
	DosageForm nvarchar(20) not null,
	Cost decimal(5,2) not null,
	Price decimal(5,2) not null,
	Interactions nvarchar(40) not null,
	PregCategory nchar(1) not null,
	Supplier nvarchar(100) not null,
	constraint pk_tblDrug primary key clustered 
	(DIN asc)
)
;
go

/***** Table No. 11 - Prescription.tblRx ****/

create table Prescription.tblRx
(
	PrescriptionID int identity(1,1) not null,
	DIN nvarchar(8) not null,
	Quantity decimal(5,2) not null,
	Unit nvarchar(10) not null,
	Date date not null,
	ExpireDate date not null,
	Refills int not null,
	AutoRefill nchar(3) not null,
	RefillsUsed int not null,
	Instructions nvarchar(50) not null,
	CustID int not null,
	DoctorID int not null,
	constraint pk_tblRx primary key clustered 
	(PrescriptionID asc)
)
;
go

/***** Table No. 12 - Prescription.tblRefill ****/

create table Prescription.tblRefill
(
	PrescriptionID int identity(1,1) not null,
	RefillDate date not null,
	EmplID int not null,
)
;
go