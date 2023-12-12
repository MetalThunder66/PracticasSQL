--1.2. Indicar la cantidad de películas que han sido entregadas en 2006 por un distribuidor nacional.

set search_path = 'unc_esq_peliculas';

SELECT SUM(cantidad)
FROM renglon_entrega re
WHERE re.nro_entrega IN (
    SELECT e.nro_entrega
    FROM entrega e INNER JOIN distribuidor d on e.id_distribuidor = d.id_distribuidor
    WHERE d.tipo = 'N' AND EXTRACT(YEAR FROM e.fecha_entrega) = '2006'
    );







