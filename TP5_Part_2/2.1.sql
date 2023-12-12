--A. Para cada tarea el sueldo máximo debe ser mayor que el sueldo mínimo.

set search_path = unc_esq_peliculas;

ALTER TABLE tarea
ADD CONSTRAINT ck_coherencia_sueldo
CHECK(sueldo_maximo > sueldo_minimo);

--B. No puede haber más de 70 empleados en cada departamento.

ALTER TABLE empleado
ADD CONSTRAINT ck_max_empleados
CHECK (NOT EXISTS(
                  SELECT id_departamento, id_distribuidor
                  FROM empleado
                  GROUP BY id_departamento, id_distribuidor
                  HAVING count(id_empleado) > 70
                  )
);

--C. Los empleados deben tener jefes que pertenezcan al mismo departamento.

ALTER TABLE empleado
ADD CONSTRAINT CK_JEFE_MISMO_DEPTO
CHECK ( NOT EXISTS ( SELECT e1.id_departamento, e1.id_distribuidor, e1.id_empleado, e2.id_jefe
                     FROM empleado e1
                     JOIN empleado e2
                     ON e1.id_jefe = e2.id_empleado
                     AND e1.id_departamento <> e2.id_departamento
                     AND e1.id_distribuidor <> e2.id_distribuidor
                    )
);

--D. Todas las entregas, tienen que ser de películas de un mismo idioma.

CREATE ASSERTION as_idioma_entrega
CHECK ( NOT EXISTS (
                    SELECT  re.nro_entrega, COUNT(p.idioma)
                    FROM renglon_entrega re
                    JOIN pelicula p on p.codigo_pelicula = re.codigo_pelicula
                    GROUP BY  re.nro_entrega
                    HAVING COUNT(p.idioma) <> 1)
);

--E. No pueden haber más de 10 empresas productoras por ciudad.

ALTER TABLE empresa_productora
ADD CONSTRAINT ck_max_empresas_por_ciudad
CHECK ( NOT EXISTS (
                    SELECT COUNT(*)
                    FROM empresa_productora
                    WHERE id_ciudad IS NOT NULL
                    GROUP BY id_ciudad
                    HAVING COUNT(*) > 10
                    ORDER BY COUNT(*) DESC
                    )
);

--F. Para cada película, si el formato es 8mm, el idioma tiene que ser francés.

ALTER TABLE pelicula
ADD CONSTRAINT ck_formato8_frances
CHECK (((formato = 'Formato 8') AND (idioma = 'Francés'))
        OR (formato <> 'Formato 8')
);

--G. El teléfono de los distribuidores Nacionales debe tener la misma característica que la de su distribuidor mayorista.

ALTER TABLE distribuidor
ADD CONSTRAINT ck_distrb_nac_igual_caracteristica_su_mayorista
CHECK (NOT EXISTS (
                    SELECT tipo, telefono, id_distribuidor
                    FROM distribuidor
    )
);


