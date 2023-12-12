set search_path = unc_251302;

CREATE TABLE CLIENTE (
    id_cliente int  NOT NULL,
    apellido varchar(80)  NOT NULL,
    nombre varchar(80)  NOT NULL,
    estado char(5)  NOT NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente));

INSERT INTO CLIENTE (id_cliente, apellido, nombre, estado)
VALUES (1, 'Gomez', 'Rodrigo', 'A'),
       (2, 'Simons', 'Veronica', 'A'),
       (3, 'De Rosa', 'Saul', 'C'),
       (4, 'De Vicente', 'Patricio', 'B' ),
       (5, 'Gallo', 'Lautaro', 'C' ),
       (6, 'Perez', 'Ivan', 'D' ),
       (7, 'Tomassi', 'Rocio','A '),
       (8, 'Gschwindt', 'Matias', 'S'),
       (9, 'Rodriguez', 'MarÃ­a', 'D'),
       (10, 'Martignoni', 'Natalia', 'J' );

CREATE TABLE FECHA_LIQ (
    dia_liq int  NOT NULL,
    mes_liq int  NOT NULL,
    cant_dias int  NOT NULL,
    CONSTRAINT PK_FECHA_LIQ PRIMARY KEY (dia_liq,mes_liq));

INSERT INTO FECHA_LIQ (dia_liq, mes_liq, cant_dias)
        VALUES (15, 05, 365),
               (12, 07, 120),
               (10, 09, 90),
               (7, 09, 45),
               (5, 05, 60),
               (20, 03, 210),
               (19, 02, 30),
               (2, 01, 60),
               (30, 09, 90),
               (28, 11, 120);

CREATE TABLE PRENDA (
    id_prenda int  NOT NULL,
    precio decimal(10,2)  NOT NULL,
    descripcion varchar(120)  NOT NULL,
    tipo varchar(40)  NOT NULL,
    categoria varchar(80)  NOT NULL,
    CONSTRAINT PK_PRENDA PRIMARY KEY (id_prenda));

INSERT INTO PRENDA (id_prenda, precio, descripcion, tipo, categoria)
VALUES (1, 12.5, 'prenda_01', 'remera', 'urbana'),
       (2, 12.5, 'prenda_02', 'chomba', 'polo'),
       (3, 12.5, 'prenda_03', 'bikini', 'playa'),
       (4, 12.5, 'prenda_04', 'campera', 'abrigo'),
       (5, 12.5, 'prenda_05', 'buzo', 'abrigo'),
       (6, 12.5, 'prenda_06', 'jean', 'urbana'),
       (7, 12.5, 'prenda_07', 'short', 'verano'),
       (8, 12.5, 'prenda_08', 'bufanda', 'invierno'),
       (9, 12.5, 'prenda_09', 'gorro de lana', 'invierno'),
       (10, 12.5, 'prenda_10', 'guantes', 'deporte');

CREATE TABLE VENTA (
    id_venta int  NOT NULL,
    descuento decimal(10,2)  NOT NULL,
    fecha timestamp  NOT NULL,
    id_prenda int  NOT NULL,
    id_cliente int  NOT NULL,
    CONSTRAINT PK_VENTA PRIMARY KEY (id_venta));

INSERT INTO VENTA (id_venta, descuento, fecha, id_prenda, id_cliente)
VALUEs (1, 5.0, '2022-02-23', 4, 1),
       (2, 10.0, '2022-02-27', 2, 7),
       (3, 12.0, '2022-03-6', 9, 2),
       (4, 6.0, '2022-04-20', 1, 3),
       (5, 3.0, '2022-04-27', 5, 5),
       (6, 2.0, '2022-04-30', 3, 4),
       (7, 20.0,'2022-05-7', 6, 8),
       (8, 70.0, '2022-06-3', 8, 6),
       (9, 80.0, '2022-07-9', 7, 9),
       (10, 50.0, '2022-08-13', 10, 10),
       (11, 5.0, '2022-09-28', 4, 5),
       (12, 5.0, '2022-10-05', 7, 8),
       (13, 5.0, '2022-11-08', 3, 1),
       (14, 5.0, '2022-11-12', 2, 3),
       (15, 5.0, '2022-12-24', 9, 8);

ALTER TABLE VENTA ADD CONSTRAINT FK_E5_VENTA_CLIENTE
    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE (id_cliente)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;

ALTER TABLE VENTA ADD CONSTRAINT FK_E5_VENTA_PRENDA
    FOREIGN KEY (id_prenda)
    REFERENCES PRENDA (id_prenda)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE;