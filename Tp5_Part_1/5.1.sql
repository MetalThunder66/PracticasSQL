
set search_path = 'unc_251302';

CREATE TABLE ARTICULO (
    id_articulo SERIAL,
    titulo varchar(120)  NOT NULL,
    autor varchar(30)  NOT NULL,
    CONSTRAINT ARTICULO_pk PRIMARY KEY (id_articulo)
);

-- Table: P5P1E1_PALABRA
CREATE TABLE PALABRA (
    idioma char(2)  NOT NULL,
    cod_palabra SERIAL,
    descripcion varchar(25)  NOT NULL,
    CONSTRAINT PALABRA_pk PRIMARY KEY (idioma,cod_palabra)
);

-- Table: P5P1E1_CONTIENE
CREATE TABLE CONTIENE (
    id_articulo int  NOT NULL,
    idioma char(2)  NOT NULL,
    cod_palabra int  NOT NULL,
    CONSTRAINT CONTIENE_pk PRIMARY KEY (id_articulo,idioma,cod_palabra)
);

-- foreign keys
-- Reference: FK_P5P1E1_CONTIENE_ARTICULO (table: P5P1E1_CONTIENE)
ALTER TABLE CONTIENE ADD CONSTRAINT FK_CONTIENE_ARTICULO
    FOREIGN KEY (id_articulo)
    REFERENCES ARTICULO (id_articulo)
    ON DELETE CASCADE
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_P5P1E1_CONTIENE_PALABRA (table: P5P1E1_CONTIENE)
ALTER TABLE CONTIENE ADD CONSTRAINT FK_CONTIENE_PALABRA
    FOREIGN KEY (idioma, cod_palabra)
    REFERENCES PALABRA (idioma, cod_palabra)
    ON DELETE CASCADE
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

--La tabla contiene se crea a partir de la relacion que guardan
--las tablas articulo y palabra

--Cargar tabla articulo
INSERT INTO ARTICULO(titulo, autor)
VALUES ('una', 'Agustin s');

--Cargar tabla palabra
INSERT INTO PALABRA(idioma, descripcion)
VALUES ('as', 'asdaasdsdo');

--Cargar tabla contiene
INSERT INTO CONTIENE(id_articulo, idioma, cod_palabra)
VALUES (4, 'ib', 3); --los datos deben existir tanto en articulo como en palabra

DELETE FROM ARTICULO
WHERE id_articulo = 2;

--a) Cómo debería implementar las Restricciones de Integridad Referencial (RIR) si se desea
-- que cada vez que se elimine un registro de la tabla PALABRA , también se eliminen los artículos
-- que la referencian en la tabla CONTIENE.

--ON DELETE CASCADE en CONTIENE

--b)	Verifique qué sucede con las palabras contenidas en cada artículo, al eliminar una palabra, si definen
-- la Acción Referencial para las bajas (ON DELETE) de la RIR correspondiente como:
--ii) Restrict
--iii) Es posible para éste ejemplo colocar SET NULL o SET DEFAULT para ON DELETE y ON UPDATE?

-- foreign keys
-- Reference: FK_P5P1E1_CONTIENE_ARTICULO (table: P5P1E1_CONTIENE)
ALTER TABLE CONTIENE ADD CONSTRAINT FK_CONTIENE_ARTICULO
    FOREIGN KEY (id_articulo)
    REFERENCES ARTICULO (id_articulo)
    ON DELETE SET DEFAULT
    ON UPDATE SET DEFAULT
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_P5P1E1_CONTIENE_PALABRA (table: P5P1E1_CONTIENE)
ALTER TABLE CONTIENE ADD CONSTRAINT FK_CONTIENE_PALABRA
    FOREIGN KEY (idioma, cod_palabra)
    REFERENCES PALABRA (idioma, cod_palabra)
    ON DELETE SET DEFAULT
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Table: P5P1E1_CONTIENE
CREATE TABLE CONTIENE (
    id_articulo int  NOT NULL,
    idioma char(2)  NOT NULL DEFAULT 'en',
    cod_palabra int  NOT NULL DEFAULT '3',
    CONSTRAINT CONTIENE_pk PRIMARY KEY (id_articulo,idioma,cod_palabra)
);

--modificar una propiedad de tabla ya creada
ALTER TABLE CONTIENE
ALTER COLUMN idioma
SET DEFAULT 'es';

UPDATE PALABRA
SET cod_palabra = 4
WHERE cod_palabra = 3

