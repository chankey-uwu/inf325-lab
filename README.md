# [INF-325] Bases de Datos Avanzadas - Laboratorio 1 (Cassandra)

## Descripción

## Requisitos

- Tener instalado [Docker](https://www.docker.com).

## Ejecución del proyecto

- Una vez iniciado Docker, se debe ejecutar el archivo `docker-compose.yml` usando el comando:
```bash
docker-compose up -d
```

Esto generará el contenedor `Lab1` con 3 servicios dentro, correspondientes a los nodos de Cassandra.

**Importante**: Para los siguientes pasos, el contenedor debe estar ejecutándose. En caso contrario, dará error.

- Se debe copiar el archivo `postulaciones.csv` a un nodo (de preferencia a `cassandra-node1`) usando el comando:
```bash
docker cp "Ruta/al/archivo/postulaciones.csv" cassandra-node1:/data.csv
```

Esto copiará el archivo al nodo, dándole el nombre `data.csv`.

- Hay que conectarse a la terminal de un nodo (de preferencia a `cassandra-node1`) usando el comando:
```bash
docker exec -it cassandra-node1 bash
```

- Se debe acceder a la terminal de CQL usando el comando:
```bash
cqlsh
```

- Se debe crear el keyspace de Cassandra usando el comando:
```cql
CREATE KEYSPACE <nombre> WITH replication={'class':'SimpleStrategy','replication_factor':3};
```

Esto generará el keyspace con la configuración necesaria para el laboratorio.

- Una vez creado el keyspace, se debe acceder a este con el comando:
```cql
use <nombre>;
```

- Una vez dentro del keyspace, se crean las tablas para el laboratorio, las que se detallan en la siguiente sección.

## Tablas utilizadas

### Tabla 1

Esta tabla se crea para responder al punto 3.a del laboratorio, que consiste en *Devolver todos los postulantes matriculados en la carrera de medicina ordenados por periodo*.

#### Creación de la tabla

Para crear la tabla, se usa el comando:
```cql
CREATE TABLE IF NOT EXISTS medicina_postulantes (
    cedula TEXT,
    periodo INT,
    sexo TEXT,
    preferencia INT,
    carrera TEXT,
    matriculado TEXT,
    facultad TEXT,
    puntaje DOUBLE,
    grupo_depen TEXT,
    region TEXT,
    latitud DOUBLE,
    longitud DOUBLE,
    ptje_nem DOUBLE,
    psu_promlm DOUBLE,
    pace TEXT,
    gratuidad TEXT,
    PRIMARY KEY (carrera, periodo, cedula)
);
```

Este comando generará la tabla *medicina_postulantes*, cuya **partition key** es el campo *carrera* y sus **clustering keys** son *periodo* y *cedula*.

##### Copiar los datos del CSV a la tabla

Para copiar los datos del CSV a la tabla, se usa el comando:
```cql
COPY medicina_postulantes (CEDULA, PERIODO, SEXO, PREFERENCIA, CARRERA, MATRICULADO, FACULTAD, PUNTAJE, GRUPO_DEPEN, REGION, LATITUD, LONGITUD, PTJE_NEM, PSU_PROMLM, PACE, GRATUIDAD) FROM 'data.csv' WITH DELIMITER=',' AND HEADER = true;
```

##### Consultar datos

Para consultar los datos del item 3.a, se usa el comando:
```cql
SELECT * FROM medicina_postulantes WHERE carrera='MEDICINA';
```

### Tabla 2

Esta tabla se crea para responder al punto 3.b del laboratorio, que consiste en *Devolver todos los postulantes matriculados provenientes de la región del Maule en la carrera Ingeniería Civil Informática ordenados por periodo*.

#### Creación de la tabla

Para crear la tabla, se usa el comando:
```cql
CCREATE TABLE IF NOT EXISTS inf_maule_postulantes (
    cedula TEXT,
    periodo INT,
    sexo TEXT,
    preferencia INT,
    carrera TEXT,
    matriculado TEXT,
    facultad TEXT,
    puntaje DOUBLE,
    grupo_depen TEXT,
    region TEXT,
    latitud DOUBLE,
    longitud DOUBLE,
    ptje_nem DOUBLE,
    psu_promlm DOUBLE,
    pace TEXT,
    gratuidad TEXT,
    PRIMARY KEY ((carrera, region), periodo, cedula));
```

Este comando generará la tabla *inf_maule_postulantes*, cuya **partition key** es compuesta por el campo *carrera* y *region*, mientras que sus **clustering keys** son *periodo y cedula*.

##### Copiar los datos del CSV a la tabla

Para copiar los datos del CSV a la tabla, se usa el comando:
```cql
COPY inf_maule_postulantes (CEDULA, PERIODO, SEXO, PREFERENCIA, CARRERA, MATRICULADO, FACULTAD, PUNTAJE, GRUPO_DEPEN, REGION, LATITUD, LONGITUD, PTJE_NEM, PSU_PROMLM, PACE, GRATUIDAD) FROM 'data.csv' WITH DELIMITER=',' AND HEADER = true;
```

##### Consultar datos

Para consultar los datos del item 3.b, se usa el comando:
```cql
SELECT * FROM inf_maule_postulantes WHERE region='MAULE' AND carrera='INGENIERÍA CIVIL INFORMÁTICA';
```

### Tabla 3

Esta tabla se crea para responder al punto 3.c del laboratorio, que consiste en *Devolver todos los postulantes matriculados en la facultad de Ciencias de la Salud ordenado por puntaje PSU*.

#### Creación de la tabla

Para crear la tabla, se usa el comando:
```cql
CREATE TABLE IF NOT EXISTS matriculados_ciencias_psu (
    cedula TEXT,
    periodo INT,
    sexo TEXT,
    preferencia INT,
    carrera TEXT,
    matriculado TEXT,
    facultad TEXT,
    puntaje DOUBLE,
    grupo_depen TEXT,
    region TEXT,
    latitud DOUBLE,
    longitud DOUBLE,
    ptje_nem DOUBLE,
    psu_promlm DOUBLE,
    pace TEXT,
    gratuidad TEXT,
    PRIMARY KEY (facultad, puntaje, cedula)
);
```

Este comando generará la tabla *matriculados_ciencias_psu*, cuya **partition key** es el campo *facultad* y sus **clustering keys** son *puntaje* y *cedula*.

##### Copiar los datos del CSV a la tabla

Para copiar los datos del CSV a la tabla, se usa el comando:
```cql
COPY matriculados_ciencias_psu (CEDULA, PERIODO, SEXO, PREFERENCIA, CARRERA, MATRICULADO, FACULTAD, PUNTAJE, GRUPO_DEPEN, REGION, LATITUD, LONGITUD, PTJE_NEM, PSU_PROMLM, PACE, GRATUIDAD) FROM 'data.csv' WITH DELIMITER=',' AND HEADER = true;
```

##### Consultar datos

Para consultar los datos del item 3.c, se usa el comando:
```cql
SELECT * FROM matriculados_ciencias_psu WHERE facultad='CIENCIAS DE LA SALUD';
```