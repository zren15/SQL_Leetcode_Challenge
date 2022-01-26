Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
id is the primary key for this table.
 

Write an SQL query to find all numbers that appear at least three times consecutively.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.

# Write your MySQL query statement below
SELECT distinct num as ConsecutiveNums
FROM
(
    SELECT id, num, 
    Lag(Num,1)OVER(order by id) as num_1,      #选择指定行的向后一行的内容
    lead(Num,1)over(order by id) as num_2      #选择指定行的向前一行的内容
    FROM logs
) next_prev
WHERE num = num_1 and num_1 = num_2



例子 #1

# lag ，lead 分别是向前，向后；
# lag 和lead 有三个参数，第一个参数是列名，第二个参数是偏移的offset，第三个参数是 超出记录窗口时的默认值）

select id,name,lead(name,1,0) over ( order by id )  from kkk;
                                                                   
        ID NAME                 LEAD(NAME,1,0)OVER(ORDERBYID)    
---------- -------------------- -----------------------------    
         1 1name                2name                            
         2 2name                3name                            
         3 3name                4name                            
         4 4name                5name                            
         5 5name                0        

例子 #2

SELECT 
    customerName,
    orderDate,
    LEAD(orderDate,1) OVER (                   #返回的值是向前一行的orderDate，没有定义后续行，返回NULL。
        PARTITION BY customerNumber            #根据customerNumber分组
        ORDER BY orderDate ) nextOrderDate     #根据orderDate排序
FROM 
    orders
INNER JOIN customers USING (customerNumber); 

结果输出：
+------------------------------------+------------+---------------+
| customerName                       | orderDate  | nextOrderDate |
+------------------------------------+------------+---------------+
| Atelier graphique                  | 2013-05-20 | 2014-09-27    |
| Atelier graphique                  | 2014-09-27 | 2014-11-25    |
| Atelier graphique                  | 2014-11-25 | NULL          |
| Signal Gift Stores                 | 2013-05-21 | 2014-08-06    |
| Signal Gift Stores                 | 2014-08-06 | 2014-11-29    |
| Signal Gift Stores                 | 2014-11-29 | NULL          |
| Australian Collectors, Co.         | 2013-04-29 | 2013-05-21    |
| Australian Collectors, Co.         | 2013-05-21 | 2014-02-20    |
| Australian Collectors, Co.         | 2014-02-20 | 2014-11-24    |
| Australian Collectors, Co.         | 2014-11-24 | 2014-11-29    |
| Australian Collectors, Co.         | 2014-11-29 | NULL          |
| La Rochelle Gifts                  | 2014-07-23 | 2014-10-29    |
| La Rochelle Gifts                  | 2014-10-29 | 2015-02-03    |
| La Rochelle Gifts                  | 2015-02-03 | 2015-05-31    |
| La Rochelle Gifts                  | 2015-05-31 | NULL          |
| Baane Mini Imports                 | 2013-01-29 | 2013-10-10    |
| Baane Mini Imports                 | 2013-10-10 | 2014-10-15    |
...

