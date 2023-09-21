import pandas as pd

csv_file = 'postulaciones.csv'

df = pd.read_csv(csv_file, sep=',')

print("Postulantes Medicina:",df['CARRERA'].value_counts()['MEDICINA'])

filtro = df['REGION'] == 'MAULE'
postulantes_maule_informatica = df[filtro]
print("Postulantes Informática de Maule:",postulantes_maule_informatica['CARRERA'].value_counts()['INGENIERÍA CIVIL INFORMÁTICA'])

estudiantes_salud = df[df['FACULTAD'] == 'CIENCIAS DE LA SALUD']
print("Postulantes Ciencias de la Salud:",len(estudiantes_salud))

#Caso 2 periodos de postulación
#p = df[df['CEDULA'] == 19653987]
#print(p)