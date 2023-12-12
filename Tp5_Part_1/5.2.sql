set search_path = 'unc_251302';

-- Table: TP5_P1_EJ2_AUSPICIO
CREATE TABLE TP5_P1_EJ2_AUSPICIO (
    id_proyecto int  NOT NULL,
    nombre_auspiciante varchar(20)  NOT NULL,
    tipo_empleado char(2)  NULL,
    nro_empleado int  NULL,
    CONSTRAINT TP5_P1_EJ2_AUSPICIO_pk PRIMARY KEY (id_proyecto,nombre_auspiciante)
);

-- Table: TP5_P1_EJ2_EMPLEADO
CREATE TABLE TP5_P1_EJ2_EMPLEADO (
    tipo_empleado char(2)  NOT NULL,
    nro_empleado int  NOT NULL,
    nombre varchar(40)  NOT NULL,
    apellido varchar(40)  NOT NULL,
    cargo varchar(15)  NOT NULL,
    CONSTRAINT TP5_P1_EJ2_EMPLEADO_pk PRIMARY KEY (tipo_empleado,nro_empleado)
);

-- Table: TP5_P1_EJ2_PROYECTO
CREATE TABLE TP5_P1_EJ2_PROYECTO (
    id_proyecto int  NOT NULL,
    nombre_proyecto varchar(40)  NOT NULL,
    anio_inicio int  NOT NULL,
    anio_fin int  NULL,
    CONSTRAINT TP5_P1_EJ2_PROYECTO_pk PRIMARY KEY (id_proyecto)
);

-- Table: TP5_P1_EJ2_TRABAJA_EN
CREATE TABLE TP5_P1_EJ2_TRABAJA_EN (
    tipo_empleado char(2)  NOT NULL,
    nro_empleado int  NOT NULL,
    id_proyecto int  NOT NULL,
    cant_horas int  NOT NULL,
    tarea varchar(20)  NOT NULL,
    CONSTRAINT TP5_P1_EJ2_TRABAJA_EN_pk PRIMARY KEY (tipo_empleado,nro_empleado,id_proyecto)
);

-- foreign keys
-- Reference: FK_TP5_P1_EJ2_AUSPICIO_EMPLEADO (table: TP5_P1_EJ2_AUSPICIO)
ALTER TABLE TP5_P1_EJ2_AUSPICIO ADD CONSTRAINT FK_TP5_P1_EJ2_AUSPICIO_EMPLEADO
    FOREIGN KEY (tipo_empleado, nro_empleado)
    REFERENCES TP5_P1_EJ2_EMPLEADO (tipo_empleado, nro_empleado)
	MATCH FULL --se aplican a las FK
    ON DELETE  SET NULL
    ON UPDATE  RESTRICT
;

-- Reference: FK_TP5_P1_EJ2_AUSPICIO_PROYECTO (table: TP5_P1_EJ2_AUSPICIO)
ALTER TABLE TP5_P1_EJ2_AUSPICIO ADD CONSTRAINT FK_TP5_P1_EJ2_AUSPICIO_PROYECTO
    FOREIGN KEY (id_proyecto)
    REFERENCES TP5_P1_EJ2_PROYECTO (id_proyecto)
    ON DELETE  RESTRICT
    ON UPDATE  RESTRICT
;

-- Reference: FK_TP5_P1_EJ2_TRABAJA_EN_EMPLEADO (table: TP5_P1_EJ2_TRABAJA_EN)
ALTER TABLE TP5_P1_EJ2_TRABAJA_EN ADD CONSTRAINT FK_TP5_P1_EJ2_TRABAJA_EN_EMPLEADO
    FOREIGN KEY (tipo_empleado, nro_empleado)
    REFERENCES TP5_P1_EJ2_EMPLEADO (tipo_empleado, nro_empleado)
    ON DELETE  CASCADE
    ON UPDATE  RESTRICT
;

-- Reference: FK_TP5_P1_EJ2_TRABAJA_EN_PROYECTO (table: TP5_P1_EJ2_TRABAJA_EN)
ALTER TABLE TP5_P1_EJ2_TRABAJA_EN ADD CONSTRAINT FK_TP5_P1_EJ2_TRABAJA_EN_PROYECTO
    FOREIGN KEY (id_proyecto)
    REFERENCES TP5_P1_EJ2_PROYECTO (id_proyecto)
    ON DELETE  RESTRICT
    ON UPDATE  CASCADE
;

-- EMPLEADO
INSERT INTO tp5_p1_ej2_empleado VALUES ('A ', 1, 'Juan', 'Garcia', 'Jefe');
INSERT INTO tp5_p1_ej2_empleado VALUES ('B', 1, 'Luis', 'Lopez', 'Adm');
INSERT INTO tp5_p1_ej2_empleado VALUES ('A ', 2, 'María', 'Casio', 'CIO');
INSERT INTO tp5_p1_ej2_empleado VALUES ('A ', 5, 'María', 'Casio', 'CIO');

