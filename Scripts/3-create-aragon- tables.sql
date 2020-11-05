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

create table Customer.tblHealthPlan(
PlanID nvarchar(25) not null, --  id plan
PlanName nvarchar(25) null, -- name of the plan
Address nvarchar(25) not null, -- address 
City nvarchar(25) not null, -- city 
Province  nvarchar(2) not null, -- have toconvert to  uppercase letters and cannot enter digits
PostalCode nvarchar(7) not null,--
/*Postal codes in Canada have the following format: uppercase letter, number, uppercase letter, space, number, uppercase letter, number (for example, T6H 8U7). Add properties to the PostalCode field to ensure that data entry into this field is accurate and correctly formatted. You might want to consider using a pattern, such as >L0>L\0>L0*/
Phone nvarchar(15) null, -- Phone Number. Should store 15 characters in the format of (###) ###-####. Area code entry is required.
Days int null, -- treatment days plan in days
WebSite nvarchar(25) null,-- web site address
constraint pk_tblHealthPlan primary key clustered -- Clustered primary key
(PlanId asc)
)
;
go

/***** Table No. 6 - Customer.tblHousehold ****/

create table Customer.tblHousehold(
HouseID int not null, -- The class identification number, field store numbers with no decimal places.
Address nvarchar(25) not null, --
City  nvarchar(25) not null, -- city
Province  nvarchar(2) not null, -- province
PostalCode nvarchar(7) not null, -- postal code
constraint pk_tblHousehold primary key clustered -- Clustered primary key
(HouseID asc)
)
;
go

/***** Table No. 7 - Customer.tblCustomer ****/

create table Customer.tblCustomer(
CustID int not null, -- The class identification number, field store numbers with no decimal places.
CustFirst nvarchar(25) not null, --  Customer first name
CustLast nvarchar(25) not null, --  Customer last name
Phone nvarchar(15) null, -- Phone Number. Should store 15 characters in the format of (###) ###-####. Area code entry is required.
DOB date not null, -- Customer date of birth
Gender nvarchar(2) not null, --Customer gender
Balance decimal(15,2) null, --Customer balance
ChildproofCap nvarchar(5) not null,-- true or false
PlanID nvarchar(25) not null, -- foreign key
HouseID int not null, -- it's ID for connect to Customer.tblHousehold table
HeadHH  nvarchar(5) not null,-- true or false
Allergies varchar(50) null,-- Customer allergies
constraint pk_tblCustomer primary key clustered -- Clustered primary key
(CustID asc)
)
;
go

            -- Ihor Stashchuk part

/***** Table No. 8 - Prescription.tblClinic ****/

create table Prescription.tblClinic
(
	ClinicID int not null, -- Clinic ID
	ClinicName nvarchar(30) not null, -- Clinic name
	Address1 nvarchar(40) not null, -- Clinic first address
	Address2 nvarchar(40) not null, -- Clinic second address
	City nvarchar(40) not null, -- Clinic city
	Province nchar(2) not null, -- Clinic province
	PostalCode nvarchar(7) not null, -- Clinic postal code
	Phone nvarchar(15) not null, -- Clinic phone number
	constraint pk_tblClinic primary key clustered -- Primary key
	(ClinicID asc)
)
;
go

/***** Table No. 9 - Prescription.tblDoctor ****/

create table Prescription.tblDoctor
(
	DoctorID int not null, -- Doctor ID.
	DoctorFirst nvarchar(30) not null, -- Doctor first name. The field for the doctor’s first name should store 30 characters
	DoctorLast nvarchar(30) not null, -- Doctor last name. The field for the doctor’s last name should store 30 characters
	Phone nvarchar(15) not null, -- Doctor phone number. Should store 15 characters. Values formatted with the following format: (###) ###-####. # is a numeric character.
	Cell nvarchar(15) not null, -- Doctor cell phone number. Should store 15 characters. Values formatted with the following format: (###) ###-####. # is a numeric character.
	ClinicID int not null, -- Doctor's clinic ID. This is a foreign key to tblClinic
	CONSTRAINT pk_tblDoctor primary key clustered 
	(DoctorID ASC) -- Primary key
)
;
go

/***** Table No. 10 - Prescription.tblDrug ****/

create table Prescription.tblDrug
(
	DIN nvarchar(8) not null, -- Drug Identification Number. Unique, eight-digit (numeric characters) value. Not used in calculations
	Name nvarchar(30) not null, -- Drug name. Does not exceed 30 characters
	Generic nchar(3) not null, -- Indicates if a drug is a generic. Indicated by selecting a check box. Values are 'yes' and 'no'
	Description nvarchar(100) not null, -- Drug description. Collects data about the drug, such as contraindications, generic equivalents, and recommended dosage
	Unit nvarchar(10) not null, -- Drug unit of measure, like pill or bottle. Requires 10 characters
	Dosage nvarchar(10) not null, -- Drug dosage. Stores information about the drug’s strength and requires 10 characters
	DosageForm nvarchar(20) not null, -- Unit of measure for the drug strength. Does not exceed 20 characters
	Cost decimal(5,2) not null, -- One drug unit cost
	Price decimal(5,2) not null, -- One drug price
	Interactions nvarchar(40) not null, -- Possible drug interactions and possible reactions
	PregCategory nchar(1) not null, -- Pregnancy risk category
	Supplier nvarchar(100) not null, -- Drug supplier
	constraint pk_tblDrug primary key clustered -- Primary key
	(DIN asc)
)
;
go

/***** Table No. 11 - Prescription.tblRx ****/

create table Prescription.tblRx
(
	PrescriptionID int not null, -- Prescription ID
	DIN nvarchar(8) not null, -- Drug Identification Number. Unique, eight-digit (numeric characters) value. Not used in calculations
	Quantity decimal(5,2) not null, -- Amount of medication dispensed. Numeric field that might contain decimal places
	Unit nvarchar(10) not null, -- Drug unit of measure, like pill or bottle. Requires 10 characters
	Date date not null, -- Date when prescription is made. hould store two-digit months and days and four-digit years in the format ##/##/####
	ExpireDate date not null, -- Date when prescription expires. hould store two-digit months and days and four-digit years in the format ##/##/####
	Refills int not null, -- Number of refills authorized by the prescribing doctor
	AutoRefill nchar(3) not null, -- Customer’s preference (yes or no) for automatic refills. Default value is 'no'
	RefillsUsed int not null, -- Number of refills a customer has used
	Instructions nvarchar(50) not null, -- Medication directions. Does not exceed 50 characters
	CustID int not null, -- Customer ID. Foreign key in tblCustomer. Numeric
	DoctorID int not null, -- Doctor ID. Foreign key in tblDoctor. Numeric
	constraint pk_tblRx primary key clustered -- Primary key
	(PrescriptionID asc)
)
;
go

/***** Table No. 12 - Prescription.tblRefill ****/

create table Prescription.tblRefill
(
	PrescriptionID int not null, -- Foreign key in tblRx
	RefillDate date not null, -- Date when a refill was made
	EmpID int not null, -- Employee ID who made a refill. Foreign key in tblEmployee
    constraint pk_tblRefill primary key clustered (PrescriptionID, RefillDate) -- Composite primary key
)
;
go

/***** Table No. 13 - Employee.tblEmployeeHistory ****/
create table Employee.tblEmployeeHistory
(
	-- column_name data_type constraint_type(s)
	EHID int not null, -- assigned by the pharmacy using unique numbers
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
	constraint pk_tblEmployeeHistory primary key clustered -- Clustered Primary key
		(EHID asc)
)
;
go

/***** Table No. 14 - Employee.tblEmployeeTrainingHistory ****/
create table Employee.tblEmployeeTrainingHistory
(
	-- column_name data_type constraint_type(s)
	EmpID int not null, -- Field store numbers with no decimal places. (Foreign key EmpID in  table Employee.tblEmployee)
    Date date not null, -- The Date field stores the date of the training session. Display the date using the format ##/##/####.
    ClassID int not null, -- Field store numbers with no decimal places. (Foreign key ClassID in  table Employee.tblClass)
	-- constraint constraint_name constraint_type
	constraint pk_tblEmployeeTrainingHistory primary key clustered -- Clustered Composite Primary Key
		(EmpID, Date, ClassID)
)
;
go