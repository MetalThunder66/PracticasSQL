--2.4.	Cree una consulta para mostrar los números de voluntarios
-- y los apellidos de todos los voluntarios cuya cantidad de horas
-- aportadas sea mayor que la media de las horas aportadas. Ordene
-- los resultados por horas aportadas en orden ascendente

set search_path = 'unc_esq_voluntario';

SELECT v.nro_voluntario, v.apellido, v.horas_aportadas
FROM voluntario v
WHERE v.horas_aportadas > (
    SELECT AVG(v2.horas_aportadas)
    FROM voluntario v2
    )
ORDER BY v.horas_aportadas


