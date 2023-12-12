--Se solicita llenarla con la información correspondiente a los datos completos de
-- todos los distribuidores nacionales.

set search_path = 'unc_251302';

INSERT INTO distribuidornac(id_distribuidor, nombre, direccion, telefono, nro_inscripcion, encargado)
    SELECT n.id_distribuidor, d.nombre, d.direccion, d.telefono, n.nro_inscripcion, n.encargado
    FROM unc_esq_peliculas.nacional n
    JOIN unc_esq_peliculas.distribuidor d on n.id_distribuidor = d.id_distribuidor;

SELECT *
FROM distribuidornac






