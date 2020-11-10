-- switch to the Aragon2020 database
USE Aragon2020
;
GO

/* 1. Create a view and save it as DuplicatePostalCodesView. 
Kim wants to identify employees who live in the same neighborhood in Montreal 
so they can create carpools and share rides to work. In Montreal, the postal codes roughly correspond to neighborhood. 
Prepare a list of employees who live in the same neighborhood so that Kim can create a list of employees 
who can share rides to work.*/
if OBJECT_ID('Employee.DuplicatePostalCodesView', 'V') is not null
	drop view Employee.DuplicatePostalCodesView
;
go

create view Employee.DuplicatePostalCodesView
as
select concat_ws(' ', EE.EmpFirst, EE.EmpMI + '.', EE.EmpLast) as 'Employee',
EE.PostalCode
from Employee.tblEmployee as EE
where EE.PostalCode
in  (select PostalCode
    from Employee.tblEmployee
    group by PostalCode
    having count(PostalCode) > 1)
group by EE.PostalCode, EE.EmpFirst, EE.EmpMI, EE.EmpLast
;
go

select * 
from Employee.DuplicatePostalCodesView
;
go

--Version 2. Duplicate first 3 character of the Postal code
if OBJECT_ID('Employee.DuplicatePostalCodesV2View', 'V') is not null
	drop view Employee.DuplicatePostalCodesV2View
;
go

create view Employee.DuplicatePostalCodesV2View
as
select concat_ws(' ', EE.EmpFirst, EE.EmpMI + '.', EE.EmpLast) as 'Employee',
EE.PostalCode
from Employee.tblEmployee as EE
where left(EE.PostalCode, 3) 
in  (select left(PostalCode, 3)
    from Employee.tblEmployee
    group by left(PostalCode, 3)
    having count(left(PostalCode, 3)) > 1)
group by EE.PostalCode, EE.EmpFirst, EE.EmpMI, EE.EmpLast
;
go

select * 
from Employee.DuplicatePostalCodesV2View
;
go
/* 2. Create a view and save it as NoTrainingView. 
A new policy at Aragon Pharmacy is that all employees must acquire and maintain certifications in adult, infant, 
and child CPR and in using defibrillators. Kim asks you to identify employees who have not completed any certification training.*/
if OBJECT_ID('Employee.NoTrainingView', 'V') is not null
	drop view Employee.NoTrainingView
;
go

create view Employee.NoTrainingView
as
select
concat_ws(' ', E.EmpFirst, E.EmpLast) as 'Employee Name',
coalesce(C.Description, 'No Certification') as 'Certification'
from Employee.tblEmployee as E
left outer join Employee.tblEmployeeTraining as ET
on E.EmpID = ET.EmpID
left outer join Employee.tblClass as C
on ET.ClassID = C.ClassID
where ET.ClassID is null
;
go

select * from Employee.NoTrainingView
;
go

/* 3. Create a view and save it as EmployeeTrainingView. 
Kim also needs to list all employees and the classes they have taken. The results should include current employees 
who have not attended training as well as those who have.*/
if OBJECT_ID('Employee.EmployeeTrainingView', 'V') is not null
	drop view Employee.EmployeeTrainingView
;
go

create view Employee.EmployeeTrainingView 
AS 
select EE.EmpID as 'Employee ID', EE.EmpFirst as 'First Name', EE.EmpLast as 'Last Name', coalesce(EET.classId, '0') as 'Class ID',
coalesce(EC.Description, 'Not attended') as 'Class Description'
from ((Employee.tblEmployeeTraining as EET
right join Employee.tblEmployee as EE on EET.EmpID = EE.EmpID)
left join Employee.tblClass as EC on EET.classId = EC.classId)
;
go

select *
from Employee.EmployeeTrainingView
;
go
/* 4. Create a view and save it as UpToDateView. 
Kim also needs to identify employees whose CPR or defibrillator certification has expired, 
depending on the time period she specifies. Show all employees whose Adult CPR, Child/Infant CPR, 
or Defibrillator Use certification has expired in any specified time period.*/
if OBJECT_ID('Employee.UpToDateView', 'V') is not null
	drop view Employee.UpToDateView
;
go

