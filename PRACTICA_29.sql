CREATE TABLE equipos (
  id_equipo NUMBER(2) CONSTRAINT equipos_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT equipos_uk1 UNIQUE
                      CONSTRAINT equipos_nn1 NOT NULL,
  estadio VARCHAR2(50) CONSTRAINT equipos_uk2 UNIQUE,
  aforo NUMBER(6),
  ano_fundacion NUMBER(4),
  ciudad VARCHAR2(50) CONSTRAINT equipos_nn2 NOT NULL
);

CREATE TABLE jugadores (
  id_jugador NUMBER(3) CONSTRAINT jugadores_pk PRIMARY KEY ,
  nombre VARCHAR2(50) CONSTRAINT jugadores_nn NOT NULL ,
  fecha_nac DATE,
  id_equipo number(2) CONSTRAINT jugadores_fk REFERENCES equipos(id_equipo) ON DELETE SET NULL
);

CREATE TABLE partidos (
  id_equipo_casa NUMBER(2),
  id_equipo_fuera NUMBER(2),
  fecha TIMESTAMP,
  goles_casa NUMBER(2),
  goles_fuera NUMBER(2),
  observaciones VARCHAR2(1000),
  CONSTRAINT partidos_pk PRIMARY KEY (id_equipo_casa,id_equipo_fuera),
  CONSTRAINT partidos_fk1 FOREIGN KEY (id_equipo_casa) REFERENCES equipos ON DELETE CASCADE,
  CONSTRAINT partidos_fk2 FOREIGN KEY (id_equipo_fuera) REFERENCES equipos ON DELETE CASCADE,
  CONSTRAINT partidos_ck CHECK (id_equipo_casa!=id_equipo_fuera)
);

CREATE TABLE goles(
  id_equipo_casa NUMBER(2),
  id_equipo_fuera NUMBER(2),
  minuto INTERVAL DAY TO SECOND,
  descripcion VARCHAR2(2000),
  id_jugador NUMBER(3),
  CONSTRAINT goles_pk PRIMARY KEY (id_equipo_casa,id_equipo_fuera),
  CONSTRAINT goles_fk1 FOREIGN KEY (id_equipo_casa,id_equipo_fuera) REFERENCES partidos(id_equipo_casa,id_equipo_fuera) ON DELETE CASCADE ,
  CONSTRAINT goles_fk2 FOREIGN KEY (id_jugador) REFERENCES jugadores ON DELETE CASCADE
);

ALTER TABLE equipos MODIFY aforo CONSTRAINT equipos_nn3 NOT NULL;
ALTER TABLE equipos MODIFY estadio CONSTRAINT equipos_nn4 NOT NULL ;

ALTER TABLE equipos MODIFY (ano_fundacion DATE);

ALTER TABLE jugadores DROP CONSTRAINT jugadores_nn;

INSERT INTO equipos VALUES (1,'Cascorro F.C.','Arenera','4000', '12/1/1961', 'Cascorro de Arriba');
INSERT INTO equipos VALUES (2,'Athletico Matalasleñas','Cerro Gálvez','1200','12/3/1970','Matalasleñas');

INSERT INTO jugadores VALUES (1,'Amoribia','20/1/1990',1);
INSERT INTO jugadores VALUES (20,'García','2/3/1991',2);
INSERT INTO jugadores VALUES (2,'Pedrosa','12/10/1993',1);

INSERT INTO partidos VALUES (1,2,TO_DATE ('5/11/2016','DD/MM/YYYY'),2,1,'VAYA PARTIDAZO') ;


INSERT INTO goles VALUES (1,2,INTERVAL '0:23'HOUR TO MINUTE,'Falta directa',1);
INSERT INTO goles VALUES (1,2,INTERVAL '0:40'HOUR TO MINUTE,'Penalti',20);
INSERT INTO goles VALUES (1,2,INTERVAL '1:20'HOUR TO MINUTE,'Gran jugada personal',2);

UPDATE equipos SET nombre= 'Real Cascorro' WHERE nombre= 'Cascoro F.C.';
UPDATE equipos SET aforo=aforo+500;

COMMIT;

















