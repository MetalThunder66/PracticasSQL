set search_path = unc_251302;

--INSERTA COPIA DE TABLAS EXISTENTES
INSERT INTO tarea
SELECT * FROM unc_esq_voluntario.tarea;

INSERT INTO continente
SELECT * FROM unc_esq_voluntario.continente;

INSERT INTO pais
SELECT * FROM unc_esq_voluntario.pais;

INSERT INTO direccion
SELECT * FROM unc_esq_voluntario.direccion;

INSERT INTO institucion (nombre_institucion, id_direccion, id_institucion)
SELECT i.nombre_institucion, i.id_direccion, i.id_institucion
FROM unc_esq_voluntario.institucion i;
--WHERE id_institucion <> 10;

INSERT INTO voluntario
SELECT *
FROM unc_esq_voluntario.voluntario v;
--WHERE v.nro_voluntario <> 100;

INSERT INTO historico
SELECT * FROM unc_esq_voluntario.historico;

SELECT institucion.id_institucion FROM unc_esq_voluntario.institucion;

--UPDATE institucion SET id_director=205 WHERE id_institucion=110; a manopla por puto

UPDATE institucion
SET id_director = i2.id_director
FROM unc_esq_voluntario.institucion i2
WHERE id_institucion = i2.id_institucion;

SELECT current_user;  -- user name of current execution context
SELECT session_user;  -- session user name


--CREATE TABLES

create table continente
(
    nombre_continente varchar(25),
    id_continente     numeric not null
        constraint pk_continente
            primary key
);
    --with oids
    --with (autovacuum_enabled = true);

alter table continente
    owner to unc_251302;

grant references, select on continente to public;

create table pais
(
    nombre_pais   varchar(40),
    id_continente numeric not null
        constraint fk_continente
            references continente,
    id_pais       char(2) not null
        constraint pk_pais
            primary key
);
    --with oids
    --with (autovacuum_enabled = true);

alter table pais
    owner to unc_251302;

grant references, select on pais to public;

create table direccion
(
    calle         varchar(40),
    codigo_postal varchar(12),
    ciudad        varchar(30) not null,
    provincia     varchar(25),
    id_pais       char(2)     not null
        constraint fk_pais
            references pais,
    id_direccion  numeric(4)  not null
        constraint pk_direccion
            primary key
);
    --with oids
    --with (autovacuum_enabled = true);

alter table direccion
    owner to unc_251302;

grant references, select on direccion to public;

create table tarea
(
    nombre_tarea varchar(40) not null,
    min_horas    numeric(6),
    id_tarea     varchar(10) not null
        constraint pk_tarea
            primary key,
    max_horas    numeric(6)
);
    --with oids
    --with (autovacuum_enabled = true);

alter table tarea
    owner to unc_251302;

create table voluntario
(
    nombre           varchar(20),
    apellido         varchar(25) not null,
    e_mail           varchar(40) not null,
    telefono         varchar(20),
    fecha_nacimiento date        not null,
    id_tarea         varchar(10) not null
        constraint fk_tarea_v
            references tarea,
    nro_voluntario   numeric(6)  not null
        constraint pk_voluntario
            primary key,
    horas_aportadas  numeric(8, 2)
        constraint chk_hs_ap
            check (horas_aportadas > (0)::numeric),
    porcentaje       numeric(2, 2),
    id_institucion   numeric(4),
    id_coordinador   numeric(6)
        constraint fk_coordinador
            references voluntario,
    constraint ck_horas_aportadas
        check ((horas_aportadas <= (24000)::numeric) AND (id_coordinador < (206)::numeric))
);
    --with oids
    --with (autovacuum_enabled = true);

alter table voluntario
    owner to unc_251302;

create unique index emp_email_uk
    on voluntario (e_mail);

grant references, select on voluntario to public;

create table institucion
(
    nombre_institucion varchar(60) not null,
    id_director        numeric(6)
        constraint fk_director
            references voluntario,
    id_direccion       numeric(4)
        constraint fk_direccion
            references direccion,
    id_institucion     numeric(4)  not null
        constraint pk_institucion
            primary key
);
    --with oids
    --with (autovacuum_enabled = true);

alter table institucion
    owner to unc_251302;

alter table voluntario
    add constraint fk_institucion_v
        foreign key (id_institucion) references institucion;

create table historico
(
    fecha_inicio   date        not null,
    nro_voluntario numeric(6)  not null
        constraint fk_voluntario_h
            references voluntario,
    fecha_fin      date        not null,
    id_tarea       varchar(10) not null
        constraint fk_tarea_h
            references tarea,
    id_institucion numeric(4)
        constraint fk_institucion_h
            references institucion,
    constraint pk_historico
        primary key (fecha_inicio, nro_voluntario),
    constraint historico_check
        check (fecha_fin > fecha_inicio)
);
    --with oids
    --with (autovacuum_enabled = true);

alter table historico
    owner to unc_251302;

grant references, select on historico to public;

grant references, select on institucion to public;

grant references, select on pais to public;



