#%%

from sqlalchemy import create_engine

#%%
# pymssql
engine = create_engine("mssql+pyodbc://chris@localhost:CEREBRO")
connection = engine.connect()
metadata = db.MetaData()
coast = db.Table('uscg', metadata, autoload=True, autoload_with=engine)

# Print the column names
print(coast.columns.keys())
# %%
