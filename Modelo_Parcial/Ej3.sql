--Utilizando el esquema de películas
-- (unc_esq_peliculas). Cual es la sentencia SQL que me daría un listado con los
-- códigos(ids) de país y la cantidad de ciudades, teniendo en cuenta sólo las ciudades
-- cuyo nombre terminan en 'on'

set search_path = 'unc_esq_peliculas';

SELECT c.id_pais, count(*) AS Cant_ciudades
FROM unc_esq_peliculas.ciudad c
JOIN unc_esq_peliculas.pais p ON (c.id_pais = p.id_pais)
WHERE nombre_ciudad LIKE '%on'
group by c.id_pais
order by c.id_pais
