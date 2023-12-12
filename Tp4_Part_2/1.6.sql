--1.6.	Liste el apellido y nombre de los empleados que
-- pertenecen a aquellos departamentos de Argentina y donde el
-- jefe de departamento posee una comisión de más
-- del 10% de la que posee su empleado a cargo

set search_path = 'unc_esq_peliculas';

SELECT *
FROM empleado e
WHERE e.id_departamento IN (
    SELECT d.id_departamento
    FROM departamento d
    WHERE d.id_ciudad IN (
        SELECT c.id_ciudad
        FROM ciudad c
        WHERE c.id_pais = 'AR')
    )
AND EXISTS(SELECT 1
            FROM departamento d
            INNER JOIN empleado j ON (d.jefe_departamento = j.id_empleado)
            AND e.id_jefe = j.id_empleado
            AND (j.porc_comision - e.porc_comision) > 10
    );

select *
from empleado
where id_empleado = '32504'















