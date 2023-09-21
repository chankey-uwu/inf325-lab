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

- Hay que conectarse a la terminal de un nodo (de preferencia a `cassandra-node1`) usando el comando:
```bash
docker exec -it cassandra-node1 bash
```

- Se debe ejecutar el siguiente comando:
```bash
cqlsh --file init.cql
```
Esto creará el keyspace, las tablas y cargará los datos a las respectivas tablas.

- Para ingresar al keyspace, y realizar las consultas pedidas corremos el siguiente comando:
```bash
cqlsh
```
y luego
```bash
use lab1;
```

- Una vez dentro del keyspace, se realizan las consultas, esto se detalla en la siguiente sección.

## Consultas

### Tabla 1

Esta consulta se realiza para responder al punto 3.a del laboratorio, que consiste en *Devolver todos los postulantes matriculados en la carrera de medicina ordenados por periodo*.

##### Consultar datos

Para consultar los datos del item 3.a, se usa el comando:
```cql
SELECT * FROM medicina_postulantes WHERE carrera='MEDICINA';
```

### Tabla 2

Esta consulta se realiza para responder al punto 3.b del laboratorio, que consiste en *Devolver todos los postulantes matriculados provenientes de la región del Maule en la carrera Ingeniería Civil Informática ordenados por periodo*.

##### Consultar datos

Para consultar los datos del item 3.b, se usa el comando:
```cql
SELECT * FROM inf_maule_postulantes WHERE region='MAULE' AND carrera='INGENIERÍA CIVIL INFORMÁTICA';
```

### Tabla 3

Esta consulta se realiza para responder al punto 3.c del laboratorio, que consiste en *Devolver todos los postulantes matriculados en la facultad de Ciencias de la Salud ordenado por puntaje PSU*.

##### Consultar datos

Para consultar los datos del item 3.c, se usa el comando:
```cql
SELECT * FROM matriculados_ciencias_psu WHERE facultad='CIENCIAS DE LA SALUD';
```
