# %%
import pandas as pd
import mysql.connector

# %% [markdown]
# ### mysql connector + pandas sql

# %%
# připojit k databázi - db object pro referenci na připojení
db = mysql.connector.connect(
  host="localhost", # server - u nás na PC localhost, jinak např. https://svatky.adresa.info/
  user="root", # přihlášení
  password="root",
  database="nova_databaze" # výběr schématu/db -> odpovídá sql: use nase_db;
)

# %%
sql = "select * from nahodni_lide;"

# %%
tabulka = pd.read_sql(sql, db)

# %%
tabulka

# %% [markdown]
# ### sql alchemy + pandas

# %%
from sqlalchemy import create_engine
from sqlalchemy import text

# %%
mysql_db = create_engine('mysql+pymysql://root:root@localhost/nova_databaze')

# %%
sql = "select * from nahodni_lide;"

# %%
tabulka = pd.read_sql(sql, mysql_db)
tabulka


