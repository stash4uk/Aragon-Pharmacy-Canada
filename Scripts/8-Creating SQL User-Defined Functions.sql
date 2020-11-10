-- switch to the Aragon2020 database
USE Aragon2020
;
GO

/* 1. Create a function and save as ClassCostAnalysisFn. 
Kim is preparing the human resources budget for Aragon Pharmacy and needs 
to analyze the annual cost of training to determine how much to budget for training classes. 
She asks you to provide summary data for the costs by year for classes. The results you create 
should clearly compare the total annual costs of training classes and the annual costs per class.*/

if OBJECT_ID('Employee.ClassCostAnalysisFn', 'IF') is not null
	drop function Employee.ClassCostAnalysisFn
;
go

create function Employee.ClassCostAnalysisFn
(
	@Year as datetime
)
returns table
as
return  (select
            coalesce(EC.Description, 'Total Annual Costs') as 'Class',
            sum(EC.Cost) as 'Annual Cost'
        from Employee.tblEmployeeTraining as EET
            inner join Employee.tblClass as EC
                on EET.ClassID = EC.ClassID
        where YEAR(EET.Date) = @Year
        group by EC.Description
        with ROLLUP)
;
go

select * 
from Employee.ClassCostAnalysisFn(2016)
;
go

/* 2. Create a function and save as EmpHistoryFn. 
Kim needs to remove obsolete data from the Hudson database. 
First, she asks you to identify all employees who no longer work for Aragon Pharmacy. 
She then wants you to create a new history table with that data. Name the history table tblEmployeeHistory.*/

if OBJECT_ID('Employee.EmpHistoryFn', 'IF') is not null
	drop function Employee.EmpHistoryFn
;
go

create function Employee.EmpHistoryFn
(
)
returns table
as
return  
		(select
        concat_ws(' ', EmpFirst, EmpLast) as 'Employee Name',
        EndDate as 'Employee Last Work Date'
        from Employee.tblEmployee
		where EndDate is not null
        )
;
go 

select * from Employee.EmpHistoryFn()
;
go

if OBJECT_ID ('Employee_Delete', 'TR') IS NOT NULL  
   drop trigger Employee_Delete;
   go

create trigger TR_Employee_Delete
on Employee.tblEmployee
after delete
as
begin
	set nocount on;
	insert into Employee.tblEmployeeHistory
		select *
		from deleted
end
;
go

drop procedure if EXISTS Employee.DeleteEmployeeSp
;  
go

create procedure
   Employee.DeleteEmployeeSp
   
 as
	begin		
		
		delete from Employee.tblEmployee
		where EndDate is not null
		
	end
;
go

alter table Prescription.tblRefill
drop constraint fk_tblRefill_tblEmployee
;
go

execute Employee.DeleteEmployeeSp
;
go

alter table Prescription.tblRefill
add constraint fk_tblRefill_tblEmployee foreign key (EmpID)
		references Employee.tblEmployee (EmpID)
;
go

select * from Employee.tblEmployee
select * from Employee.tblEmployeeHistory






/* 3. Create a function and save as EmployeeTrainingHistoryFn. 
Kim also wants to remove records for classes that employees have completed 
and for which their certification has already been updated. 
She asks you to select classes in which employees earn certification—Adult CPR, Adult CPR Recertification, 
Child/Infant CPR, and Child/Infant CPR Recertification—and that they attended before January 1, 2017 
because certification achieved in these classes is now out of date in Canada. Create a history table 
that contains this data and name the table tblEmployeeTrainingHistory.*/


if OBJECT_ID('Employee.EmployeeTrainingHistoryFn', 'IF') is not null
    drop function Employee.EmployeeTrainingHistoryFn
;
go

create function Employee.EmployeeTrainingHistoryFn
(
    @Date as datetime,
    @Class1 as varchar(40),
	@Class2 as varchar(40),
	@Class3 as varchar(40),
	@Class4 as varchar(40)
)
returns table
as
return  (select
           EET.EmpID,
           EET.Date,
           EET.ClassID,
           EC.Description
        from Employee.tblEmployeeTraining as EET
            inner join Employee.tblClass as EC
                on EET.ClassID = EC.ClassID
        where EC.Description in (@Class1,@Class2,@Class3,@Class4)
        and datediff(day, @Date, EET.Date) < 0
        )
;
go 

select * 
from Employee.EmployeeTrainingHistoryFn('2017-01-01', 'Adult CPR','Adult CPR Recertification',
'Child/Infant CPR','Child/Infant CPR Recertification')
;
go


