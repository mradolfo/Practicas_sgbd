CREATE TABLE tipos_pieza(
  tipo CHAR(2),
  descripcion VARCHAR2(25) CONSTRAINT tipos_piezas_nn NOT NULL,
  CONSTRAINT tipos_piezas_pk PRIMARY KEY (tipo)
);

CREATE TABLE suministros (
  tipo CHAR(2) CONSTRAINT suministros_fk1 REFERENCES tipos_pieza(tipo),
  modelo NUMBER(2),
  cif CHAR(9) CONSTRAINT suministros__fk2 REFERENCES empresas(cif),
  precio_compra NUMBER(11,4) CONSTRAINT suministros_nn NOT NULL,
  CONSTRAINT suministros_pk PRIMARY KEY (tipo,modelo,cif)
);

CREATE TABLE empresas(
  cif CHAR(2) CONSTRAINT empresas_pk PRIMARY KEY,
  nombre VARCHAR2(50) CONSTRAINT empresas_nn NOT NULL
                      CONSTRAINT empresas_uk UNIQUE,
  telefono CHAR(9),
  direccion VARCHAR2(50),
  localidad VARCHAR2(50),
  provincia VARCHAR2(30)
);

CREATE TABLE pedidos (
  n_pedido NUMBER(4) CONSTRAINT pedidos_pk PRIMARY KEY,
  cif      CHAR(9) CONSTRAINT pedidos_nn1 NOT NULL
                   CONSTRAINT pedidos_fk REFERENCES empresas(cif),
  fecha DATE CONSTRAINT pedidos_nn2 NOT NULL
);

CREATE TABLE existencias(
  tipo CHAR(2),
  modelo NUMBER(2),
  n_almacen NUMBER(2),
  cantidad NUMBER(9) CONSTRAINT existencias_nn NOT NULL
                     CONSTRAINT existencias_ck CHECK (cantidad>0),
  CONSTRAINT existencias_pk PRIMARY KEY (tipo,modelo,n_almacen),
  CONSTRAINT existencias_fk1  FOREIGN KEY (tipo,modelo)REFERENCES piezas,
  CONSTRAINT existencias_fk2 FOREIGN KEY (n_almacen)REFERENCES almacenes
);

CREATE TABLE almacenes (
  n_almacen NUMBER(2) CONSTRAINT almacenes_pk PRIMARY KEY,
  descripcion VARCHAR2(1000) CONSTRAINT almacenes_nn NOT NULL,
  direccion VARCHAR2(100)
);

CREATE TABLE lineas_pedido (
  tipo CHAR(2) CONSTRAINT lineas_pedido_nn1 NOT NULL,
  modelo NUMBER(2) CONSTRAINT lineas_pedido_nn2 NOT NULL,
  n_pedido NUMBER(4),
  n_linea NUMBER(2),
  cantidad NUMBER(5),
  precio NUMBER(11,4),
  CONSTRAINT lineas_pedido_fk1 FOREIGN KEY (n_pedido) REFERENCES pedidos,
  CONSTRAINT lineas_pedido_fk2 FOREIGN KEY (tipo,modelo)REFERENCES piezas,
  CONSTRAINT lineas_pedido_pk PRIMARY KEY (n_linea,n_pedido)
);

CREATE TABLE piezas (
  tipo CHAR(2),
  modelo NUMBER(2),
  precio_venta NUMBER(11,4) CONSTRAINT piezas_nn NOT NULL,
  CONSTRAINT piezas_pk PRIMARY KEY (tipo,modelo),
  CONSTRAINT piezas_fk FOREIGN KEY (tipo)REFERENCES tipos_pieza
);