-- PROYECTO
INSERT INTO tp5_p1_ej2_proyecto VALUES (1, 'Proy 1', 2019, NULL);
INSERT INTO tp5_p1_ej2_proyecto VALUES (2, 'Proy 2', 2018, 2019);
INSERT INTO tp5_p1_ej2_proyecto VALUES (3, 'Proy 3', 2020, NULL);
INSERT INTO tp5_p1_ej2_proyecto VALUES (66, 'Proy 5', 2020, NULL);

-- TRABAJA_EN
INSERT INTO tp5_p1_ej2_trabaja_en VALUES ('A ', 1, 1, 35, 'T1');
INSERT INTO tp5_p1_ej2_trabaja_en VALUES ('A ', 2, 2, 25, 'T3');

-- AUSPICIO
INSERT INTO tp5_p1_ej2_auspicio VALUES (2, 'McDonald', 'A ', 2);
INSERT INTO tp5_p1_ej2_auspicio VALUES (22, 'McDonald', 'A ', 5);

--b.1) delete from tp5_p1_ej2_proyecto where id_proyecto = 3;
delete from tp5_p1_ej2_proyecto where id_proyecto = 3;
--borro correctamente porque no existen referencias a id_proyecto = 3

--b.2) update tp5_p1_ej2_proyecto set id_proyecto = 7 where id_proyecto = 3;
update tp5_p1_ej2_proyecto set id_proyecto = 7 where id_proyecto = 3;
--actualiza correctamente, no hay referencias de ese id de proyecto

--b.3) delete from tp5_p1_ej2_proyecto where id_proyecto = 1;
delete from tp5_p1_ej2_proyecto where id_proyecto = 66;
--error: aun existe una referencia de Proyecto en la tabla Trabaja_en (id_preoyecto = 1), tiene RESTRICT

--b.4) delete from tp5_p1_ej2_empleado where tipo_empleado = ‘A’ and nro_empleado = 2;
delete from tp5_p1_ej2_empleado where nro_empleado = 2 AND tipo_empleado = 'A';
--borra bien, funciona la cascada y borra tambien en Trabaja_en. Auspicio le pone nulo al borrar, tiene q permitir nulos el campo

--b.5) update tp5_p1_ej2_trabaja_en set id_proyecto = 3 where id_proyecto =1;
update tp5_p1_ej2_trabaja_en set id_proyecto = 3 where id_proyecto = 1;
--se puede siempre y cuando exista en la tabla proyecto esa id.

--b.6) update tp5_p1_ej2_proyecto set id_proyecto = 5 where id_proyecto = 2;
update tp5_p1_ej2_proyecto set id_proyecto = 5 where id_proyecto = 2;
--no se puede ya que id_proyecto 2 tiene una referencia en la tabla auspicio, auspicio tiene UPDATE RESTRICT

--b-b)	Indique el resultado de la siguiente operaciones justificando su elección:
--ninguna de las anteriores, si la tupla nro empleado 5 e id proyecto 22 no existen en sus respectivas tablas (proyecto y empleado),
-- y id_proyecto = 66, nro_empleado = 10 deben tambien existir
-- sino no puedan modificarse los campos

update tp5_p1_ej2_auspicio set id_proyecto= 66, nro_empleado = 10
where id_proyecto = 22
and tipo_empleado = 'A'
and nro_empleado = 5;

--d) Indique cuáles de las siguientes operaciones serán aceptadas/rechazadas, según se considere para las
-- relaciones AUSPICIO-EMPLEADO y AUSPICIO-PROYECTO match:
-- i) simple,
-- ii) parcial,
-- iii) full:
    --a. insert into Auspicio values (1, Dell , B, null);
    insert into TP5_P1_EJ2_AUSPICIO values (1, 'Dell' , 'B', null);
        --rechazada. Tiene una pk null y otra hace referencia. Seria para match simple y partial pero solo admite FULL MATCHING

    --b. insert into Auspicio values (2, Oracle, null, null);
    insert into TP5_P1_EJ2_AUSPICIO values (2, 'Oracle', null, null);
        --aceptada, full matching, las 2 pk son nulos y cumple con la restriccion

    --c. insert into Auspicio values (3, Google, A, 3);
    insert into TP5_P1_EJ2_AUSPICIO values (3, 'Google', 'A', 3);
        --rechazada, no existen id_empleado 3 en su respectiva tablas.
        -- no acepta ningun tipo de matching

    --d. insert into Auspicio values (1, 'HP', null, 3);
    insert into TP5_P1_EJ2_AUSPICIO values (1, 'HP', null, 3);
        --match partial no porqe no existe la referencia 3 en id_empleado