drop procedure if EXISTS Employee.InsertEmployeeTrainingHistoryFn
;  
go

create procedure
   Employee.InsertEmployeeTrainingHistorySP
   @Date as datetime,
   @Class1 as varchar(40),
   @Class2 as varchar(40),
   @Class3 as varchar(40),
   @Class4 as varchar(40)
 as
    begin
        insert into Employee.tblEmployeeTrainingHistory (EmpID, Date, ClassID)
        select EmpID, Date, ClassID
        from Employee.EmployeeTrainingHistoryFn(@Date, @Class1,@Class2,@Class3,@Class4)
    end
;
go
    
execute Employee.InsertEmployeeTrainingHistorySP 
@Date = '2017-01-01', 
@Class1 = 'Adult CPR',
@Class2 = 'Adult CPR Recertification',
@Class3 = 'Child/Infant CPR',
@Class4 = 'Child/Infant CPR Recertification'
;
go

select  * from Employee.tblEmployeeTrainingHistory
;
go
select  * from Employee.tblEmployeeTraining
;
go

TRUNCATE table Employee.tblEmployeeTrainingHistory
;
go
TRUNCATE table Employee.tblEmployeeTraining
;
go

/* 4. Create a function and save as ObsoleteClassesFn. 
Kim checked your results and realizes that tblEmployeeTrainingHistory 
should also include obsolete data for Defibrillator Use classes. 
Add the obsolete training records for Defibrillator Use classes to tblEmployeeTrainingHistory. 
Because Kim will continue to use this view for other classes as they become outdated, set up the view 
so that it prompts her for the necessary criteria (parameter) before running. 
Defibrillator Use certifications before 1/1/2017 are no longer valid.*/

if OBJECT_ID('Employee.ObsoleteClassesFn', 'IF') is not null
    drop function Employee.ObsoleteClassesFn
;
go

create function Employee.ObsoleteClassesFn
(
    @Date as datetime,
    @Class as varchar(40)
)
returns table
as
return  (select
           EET.EmpID,
           EET.Date,
           EET.ClassID,
           EC.Description
        from Employee.tblEmployeeTraining as EET
            inner join Employee.tblClass as EC
                on EET.ClassID = EC.ClassID
        where EC.Description = @Class
        and datediff(day, @Date, EET.Date) < 0
        )
;
go 

select * 
from Employee.ObsoleteClassesFn('2017-01-01', 'Defibrillator Use')
;
go

drop procedure if EXISTS Employee.InsertObsoleteClassesSp
;  
go

create procedure
   Employee.InsertObsoleteClassesSp
   @Date as datetime,
   @Class as varchar(40)
 as
    begin
        insert into Employee.tblEmployeeTrainingHistory (EmpID, Date, ClassID)
        select EmpID, Date, ClassID
        from Employee.ObsoleteClassesFn(@Date, @Class)
    end
;
go
    
execute Employee.InsertObsoleteClassesSp 
@Date = '2017-01-01', 
@Class = 'Defibrillator Use'
;
go

select  * from Employee.tblEmployeeTrainingHistory
;
go
select  * from Employee.tblEmployeeTraining
;
go

TRUNCATE table Employee.tblEmployeeTrainingHistory
;
go

TRUNCATE table Employee.tblEmployeeTraining
;
go



/* 5. Create a function and save as DeleteClassesView. 
Verify that tblEmployeeTrainingHistory includes all the obsolete classes. Delete the now archived records from tblEmployeeTraining. 
As with qryObsoleteClasses, Kim will continue to use this query to remove obsolete records after they’ve been archived. 
Set up the query so that it prompts her for the necessary criteria (parameter) before running. 
Make sure the total number of records you deleted is the same as the number of records in tblEmployeeTrainingHistory.*/

drop procedure if EXISTS Employee.DeleteClassesSp
;  
go

create procedure
   Employee.DeleteClassesSp
   @Date as datetime,
   @Class1 as varchar(40),
   @Class2 as varchar(40),
   @Class3 as varchar(40),
   @Class4 as varchar(40),
   @Class5 as varchar(40)
as
begin				
	delete from Employee.tblEmployeeTraining
	where Date < @Date
	and ClassID in	
		(
		select ET.ClassID
		from Employee.tblEmployeeTraining as ET
		inner join Employee.tblClass as C
		on ET.ClassID = C.ClassID
		where C.Description in
		(@Class1, @Class2, @Class3, @Class4, @Class5)
		)		
