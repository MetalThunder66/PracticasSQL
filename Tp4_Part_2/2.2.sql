--2.2. Determine la cantidad de coordinadores en cada país,
-- agrupados por nombre de país y nombre de continente.
-- Etiquete la primer columna como 'Número de coordinadores'

set search_path = 'unc_esq_voluntario';

SELECT count(v.id_coordinador) AS "Numero de coordinadores", p.nombre_pais, c.nombre_continente
FROM voluntario v
JOIN institucion i ON (v.id_institucion = i.id_institucion)
JOIN direccion d on i.id_direccion = d.id_direccion
JOIN pais p on p.id_pais = d.id_pais
JOIN continente c on p.id_continente = c.id_continente
GROUP BY p.nombre_pais, c.nombre_continente
ORDER BY p.nombre_pais, c.nombre_continente