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

/* 3. Create a function and save as EmployeeTrainingHistoryFn. 
Kim also wants to remove records for classes that employees have completed 
and for which their certification has already been updated. 
She asks you to select classes in which employees earn certification—Adult CPR, Adult CPR Recertification, 
Child/Infant CPR, and Child/Infant CPR Recertification—and that they attended before January 1, 2017 
because certification achieved in these classes is now out of date in Canada. Create a history table 
that contains this data and name the table tblEmployeeTrainingHistory.*/

/* 4. Create a function and save as ObsoleteClassesFn. 
Kim checked your results and realizes that tblEmployeeTrainingHistory 
should also include obsolete data for Defibrillator Use classes. 
Add the obsolete training records for Defibrillator Use classes to tblEmployeeTrainingHistory. 
Because Kim will continue to use this view for other classes as they become outdated, set up the view 
so that it prompts her for the necessary criteria (parameter) before running. 
Defibrillator Use certifications before 1/1/2017 are no longer valid.*/

/* 5. Create a function and save as DeleteClassesView. 
Verify that tblEmployeeTrainingHistory includes all the obsolete classes. Delete the now archived records from tblEmployeeTraining. 
As with qryObsoleteClasses, Kim will continue to use this query to remove obsolete records after they’ve been archived. 
Set up the query so that it prompts her for the necessary criteria (parameter) before running. 
Make sure the total number of records you deleted is the same as the number of records in tblEmployeeTrainingHistory.*/

/* 6. Create a function and save as TechnicianRaiseFn. 
Kim recently met with Mai Yan, manager of Aragon Pharmacy, who authorized a 5% raise 
for all current pharmacy technicians. Update the employee records for pharmacy technicians 
so that their pay rate includes this 5% raise.*/

/* 7. Create a function and save as RetirementView. 
Current Aragon Pharmacy employees are eligible for participation in a 401(k)-retirement plan after one year. 
Identify each employee by full name and show whether they are eligible for the plan 
with a column stating “Eligible” or “Not Eligible” in the results.*/

/* 8. Create a function and save as Top3SalariesFn. Kim is meeting with Mai later today and needs to report 
which salaried employees earn the top three salaries. Create a query in SQL view that lists all employees who earn the 
top three salaries. Be certain to separate the SQL terms to make it more readable.*/