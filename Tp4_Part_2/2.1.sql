--2.1.	Muestre, para cada institución, su nombre y la cantidad
--de voluntarios que realizan aportes. Ordene el resultado por
--nombre de institución.

set search_path = 'unc_esq_voluntario';

SELECT i.nombre_institucion, count(v.nro_voluntario) AS cantidad_vol
FROM institucion i
RIGHT JOIN voluntario v ON i.id_institucion = v.id_institucion
GROUP BY i.nombre_institucion
ORDER BY i.nombre_institucion asc


