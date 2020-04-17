/* The contents in chapter 1 move with operations on 1 single table */

/* SELECT used to select the rows desired from the table
FROM is used to select a table by its name
LIMIT is used to limit the no of rows selected
all the tables used here are taken from PARCH AND POSEY a paper printing company */
SELECT occurred_at,account_id,channel
FROM web_events
LIMIT 15; 

-- ORDER BY:
/* ORDER BY is used to order the table based a row usually a table is ordered by its primary key.
But we can also order it by our own row name pref. 
It should be used before the LIMIT statement*/

/* These two are arranged in terms of smaller amount that is in ascending order.
By default ORDER BY uses ascending order of the specified column. */
SELECT id,occurred_at,total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 5;

/* This query used here is ordeered in terms of largest value that is it is arranged in descending order.
We can use DESC after the column name to arrange the column in descending order. */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 20;

/* Here in ORDER BY when more than one column name is specified they are sorted from left to right ie., 
columns specified in the left most gets sorted first and then the next column and so on.
Also column names containing the keyword DESC are only ordered in descending order.
In this query the account_id is sorted first in ascending order and then the total is ordered in descending order
For each corresponding account_id the total is arranged in descending order */
SELECT id, account_id, total
FROM orders
ORDER BY account_id, total DESC;

/* Here in this query the total is first ordered in the descending order and 
then the corresponding account_id in ascending order.
Since there is no same total value the respective account_id are sorted for total value. */
SELECT id, account_id, total
FROM orders
ORDER BY total DESC,account_id;

-- WHERE
/* WHERE is used to select the data from the table based on some condition 
Here the table pulls 5 rows and all columns whose gloss_amt_used is greater than or equal to 1000 */
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* In this query we pull 10 rows and all columns that have gloss_amt_usd less than 500 */
SELECT *
FROM orders
WHERE gloss_amt_usd < 500
LIMIT 10;

/* This query here includes the name, website and primary_poc(point of contact) 
from the accounts table where the name is 'Exxon Mobil'
Enclose non numeric values in single quotes 
We also may use IN, NOT, LIKE keywords for this*/
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

/* Here we form a derived columnn by dividing standard_amt_usd and standard_qty 
and giving that column an alias name by the keyword AS 
Along with it we select the standard_amt_usd, standard_qty, id, account_id columns too */
SELECT standard_amt_usd, standard_qty, standard_amt_usd / standard_qty AS unit_price, id, account_id
FROM orders
LIMIT 10;

/* This query finds the poster percentage by adding poster_amt_usd, gloss_amt_usd, standard_amt_usd 
and dividing it by poster_amt_usd.finally multiplied with 100 to get whole number with decimal value.
This derived column is named as poster_percent
 */
SELECT id, account_id, poster_amt_usd/(poster_amt_usd+gloss_amt_usd+standard_amt_usd)*100 AS poster_percent
FROM orders
LIMIT 10;

-- LIKE
/* LIKE is an operator that is similar to ''='' but works with text(string).
It generally uses '%' symbol in its query to denote if it is used to get a start or end or sub string
of some vakue in a column.
Also the text to be fetched is represented within single quotes ''
They are case sensitive too ie., C is different from c

This query here is used to select all the company names that start with the letter C  
So the words within single quotes must start with C and ending can be anything after it denoted by %. */
SELECT name
FROM accounts
WHERE name LIKE 'C%';

/* This query is used to select all company names that have the string 'one' in it. 
Since it is a sub string anything can be a prefix or sufix of the word 'one'*/
SELECT name
FROM accounts
WHERE name LIKE '%one%';

/* This query is used to fetch all the company names starting with the letter SELECT. 
Since it is an ending with we use s at the end and anything can be a prefix so we use % in that place*/
SELECT name
FROM accounts
WHERE name LIKE '%s';

-- IN
/* This query can be used to fetch both text and numeric values and also to fetch more than one value.
It is similar to OR operator to choose either one or both but it is cleaner way to use IN 
Also text represented within single quotes and numbers as such
If a text already contains apostrophe then use 2 single quotes in its place eg., Mary's as 'Mary''s'

In this query we fetch all the rows that have name 'Walmart', 'Target', 'Nordstrom'
from the name, primary_poc, sales_rep_id columns and from accounts table. */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/* This query is used to fetch all the coulmns with channel names 'organic' and 'adwords'
from the web_events table  */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/* This query is used to fetch account_id and channel column from web_events table
where the account_id value is 1061, 1081 */
SELECT id, account_id, channel
FROM web_events
WHERE account_id IN (1061,1081);

-- NOT IN
/* This keyword is used along with LIKE and IN to get the inverse results of the query using IN and LIKE

In this query we fetch all the results except the names containing Walmart, Target, Nordstrom */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

/* This query is used to fetch the inverse of the query that contains channel organic and adwords */
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/* This query is used to fetch all the names that do not start with C */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

/* This query is used to fetch all the names that does not contain the sub string one */
SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

/* This query is used to fetch all the names that do not end with s */
SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

-- AND
/* AND keyword is used to fetch all the rows that are true for both the conditions
We can use more than 1 AND in a query
It is used along with the operators namely LIK, NOT, IN etc.,*/
/*
A query that returns all the orders
where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0. */
SELECT *
FROM orders
WHERE standard_qty >1000 AND poster_qty = 0 AND gloss_qty = 0;

/* Using the accounts table, to find all the companies whose names 
do not start with 'C' and end with 's'. */
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

/* A query that displays the order date and gloss_qty data for all orders where gloss_qty 
is between 24 and 29
Here the BETWEEN..AND include the endpoints value too */
SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

/* Use the web_events table to find all information regarding individuals who were contacted via
the organic or adwords channels,and started their account at any point in 2016, 
sorted from newest to oldest. */
SELECT *
FROM web_events
WHERE  channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY occurred_at;

-- OR
/* This keyword is used to obtain the rows that satisfies either of the 2 conditions
It is similar to AND to execute multiple conditions, works along with operators as mentioned above in AND keyword
When using multiple conditions and OR operator, 
it is necessary to use paranthesis to maintain the order of execution we prefer to perform  */
/* List of orders ids where either gloss_qty or poster_qty is greater than 4000.
Only include the id field in the resulting table. */
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

/* A query that returns a list of orders where the standard_qty is zero and 
either the gloss_qty or poster_qty is over 1000. */
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty >1000 OR poster_qty > 1000);

/* All the company names that start with a 'C' or 'W',and
the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'. */
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
     AND primary_poc NOT LIKE '%eana%');

/* TIPS:
SELECT column_name AS new_name
FROM
WHERE
ORDER BY
LIMIT

PEDMAS:
P-Paranthesis
E-Exponentiation
D-Division
M-Multiplication
A-Addition
S-Subtraction */