end
;
go

execute Employee.DeleteClassesSp
@Date = '2017-01-01', 
@Class1 = 'Adult CPR',
@Class2 = 'Adult CPR Recertification',
@Class3 = 'Child/Infant CPR',
@Class4 = 'Child/Infant CPR Recertification',
@Class5 = 'Defibrillator Use'
;
go

/* ------------- trigger 5 ------------- */
if OBJECT_ID ('EmployeeTraining_Delete', 'TR') IS NOT NULL  
   drop trigger EmployeeTraining_Delete;
   go

create trigger TR_EmployeeTraining_Delete
on Employee.tblEmployeeTraining
after delete
as
begin
	set nocount on;
	insert into Employee.tblEmployeeTrainingHistory (EmpID, Date, ClassID)
		select *
		from deleted
end
;
go

-- Version 2
if OBJECT_ID ('Employee.EmployeeTraining_Delete_TR', 'TR') IS NOT NULL  
   drop trigger Employee.EmployeeTraining_Delete_TR
;
go

select * from sysobjects where name = 'EmployeeTraining_Delete_TR'
;
go

create trigger EmployeeTraining_Delete_TR
on Employee.tblEmployeeTrainingHistory
after insert
as
begin
    set nocount on;
    PRINT '**********Transferred Rows***************'
    SELECT * from inserted
    delete from Employee.tblEmployeeTraining
    where EmpID in (select EmpID from inserted) 
    and Date in (select Date from inserted) 
    and ClassID in (select ClassID from inserted)
end
;
go

/* 6. Create a function and save as TechnicianRaiseFn. 
Kim recently met with Mai Yan, manager of Aragon Pharmacy, who authorized a 5% raise 
for all current pharmacy technicians. Update the employee records for pharmacy technicians 
so that their pay rate includes this 5% raise.*/

drop procedure if EXISTS Employee.TechnicianRaiseSp
;  
go

create procedure
   Employee.TechnicianRaiseSp
   @Percent as float,
   @Title as varchar(30)
 as
    begin
        update Employee.tblEmployee
        set HourlyRate += (HourlyRate * @Percent)/100
			from Employee.tblEmployee as EE
			    inner join Employee.tblJobTitle as EJT
			        on EE.JobId = EJT.JobId
			where EJT.Title = @Title
    end
;
go
    
execute Employee.TechnicianRaiseSp
@Percent = 5, 
@Title = 'Technician'
;
go

SELECT * from Employee.tblEmployee;
go
/* 7. Create a function and save as RetirementView. 
Current Aragon Pharmacy employees are eligible for participation in a 401(k)-retirement plan after one year. 
Identify each employee by full name and show whether they are eligible for the plan 
with a column stating “Eligible” or “Not Eligible” in the results.*/


if OBJECT_ID('Employee.RetirementViewFn', 'IF') is not null
    drop function Employee.RetirementViewFn
;
go

create function Employee.RetirementViewFn
(
)
returns table
as
return  
        (select
        concat_ws(' ', EmpFirst, EmpLast) as 'Employee Name',
        StartDate as 'Employee Start Date',
        'Eligible' as 'Retirement Plan Status'
        from Employee.tblEmployee
        where abs(datediff(day, StartDate, GETDATE())) > 365
        union 
        select
        concat_ws(' ', EmpFirst, EmpLast) as 'Employee Name',
        StartDate as 'Employee Start Date',
        'Not Eligible' as 'Retirement Plan Status'
        from Employee.tblEmployee
        where abs(datediff(day, StartDate, GETDATE())) < 365
        )
;
go 

select * from Employee.RetirementViewFn()
;
go

select * from Employee.tblEmployee
;
go



/* 8. Create a function and save as Top3SalariesFn. Kim is meeting with Mai later today and needs to report 
which salaried employees earn the top three salaries. Create a query in SQL view that lists all employees who earn the 
top three salaries. Be certain to separate the SQL terms to make it more readable.*/

if OBJECT_ID('Employee.Top3SalariesFn', 'IF') is not null
	drop function Employee.Top3SalariesFn
;
go

create function Employee.Top3SalariesFn
(
)
returns table
as
return  (select top 3
		concat_ws(' ', EmpFirst, EmpLast) as 'Employee Name',
		Salary as 'Employee Salary'
		from Employee.tblEmployee
        where Salary > 0
		order by Salary desc
        )
;
go 

select * 
from Employee.Top3SalariesFn()
;
go