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

/***** Table No. 6 - Customer.tblHousehold ****/

alter table Employee.tblEmployee
	add constraint fk_tblEmployee_tblJobTitle foreign key (JobID)
		references Employee.tblJobTitle (JobID)
;
go

/***** Table No. 7 - Customer.tblCustomer ****/

alter table Customer.tblCustomer
	add constraint fk_tblCustomer_tblHousehold foreign key (HouseId)
		references Customer.tblHousehold (HouseId)
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

/***** Table No. 10 - Prescription.tblDrug ****/

/***** Table No. 11 - Prescription.tblRx ****/

/***** Table No. 12 - Prescription.tblRefill ****/