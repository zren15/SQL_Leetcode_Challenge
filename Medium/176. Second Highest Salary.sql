Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

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
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

# Write your MySQL query statement below
select 
ifnull(
    (select distinct salary 
       from Employee
       order by salary DESC
       limit 1 offset 1),null
) as SecondHighestSalary

# 来看怎么取排名第二的数据

#方法1，先取得最大的，然后not in 最大的那个，在剩下的取最大的就是第二个。
#select Max(Salary ) from Employee where Salary not in (select Max(Salary ) from Employee )

 

#方法2，使用limit
#select Salary from Employee order by Salary limit 1,1
## SELECT * FROM table LIMIT 5,10; //检索记录行6-15
## SELECT * FROM table LIMIT 95,-1; // 检索记录行 96-last 

#方法3，使用limit 和 offset
#select Salary from Employee order by limit 1 offset 1
# limit X offset Y  从第Y条开始，选取X条。
# limit 1 offset 1（从第2条开始，选一条，所以就是排名第二的那条）