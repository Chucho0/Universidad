create database UNIVERSIDAD;

use UNIVERSIDAD;

CREATE TABLE DECANOS (
    cedula INT PRIMARY KEY,
    nombres VARCHAR(200),
    apellidos VARCHAR(200),
    celular VARCHAR(200)
);

CREATE TABLE FACULTAD (
    numero INT PRIMARY KEY,
    nombre VARCHAR(200),
    ubicacion VARCHAR(200),
    cedula INT,
    FOREIGN KEY (cedula) REFERENCES DECANOS (cedula)
);

CREATE TABLE DOCENTES (
    cedula INT PRIMARY KEY,
    nombres VARCHAR(200),
    apellido VARCHAR(200),
    titulo VARCHAR(200),
    numero INT,
    FOREIGN KEY (numero) REFERENCES FACULTAD (numero)
);

CREATE TABLE ASIGNATURAS(
    codigo INT PRIMARY KEY,
    nombre  VARCHAR(200),
    nro_creditos VARCHAR(200)
);

CREATE TABLE CURSO(
    nro_id INT PRIMARY KEY,
    cedula INT,
    codigo INT,
    FOREIGN KEY (cedula) REFERENCES DOCENTES (cedula),
    FOREIGN KEY (codigo) REFERENCES ASIGNATURAS (codigo)
);

CREATE TABLE ESTUDIANTES(
    nro_id INT PRIMARY KEY,
    nombres VARCHAR(200),
    apellido VARCHAR(200),
    direccion VARCHAR(200)
);

CREATE TABLE INSCRIPCION(
    nro_inscripcion INT PRIMARY KEY,
    codigo INT,
    nro_id INT,
    FOREIGN KEY (codigo) REFERENCES ASIGNATURAS (codigo),
    FOREIGN KEY (nro_id) REFERENCES ESTUDIANTES (nro_id),
    periodo VARCHAR(200)
);


INSERT INTO DECANOS (cedula, nombres, apellidos, celular) VALUES
(5001, 'Roberto', 'Gomez', '123-456-7890'),
(5002, 'Laura', 'Hernandez', '234-567-8901'),
(5003, 'Carlos', 'Martinez', '345-678-9012');

INSERT INTO FACULTAD (numero, nombre, ubicacion, cedula) VALUES
(1, 'Facultad de Ciencias', 'Edificio A', 5001),
(2, 'Facultad de Ingeniería', 'Edificio B', 5002),
(3, 'Facultad de Artes', 'Edificio C', 5003);

INSERT INTO DOCENTES (cedula, nombres, apellido, titulo, numero) VALUES
(1011, 'Rosa', 'Santos', 'MSc', 1),
(1012, 'Pablo', 'Ortega', 'PhD', 2),
(1013, 'Marta', 'Flores', 'MSc', 3);

INSERT INTO ASIGNATURAS (codigo, nombre, nro_creditos) VALUES
(1, 'Calculo', '4'),
(2, 'Base de Datos', '3'),
(3, 'Investigación', '3'),
(4, 'Física', '4'),
(5, 'Contabilidad', '3'),
(6, 'Ética', '2'),
(7, 'Dibujo', '2');

INSERT INTO DOCENTES (cedula, nombres, apellido, titulo, numero) VALUES
(1001, 'Juan', 'Perez', 'PhD', 1),
(1002, 'Maria', 'Gomez', 'MSc', 2),
(1003, 'Carlos', 'Lopez', 'PhD', 3),
(1004, 'Ana', 'Martinez', 'MSc', 1),
(1005, 'Luis', 'Rodriguez', 'PhD', 2),
(1006, 'Laura', 'Fernandez', 'MSc', 3),
(1007, 'Pedro', 'Diaz', 'PhD', 1),
(1008, 'Elena', 'Sanchez', 'MSc', 2),
(1009, 'Javier', 'Torres', 'PhD', 3),
(1010, 'Isabel', 'Ruiz', 'MSc', 1);

INSERT INTO CURSO (nro_id, cedula, codigo) VALUES
(1, 1001, 1),
(2, 1002, 2),
(3, 1003, 3),
(4, 1004, 4),
(5, 1005, 5),
(6, 1006, 6),
(7, 1007, 7),
(8, 1008, 1),
(9, 1009, 2),
(10, 1010, 3);

INSERT INTO ESTUDIANTES (nro_id, nombres, apellido, direccion) VALUES
(1, 'Diego', 'Gonzalez', 'Calle 123, Ciudad'),
(2, 'Sofia', 'Lopez', 'Av. Principal, Pueblo'),
(3, 'Mateo', 'Martinez', 'Calle Central, Villa'),
(4, 'Valentina', 'Rodriguez', 'Av. Norte, Ciudad'),
(5, 'Daniel', 'Hernandez', 'Calle 45, Pueblo'),
(6, 'Camila', 'Perez', 'Av. Sur, Ciudad'),
(7, 'Alejandro', 'Torres', 'Calle 67, Pueblo'),
(8, 'Fernanda', 'Diaz', 'Av. Oeste, Ciudad'),
(9, 'Joaquin', 'Sanchez', 'Calle 89, Pueblo'),
(10, 'Alicia', 'Fernandez', 'Av. Este, Ciudad');

