--Para todos los registros de la tabla DistribuidorNac, llenar el nuevo campo
-- "codigo_pais" con el valor correspondiente existente en la tabla "Internacional".

set search_path = 'unc_251302';
-- unc_250916

SET codigo_pais
UPDATE distribuidornac AS ds
SET column1 = <expression1 | value1> [, column2 = <expression2 | value2>, <columnN = expression3 | value3>]
FROM table1
[INNER | OUTER LEFT | OUTER RIGHT] JOIN table2 on table1.keycolumn = table2.keycolumn
[WHERE condition]
