import pandas as pd

def diff():
    df1 = pd.read_csv('flight.csv')
    df2 = pd.read_csv('aircraft.csv')
    df = df1[~(df1['OP_UNIQUE_CARRIER'].isin(df2['OP_UNIQUE_CARRIER']) & df1['TAIL_NUM'].isin(df2['TAIL_NUM']))]
    df = df[['OP_UNIQUE_CARRIER', 'TAIL_NUM']]
    print(df.to_string())
    print(df.shape)

def check_null_cols(df):
    cols = df.columns[df.isna().any()].tolist()
    return cols

def col_null_fix():
    df = pd.read_csv('flight.csv')
    df["TAIL_NUM"].fillna("Unknown",inplace=True)
    assert ("TAIL_NUM" not in check_null_cols(df))
    df.to_csv("new_flight.csv",index=None)

df = pd.read_csv('new_flight.csv')
print("Read")

df["DEP_TIME"] = df["DEP_TIME"].fillna(-1)
df["DEP_TIME"] = df["DEP_TIME"].astype(int)
df["DEP_TIME"] = df["DEP_TIME"].astype(str)
df["DEP_TIME"] = df["DEP_TIME"].replace('-1', '')

df["ARR_TIME"] = df["ARR_TIME"].fillna(-1)
df["ARR_TIME"] = df["ARR_TIME"].astype(int)
df["ARR_TIME"] = df["ARR_TIME"].astype(str)
df["ARR_TIME"] = df["ARR_TIME"].replace('-1', '')


df["DIV_AIRPORT_LANDINGS"] = df["DIV_AIRPORT_LANDINGS"].fillna(-1)
df["DIV_AIRPORT_LANDINGS"] = df["DIV_AIRPORT_LANDINGS"].astype(int)
df["DIV_AIRPORT_LANDINGS"] = df["DIV_AIRPORT_LANDINGS"].astype(str)
df["DIV_AIRPORT_LANDINGS"] = df["DIV_AIRPORT_LANDINGS"].replace('-1', '')

print("Write")
df.to_csv("new_flight2.csv",index=None)
