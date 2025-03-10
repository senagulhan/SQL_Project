######################################################## 3rd Query ########################################################
#Our company wants to give a discount gift to the customer who orders the most in last month.

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

query_3 = """
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
"""
df_3 = pd.read_sql_query(query_3, conn)

print(df_3)

conn.close()

#Visualization 

plt.figure(figsize=(12, 15)) 

ax=sns.barplot(x="contactname", y="total_qty", data=df_3)
ax.bar_label(ax.containers[0], labels=df_3["phone"].astype(str))
plt.xlabel("contactname")
plt.ylabel("total_qty")
plt.title("Most ordered person")
plt.xticks(rotation=15)
plt.yticks(rotation=30)  
plt.grid(True) 

plt.show()
