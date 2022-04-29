CREATE DATABASE ejercicios_db;

-- con \c nos vamos a la database
\c ejercicios_db --cargando base de datos

CREATE TABLE actores (
id_pelicula INT FOREIGN KEY REFERENCES Peliculas (id_Pelicula),
id_actor INT PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
PRIMARY KEY (id_Actor)
);

CREATE TABLE peliculas  (
id_pelicula INT PRIMARY KEY,
pelicula VARCHAR(30) NOT NULL,
genero VARCHAR(30) NOT NULL,
PRIMARY KEY (id_Pelicula)
);

----------------------Relaciones N a N
CREATE TABLE usuario (
email PRIMARY KEY
nombre VARCHAR(50)
password INT
);
CREATE TABLE participacion(
usuario_email FOREIGN KEY
proyecto_
);
CREATE TABLE proyecto ();

----------------------5.Continuando con el caso propuesto de la plataforma de reseñas de películas
--tablas en la notación
actores(#id_actor, nombre)
peliculas(#id_pelicula, pelicula, genero)
actores_peliculas(#id_pelicula, #id_actor)

------ Volviendo al ejercicio de usuario y proyecto
CREATE TABLE usuario(
    email VARCHAR(50),
    nombre VARCHAR(20),
    password VARCHAR(255),
    PRIMARY KEY (email)
);

CREATE TABLE proyecto(
    id SERIAL,
    nombre VARCHAR(50),
    descripcion text,
    PRIMARY KEY (id)
);

-- La tabla intermedia se crea al último para poder agregar las referencias
CREATE TABLE participacion(
    usuario_email VARCHAR REFERENCES usuario (email),
    proyecto_id INTEGER REFERENCES proyecto (id),
    PRIMARY KEY(usuario_email, proyecto_id)
);

INSERT INTO
    usuario(email, nombre, password)
VALUES
    ('usuario1@gmail.com', 'Juan', '12345678');

INSERT INTO
    usuario(email, nombre, password)
VALUES
    ('usuario2@gmail.com', 'Francisca', 'asdfghi');

INSERT INTO
    proyecto(nombre, descripcion)
VALUES
    ('Proyecto1', 'Proyecto
secreto');

INSERT INTO
    proyecto(nombre, descripcion)
VALUES
    ('Proyecto2', 'Proyecto
público');

INSERT INTO
    participacion(usuario_email, proyecto_id)
values
    ('usuario1@gmail.com', 1);

INSERT INTO
    participacion(usuario_email, proyecto_id)
values
    ('usuario1@gmail.com', 2);

INSERT INTO
    participacion(usuario_email, proyecto_id)
values
    ('usuario2@gmail.com', 1);