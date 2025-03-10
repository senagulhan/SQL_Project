--Sorgu #1
--Sales.Customers UK, USA veya France tablosundan �lkesi olan t�m m��terileri
--rapor olarak �eken sorguyu yaz�n�z. Toplamda ka� m��teri var?

--Sales.Customers UK, USA veya France tablosundan �lkesi olan t�m m��terileri �eken rapor
USE TSQL
GO
SELECT C.contactname
FROM [Sales].[Customers] AS C
WHERE country IN ('UK', 'USA', 'France');

--Toplamda ka� m��teri var 
USE TSQL
GO
SELECT COUNT(C.contactname)
FROM [Sales].[Customers] AS C
WHERE country IN ('UK', 'USA', 'France');

--Sorgu #2
--Production.Products Production.Categories ve tablolar�ndan her kategorideki
--�r�n say�s�n� yazd�ran raporu �ekiniz? En fazla hangi kategoride �r�n var?

--�r�n say�s�n� yazd�ran rapor 
USE TSQL
GO 
SELECT C.categoryname, COUNT(P.productid) AS product_count
FROM [Production].[Products] AS P
INNER JOIN [Production].[Categories] AS C ON P.categoryid = C.categoryid
GROUP BY C.categoryname
ORDER BY product_count DESC;

--En fazla �r�n olan kategori
--�r�n say�s�n� yazd�ran rapor 
USE TSQL
GO 
SELECT top(1) C.categoryname, COUNT(P.productid) AS product_count
FROM [Production].[Products] AS P
INNER JOIN [Production].[Categories] AS C ON P.categoryid = C.categoryid
GROUP BY C.categoryname
ORDER BY product_count DESC;

--Sorgu #3
--Brezilya'daki Brezilya'daki toplam sat��lar� �ehir baz�nda raporlay�n�z. en fazla
--gelir hangi �ehirde yap�lm��t�r?

--Brezilyadaki toplam sat��lar�n �ehir baz�nda raporu
USE TSQL
GO
SELECT C.city, C.country , SUM(OD.unitprice*OD.qty) AS TOTAL_PRICE
FROM [Sales].[Customers] AS C
LEFT JOIN [Sales].[Orders] AS O ON C.custid=O.custid
LEFT JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
WHERE C.country = 'Brazil'  
GROUP BY C.city, C.country  
ORDER BY TOTAL_PRICE DESC;

--En fazla gelir yapan �ehir
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
--Her bir order i�in toplam sat��� yap�lan �r�n/kalem say�s�n� yazd�r�n�z. En fazla
--kalem �r�n� hangi sipari�te ve hangi m��teriye yapm��t�n�z?

--Her bir order i�in toplam sat�� yap�lan �r�n kalem say�s� ve total price
SELECT C.contactname, OD.qty ,O.orderid, SUM(OD.unitprice*OD.qty) AS TOTAL_PRICE
FROM [Sales].[Customers] AS C
INNER JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
GROUP BY C.contactname, OD.qty ,O.orderid
ORDER BY OD.qty DESC;

--En fazla kalem �r�n sipari�i ve m��teri
SELECT top(1) C.contactname, OD.qty ,O.orderid, SUM(OD.unitprice*OD.qty) AS TOTAL_PRICE
FROM [Sales].[Customers] AS C
INNER JOIN [Sales].[Orders] AS O ON C.custid=O.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
GROUP BY C.contactname, OD.qty ,O.orderid
ORDER BY OD.qty DESC;

--Sorgu #5
--2007 ve 2008 y�llar� i�in ilk 3 �lke en fazla sat�� yapm�� oldu�unuz hangisidir?

USE TSQL
GO
SELECT top(3) C.country, O.orderdate ,OD.qty
FROM [Sales].[Orders] AS O
INNER JOIN [Sales].[Customers] AS C ON O.custid=C.custid
INNER JOIN [Sales].[OrderDetails] AS OD ON O.orderid=OD.orderid 
WHERE YEAR(O.orderdate)= 2007 OR YEAR(O.orderdate)= 2008
ORDER BY OD.qty DESC;


SELECT local_net_address FROM sys.dm_exec_connections WHERE session_id = @@SPID;
