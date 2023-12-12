set search_path = 'unc_esq_peliculas';

--1.1.	Listar todas las películas que poseen entregas de películas
-- de idioma inglés durante el año 2006.

SELECT *
FROM pelicula p
WHERE upper (p.idioma) = 'INGLÉS'
AND p.codigo_pelicula IN (
        SELECT r.codigo_pelicula
        FROM renglon_entrega r
        WHERE r.nro_entrega IN(
            SELECT e.nro_entrega
            FROM entrega e
            WHERE extract(YEAR FROM fecha_entrega) = '2006'
        )
    )



