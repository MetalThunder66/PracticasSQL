--A. La modalidad de la imagen médica puede tomar los siguientes valores RADIOLOGIA CONVENCIONAL,
-- FLUOROSCOPIA, ESTUDIOS RADIOGRAFICOS CON FLUOROSCOPIA, MAMOGRAFIA, SONOGRAFIA,

ALTER TABLE p5p2e4_imagen_medica
ADD CONSTRAINT ck_modalidad_imagen
CHECK ( modalidad IN (
                        'ADIOLOGIA CONVENCIONAL','FLUOROSCOPIA', 'ESTUDIOS RADIOGRAFICOS CON FLUOROSCOPIA',
                        'MAMOGRAFIA', 'SONOGRAFIA'));

--B. Cada imagen no debe tener más de 5 procesamientos.

ALTER TABLE p5p2e4_imagen_medica
ADD CONSTRAINT ck_max_procesamiento
CHECK ( NOT EXISTS ( SELECT *
                     FROM p5p2e4_procesamiento
                     GROUP BY id_imagen, id_paciente
                     HAVING count(*) > 5)
);

--C. Agregue dos atributos de tipo fecha a las tablas Imagen_medica y Procesamiento, una indica la fecha de la imagen y la otra la fecha de
-- procesamiento de la imagen y controle que la segunda no sea menor que la primera.

ALTER TABLE p5p2e4_imagen_medica
ADD COLUMN fecha_imagen date;

ALTER TABLE p5p2e4_procesamiento
ADD COLUMN fecha_procesamiento date;

CREATE ASSERTION as_fecha_imagen_fecha_procesamiento
CHECK ( NOT EXISTS (    SELECT 1
                        FROM imagen_medica i
                        JOIN procesamiento p ON i.id_imagen = p.id_imagen AND i.id_paciente = p.id_paciente
                        WHERE p.fecha_procesamiento > i.fecha_imagen
                    )
);

--D. Cada paciente sólo puede realizar dos FLUOROSCOPIA anuales.

ALTER TABLE p5p2e4_imagen_medica
ADD CONSTRAINT ck_max_modalidad
CHECK ( NOT EXISTS( SELECT 1
                    FROM p5p2e4_imagen_medica im
                    WHERE modalidad = 'FLUOROSCOPIA'
                    GROUP BY id_paciente, id_imagen, EXTRACT(YEAR FROM fecha_imagen)
                    HAVING count(*) > 2
          )
);

--E. No se pueden aplicar algoritmos de costo computacional “O(n)” a imágenes de FLUOROSCOPIA

CREATE ASSERTION costo_computacional_FLUOROSCOPIA
CHECK ( NOT EXISTS (    SELECT 1
                        FROM p5p2e4_algoritmo a
                        JOIN p5p2e4_procesamiento p ON a.id_algoritmo = p.id_algoritmo
                        JOIN p5p2e4_imagen_medica im ON p.id_imagen = im.id_imagen AND p.id_paciente = im.id_paciente
                        WHERE (a.costo_computacional = 'O(n)' AND im.modalidad <> 'FLUOROSCOPIA') OR a.costo_computacional <> 'O(n)'
                    )
);

