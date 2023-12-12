--2.3. Escriba una consulta para mostrar el apellido, nombre y
-- fecha de nacimiento de cualquier voluntario que trabaje en la
-- misma institución que el Sr. de apellido Zlotkey. Excluya del
-- resultado a Zlotkey.

set search_path = 'unc_esq_voluntario';

SELECT v.apellido, v.nombre, v.fecha_nacimiento
FROM voluntario v
WHERE v.id_institucion IN (
    SELECT v.id_institucion
    FROM voluntario v
    WHERE v.apellido = 'Zlotkey'
    )
AND v.apellido != 'Zlotkey'

