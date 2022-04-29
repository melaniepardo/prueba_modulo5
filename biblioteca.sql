CREATE DATABASE biblioteca_db;

-- \ c biblioteca_db
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
    codigo_autor int REFERENCES autor(codigo_autor),
    isbn varchar(15) REFERENCES libros(isbn),
    tipo_autor VARCHAR(10)
);

CREATE TABLE socios (
    rut varchar(12) PRIMARY KEY,
    nombre varchar(25),
    apellido varchar(25),
    direccion varchar(50) NOT NULL UNIQUE,
    telefono int NOT NULL UNIQUE
);

CREATE TABLE prestamos (
    id SERIAL NOT NULL PRIMARY KEY,
    rut_socio varchar(12) REFERENCES socios(rut),
    isbn varchar(15) REFERENCES libros(isbn),
    fecha_inicio DATE NOT NULL,
    fecha_devolucion DATE NOT NULL
);

CREATE TABLE socio_prestamo (
    id_prestamo int REFERENCES prestamos(id),
    rut_socio varchar(12) REFERENCES socios(rut)
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

-- LIBROS ISBN TÍTULO PÁG.CÓD.AUTOR NOMBRE AUTOR APELLIDO AUTOR NACIMIENTO - MUERTE TIPO AUTOR 111 -111 1111 -11 1 CUENTOS DE TERROR 344 3 JOSE SALGADO 1968 -2020 PRINCIPAL 111 -111 1111 -11 1 CUENTOS DE TERROR 344 4 ANA SALGADO 1972 - COAUTOR 222 -222 2222 -22 2 POESÍAS CONTEMPO RANEAS 167 1 ANDRÉS ULLOA 1982 - PRINCIPAL 333 -333 3333 -33 3 HISTORIA DE ASIA 511 2 SERGIO MARDONES 1950 -2012 PRINCIPAL 444 -444 4444 -44 4 MANUAL DE MECÁNICA 298 5 MARTIN PORTA 1976 - PRINCIPAL
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

-- BEGIN;
-- ALTER TABLE libro_autor
-- ALTER COLUMN tipo_autor TYPE VARCHAR;
-- COMMIT;
-- SOCIO LIBRO FECHA DEL PRÉSTAMO FECHA DE LA DEVOLUCIÓN JUAN SOTO CUENTOS DE TERROR 20 -01 -2020 27 -01 -2020 SILVANA MUÑOZ POESÍAS CONTEMPORANEAS 20 -01 -2020 30 -01 -2020 SANDRA AGUILAR HISTORIA DE ASIA 22 -01 -2020 30 -01 -2020 ESTEBAN JEREZ MANUAL DE MECÁNICA 23 -01 -2020 30 -01 -2020 ANA PÉREZ CUENTOS DE TERROR 27 -01 -2020 04 -02 -2020 JUAN SOTO MANUAL DE MECÁNICA 31 -01 -2020 12 -02 -2020 SANDRA AGUILAR POESÍAS CONTEMPORANEAS 31 -01 -2020 12 -02 -2020
BEGIN;

INSERT INTO
    socios (rut, nombre, apellido, direccion, telefono)
VALUES
    (
        '1111111-1',
        'JUAN',
        'SOTO',
        'AVENIDA 1, SANTIAGO',
        911111111
    );

INSERT INTO
    socios (rut, nombre, apellido, direccion, telefono)
VALUES
    (
        '2222222-2',
        'ANA',
        'PEREZ',
        'PASAJE 2, SANTIAGO',
        922222222
    );

INSERT INTO
    socios (rut, nombre, apellido, direccion, telefono)
VALUES
    (
        '3333333-3',
        'SANDRA',
        'AGUILAR',
        'AVENIDA 2, SANTIAGO',
        933333333
    );

INSERT INTO
    socios (rut, nombre, apellido, direccion, telefono)
VALUES
    (
        '4444444-4',
        'ESTEBAN',
        'JEREZ',
        'AVENIDA3, SANTIAGO',
        944444444
    );

INSERT INTO
    socios (rut, nombre, apellido, direccion, telefono)
VALUES
    (
        '5555555-5',
        'SILVANA',
        'MUNOZ',
        'PASAJE 3, SANTIAGO',
        955555555
    );

COMMIT;

-- INSERT INTO libros (isbn, titulo, numero_paginas) VALUES ('111-1111-1', 'CUENTOS DE TERROR', 344);
-- INSERT INTO libros (isbn, titulo, numero_paginas) VALUES ('222-2222-2', 'POESÍAS CONTEMPORANEAS', 167);
-- INSERT INTO libros (isbn, titulo, numero_paginas) VALUES ('333-3333-3', 'HISTORIA DE ASIA', 511);
-- INSERT INTO libros (isbn, titulo, numero_paginas) VALUES ('444-4444-4', 'MANUAL DE MECÁNICA', 298);
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
        '01-31-2020',
        '02-04-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '4444444-4',
        '444-4444-4',
        '02-03-2020',
        '02-04-2020'
    );

INSERT INTO
    prestamos (rut_socio, isbn, fecha_inicio, fecha_devolucion)
VALUES
    (
        '2222222-2',
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
--3.Realizar las siguientes consultas:

-- a.Mostrar todos los libros que posean menos de 300 páginas.

SELECT titulo FROM libro WHERE numero_pagina = <300

-- b.Mostrar todos los autores que hayan nacido después del 01-01-1970.

SELECT nombre_autor FROM libro WHERE nacimiento_muerte = >01-01-1970


-- c.¿ Cuál es el libro más solicitado ?
COUNT (columna) =  o usar LIKE

--d.Si se cobrara una multa de $ 100 por cada día de atraso, mostrar cuánto debería pagar cada
--usuario que entregue el préstamo después de 7 días.
