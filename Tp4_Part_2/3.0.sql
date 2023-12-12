set search_path = 'unc_251302';

CREATE TABLE DistribuidorNac
(
    id_distribuidor numeric(5,0) NOT NULL,
    nombre character varying(80) NOT NULL,
    direccion character varying(120) NOT NULL,
    telefono character varying(20),
    nro_inscripcion numeric(8,0) NOT NULL,
    encargado character varying(60) NOT NULL,
    id_distrib_mayorista numeric(5,0),

    CONSTRAINT pk_distribuidorNac PRIMARY KEY (id_distribuidor)
);



