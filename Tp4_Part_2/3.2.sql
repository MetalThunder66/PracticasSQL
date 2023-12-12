--Agregar a la definición de la tabla DistribuidorNac, el campo "codigo_pais" que indica el código
-- de país del distribuidor mayorista que
-- atiende a cada distribuidor nacional.(codigo_pais character varying(5) NULL)

set search_path = 'unc_251302';

ALTER TABLE DistribuidorNac
ADD COLUMN codigo_pais character varying(5) NULL;