INSERT INTO INSCRIPCION (nro_inscripcion, codigo, nro_id, periodo) VALUES
(1, 1, 1, '2023-01'),
(2, 2, 2, '2023-01'),
(3, 3, 3, '2023-01'),
(4, 4, 4, '2023-01'),
(5, 5, 5, '2023-01'),
(6, 6, 6, '2023-01'),
(7, 7, 7, '2023-01'),
(8, 1, 8, '2023-01'),
(9, 2, 9, '2023-01'),
(10, 3, 10, '2023-01'),
(11, 1, 1, '2023-02'),
(12, 2, 2, '2023-02'),
(13, 3, 3, '2023-02'),
(14, 4, 4, '2023-02'),
(15, 5, 5, '2023-02'),
(16, 6, 6, '2023-02'),
(17, 7, 7, '2023-02'),
(18, 1, 8, '2023-02'),
(19, 2, 9, '2023-02'),
(20, 3, 10, '2023-02');


-- con iner join traer el nombre de la asignatura y el numero total de estudiantes inscritos--
SELECT ASIGNATURAS.nombre, COUNT(INSCRIPCION.nro_id) AS TOTAL_ESTUDIANTES
FROM ASIGNATURAS
INNER JOIN INSCRIPCION ON ASIGNATURAS.codigo = INSCRIPCION.codigo
GROUP BY ASIGNATURAS.nombre;

--con iner join traer numero de documento de los estudiantes el periodo inscrito los nombres y los apellidos en una sola columna y la cantidad de creditos de cada uno--
SELECT ESTUDIANTES.nro_id, INSCRIPCION.periodo, CONCAT(ESTUDIANTES.nombres, ' ', ESTUDIANTES.apellido) AS NOMBRE_COMPLETO, ASIGNATURAS.nro_creditos
FROM ESTUDIANTES
INNER JOIN INSCRIPCION ON ESTUDIANTES.nro_id = INSCRIPCION.nro_id
INNER JOIN ASIGNATURAS ON INSCRIPCION.codigo = ASIGNATURAS.codigo;


--SUBCONSULTAS--

-- taer el numero de documento del estudiante nombre y apellido en un campo y traer cual es el periodo mas alto de las inscripciones, si se repite el periodo limitarlo a 1 solo--
SELECT CONCAT(E.nro_id, ' - ', E.nombres, ' ', E.apellido) AS Estudiante, I.periodo
FROM ESTUDIANTES E
JOIN INSCRIPCION I ON E.nro_id = I.nro_id
WHERE I.periodo = (SELECT MAX(periodo) FROM INSCRIPCION)
LIMIT 1;


--SUBCONSULTAS CON LA CLAUSULA HAVING--

--traer nombres completos de los docentes la sumatoria de los creditos de los docentes que estan asignados a él, y el having usarlo para listar los docentes que tenga mas de 2 creditos--

SELECT CONCAT(d.nombres, ' ', d.apellido) AS NombreCompleto,
       SUM(a.nro_creditos) AS TotalCreditos
FROM DOCENTES d
JOIN CURSO c ON d.cedula = c.cedula
JOIN ASIGNATURAS a ON c.codigo = a.codigo
GROUP BY d.cedula, d.nombres, d.apellido
HAVING TotalCreditos > 2;


-- crear un campo llamado promedio en la tabla INSCRIPCION y que el valor por defecto sea 0

ALTER TABLE INSCRIPCION
ADD COLUMN promedio INT DEFAULT 0;

DELIMITER //

CREATE PROCEDURE AumentarPromedio(
    INOUT beneficio INT(255),
    IN num_inscripcion INT(11))
BEGIN
SELECT @incrementopromedio = promedio
FROM INSCRIPCION
WHERE nro_inscripcion = num_inscripcion;
SET beneficio = beneficio + @incrementopromedio;
END //

DELIMITER ;

SET @beneficio = 0;
CALL AumentarPromedio(@beneficio, 1);
CALL AumentarPromedio(@beneficio, 2);
SELECT @beneficio;



DELIMITER $$

CREATE PROCEDURE AumentarPromedio(
    IN beneficio_in INT,
    IN num_inscripcion INT,
    OUT beneficio_out INT
)
BEGIN
    DECLARE incrementopromedio INT;
    
    SELECT promedio INTO incrementopromedio
    FROM INSCRIPCION
    WHERE nro_inscripcion = num_inscripcion;

    SET beneficio_out = beneficio_in + incrementopromedio;
END $$

DELIMITER ;

SET @beneficio = 0;

CALL AumentarPromedio(@beneficio, 1, @beneficio);
CALL AumentarPromedio(@beneficio, 2, @beneficio);

SELECT @beneficio;


-- Escribe un procedimiento que se llame calcular_max_min_media, tabla inscripción que reciba como parámetro de entrada numero id de un estudiante y devuelva como salida tres parámetros. La nota1 máximo, la nota2 mínima y la media de la nota 3 que existen para el estudiante.

DELIMITER $$
CREATE PROCEDURE calcular_max_min_media(
    IN nro_id INT,
    OUT nota1 INT,
    OUT nota2 INT,
    OUT nota3 INT
)
BEGIN
    SELECT MAX(nota1) INTO nota1
    FROM INSCRIPCION
    WHERE nro_id = nro_id;

    SELECT MIN(nota2) INTO nota2
    FROM INSCRIPCION
    WHERE nro_id = nro_id;

    SELECT AVG(nota3) INTO nota3
    FROM INSCRIPCION
    WHERE nro_id = nro_id;
END $$
DELIMITER ;

CALL calcular_max_min_media(1, @nota1, @nota2, @nota3);
SELECT @nota1, @nota2, @nota3;


