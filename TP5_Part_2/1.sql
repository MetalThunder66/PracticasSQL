set search_path = unc_251302;

--A. No puede haber voluntarios de más de 70 años.

ALTER TABLE voluntario
ADD CONSTRAINT ck_edad_menor_70
CHECK (EXTRACT (year FROM age(current_date,fecha_nacimiento)) < 70);

INSERT INTO voluntario(nombre, apellido, e_mail, telefono, fecha_nacimiento, id_tarea, nro_voluntario, horas_aportadas, porcentaje, id_institucion, id_coordinador)
VALUES ('agus','sau','dal6e66ctm@gmail.com', 555966, (TO_DATE('1952/12/06','YYYY/MM/DD')), 'ST_CLERK', 1061, 10, null, 80, 100);

delete from voluntario
WHERE nro_voluntario = '1061';

--B. Ningún voluntario puede aportar más horas que las de su coordinador.

ALTER TABLE  voluntario
ADD CONSTRAINT ck_horas_voluntario_menos_coordinador
CHECK ( NOT EXISTS ( SELECT v1.nro_voluntario
                     FROM voluntario v1
                     JOIN voluntario v2 ON v1.id_coordinador = v2.nro_voluntario
                     WHERE v1.horas_aportadas > v2.horas_aportadas
                    )

);

SELECT v1.horas_aportadas, v2.horas_aportadas
FROM voluntario v1
JOIN voluntario v2 ON (v1.id_coordinador = v2.nro_voluntario)
WHERE v1.nro_voluntario = 137;

--C. Las horas aportadas por los voluntarios deben estar dentro de los valores máximos y mínimos consignados en la tarea.

CREATE ASSERTION as_horas_aportadas_tarea
CHECK ( NOT EXISTS ()

--D. Todos los voluntarios deben realizar la misma tarea que su coordinador.
--E. Los voluntarios no pueden cambiar de institución más de tres veces en el año.
--F. En el histórico, la fecha de inicio debe ser siempre menor que la fecha de finalización.
