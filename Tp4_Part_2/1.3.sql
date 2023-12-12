/*1.3.Indicar los departamentos que no posean empleados cuya diferencia de sueldo
    máximo y mínimo (asociado a la tarea que realiza) no
    supere el 40% del sueldo máximo. (P) (Probar con 10% para que retorne valores)*/

SELECT d.nombre
FROM unc_esq_peliculas.departamento d
WHERE d.id_distribuidor AND d.id_departamento NOT IN (
    SELECT e.id_departamento
    FROM unc_esq_peliculas.empleado e
    WHERE e.id_tarea IN(
        SELECT t.id_tarea
        FROM unc_esq_peliculas.tarea t
        WHERE (t.sueldo_maximo - t.sueldo_minimo ) < (t.sueldo_maximo * 0.07)
        )
    );

SELECT nombre FROM departamento d WHERE NOT EXISTS (
    SELECT 'X'
    FROM empleado e
    WHERE d.id_departamento = e.id_departamento
      AND d.id_distribuidor = e.id_distribuidor
      AND EXISTS (
          SELECT 'Y'
          FROM tarea t
          WHERE e.id_tarea = t.id_tarea
            AND t.sueldo_maximo - t.sueldo_minimo <= t.sueldo_maximo * 0.1
          )
    );

