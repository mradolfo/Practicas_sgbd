CREATE TABLE tipos_apli(
  id_tipo NUMBER(2) CONSTRAINT tipos_apli_pk PRIMARY KEY,
  tipo VARCHAR2(25)CONSTRAINT tipos_apli_uk1 UNIQUE
                   CONSTRAINT tipos_apli_nn1 NOT NULL
);

CREATE TABLE aplicaciones (
  n_aplicacion NUMBER(4) CONSTRAINT aplicaciones PRIMARY KEY ,
  nombre VARCHAR2(25) CONSTRAINT aplicaciones_uk1 UNIQUE
                      CONSTRAINT aplicaciones_nn1 NOT NULL ,
  extension VARCHAR2(10),
  id_tipo NUMBER(11,2) CONSTRAINT aplicaciones_nn2 NOT NULL
                      CONSTRAINT aplicaciones_fk1 REFERENCES tipos_apli(id_tipo)
);

CREATE TABLE procesos (
  n_aplicacion NUMBER(4),
  id_proceso NUMBER(3),
  nombre VARCHAR2(25)  CONSTRAINT procesos_uk1 UNIQUE
                       CONSTRAINT procesos_nn1 NOT NULL ,
  mem_minima NUMBER(5,1),
  id_proceso_lanz NUMBER(3),
  n_aplicacion_lanz NUMBER(4),
  CONSTRAINT procesos_pk PRIMARY KEY (n_aplicacion,id_proceso),
   CONSTRAINT procesos_fk1 FOREIGN KEY(n_aplicacion) REFERENCES aplicaciones(n_aplicacion),
  CONSTRAINT procesos_fk2 FOREIGN KEY (id_proceso_lanz,n_aplicacion_lanz)REFERENCES procesos (id_proceso_lanz,n_aplicacion_lanz)
);

CREATE TABLE maquinas (
  n_maquina NUMBER(3)CONSTRAINT maquinas_pk PRIMARY KEY ,
  ip1 NUMBER(3) CONSTRAINT maquinas_nn1 NOT NULL,
  ip2 NUMBER(3) CONSTRAINT maquinas_nn2 NOT NULL,
  ip3 NUMBER(3) CONSTRAINT maquinas_nn3 NOT NULL,
  ip4 NUMBER(3) CONSTRAINT maquinas_nn4 NOT NULL,
  nombre VARCHAR2(45) CONSTRAINT maquinas_nn5 NOT NULL ,
  memoria NUMBER(5,1),
  CONSTRAINT maquinas_uk UNIQUE (ip1,ip2,ip3,ip4)
);

CREATE TABLE procesos_lanzados (
  n_aplicacion NUMBER(4)CONSTRAINT procesos_lanzados_pk PRIMARY KEY
                        CONSTRAINT procesos_lanzados_fk REFERENCES procesos(n_aplicacion),
  id_aplicacion NUMBER(3)CONSTRAINT procesos_lanzados_pk PRIMARY KEY
                         CONSTRAINT procesos_lanzados_fk1 REFERENCES procesos(id_proceso),
  fecha_lanz TIMESTAMP CONSTRAINT procesos_lanzados_pk PRIMARY KEY,
  fecha_termino TIMESTAMP,
  bloqueado NUMBER(1),
  n_maquina NUMBER(3) CONSTRAINT procesos_lanzados_fk2 REFERENCES maquinas(n_maquina)
                      CONSTRAINT procesos_lanzados_nn1 NOT NULL
);


