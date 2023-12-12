set search_path = unc_251302;

-- Table: P5P2E4_ALGORITMO
CREATE TABLE P5P2E4_ALGORITMO (
    id_algoritmo int  NOT NULL,
    nombre_metadata varchar(40)  NOT NULL,
    descripcion varchar(256)  NOT NULL,
    costo_computacional varchar(15)  NOT NULL,
    CONSTRAINT PK_P5P2E4_ALGORITMO PRIMARY KEY (id_algoritmo)
);

-- Table: P5P2E4_IMAGEN_MEDICA
CREATE TABLE P5P2E4_IMAGEN_MEDICA (
    id_paciente int  NOT NULL,
    id_imagen int  NOT NULL,
    modalidad varchar(80)  NOT NULL,
    descripcion varchar(180)  NOT NULL,
    descripcion_breve varchar(80)  NULL,
    CONSTRAINT PK_P5P2E4_IMAGEN_MEDICA PRIMARY KEY (id_paciente,id_imagen)
);

-- Table: P5P2E4_PACIENTE
CREATE TABLE P5P2E4_PACIENTE (
    id_paciente int  NOT NULL,
    apellido varchar(80)  NOT NULL,
    nombre varchar(80)  NOT NULL,
    domicilio varchar(120)  NOT NULL,
    fecha_nacimiento date  NOT NULL,
    CONSTRAINT PK_P5P2E4_PACIENTE PRIMARY KEY (id_paciente)
);

-- Table: P5P2E4_PROCESAMIENTO
CREATE TABLE P5P2E4_PROCESAMIENTO (
    id_algoritmo int  NOT NULL,
    id_paciente int  NOT NULL,
    id_imagen int  NOT NULL,
    nro_secuencia int  NOT NULL,
    parametro decimal(15,3)  NOT NULL,
    CONSTRAINT PK_P5P2E4_PROCESAMIENTO PRIMARY KEY (id_algoritmo,id_paciente,id_imagen,nro_secuencia)
);

-- foreign keys
-- Reference: FK_P5P2E4_IMAGEN_MEDICA_PACIENTE (table: P5P2E4_IMAGEN_MEDICA)
ALTER TABLE P5P2E4_IMAGEN_MEDICA ADD CONSTRAINT FK_P5P2E4_IMAGEN_MEDICA_PACIENTE
    FOREIGN KEY (id_paciente)
    REFERENCES P5P2E4_PACIENTE (id_paciente)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_P5P2E4_PROCESAMIENTO_ALGORITMO (table: P5P2E4_PROCESAMIENTO)
ALTER TABLE P5P2E4_PROCESAMIENTO ADD CONSTRAINT FK_P5P2E4_PROCESAMIENTO_ALGORITMO
    FOREIGN KEY (id_algoritmo)
    REFERENCES P5P2E4_ALGORITMO (id_algoritmo)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

-- Reference: FK_P5P2E4_PROCESAMIENTO_IMAGEN_MEDICA (table: P5P2E4_PROCESAMIENTO)
ALTER TABLE P5P2E4_PROCESAMIENTO ADD CONSTRAINT FK_P5P2E4_PROCESAMIENTO_IMAGEN_MEDICA
    FOREIGN KEY (id_paciente, id_imagen)
    REFERENCES P5P2E4_IMAGEN_MEDICA (id_paciente, id_imagen)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

INSERT INTO unc_251302.p5p2e4_paciente values (6,'Garcia','Jackson','Leal2313','2010/09/15'),
                                              (7,' Wright','Liam','9 de Julio 2323','2001/08/12'),
                                              (8,'Robinson','Lucas','Pedro Agote 345','2002/10/14'),
                                              (9,'Johnson','Alexander','Alberti 6545','2010/1/15'),
                                              (10,'Garcia','Jackson','Leal2313','2010/11/25'),
                                              (11,' Martín','Liam','Boyacá 2323','2001/08/12'),
                                              (12,'Louis','Alejandro','Cabildo 6445','2002/04/24'),
                                              (13,'Johnson','Santiago','Alberti 4545','2011/4/15'),
                                              (14,'Garcia','Matheus','Castroc4455,','2010/09/03'),
                                              (15,' Evans','Liam','Coronel Roca     2213','2001/07/08'),
                                              (16,'Robinson','James','Coronel Roca 1245','2008/07/09'),
                                              (17,'Evans','Davi','Alberti 7545','2008/07/15'),
                                              (18,'Evans','Jackson','Coronel Roca     2323','2008/11/25'),
                                              (19,' Martín','Miguel','Coronel Roca 1323','2002/06/12'),
                                              (20,'Louis','Alejandro','Córdoba 6785','2002/06/24'),
                                              (21,'Johnson','James','Córdoba 4125','2013/06/15');

