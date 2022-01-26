Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
set N=N-1;   # 在这设置
  RETURN (
      # Write your MySQL query statement below.
      select 
      ifnull(
          (select distinct salary
           from Employee
           order by salary DESC
           limit N,1),null)      
  );
END


#错误

# CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
# BEGIN
# set N=N-1;   # 应该在这设置set
#   RETURN (
#       # Write your MySQL query statement below.
#       select 
#       ifnull(
#           (select distinct salary
#            from Employee
#            order by salary DESC
#            limit N-1,1),null)
#       as getNthHighestSalary(N)     ## 不需要哦   
#   );
# END