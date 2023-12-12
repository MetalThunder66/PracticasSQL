--1.9.Listar, para cada ciudad, el nombre de la ciudad y la cantidad
-- de empleados mayores de edad que desempeñan tareas en departamentos
-- de la misma y que posean al menos 30 empleados.

SELECT c.nombre_ciudad, count(e.id_empleado) AS cantidad
FROM unc_esq_peliculas.ciudad c
JOIN unc_esq_peliculas.departamento d ON (c.id_ciudad = d.id_ciudad)
JOIN unc_esq_peliculas.empleado e ON (d.id_departamento = e.id_departamento)
AND d.id_distribuidor = e.id_distribuidor
GROUP BY c.nombre_ciudad
HAVING count(e.id_empleado) > 30
ORDER BY cantidad

