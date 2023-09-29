CREATE KEYSPACE IF NOT EXISTS lab1 WITH replication={'class':'SimpleStrategy','replication_factor':3};
CONSISTENCY Three;
USE lab1;

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
    PRIMARY KEY ((carrera, matriculado), periodo, cedula)
);

CREATE TABLE IF NOT EXISTS inf_maule_postulantes (
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
    PRIMARY KEY ((carrera, region, matriculado), periodo, cedula));

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
    PRIMARY KEY ((facultad, matriculado), puntaje, cedula, preferencia, periodo)
);

COPY medicina_postulantes (CEDULA, PERIODO, SEXO, PREFERENCIA, CARRERA, MATRICULADO, FACULTAD, PUNTAJE, GRUPO_DEPEN, REGION, LATITUD, LONGITUD, PTJE_NEM, PSU_PROMLM, PACE, GRATUIDAD) FROM 'data.csv' WITH DELIMITER=',' AND HEADER = true;

COPY inf_maule_postulantes (CEDULA, PERIODO, SEXO, PREFERENCIA, CARRERA, MATRICULADO, FACULTAD, PUNTAJE, GRUPO_DEPEN, REGION, LATITUD, LONGITUD, PTJE_NEM, PSU_PROMLM, PACE, GRATUIDAD) FROM 'data.csv' WITH DELIMITER=',' AND HEADER = true;

COPY matriculados_ciencias_psu (CEDULA, PERIODO, SEXO, PREFERENCIA, CARRERA, MATRICULADO, FACULTAD, PUNTAJE, GRUPO_DEPEN, REGION, LATITUD, LONGITUD, PTJE_NEM, PSU_PROMLM, PACE, GRATUIDAD) FROM 'data.csv' WITH DELIMITER=',' AND HEADER = true;
