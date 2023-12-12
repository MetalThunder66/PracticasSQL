--A. Los descuentos en las ventas son porcentajes y deben estar entre  0 y 100.

ALTER TABLE venta
ADD CONSTRAINT ck_descuento_ventas
CHECK ( descuento BETWEEN 0 AND 100);

--B. Los descuentos realizados en fechas de liquidación deben superar el 30%.

CREATE ASSERTION as_porc_fecha_liquidacion
CHECK ( NOT EXISTS ( SELECT 1
                    FROM venta v
                    WHERE EXTRACT(MONTH FROM v.fecha) IN (  SELECT f.mes_liq
                                                            FROM fecha_liq f
                                                            WHERE EXTRACT(DAY FROM v.fecha) = f.dia_liq
                                                            AND descuento <= 30)

                    )
);

--C. Las liquidaciones de Julio y Diciembre no deben superar los 5 días.

ALTER TABLE fecha_liq
ADD CONSTRAINT ck_liq_julio_dec_menor_5_dias
CHECK ((fecha_liq.mes_liq IN (7,12) AND fecha_liq.cant_dias <= 5)
        OR fecha_liq.mes_liq NOT IN (12,7))

--D. Las prendas de categoría ‘oferta’ no tienen descuentos.

CREATE ASSERTION as_oferta_sin_descuento
CHECK (NOT EXISTS ( SELECT 1
                    FROM prenda p
                    JOIN venta v ON (p.id_prenda = v.id_prenda)
                    WHERE (p.categoria = 'oferta' AND descuento <> 0) OR categoria <> 'oferta'
                  )
);
