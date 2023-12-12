--1.7.	Indicar la cantidad de películas entregadas a partir
-- del 2010, por género.

SELECT p.genero, count(*) AS Cantidad_Entregadas
FROM unc_esq_peliculas.pelicula p
WHERE p.codigo_pelicula IN (
    SELECT r.codigo_pelicula
    FROM unc_esq_peliculas.renglon_entrega r
    WHERE r.nro_entrega IN (
        SELECT e.nro_entrega
        FROM unc_esq_peliculas.entrega e
        WHERE extract(YEAR FROM e.fecha_entrega) > '2010'
        )
    )
GROUP BY p.genero
ORDER BY p.genero ASC



