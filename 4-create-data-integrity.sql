-- switch to the Aragon2020 database
USE Aragon2020
;
GO

            -- Artem Garanin part

/***** Table No. 1 - Employee.tblClass ****/

/***** Table No. 2 - Employee.tblJobTitle ****/

/***** Table No. 3 - Employee.tblEmployee ****/

alter table Employee.tblEmployee
	add constraint fk_tblEmployee_tblJobTitle foreign key (JobID)
		references Employee.tblJobTitle (JobID)
;
go
alter table Employee.tblEmployee
	add constraint ck_Phone_tblEmployee check (Phone LIKE
    '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go
alter table Employee.tblEmployee
	add constraint ck_Cell_tblEmployee check (Cell LIKE
    '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go
alter table Employee.tblEmployee
	add constraint ck_PostalCode_tblEmployee check (PostalCode LIKE 
	'[A-Z][0-9][A-Z] [0-9][A-Z][0-9]')
;
go
alter table Employee.tblEmployee
	add constraint ck_Province_tblEmployee check (Province LIKE 
	'[A-Z][A-Z]')
;
go
alter table Employee.tblEmployee
	add constraint ck_SIN_tblEmployee check (SIN LIKE 
	'[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]')
;
go
alter table Employee.tblEmployee
	add constraint ck_StartDate_tblEmployee check (StartDate like 
	'[0-1][0-9]/[0-3][0-9]/[1-2][0-9][0-9][0-9]')
;
go
alter table Employee.tblEmployee
	add constraint ck_EndDate_tblEmployee check (EndDate like 
	'[0-1][0-9]/[0-3][0-9]/[1-2][0-9][0-9][0-9]')
;
go
alter table Employee.tblEmployee
	add constraint ck_Review_tblEmployee check (Review like 
	'[0-1][0-9]/[0-3][0-9]/[1-2][0-9][0-9][0-9]')
;
go
alter table Employee.tblEmployee
	add constraint df_Province_tblEmployee default ('QC') for Province
;
go

/***** Table No. 4 - Employee.tblEmployeeTraining ****/

alter table Employee.tblEmployeeTraining
	add constraint fk_tblEmployeeTraining_tblEmployee foreign key (EmpID)
		references Employee.tblEmployee (EmpID)
;
go

alter table Employee.tblEmployeeTraining
	add constraint fk_tblEmployeeTraining_tblClass foreign key (ClassID)
		references Employee.tblClass (ClassID)
;
go

            -- Vladimir Tocari part

/***** Table No. 5 - Customer.tblHealthPlan ****/

alter table Customer.tblHealthPlan
constraint ck_Province_tblHealthPlan check (Province LIKE '[A-Z][A-Z]') -- check that entered values is not a digit
;
go
alter table Customer.tblHealthPlan
constraint ck_phone_tblHealthPlan check (Phone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

alter table Customer.tblHealthPlan
add constraint df_Province_tblHealthPlan default ('QC') for Province
;
go

/***** Table No. 6 - Customer.tblHousehold ****/
alter table Customer.tblHousehold
add constraint ck_Province_tblHousehold check (Province LIKE '[A-Z][A-Z]') -- check that entered values is not a digit
;
go
alter table Customer.tblHousehold
add constraint df_Province_tblHousehold default ('QC') for Province
;
go

/***** Table No. 7 - Customer.tblCustomer ****/
alter table Customer.tblCustomer
	add constraint fk_tblCustomer_tblHousehold foreign key (HouseId)
		references Customer.tblHousehold (HouseId)
;
go

alter table Customer.tblCustomer
add constraint fk_tblCustomer_tblHealthPlan foreign key (PlanId)
		references Customer.tblHealthPlan (PlanId)
;
go
alter table Customer.tblCustomer
add constraint check_Phone_tblCustomer check (Phone like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go
            -- Ihor Stashchuk part

/***** Table No. 8 - Prescription.tblClinic ****/

alter table Prescription.tblClinic
add constraint ck_Province_tblClinic check (Province like '[A-Z][A-Z]')
;
go

alter table Prescription.tblClinic
add constraint ck_PostalCode_tblClinic check (PostalCode like '[A-Z][0-9][A-Z] [0-9][A-Z][0-9]')
;
go

alter table Prescription.tblClinic
add constraint ck_Phone_tblClinic check (Phone like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

/***** Table No. 9 - Prescription.tblDoctor ****/

alter table Prescription.tblDoctor
add constraint ck_Phone_tblDoctor check (Phone like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

alter table Prescription.tblDoctor
add constraint ck_Cell_tblDoctor check (Cell like '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
;
go

alter table Prescription.tblDoctor
	add constraint fk_tblDoctor_tblClinic foreign key (ClinicID)
		references Prescription.tblClinic (ClinicID)
;
go

/***** Table No. 10 - Prescription.tblDrug ****/

alter table Prescription.tblDrug
	add constraint uq_DIN_tblDrug unique (DIN)
;
go

/***** Table No. 11 - Prescription.tblRx ****/

alter table Prescription.tblRx
	add constraint uq_DIN_tblRx unique (DIN)
;
go

alter table Prescription.tblRx
add constraint ck_Date_tblRx check (Date like '[0-1][0-9]/[0-3][0-9]/[1-2][0-9][0-9][0-9]')
;
go

alter table Prescription.tblRx
add constraint ck_ExpireDate_tblRx check (ExpireDate like '[0-1][0-9]/[0-3][0-9]/[1-2][0-9][0-9][0-9]')
;
go

alter table Prescription.tblRx
	add constraint df_AutoRefill_tblRx default ('No') for AutoRefill
;
go

alter table Prescription.tblRx
	add constraint fk_tblRx_tblCustomer foreign key (CustID)
		references Customer.tblCustomer (CustID)
;
go

alter table Prescription.tblRx
	add constraint fk_tblRx_tblDrug foreign key (DIN)
		references Prescription.tblDrug (DIN)
;
go

alter table Prescription.tblRx
	add constraint fk_tblRx_tblDoctor foreign key (DoctorID)
		references Prescription.tblDoctor (DoctorID)
;
go

/***** Table No. 12 - Prescription.tblRefill ****/

alter table Prescription.tblRefill
	add constraint fk_tblRefill_tblEmployee foreign key (EmpID)
		references Employee.tblEmployee (EmpID)
;
go

alter table Prescription.tblRefill
	add constraint fk_tblRefill_tblRx foreign key (PrescriptionID)
		references Prescription.tblRx (PrescriptionID)
;
go
