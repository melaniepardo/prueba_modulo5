CREATE DATABASE biblioteca_db;

-- \c biblioteca_db
CREATE TABLE autor (
    codigo_autor SERIAL PRIMARY KEY,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    fecha_nacimiento INT,
    fecha_muerte INT
);

CREATE TABLE libros (
    isbn VARCHAR(15) PRIMARY KEY,
    titulo VARCHAR(50) NOT NULL,
    numero_paginas SMALLINT NOT NULL
);

CREATE TABLE libro_autor (
    codigo_autor INT REFERENCES autor(codigo_autor),
    isbn VARCHAR(15) REFERENCES libros(isbn),
    tipo_autor VARCHAR(10)
);

CREATE TABLE socios (
    rut VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    direccion VARCHAR(50) NOT NULL UNIQUE,
    telefono INT NOT NULL UNIQUE
);

CREATE TABLE prestamos (
    id SERIAL NOT NULL PRIMARY KEY,
    rut_socio VARCHAR(12) REFERENCES socios(rut),
    isbn VARCHAR(15) REFERENCES libros(isbn),
    fecha_inicio DATE NOT NULL,
    fecha_devolucion DATE NOT NULL
);

CREATE TABLE socio_prestamo (
    id_prestamo INT REFERENCES prestamos(id),
    rut_socio VARCHAR(12) REFERENCES socios(rut)
);

INSERT INTO
    socios (rut, nombre, apellido, direccion, telefono)
VALUES
    (
        '1111111-1',
        'JUAN',
        'SOTO',
        'AVENIDA 1, SANTIAGO',
        911111111
    ),
    (
        '2222222-2',
        'ANA',
        'PEREZ',
        'PASAJE 2, SANTIAGO',
        922222222
    ),
    (
        '3333333-3',
        'SANDRA',
        'AGUILAR',
        'AVENIDA 2, SANTIAGO',
        933333333
    ),
    (
        '4444444-4',
        'ESTEBAN',
        'JEREZ',
        'AVENIDA3, SANTIAGO',
        944444444
    ),
    (
        '5555555-5',
        'SILVANA',
        'MUNOZ',
        'PASAJE 3, SANTIAGO',
        955555555
    );

BEGIN;

INSERT INTO
    libros (isbn, titulo, numero_paginas)
VALUES
    ('111-1111-1', 'CUENTOS DE TERROR', 344);

INSERT INTO
    libros (isbn, titulo, numero_paginas)
VALUES
    ('222-2222-2', 'POESÍAS CONTEMPORANEAS', 167);

INSERT INTO
    libros (isbn, titulo, numero_paginas)
VALUES
    ('333-3333-3', 'HISTORIA DE ASIA', 511);

INSERT INTO
    libros (isbn, titulo, numero_paginas)
VALUES
    ('444-4444-4', 'MANUAL DE MECÁNICA', 298);

COMMIT;

BEGIN;

INSERT INTO
    autor (nombre, apellido, fecha_nacimiento, fecha_muerte)
VALUES
    ('JOSE', 'SALGADO', 1968, 2020),
    ('ANA', 'SALGADO', 1972, NULL),
    ('ANDRES', 'ULLOA', 1982, NULL),
    ('SERGIO', 'MARDONES', 1950, 2012),
    ('MARTIN', 'PORTA', 1976, NULL);

COMMIT;

BEGIN;

INSERT INTO
    libro_autor (codigo_autor, isbn, tipo_autor)
VALUES
    (3, '111-1111-1', 'PRINCIPAL'),
    (4, '111-1111-1', 'COAUTOR'),
    (1, '222-2222-2', 'PRINCIPAL'),
    (2, '333-3333-3', 'PRINCIPAL'),
    (5, '444-4444-4', 'PRINCIPAL');

COMMIT;

BEGIN;

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '1111111-1',
        '111-1111-1',
        '01-20-2020',
        '01-27-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '5555555-5',
        '222-2222-2',
        '01-20-2020',
        '01-30-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '3333333-3',
        '333-3333-3',
        '01-22-2020',
        '01-30-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '4444444-4',
        '444-4444-4',
        '01-23-2020',
        '01-30-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '2222222-2',
        '111-1111-1',
        '01-27-2020',
        '02-04-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '1111111-1',
        '444-4444-4',
        '01-31-2020',
        '02-12-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '3333333-3',
        '222-2222-2',
        '01-31-2020',
        '02-12-2020'
    );

COMMIT;

BEGIN;

INSERT INTO
    socio_prestamo (rut_socio, id_prestamo)
VALUES
    ('1111111-1', 1);

INSERT INTO
    socio_prestamo (rut_socio, id_prestamo)
VALUES
    ('5555555-5', 2);

INSERT INTO
    socio_prestamo (rut_socio, id_prestamo)
VALUES
    ('3333333-3', 3);

INSERT INTO
    socio_prestamo (rut_socio, id_prestamo)
VALUES
    ('4444444-4', 4);

INSERT INTO
    socio_prestamo (rut_socio, id_prestamo)
VALUES
    ('1111111-1', 5);

INSERT INTO
    socio_prestamo (rut_socio, id_prestamo)
VALUES
    ('2222222-2', 6);

INSERT INTO
    socio_prestamo (rut_socio, id_prestamo)
VALUES
    ('3333333-3', 7);

COMMIT;

-- a. Mostrar todos los libros que posean menos de 300 páginas.
SELECT
    titulo,
    numero_paginas
FROM
    libros
WHERE
    numero_paginas < 300;

-- b. Mostrar todos los autores que hayan nacido después del 01-01-1970.
SELECT
    nombre,
    apellido
FROM
    autor
WHERE
    fecha_nacimiento >= 1970;

-- c. ¿Cuál es el libro más solicitado?
SELECT
    titulo,
    COUNT(prestamos.isbn) AS numero_solicitudes
FROM
    prestamos
    INNER JOIN libros ON prestamos.isbn = libros.isbn
GROUP BY
    titulo
ORDER BY
    numero_solicitudes DESC;

-- Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
SELECT
    nombre,
    ((fecha_devolucion - fecha_inicio) -7) * 100 AS deuda
FROM
    socios
    INNER JOIN prestamos ON socios.rut = prestamos.rut_socio
where
    (fecha_devolucion - fecha_inicio) > 7;
