Table Salaries:

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| company_id    | int     |
| employee_id   | int     |
| employee_name | varchar |
| salary        | int     |
+---------------+---------+
(company_id, employee_id) is the primary key for this table.
This table contains the company id, the id, the name, and the salary for an employee.
 

Write an SQL query to find the salaries of the employees after applying taxes. Round the salary to the nearest integer.

The tax rate is calculated for each company based on the following criteria:

0% If the max salary of any employee in the company is less than $1000.
24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
49% If the max salary of any employee in the company is greater than $10000.
Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Salaries table:
+------------+-------------+---------------+--------+
| company_id | employee_id | employee_name | salary |
+------------+-------------+---------------+--------+
| 1          | 1           | Tony          | 2000   |
| 1          | 2           | Pronub        | 21300  |
| 1          | 3           | Tyrrox        | 10800  |
| 2          | 1           | Pam           | 300    |
| 2          | 7           | Bassem        | 450    |
| 2          | 9           | Hermione      | 700    |
| 3          | 7           | Bocaben       | 100    |
| 3          | 2           | Ognjen        | 2200   |
| 3          | 13          | Nyancat       | 3300   |
| 3          | 15          | Morninngcat   | 7777   |
+------------+-------------+---------------+--------+
Output: 
+------------+-------------+---------------+--------+
| company_id | employee_id | employee_name | salary |
+------------+-------------+---------------+--------+
| 1          | 1           | Tony          | 1020   |
| 1          | 2           | Pronub        | 10863  |
| 1          | 3           | Tyrrox        | 5508   |
| 2          | 1           | Pam           | 300    |
| 2          | 7           | Bassem        | 450    |
| 2          | 9           | Hermione      | 700    |
| 3          | 7           | Bocaben       | 76     |
| 3          | 2           | Ognjen        | 1672   |
| 3          | 13          | Nyancat       | 2508   |
| 3          | 15          | Morninngcat   | 5911   |
+------------+-------------+---------------+--------+
Explanation: 
For company 1, Max salary is 21300. Employees in company 1 have taxes = 49%
For company 2, Max salary is 700. Employees in company 2 have taxes = 0%
For company 3, Max salary is 7777. Employees in company 3 have taxes = 24%
The salary after taxes = salary - (taxes percentage / 100) * salary
For example, Salary for Morninngcat (3, 15) after taxes = 7777 - 7777 * (24 / 100) = 7777 - 1866.48 = 5910.52, which is rounded to 5911.


# Write your MySQL query statement below
select company_id, employee_id, employee_name, 
CASE 
    WHEN (MAX(salary) OVER(PARTITION BY company_id)) < 1000 THEN salary
    WHEN (MAX(salary) OVER(PARTITION BY company_id)) BETWEEN 1000 AND 10000 THEN ROUND(salary*0.76,0)
    WHEN (MAX(salary) OVER(PARTITION BY company_id)) > 10000 THEN ROUND(salary*0.51,0)
END AS salary
from Salaries

#?????????solution 03/23/2022
# Write your MySQL query statement below

select Salaries.company_id, Salaries.employee_id, Salaries.employee_name, round(salary_after_cal*Salaries.salary,0) as salary
from (
select company_id, 
case 
    when max(salary) < 1000 then 1
    when max(salary)>=1000 and max(salary)<= 10000 then 0.76
    when max(salary) > 10000 then 0.51
end as salary_after_cal
from Salaries
group by company_id)TableA
right join Salaries using(company_id) 