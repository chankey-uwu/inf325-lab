from cassandra.cluster import Cluster
import pandas as pd

# Proporciona una ruta absoluta al archivo Excel
file_path = '/app/postulaciones.xlsx'

# Leer el archivo Excel
df = pd.read_excel(file_path)

cluster = Cluster(['cassandra-node1', 'cassandra-node2', 'cassandra-node3'])
session = cluster.connect()

session.execute("""
    CREATE KEYSPACE IF NOT EXISTS mykeyspace 
    WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3}
""")
session.execute("""
    USE mykeyspace
""")
session.execute("""
    CREATE TABLE IF NOT EXISTS postulaciones (
        cedula text PRIMARY KEY,
        periodo text,
        sexo text,
        preferencia text,
        carrera text,
        matriculado text,
        facultad text,
        puntaje text,
        grupo_depen text,
        region text,
        latitud text,
        longitud text,
        ptje_nem text,
        psu_promlm text,
        pace text,
        gratuidad text
    )
""")

for _, row in df.iterrows():
    session.execute("""
        INSERT INTO postulaciones (
            cedula, periodo, sexo, preferencia, carrera, matriculado, facultad, puntaje,
            grupo_depen, region, latitud, longitud, ptje_nem, psu_promlm, pace, gratuidad
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (
        str(row['CEDULA']), str(row['PERIODO']), str(row['SEXO']), str(row['PREFERENCIA']),
        str(row['CARRERA']), str(row['MATRICULADO']), str(row['FACULTAD']), str(row['PUNTAJE']),
        str(row['GRUPO_DEPEN']), str(row['REGION']), str(row['LATITUD']), str(row['LONGITUD']),
        str(row['PTJE_NEM']), str(row['PSU_PROMLM']), str(row['PACE']), str(row['GRATUIDAD'])
    ))

cluster.shutdown()

