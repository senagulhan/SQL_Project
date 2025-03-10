
######################################################## 1st Query ########################################################
#Best saled products at 2008

import pyodbc # for connect mssql to vs code
import pandas as pd # for data manipulation
import matplotlib.pyplot as plt # for data visualization
import seaborn as sns # for data visualization

server = input("Please enter your Server name: ")
database = input("Please enter your Database name: ")
#If you don't use Windows Authentication please activate following two  this line
#username = input("Please enter your username: ") 
#password = input("Please enter your password: ")


# Connection with Windows Authentication 
#If you don't use Windows Authentication please deactivate this line
conn = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;') 
#If you don't use Windows Authentication please activate this line
#conn = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}') 
query_1 = """
    SELECT top(10)
	SO.custid, 
	SO.orderdate, 
	SUM(SOD.qty) AS total_qty,
	PP.productname
    FROM [Sales].[Orders] AS SO
    INNER JOIN [Sales].[OrderDetails] AS SOD ON SO.orderid=SOD.orderid
    INNER JOIN [Production].[Products] AS PP ON PP.productid=SOD.productid
    WHERE YEAR(SO.orderdate)=2008
    GROUP BY SO.custid, SO.orderdate, PP.productname
    ORDER BY total_qty  DESC;
"""
df_1 = pd.read_sql_query(query_1, conn)

print(df_1)

conn.close()

#Visualization 

plt.figure(figsize=(12, 15))  

sns.barplot(x="productname", y="total_qty", data=df_1)

plt.xlabel("Quantity Ordered")
plt.ylabel("Product Name")
plt.title("Best Sold Products in 2008")
plt.xticks(rotation=15)
plt.yticks(rotation=30) 
plt.grid(True)  

plt.show()
