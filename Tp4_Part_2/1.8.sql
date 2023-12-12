--1.8.Realizar un resumen de entregas por día, indicando el video
-- club al cual se le realizó la entrega y la cantidad entregada.
-- Ordenar el resultado por fecha.

SELECT e.fecha_entrega, v.propietario, count(r.cantidad) AS cantidad
FROM unc_esq_peliculas.renglon_entrega r
JOIN unc_esq_peliculas.entrega e ON (e.nro_entrega = r.nro_entrega)
JOIN unc_esq_peliculas.video v ON (e.id_video = v.id_video)
GROUP BY e.fecha_entrega, v.propietario
