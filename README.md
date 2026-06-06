# bases-SQL
Scripts básicos de SQL .

¡Claro! Veo que es una entrega de un curso de bases de datos con el catálogo de StreamFlix. Te propongo este README.md estructurado para que la documentación sea clara y profesional:

📁 Entrega Semana 1 — Catálogo StreamFlix
Nombre: Rafael Zerpa
Fecha: 02 de junio de 2026
Bootcamp: Semana 1 de Base de Datos

📋 Descripción del Proyecto
Este proyecto consiste en el desarrollo de un catálogo digital para una plataforma ficticia de streaming llamada StreamFlix. El objetivo es diseñar e implementar una base de datos MySQL que permita almacenar, consultar y gestionar información sobre películas.

El script incluye:

Creación y configuración de la base de datos
Definición de tablas con estructura optimizada
Inserción de datos de muestra (películas icónicas)
Ejecución de consultas básicas y avanzadas
🗄️ Estructura de la Base de Datos
Tabla: peliculas
Columna	Tipo	Descripción
id	INT	Clave primaria autoincremental
titulo	VARCHAR(200)	Título principal
titulo_original	VARCHAR(200)	Título original de la película
director	VARCHAR(100)	Nombre del director
año	INT	Año de estreno
duracion_minutos	INT	Duración en minutos
genero	VARCHAR(50)	Género cinematográfico
calificacion	DECIMAL(3,1)	Calificación (0.0 a 10.0)
sinopsis	TEXT	Breve descripción de la trama
idioma_original	VARCHAR(50)	Idioma original (default: Inglés)
destacada	BOOLEAN	Película destacada (default: FALSE)
fecha_agregada	DATE	Fecha de inserción en el catálogo
🔍 Consultas Implementadas
El script contiene 11 consultas básicas más 3 retos, entre las que destacan:

Consultas Básicas
Consulta	Descripción
Q1	Listado simple de título, director y año
Q2	Filtrado de películas destacadas
Q3	Búsqueda por género (Ciencia Ficción)
Q4	Ordenamiento por calificación > 8.5
Q5	Películas entre años específicos (1990–2000)
Q6	Búsqueda múltiple por género (Drama o Thriller)
Q7	Búsqueda por patrón con LIKE
Q8	Distinción de directores únicos
Q9	Top 5 pelis por calificación
Q10	3 películas más antiguas
Q11	Ordenamiento por duración
Retos Adicionales
Reto	Descripción
Reto 1	Búsqueda multi-condición (género, calificación, año)
Reto 2	Listado de géneros únicos disponibles
Reto 3	Cuadruple filtro avanzado
⚙️ Decisiones de Diseño
Decisión	Justificación
DECIMAL(3,1) para calificaciones	Precisión decimal evitando problemas de redondeo de FLOAT
VARCHAR(200) para títulos	Longitud limitada y predecible vs TEXT innecesario
AUTO_INCREMENT en ID	Generación automática de IDs únicos consecutivos
DATE default current_date	Registro automático de cuándo se agregó cada película
🚀 Cómo Usar Este Script
# 1. Acceder a MySQL
mysql -u root -p

# 2. Ejecutar el script
source entrega_semana1.sql

# 3. Verificar creación de base de datos
SHOW DATABASES;

# 4. Consultar las películas
USE streamflix;
SELECT * FROM peliculas LIMIT 5;
📊 Datos Incluidos
La base de datos se inicia con 15 películas icónicas que incluyen obras como:

El Padrino (1972)
Pulp Fiction (1994)
El Caballero de la Noche (2008)
Matrix (1999)
Interestelar (2014)
Parásitos (2019)
🔮 Mejoras Futuras
Algunas sugerencias para futuras entregas:

 Agregar tabla actores relacionada con peliculas
 Implementar tabla usuarios y sistema de reseñas
 Añadir columnas para precio_renta (DECIMAL(6,2))
 Crear índices para optimizar búsquedas frecuentes
 Incluir procedimientos almacenados para reportes
📚 Recursos de Referencia
Documentación MySQL: https://dev.mysql.com/doc/
Guía de diseño de bases de datos relacionales
Material del Bootcamp
Documento generado para la entrega semanal del Bootcamp — Semana 1.
