import pandas as pd

df = pd.read_csv('aircraft.csv')
df = df.dropna()
df.to_csv('new_aircraft.csv',index=None)
