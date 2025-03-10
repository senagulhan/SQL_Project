--Sorgu #1
--Sales.Customers UK, USA veya France tablosundan ülkesi olan tüm müþterileri
--rapor olarak çeken sorguyu yazýnýz. Toplamda kaç müþteri var?

--Sales.Customers UK, USA veya France tablosundan ülkesi olan tüm müþterileri çeken rapor
USE TSQL
GO
SELECT C.contactname
FROM [Sales].[Customers] AS C
WHERE country IN ('UK', 'USA', 'France');

--Toplamda kaç müþteri var 
USE TSQL
GO
SELECT COUNT(C.contactname)
FROM [Sales].[Customers] AS C
WHERE country IN ('UK', 'USA', 'France');

--Sorgu #2
--Production.Products Production.Categories ve tablolarýndan her kategorideki
--ürün sayýsýný yazdýran raporu çekiniz? En fazla hangi kategoride ürün var?

--Ürün sayýsýný yazdýran rapor 
USE TSQL
GO 
SELECT C.categoryname, COUNT(P.productid) AS product_count
FROM [Production].[Products] AS P
INNER JOIN [Production].[Categories] AS C ON P.categoryid = C.categoryid
GROUP BY C.categoryname
ORDER BY product_count DESC;

--En fazla ürün olan kategori
--Ürün sayýsýný yazdýran rapor 
USE TSQL
GO 
SELECT top(1) C.categoryname, COUNT(P.productid) AS product_count
FROM [Production].[Products] AS P
INNER JOIN [Production].[Categories] AS C ON P.categoryid = C.categoryid
GROUP BY C.categoryname
ORDER BY product_count DESC;

--Sorgu #3
--Brezilya'daki Brezilya'daki toplam satýþlarý þehir bazýnda raporlayýnýz. en fazla
--gelir hangi þehirde yapýlmýþtýr?

--Brezilyadaki toplam satýþlarýn þehir bazýnda raporu
USE TSQL
GO
SELECT C.city, C.country , SUM(OD.unitprice*OD.qty) AS TOTAL_PRICE
FROM [Sales].[Customers] AS C
LEFT JOIN [Sales].[Orders] AS O ON C.custid=O.custid
LEFT JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
WHERE C.country = 'Brazil'  
GROUP BY C.city, C.country  
ORDER BY TOTAL_PRICE DESC;

--En fazla gelir yapan þehir
USE TSQL
GO
SELECT top(1) C.city, C.country , SUM(OD.unitprice*OD.qty) AS TOTAL_PRICE
FROM [Sales].[Customers] AS C
LEFT JOIN [Sales].[Orders] AS O ON C.custid=O.custid
LEFT JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
WHERE C.country = 'Brazil'  
GROUP BY C.city, C.country  
ORDER BY TOTAL_PRICE DESC;

--Sorgu #4
--Her bir order için toplam satýþý yapýlan ürün/kalem sayýsýný yazdýrýnýz. En fazla
--kalem ürünü hangi sipariþte ve hangi müþteriye yapmýþtýnýz?

--Her bir order için toplam satýþ yapýlan ürün kalem sayýsý ve total price
SELECT C.contactname, OD.qty ,O.orderid, SUM(OD.unitprice*OD.qty) AS TOTAL_PRICE
FROM [Sales].[Customers] AS C
INNER JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
GROUP BY C.contactname, OD.qty ,O.orderid
ORDER BY OD.qty DESC;

--En fazla kalem ürün sipariþi ve müþteri
SELECT top(1) C.contactname, OD.qty ,O.orderid, SUM(OD.unitprice*OD.qty) AS TOTAL_PRICE
FROM [Sales].[Customers] AS C
INNER JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
GROUP BY C.contactname, OD.qty ,O.orderid
ORDER BY OD.qty DESC;

--Sorgu #5
--2007 ve 2008 yýllarý için ilk 3 ülke en fazla satýþ yapmýþ olduðunuz hangisidir?

USE TSQL
GO
SELECT top(3) C.country, O.orderdate ,OD.qty
FROM [Sales].[Orders] AS O
INNER JOIN [Sales].[Customers] AS C ON O.custid=C.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
WHERE YEAR(O.orderdate)= 2007 OR YEAR(O.orderdate)= 2008
ORDER BY OD.qty DESC;


SELECT local_net_address FROM sys.dm_exec_connections WHERE session_id = @@SPID;