INSERT INTO unc_251302.p5p2e4_IMAGEN_MEDICA (id_paciente, id_imagen, modalidad, descripcion, descripcion_breve)
VALUES   (11, 11, 'RADIOLOGIA CONVENCIONAL', 'radiologia_C_1', 'R_C_1'),
         (12, 12, 'FLUOROSCOPIA', 'fluoroscopia_1', 'F_1'),
         (13, 13, 'ESTUDIOS RADIOGRAFICOS CON FLUOROSCOPIA', 'est_rad_Cfluo_1', 'ER_CF_1'),
         (14, 14, 'MAMOGRAFIA', 'mamografia_1', 'M_1'),
         (15, 15, 'SONOGRAFIA', 'sonografia_1', 'SN_1'),
         (6, 6, 'FLUOROSCOPIA', 'fluoroscopia_2', 'F_2'),
         (7, 7, 'ESTUDIOS RADIOGRAFICOS CON FLUOROSCOPIA', 'est_rad_Cfluo_2', 'ER_CF_2'),
         (8, 8, 'MAMOGRAFIA', 'mamografia_2', 'M_2'),
         (9, 9, 'SONOGRAFIA', 'sonografia_2', 'SN_2'),
         (10, 10, 'FLUOROSCOPIA', 'fluoroscopia_3', 'F_3');

INSERT INTO unc_251302.p5p2e4_algoritmo (id_algoritmo, nombre_metadata, descripcion, costo_computacional)
VALUES (1,'metadata_1','d_metadata_1', 'O(n)'),
        (2,'metadata_2','d_metadata_2', '1(n)'),
        (3,'metadata_3','d_metadata_3', '2(n)'),
        (4,'metadata_4','d_metadata_4', 'O(n)'),
        (5,'metadata_5','d_metadata_5', '1(n)'),
        (6,'metadata_6','d_metadata_6', 'O(n)'),
        (7,'metadata_7','d_metadata_7', '1(n)'),
        (8,'metadata_8','d_metadata_8', '2(n)'),
        (9,'metadata_9','d_metadata_9', 'O(n)'),
        (10,'metadata_10','d_metadata_5', '1(n)'),
        (11,'metadata_11','d_metadata_11', '11(n)'),
        (12,'metadata_12','d_metadata_12', '12(n)'),
        (13,'metadata_13','d_metadata_13', '13(n)'),
        (14,'metadata_14','d_metadata_14', '14(n)'),
        (15,'metadata_15','d_metadata_15', '15(n)'),
        (16,'metadata_16','d_metadata_16', '16(n)'),
        (17,'metadata_17','d_metadata_17', '17(n)'),
        (18,'metadata_18','d_metadata_18', '18(n)'),
        (19,'metadata_19','d_metadata_19', '19(n)'),
        (20,'metadata_20','d_metadata_20', '20(n)');


INSERT INTO unc_251302.p5p2e4_procesamiento (id_algoritmo, id_paciente, id_imagen, nro_secuencia, parametro)
VALUES (1,11, 11,4,12.3),
       (2,12,12,4,7.3),
       (3,13,13,4,1.3),
       (4,14,14,4,72.3),
       (5,15,15,4,52.3),
       (6,6,6,4,21.3),
       (7,7,7,4,11.3),
       (8,8,8,4,17.3),
       (9,9,9,4,14.3),
       (10,10,10,4,4.3);
