-- ======================================
-- ENTREGA SEMANA 1 — CATÁLOGO STREAMFLIX
-- Nombre: [Rafael Zerpa]
-- Fecha: [02_06_2026]
-- ======================================

drop database if exists streamflix;
create database streamflix;
use streamflix;
select database();
create table peliculas (
id int auto_increment primary key,
titulo varchar(200) not null,
titulo_original varchar(200),
director varchar(100) not null,
año int not null,
duracion_minutos int,
genero varchar(50) not null,
calificacion decimal(3,1),
sinopsis text,
idioma_original varchar(50) default 'Inglés',
destacada boolean default false,
fecha_agregada date default (current_date)
);

describe peliculas;

show tables;
select count(*) from peliculas;

insert into peliculas 
(titulo, titulo_original, director, año, duracion_minutos, genero, calificacion, sinopsis, idioma_original, destacada)
values
	('El Padrino', 'The Godfather', 'Francis Ford Coppola', 1972, 175, 'Drama', 9.2,
     'La historia de la familia Corleone en el mundo de la mafia italiana.', 'Inglés', TRUE),

    ('Pulp Fiction', 'Pulp Fiction', 'Quentin Tarantino', 1994, 154, 'Crimen', 8.9,
     'Historias entrelazadas de criminales en Los Ángeles.', 'Inglés', TRUE),

    ('El Caballero de la Noche', 'The Dark Knight', 'Christopher Nolan', 2008, 152, 'Acción', 9.0,
     'Batman enfrenta al caótico Joker en Gotham City.', 'Inglés', TRUE),

    ('Inception', 'Inception', 'Christopher Nolan', 2010, 148, 'Ciencia Ficción', 8.8,
     'Un ladrón que roba secretos del subconsciente durante el sueño.', 'Inglés', TRUE),

    ('Forrest Gump', 'Forrest Gump', 'Robert Zemeckis', 1994, 142, 'Drama', 8.8,
     'La vida extraordinaria de un hombre simple que presencia eventos históricos.', 'Inglés', TRUE),

    ('Matrix', 'The Matrix', 'Lana y Lilly Wachowski', 1999, 136, 'Ciencia Ficción', 8.7,
     'Un programador descubre que la realidad es una simulación.', 'Inglés', FALSE),

    ('El Señor de los Anillos: La Comunidad del Anillo',
     'The Lord of the Rings: The Fellowship of the Ring',
     'Peter Jackson', 2001, 178, 'Fantasía', 8.8,
     'Frodo inicia su viaje para destruir el Anillo Único.', 'Inglés', TRUE),

    ('Gladiador', 'Gladiator', 'Ridley Scott', 2000, 155, 'Acción', 8.5,
     'Un general romano busca venganza contra el emperador corrupto.', 'Inglés', FALSE),

    ('El Laberinto del Fauno', 'El Laberinto del Fauno', 'Guillermo del Toro', 2006, 118, 'Fantasía', 8.2,
     'Una niña descubre un mundo mágico durante la Guerra Civil Española.', 'Español', FALSE),

    ('Interestelar', 'Interstellar', 'Christopher Nolan', 2014, 169, 'Ciencia Ficción', 8.6,
     'Exploradores viajan por un agujero de gusano buscando un nuevo hogar.', 'Inglés', FALSE),

    ('Parásitos', 'Gisaengchung', 'Bong Joon-ho', 2019, 132, 'Thriller', 8.6,
     'Una familia pobre infiltra la casa de una familia rica.', 'Coreano', TRUE),

    ('Tiempos Violentos', 'Reservoir Dogs', 'Quentin Tarantino', 1992, 99, 'Crimen', 8.3,
     'Un atraco sale mal y los criminales sospechan de un traidor.', 'Inglés', FALSE),

    ('El Club de la Pelea', 'Fight Club', 'David Fincher', 1999, 139, 'Drama', 8.8,
     'Un hombre insomne forma un club clandestino de pelea.', 'Inglés', FALSE),

    ('La Lista de Schindler', 'Schindler''s List', 'Steven Spielberg', 1993, 195, 'Drama', 9.0,
     'La historia real de un empresario que salvó a más de mil judíos.', 'Inglés', TRUE),

    ('Toy Story', 'Toy Story', 'John Lasseter', 1995, 81, 'Animación', 8.3,
     'Los juguetes de Andy cobran vida cuando él no está.', 'Inglés', FALSE);
     
select count(*) as total from peliculas;
select id, titulo, año, fecha_agregada from peliculas;

##consultas básicas
##Q1 listado simple - solo título, director y año
select titulo, director, año
from peliculas;
##Q2 solo peliculas destacadas
select titulo, destacada
from peliculas
where destacada = true;
##Q3 peliculas de ciencia ficcion
select titulo, año, genero
from peliculas 
where genero = 'ciencia ficcion';
##Q4 peliculas con calificacion > 8.5
select titulo, calificacion
from peliculas 
where calificacion > 8.5
order by calificacion desc;
##Q5 Peliculas entre 1990 y 2000
select titulo, año
from peliculas
where año between 1990 AND 2000
order by año desc;
##Q6 Peliculas de drama o thriller
select titulo, genero
from peliculas
where genero in ('drama' , 'Thriller');
##Q7 Busqueda por patron con 'LIKE'
select titulo, año
from peliculas
where titulo like ('El%');
##Q8 Uso de distinct
select  distinct director
from peliculas
where director like ('%Nolan%');
##Q9 Top 5
select titulo, calificacion
from peliculas
order by calificacion desc
limit 5;
##Q10 3 peliculas más antiguas
select titulo, año
from peliculas
order by año 
limit 3;
##Q11 Pelis ordenadas por duración
select titulo, año, duracion_minutos
from peliculas
order by duracion_minutos;

##Reto 1 Busqueda multi-condición
select titulo, genero, calificacion, año
from peliculas
where genero in ('Accion' , 'Ciencia ficcion')
and calificacion >= 8.0
and año > 2000
order by calificacion desc;

##Reto 2 Listado de generos únicos disponibles
select distinct genero
from peliculas
order by genero;

##Reto 3 Cuadruple filtro
select titulo, duracion_minutos, calificacion, destacada
from peliculas
where destacada = true
and duracion_minutos > 140
and calificacion > 8.5
order by calificacion desc;

-- DECISIONES DE DISEÑO
-- ======================================
--
-- 1. ¿Por qué DECIMAL(3,1) para calificacion en vez de FLOAT?
--    [Para tener precision y evitar problemas de redondeo de los decimales]
--
-- 2. ¿Por qué VARCHAR(200) para titulo en vez de TEXT?
--    [Para limitar el numero de caracteres, ya que es +- conocida la longitud de los textos]
--
-- 3. ¿Qué ventaja tiene AUTO_INCREMENT en id?
--    [Genera numeros consecutivos que pueden ser usados como registro único (primary key, id)]
--
-- 4. Si tuvieras que agregar precio_renta, ¿qué tipo usarías?
--    [Dependiendo del producto o bien, si son cifras grandes exactas o chicas, usaria decimal con 5 o 6 cifras y 2 decimales (Decimal (6,2)]
--
-- 5. ¿Qué fue lo que más te sorprendió esta semana?
--    [Algunas cosas que se olvidan rapido para escribir los scripts y hay que refrescar o repasar.]