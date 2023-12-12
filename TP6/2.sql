--B. Cada imagen no debe tener más de 5 procesamientos.

CREATE OR REPLACE FUNCTION fn_max_procesamientos_img()

RETURNS TRIGGER AS
    $$
DECLARE cant int;
BEGIN

    SELECT COUNT(*) INTO cant
    FROM p5p2e4_procesamiento
    WHERE id_imagen = NEW.id_imagen AND id_paciente = NEW.id_paciente;

    IF(cant > 4) THEN
    RAISE EXCEPTION 'Demasiados procesamientos para esta imagen%', NEW.id_imagen;
    END IF;

END
    $$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_max_proc_img
BEFORE INSERT OR UPDATE OF id_imagen
ON p5p2e4_procesamiento
FOR EACH ROW EXECUTE PROCEDURE fn_max_procesamientos_img();

--C. Agregue dos atributos de tipo fecha a las tablas Imagen_medica y Procesamiento, una
--indica la fecha de la imagen y la otra la fecha de procesamiento de la imagen y controle
--que la segunda no sea menor que la primera.

CREATE OR REPLACE FUNCTION fn_control_fechas()
RETURNS TRIGGER AS
$$
    DECLARE
        fecha1 p5p2e4_imagen_medica.fecha_imagen%type;

    begin
        SELECT fecha_imagen into fecha1
        FROM p5p2e4_imagen_medica
        WHERE id_imagen = NEW.id_imagen AND id_paciente = NEW.id_paciente;

        IF (new.fecha_procesamiento < fecha1) THEN
            RAISE EXCEPTION 'Error. Fecha procesamiento es menor Fecha Imagen';
        END IF;

        RETURN NEW;
    END;
$$

LANGUAGE 'plpgsql';

CREATE TRIGGER tr_fecha_procesamiento_menor_imagen_medica
BEFORE INSERT OR UPDATE OF fecha_procesamiento
ON p5p2e4_procesamiento
FOR EACH ROW
EXECUTE PROCEDURE
fn_control_fechas();

CREATE OR REPLACE FUNCTION fn_control_imagen_mayor()
RETURNS TRIGGER AS
$$
    DECLARE
        fecha_proc p5p2e4_procesamiento.fecha_procesamiento%type;
    BEGIN
        SELECT fecha_procesamiento into fecha_proc
        FROM p5p2e4_procesamiento
        WHERE id_imagen = NEW.id_imagen AND id_paciente = NEW.id_paciente;

        IF (fecha_proc < NEW.fecha_imagen) THEN
            RAISE EXCEPTION 'Error. Fecha imagen es mayor';
        END IF;
        RETURN NEW;
    END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_imagen_medica_fecha_imagen
    BEFORE UPDATE OF fecha_imagen
    ON p5p2e4_imagen_medica
    FOR EACH ROW
    EXECUTE PROCEDURE
    fn_Control_Imagen_Mayor();

--D. Cada paciente sólo puede realizar dos FLUOROSCOPIA anuales.

CREATE OR REPLACE FUNCTION fn_dos_fluoroscopia_anual()
RETURNS TRIGGER AS
$$
    DECLARE cant_fluor int;
    MAX_FLUOR int = 1;

    BEGIN
        SELECT count(*) into cant_fluor
        FROM p5p2e4_imagen_medica
        WHERE modalidad = 'FLUOROSCOPIA' AND id_paciente = NEW.id_paciente
        AND EXTRACT(YEAR FROM fecha_imagen) = EXTRACT(YEAR FROM NEW.fecha_imagen);

        IF (cant_fluor > MAX_FLUOR) THEN
            RAISE EXCEPTION 'Error. El paciente supera las 2 fluorcopias anuales';
        END IF;
        RETURN NEW;
    END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_fluorscopia_max_2
BEFORE INSERT OR UPDATE OF fecha_imagen, id_paciente, modalidad
    ON p5p2e4_imagen_medica
    FOR EACH ROW
    EXECUTE PROCEDURE
    fn_dos_fluoroscopia_anual();

--E. No se pueden aplicar algoritmos de costo computacional “O(n)” a imágenes de FLUOROSCOPIA

CREATE OR REPLACE FUNCTION fn_costo_computacional_fluor()
RETURNS TRIGGER AS
$$
    DECLARE
        COSTO varchar = 'O(n)'; cant int;
    BEGIN
        SELECT * into cant
        FROM p5p2e4_imagen_medica im
        WHERE (NEW.id_paciente, NEW.id_imagen) IN (SELECT p.id_paciente, p.id_imagen
                                                   FROM p5p2e4_procesamiento p
                                                   WHERE p.id_algoritmo IN (SELECT a.id_algoritmo
                                                                            FROM p5p2e4_algoritmo a
                                                                            WHERE a.costo_computacional = COSTO)
                                                   );

        if(cant != 0) then
            raise exception 'error';
        end if;
    return new;
    END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER tr_algoritmo_0n_fluorcopia
BEFORE UPDATE OF modalidad
ON p5p2e4_imagen_medica
FOR EACH ROW
WHEN (NEW.modalidad = 'FLUORSCOPIA')
EXECUTE PROCEDURE
fn_costo_computacional_fluor();



