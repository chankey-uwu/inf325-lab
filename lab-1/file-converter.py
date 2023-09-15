import pandas as pd

df = pd.read_excel('archivo.xlsx')
df.to_csv('archivo.csv', index=False)