create view Employee.UpToDateView
as
select 
    concat_ws(' ', EE.EmpFirst, EE.EmpMI + '.', EE.EmpLast) as 'Employee',
    EC.Description as 'Certification',
    EEt.Date as 'Expired Date'
from Employee.tblEmployeeTraining as EET
    inner join Employee.tblClass as EC
        on EET.ClassID = EC.ClassID
    inner join Employee.tblEmployee as EE
        on EET.EmpID = EE.EmpID
where EC.Description in ('Adult CPR','Child/Infant CPR','Defibrillator Use')
and abs(datediff(month, EET.Date, GETDATE())) > 60
;
go

select * 
from Employee.UpToDateView
;
go
/* 5. Create a view and save it as Top5HourlyRatesView. Mai Yan, manager of Aragon Pharmacy, 
wants to identify the five current non-salaried employees who are earning the highest wages per hour. 
These are the five employees who have been working for the pharmacy the longest or who have regularly received raises 
for their work. List the top five wage earners of all the current non-salaried employees.*/
if OBJECT_ID('Employee.Top5HourlyRatesView', 'V') is not null
	drop view Employee.Top5HourlyRatesView
;
go

create view Employee.Top5HourlyRatesView
as
select top 5
concat_ws(' ', EmpFirst, EmpLast) as 'Employee Name',
HourlyRate as 'Hourly Rate',
StartDate as 'Start Date',
Review as 'Last Review'
from Employee.tblEmployee
where EndDate is null
and
HourlyRate > 0
order by StartDate asc
;
go

select * from Employee.Top5HourlyRatesView
;
go

/* 6. Create a view and save it as MaxMinAvgHourlyRate. 
To prepare for employee reviews, Kim needs to calculate the minimum, maximum, 
and average hourly rates for each job category. Provide this information for her.*/
if OBJECT_ID('Employee.MaxMinAvgHourlyRate', 'V') is not null
	drop view Employee.MaxMinAvgHourlyRate
;
go

create view Employee.MaxMinAvgHourlyRate AS 
select
EE.JobID as 'Job ID',
EJT.Title as 'Job Title',
max(EE.HourlyRate) as 'Max hourly rate',
min(EE.HourlyRate) as 'Min hourly rate',
AVG(EE.HourlyRate) as 'Average hourly rate'
from Employee.tblEmployee as EE
inner join Employee.tblJobTitle as EJT   on EE.JobID = EJT.JobID
group by EE.JobID, EJT.Title
;
go

select *
from Employee.MaxMinAvgHourlyRate
;
go

/* 7. Create a view and save it as EmployeeAge. 
Mai is considering offering life insurance as an employee benefit and needs to know the current age of all employees. 
Provide this information for her. Be certain to provide an appropriate name 
for the column with the result and to show the ages in descending order. 
Include the job title and format the results so that they include one decimal place. 
Also show the first name and last name together.*/
if OBJECT_ID('Employee.EmployeeAgeView', 'V') is not null
	drop view Employee.EmployeeAgeView
;
go

create view Employee.EmployeeAgeView
as
select top 1000
    concat_ws(' ', EE.EmpFirst, EE.EmpMI + '.', EE.EmpLast) as 'Employee',
    EJT.Title as 'Job Title',
    FORMAT(ABS(DATEDIFF(YEAR, EE.DOB, GETDATE())), 'N1') as 'Current Age'
from Employee.tblEmployee as EE
    inner join Employee.tblJobTitle as EJT
        on EE.JobID = EJT.JobID
order by [Current Age] desc
;
go

select * 
from Employee.EmployeeAgeView
;
go
/* 8. Create a view and save it as AvgEmployeeAgeView. 
Kim asks you to provide one other statistical analysis. Show the average age of employees by job title.
*/
if OBJECT_ID('Employee.AvgEmployeeAgeView', 'V') is not null
	drop view Employee.AvgEmployeeAgeView
;
go

create view Employee.AvgEmployeeAgeView
as
select 
JT.Title as 'Job Title',
avg(datediff(year, E.DOB, getdate())) as 'Employee Average Age'
from Employee.tblEmployee as E
inner join Employee.tblJobTitle as JT
on E.JobID = JT.JobID
group by 
JT.Title 
;
go

select * 
from Employee.AvgEmployeeAgeView
;
go