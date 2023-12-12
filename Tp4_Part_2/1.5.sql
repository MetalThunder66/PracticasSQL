--1.5.	Determinar los jefes que poseen personal a cargo y cuyos departamentos
-- (los del jefe)  se encuentren en la Argentina.

--SELECT *
SELECT concat(e.nombre, '', e.apellido) AS "Jefes en Argentina", e.id_empleado
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.empleado e2
ON e.id_jefe = e2.id_empleado
WHERE (e.id_distribuidor, e2.id_departamento) IN (
    SELECT d.id_distribuidor, d.id_departamento
    FROM unc_esq_peliculas.departamento d
    WHERE d.id_ciudad IN (
        SELECT c.id_ciudad
        FROM unc_esq_peliculas.ciudad c
        WHERE c.id_pais = 'AR'
        )
    );

select *
FROM unc_esq_peliculas.empleado e
JOIN unc_esq_peliculas.departamento d ON (e.id_empleado = d.jefe_departamento)
JOIN unc_esq_peliculas.ciudad c ON (d.id_ciudad = c.id_ciudad)
WHERE e.id_empleado = '27747'




