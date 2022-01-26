Table: Scores

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| score       | decimal |
+-------------+---------+
id is the primary key for this table.
Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
 

Write an SQL query to rank the scores. The ranking should be calculated according to the following rules:

The scores should be ranked from the highest to the lowest.
If there is a tie between two scores, both should have the same ranking.
After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order.

The query result format is in the following example.

 

Example 1:

Input: 
Scores table:
+----+-------+
| id | score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
Output: 
+-------+------+
| score | rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+

# Write your MySQL query statement below
select score, 
       dense_rank() over (order by score desc)
       as 'rank'
from Scores

# 错误
# Write your MySQL query statement below
select score, 
       dense_rank() over (partition by id order by score desc) # 不应该加partition by
       as 'rank'
from Scores
# input
{"headers": {"Scores": ["id", "score"]}, "rows": {"Scores": [[1, 3.50], [2, 3.65], [3, 4.00], [4, 3.85], [5, 4.00], [6, 3.65]]}}
# 错误的output
{"headers": ["score", "rank"], "values": [[3.50, 1], [3.65, 1], [4.00, 1], [3.85, 1], [4.00, 1], [3.65, 1]]}

# dense_rank()例子
SELECT
    sales_employee,fiscal_year,sale,
    DENSE_RANK() OVER (PARTITION BY fiscal_year ORDER BY sale DESC) sales_rank
FROM
    sales; 

# 例子output
+----------------+-------------+--------+------------+
| sales_employee | fiscal_year | sale   | sales_rank |
+----------------+-------------+--------+------------+
| John           |        2016 | 200.00 |          1 |
| Alice          |        2016 | 150.00 |          2 |
| Bob            |        2016 | 100.00 |          3 |
| Bob            |        2017 | 150.00 |          1 |
| John           |        2017 | 150.00 |          1 |
| Alice          |        2017 | 100.00 |          2 |
| John           |        2018 | 250.00 |          1 |
| Alice          |        2018 | 200.00 |          2 |
| Bob            |        2018 | 200.00 |          2 |
+----------------+-------------+--------+------------+