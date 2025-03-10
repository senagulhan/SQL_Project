--------------------------------------------------1st query--------------------------------------------------
--Most sales product at 2020 

USE TSQL
GO

SELECT 
	SO.custid, 
	SO.orderdate, 
	SOD.qty,
	PP.productname
FROM [Sales].[Orders] AS SO
INNER JOIN [Sales].[OrderDetails] AS SOD ON SO.orderid=SOD.orderid
INNER JOIN [Production].[Products] AS PP ON PP.productid=SOD.productid
WHERE YEAR(SO.orderdate)=2020
ORDER BY SOD.qty DESC;
--When we run this query, there is no output.
--So, we check whether there is a problem or if there were really no sales in 2020.
--We check the minimum and maximum interval.
SELECT MIN(orderdate) AS EarliestOrder, MAX(orderdate) AS LatestOrder
FROM [Sales].[Orders];
--We determine that the sales interval between 2006-07-04 and 2008-05-06 
--So, we update the query

SELECT top(15)
	SO.custid, 
	SO.orderdate, 
	SOD.qty,
	PP.productname
FROM [Sales].[Orders] AS SO
INNER JOIN [Sales].[OrderDetails] AS SOD ON SO.orderid=SOD.orderid
INNER JOIN [Production].[Products] AS PP ON PP.productid=SOD.productid
WHERE YEAR(SO.orderdate)=2008
ORDER BY SOD.qty DESC;

--At the end of all updates, we found that the most ordered product in 2008 was Product HCQDE.
--If we want to filter the query to show only the first entry,
--we can modify our query as follows:

SELECT top(1) 
	SO.custid, 
	SO.orderdate, 
	SOD.qty,
	PP.productname
FROM [Sales].[Orders] AS SO
INNER JOIN [Sales].[OrderDetails] AS SOD ON SO.orderid=SOD.orderid
INNER JOIN [Production].[Products] AS PP ON PP.productid=SOD.productid
WHERE YEAR(SO.orderdate)=2008
ORDER BY SOD.qty DESC;

--------------------------------------------------2nd query--------------------------------------------------
-- 3 Month sales analysis for Product HCQDE at 2008

SELECT
	PP.productname, 
	SO.orderdate, 
	SOD.qty, 
	SOD.unitprice
FROM [Production].[Products] AS PP
INNER JOIN [Sales].[OrderDetails] AS SOD ON PP.productid=SOD.productid
INNER JOIN [Sales].[Orders] AS SO ON SOD.orderid=SO.orderid
WHERE YEAR(SO.orderdate) = 2008 AND
MONTH(SO.orderdate) IN (2, 3 , 4) 
AND PP.productname='Product HCQDE'
ORDER BY SO.orderdate ASC ;

--------------------------------------------------3rd query--------------------------------------------------
--Our company wants to give a discount gift to the customer who orders the most in last month.
--So, we have to find who order more than everyone

SELECT top (1)
    SO.custid,
    SC.contactname,
    SO.shipcountry,
    SO.shipcity,
    SUM(SOD.qty) AS total_qty,
    SC.phone,
    SC.fax
FROM [Sales].[Orders] AS SO
INNER JOIN [Sales].[OrderDetails] AS SOD ON SOD.orderid = SO.orderid
INNER JOIN [Sales].[Customers] AS SC ON SC.custid = SO.custid  
WHERE SO.orderdate BETWEEN '2008-04-01' AND '2008-04-30'  
GROUP BY SO.custid, SC.contactname, SO.shipcountry, SO.shipcity, SC.phone, SC.fax
ORDER BY total_qty DESC;  
