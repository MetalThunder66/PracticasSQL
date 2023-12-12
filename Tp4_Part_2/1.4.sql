/*1.4.	Liste las películas que nunca han sido entregadas por un
  distribuidor nacional*/

set search_path = 'unc_esq_peliculas';


SELECT *
FROM unc_esq_peliculas.pelicula p
WHERE p.codigo_pelicula IN (
    SELECT r.codigo_pelicula
    FROM unc_esq_peliculas.renglon_entrega r
    WHERE r.nro_entrega IN(
        SELECT e.nro_entrega
        FROM unc_esq_peliculas.entrega e
        WHERE e.id_distribuidor IN (
                SELECT d.id_distribuidor
                FROM unc_esq_peliculas.distribuidor d
                WHERE d.tipo = 'I'
            )
        )
    )

SELECT *
FROM pelicula
WHERE codigo_pelicula IN (SELECT codigo_pelicula
                        FROM renglon_entrega
                        WHERE nro_entrega IN (SELECT nro_entrega
                                        FROM entrega
                                        WHERE id_distribuidor IN (SELECT id_distribuidor
                                                                FROM internacional)));






