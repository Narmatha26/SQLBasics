/* This chapter deals with JOINS

-- JOIN/INNER JOIN

JOIN is keyword is used to collect data by joining two or more tables together.
It can be used as another FROM clause to denote another table's name
ON clause specifies the column on which you'd like to merge the two tables together.
Dot operator is used to denote the table name along with the respective column names.
 */

/* This query pulls all the columns from both the tables by merging the account_id in orders table and 
id in accounts table */
/* NOTE: SELECT orders.*, accounts.* is similar to SELECT * 
in the coumns fetched but not the order of columns fetched*/
SELECT orders.*, accounts.*
FROM orders
INNER JOIN accounts
ON orders.account_id = accounts.id;

/* This query pulls only two columns viz., occurred_at column from orders table 
and name column from accounts table and limiting the no of rows fetched to 10.*/
SELECT orders.occurred_at, accounts.name
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
LIMIT 10;

/* Pulling standard_qty, gloss_qty, and poster_qty from the orders table,
and the website and the primary_poc from the accounts table */
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty,accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

-- KEYS
/* 
Primary key -  is a unique column across the tables in a Db. Also it occurs as 1st column in any table.
Foreign key(column)- foreign key in one table acts as a Primary key in another table.
There might be more than one foreign key but only one primary key.
There are certain cases where there is more than one primary key known as composite key.
But generally it is not a good practice to have more than 1 primary key.
We always make the FK equal to the PK in an ON statement(vica is also the same) */

/* This query is used to join 3 tables web_events, accounts, orders.
To fetch the columns the table name along with the column required to pull
should be mentioned with Dot operator.Firstly join any two tables 
and then join the resulting table with the third table. */
SELECT web_events.channel, accounts.name, orders.total
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id;

-- Aliasing
/* In the previous chapter we used AS to give an alias name to a column ie., SELECT col1 + col2 AS total, col3.
Similarly we can also give alias to table name too.It can be done by giving the column name,
a space and the alias name ie., FROM tablename t.It is similar to FROM tablename AS t.Both are the same.
Usually we give the alias name of a table with small letter and denoting the first letter of the orig.tablename
and use underscores to separate within names instead of space. */

/* Here the orders table is named as o and accounts table is named as a 
and we change all the places using these two names with alias name. */
SELECT o.account_id, a.id
FROM orders o
JOIN accounts a
ON a.id = o.account_id;

/* We can also alias table name and column name.
In this query we alias orders table as o and accounts table is named as a.
Also we alias account_id as c1 and id as col2 */
SELECT o.account_id c1, a.id c2
FROM orders o
JOIN accounts a
ON a.c2 = o.c1;

/* Provide a table for all the for all web_events associated with account name of Walmart. There should be three 
columns. Be sure to include the primary_poc, time of the event, and the channel for each event. 
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen. */
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

/* Provide a table that provides the region for each sales_rep along with their associated accounts. Your final
table should include three columns: the region name,the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.

Here especially in this query we give an alias name to the column because the name column is present 
in all the three tables region table, sales_reps table, accounts table. So the result will be 
any one of the three columns.To avoid this we give alias name to all the 3 columns.   */
SELECT r.name region, s.name sales_rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, 
and unit price.A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero. */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id;

-- (OR USE)

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;

-- LEFT JOIN
/* There are two types of join 
#INNER JOIN
#OUTER JOIN
REF:https://www.w3resource.com/slides/sql-joins-slide-presentation.php

There are three types of OUTER JOIN
@LEFT JOIN / LEFT OUTER JOIN - It will include all the rows from inner join as well as additional rows from 
left table (The table in FROM clause is the left table)
@RIGHT JOIN / RIGHT OUTER JOIN - It will include all the rows from inner join as well as additional rows from 
right table (The table in join clause is the right table) 
@OUTER JOIN / FULL OUTER JOIN - It will include all the rows from inner join as well as additional rows from 
left table and right table.Also this JOIN is used in some complicated conditions.
It 1st pulls rows with matching columns, then fetches all the rows from left table(unmatched) and only after 
that all the rows from right table(unmatched).
REF:https://www.w3resource.com/sql/joins/perform-a-full-outer-join.php

There are some othe JOINS like UNION and UNION ALL, CROSS JOIN, SELF JOIN, NATURAL JOIN which are special cases.
These JOINs allow us to pull rows that might only exist in one of the two tables.

Usually LEFT JOIN AND RIGHT JOIN are interchangeable and the results will be the same if the table names are
interchanged in FROM and JOIN clause. So we always go with LEFT JOIN to the max. RIGHT JOIN are scarcely used 
as it is similar to LEFT JOIN when column names are interchanged.
If there is not matching information in the JOINed table, then you will have columns with empty cells.
These empty cells introduce a new data type called NULL */

-- PRACTICE JOIN QUERIES
/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time 
only for the Midwest region. Your final table should include three columns: the region name, the sales rep name,
and the account name. Sort the accounts alphabetically (A-Z) according to account name. */
SELECT r.name region, s.name sales_rep, a.name account
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE r.name = 'Midwest'
ORDER BY a.name;

/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time 
only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final 
table should include three columns: the region name, the sales rep name, and the account name. Sort the 
accounts alphabetically (A-Z) according to account name. */
SELECT r.name region, s.name sales_rep, a.name account
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id 
WHERE s.name LIKE 'S%'AND r.name = 'Midwest'
ORDER BY a.name;

/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time 
only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final
table should include three columns: the region name, the sales rep name, and the account name. Sort the 
accounts alphabetically (A-Z) according to account name. */
SELECT r.name region, s.name sales_rep, a.name account
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id 
WHERE s.name LIKE '% K%'AND r.name = 'Midwest'
ORDER BY a.name;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid 
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order 
quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price.
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price */
FROM orders o
JOIN accounts a
ON o.account_id = a.id  AND o.standard_qty > 100
JOIN sales_reps s
ON a.sales_rep_id = s.id 
JOIN region r
ON s.region_id = r.id;

-- (OR)
/* (But go for this as only AND can be used , WHERE cannot be used in the middle in the previous query) */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order 
quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: 
region name, account name, and unit price. Sort for the smallest unit price first. */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. However, you should only provide the results if the standard order 
quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns:
region name, account name, and unit price. Sort for the largest unit price first. */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price DESC;

/* What are the different channels used by account id 1001? Your final table should have only 2 columns:
account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the
unique values. */
SELECT DISTINCT a.name, w.channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.id = 1001;

/* Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name,
order total, and order total_amt_usd.
Here we go for 2016 Jan too because this query only includes 31st dec, 2015 order details too
But if we go for dec 31st 2015 it does not include order details of 31st.SOo we go upto 1st Jan, 2016 */
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY occurred_at DESC;

/*
Further references:
https://www.w3resource.com/sql/joins/cross-join.php
https://www.w3schools.com/sql/sql_union.asp
https://www.w3schools.com/sql/sql_distinct.asp
*/












