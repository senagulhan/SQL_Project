######################################################## 2nd Query ########################################################
#3 Month sales analysis for Product HCQDE at 2008

import pyodbc
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

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

query_2 = """
    SELECT PP.productname, SO.orderdate, SOD.qty, SOD.unitprice 
    FROM [Production].[Products] AS PP
    INNER JOIN [Sales].[OrderDetails] AS SOD ON PP.productid=SOD.productid
    INNER JOIN [Sales].[Orders] AS SO ON SOD.orderid=SO.orderid
    WHERE YEAR(SO.orderdate) = 2008 
    AND MONTH(SO.orderdate) IN (2, 3, 4) 
    AND PP.productname='Product HCQDE' 
    ORDER BY SO.orderdate ASC;
"""
df_2 = pd.read_sql_query(query_2, conn)

print(df_2)

conn.close()

#Visualization 

plt.figure(figsize=(12, 15)) 

ax=sns.barplot(x="orderdate", y="qty", data=df_2)
ax.bar_label(ax.containers[0], labels=df_2["unitprice"].astype(str))
plt.xlabel("Order date")
plt.ylabel("qty")
plt.title("3 Month sales analysis for Product HCQDE at 2008")
plt.xticks(rotation=15)
plt.yticks(rotation=30)  
plt.grid(True) 

plt.show()
