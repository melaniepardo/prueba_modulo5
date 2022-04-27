
CREATE DATABASE tienda_electronica_db;

-- con \c nos vamos a la database
\c tienda_electronica_db --cargando base de datos
CREATE TABLE clientes(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    rut VARCHAR(12),
    direccion VARCHAR(50)
);

CREATE TABLE facturas(
    id SERIAL PRIMARY KEY,
    fecha DATE,
    subtotal FLOAT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes (id)
);

CREATE TABLE categorias(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(50)
);

-- aquí deberiamos usar transacciones
CREATE TABLE productos(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(50),
    valor FLOAT,
    stock INT CHECK (stock >= 0),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias (id)
);

CREATE TABLE producto_facturas (
    id_producto INT,
    id_factura INT,
    cantidad INT,
    FOREIGN KEY (id_producto) REFERENCES productos (id),
    FOREIGN KEY(id_factura) REFERENCES facturas (id)
);

-- Parte II
-- Ingresar 3 clientes
INSERT INTO
    clientes (nombre, rut, direccion)
VALUES
    ('Jocelyn', '22.465.748-7', 'direccion 1');

INSERT INTO
    clientes (nombre, rut, direccion)
VALUES
    ('Diego', '20.785.123-4', 'direccion 3');

INSERT INTO
    clientes (nombre, rut, direccion)
VALUES
    ('Ignacia', '26.852.741-3', 'direccion 2');

--2. Insertar 2 categorías.
INSERT INTO
    categorias (nombre, descripcion)
VALUES
    ('computadoras', 'descripcion categoria 1');

INSERT INTO
    categorias (nombre, descripcion)
VALUES
    ('audio y video', 'descripcion categoria 2');

--3. Insertar 5 productos
INSERT INTO
    productos (nombre, descripcion, valor, stock, id_categoria)
VALUES
    ('Mouse', 'descripcion producto 1', 15, 10, 1);

INSERT INTO
    productos (nombre, descripcion, valor, stock, id_categoria)
VALUES
    ('Teclado', 'descripcion producto 2', 30, 10, 1);
INSERT INTO
    productos (nombre, descripcion, valor, stock, id_categoria)
VALUES
    ('Monitor', 'descripcion producto 3', 80, 10, 1);
    INSERT INTO
    productos (nombre, descripcion, valor, stock, id_categoria)
VALUES
    ('Audifonos', 'descripcion producto 4', 50, 10, 2);
INSERT INTO
    productos (nombre, descripcion, valor, stock, id_categoria)
VALUES
    ('Cable HDMI', 'descripcion producto 5', 10, 10, 2);


-- Insertar facturas

BEGIN;
INSERT INTO facturas (id_cliente, fecha)
VALUES (2,'2020-11-04');
INSERT INTO producto_facturas (id_producto, id_factura, cantidad)
VALUES (4, 2,1);
INSERT INTO
    producto_facturas (id_producto, id_factura, cantidad)
VALUES
    (5, 2, 1);
INSERT INTO
    producto_facturas (id_producto, id_factura, cantidad)
VALUES
    (3, 1, 2);
UPDATE facturas SET subtotal = 265 WHERE id = 1;
UPDATE productos SET stock = stock = 1 WHERE id =1;
UPDATE productos SET stock = stock = 3 WHERE id = 2;
UPDATE
    productos
SET
    stock = stock = 2
WHERE
    id = 3;
COMMIT;

BEGIN;
INSERT INTO facturas (id_cliente, fecha) VALUES (3, '2028-12-12');
INSERT INTO producto_facturas (id_producto, id_factura, cantidad) VALUES (5, 3, 8);
UPDATE facturas SET subtotal = 80 WHERE id = 3;
UPDATE productos SET stock = stock - 8 WHERE id = 5;
COMMIT;