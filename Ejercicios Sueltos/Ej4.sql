--Utilizando el esquema de películas (unc_esq_peliculas). Cuál es la sentencia SQL que devuelve un
-- listado de las películas existentes en más de 3 entregas,
-- con menos de 3 copias por entrega.

set search_path = 'unc_esq_peliculas';

SELECT p.titulo
FROM pelicula p
WHERE p.codigo_pelicula IN (
    SELECT re.codigo_pelicula
    FROM renglon_entrega re
    WHERE re.cantidad < 3
    GROUP BY re.codigo_pelicula
    HAVING count(re.nro_entrega) > 3
    );

SELECT *
FROM pelicula p
where exists( select 1
     from renglon_entrega re
        where p.codigo_pelicula = re.codigo_pelicula
        and cantidad < 3
        Group By codigo_pelicula
        having count(*) > 3
            );