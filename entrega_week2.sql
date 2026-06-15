-- ======================================
-- ENTREGA WEEK 2 — TECHSTORE INVENTARIO
-- Nombre: [Rafael Zerpa]  |  Fecha: [2026-15-06]
-- ======================================

#Fase 1 DDL
create database techstore_inventario;
use techstore_inventario;
select database();
#creacion de tablas
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_producto VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    stock_minimo INT DEFAULT 5,
    proveedor VARCHAR(100),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

create table ventas (
id int AUTO_INCREMENT PRIMARY key,
producto_id int not null,
cantidad int not null,
precio_venta decimal(10,2) not null,
total decimal(10,2) not null,
fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
show tables;
DESCRIBE productos;
describe ventas;

#fase 2 DML inicial cargar catalogo y primeras ventas
INSERT INTO productos
    (codigo_producto, nombre, descripcion, categoria, precio, costo, stock, stock_minimo, proveedor, activo)
VALUES
    -- Laptops
    ('LAP001', 'Laptop HP Pavilion 15', 'Laptop Intel i5, 8GB RAM, 256GB SSD', 'Laptops', 799.99, 650.00, 12, 5, 'HP Inc', TRUE),
    ('LAP002', 'MacBook Air M2', 'Apple MacBook Air con chip M2, 8GB, 256GB', 'Laptops', 1299.99, 1050.00, 8, 3, 'Apple', TRUE),
    ('LAP003', 'Dell XPS 13', 'Ultrabook Dell XPS 13, i7, 16GB, 512GB SSD', 'Laptops', 1499.99, 1200.00, 5, 3, 'Dell', TRUE),
    ('LAP004', 'Lenovo ThinkPad', NULL, 'Laptops', 899.99, 720.00, 0, 5, 'Lenovo', FALSE),

    -- Periféricos
    ('PER001', 'Mouse Logitech MX Master 3', 'Mouse ergonómico inalámbrico', 'Perifericos', 99.99, 65.00, 35, 10, 'Logitech', TRUE),
    ('PER002', 'Teclado Mecánico Keychron K2', 'Teclado mecánico RGB, switches Gateron Brown', 'Perifericos', 89.99, 55.00, 20, 8, 'Keychron', TRUE),
    ('PER003', 'Webcam Logitech C920', 'Webcam Full HD 1080p', 'Perifericos', 79.99, 50.00, 15, 10, 'Logitech', TRUE),
    ('PER004', 'Hub USB-C 7 puertos', NULL, 'Perifericos', 45.99, 25.00, 50, 15, 'Anker', TRUE),
    ('PER005', 'Mouse Pad XL', 'Mouse pad gaming 90x40cm', 'Perifericos', 24.99, 10.00, 80, 20, 'SteelSeries', TRUE),
    ('PER006', 'Soporte Laptop Ajustable', 'Soporte ergonómico aluminio', 'Perifericos', 39.99, 20.00, 25, 10, 'Rain Design', TRUE),

    -- Audio
    ('AUD001', 'Audífonos Sony WH-1000XM5', 'Audífonos con cancelación de ruido', 'Audio', 399.99, 280.00, 10, 5, 'Sony', TRUE),
    ('AUD002', 'Audífonos Gaming HyperX', NULL, 'Audio', 79.99, 45.00, 30, 10, 'HyperX', TRUE),
    ('AUD003', 'Micrófono Blue Yeti', 'Micrófono USB profesional', 'Audio', 129.99, 85.00, 12, 6, 'Logitech', TRUE),
    ('AUD004', 'Parlantes Logitech Z623', 'Sistema 2.1, 200W', 'Audio', 149.99, 95.00, 8, 5, 'Logitech', TRUE),
    ('AUD005', 'Audífonos Bluetooth JBL', 'Audífonos inalámbricos portátiles', 'Audio', 49.99, 25.00, 2, 10, 'JBL', TRUE),

    -- Componentes
    ('COM001', 'SSD Samsung 1TB', 'SSD NVMe M.2 1TB', 'Componentes', 89.99, 60.00, 40, 15, 'Samsung', TRUE),
    ('COM002', 'RAM Corsair 16GB DDR4', '16GB (2x8GB) DDR4 3200MHz', 'Componentes', 79.99, 50.00, 25, 10, 'Corsair', TRUE),
    ('COM003', 'Monitor LG 27" 4K', 'Monitor IPS 27 pulgadas 4K', 'Componentes', 449.99, 320.00, 7, 5, 'LG', TRUE),
    ('COM004', 'Cable HDMI 2.1 - 2m', NULL, 'Componentes', 19.99, 8.00, 100, 30, 'Cable Matters', TRUE),
    ('COM005', 'Adaptador USB-C a HDMI', 'Adaptador 4K 60Hz', 'Componentes', 29.99, 15.00, 60, 20, 'Anker', TRUE);
    
INSERT INTO ventas (producto_id, cantidad, precio_venta, total) VALUES
    (1,  2,  799.99, 1599.98),
    (5,  5,   99.99,  499.95),
    (6,  3,   89.99,  269.97),
    (11, 1,  399.99,  399.99),
    (16, 4,   89.99,  359.96);
    
#verificación
select count(*) from productos;
select count(*) from ventas;
select categoria, count(*) from productos group by categoria;

#Fase 3 Update de fase 3 (aumento precios,reduccion stock, marca inactivos)
select nombre, precio, round(precio *1.10, 2) as nuevo_precio, categoria
from productos where categoria = 'Audio';
set sql_safe_updates = 0;
update productos set precio = precio * 1.10 where categoria = 'Audio';
#verificacion
select nombre, precio, categoria
from productos where categoria = 'Audio';
set sql_safe_updates = 1;

#reducir stock post ventas (5)
START TRANSACTION;
select id, nombre, stock from productos where id in (1, 5 , 6, 11, 16);
UPDATE productos SET stock = stock - 2 WHERE id = 1;   -- venta 1: 2 unidades
UPDATE productos SET stock = stock - 5 WHERE id = 5;   -- venta 2: 5 unidades
UPDATE productos SET stock = stock - 3 WHERE id = 6;   -- venta 3: 3 unidades
UPDATE productos SET stock = stock - 1 WHERE id = 11;  -- venta 4: 1 unidad
UPDATE productos SET stock = stock - 4 WHERE id = 16;  -- venta 5: 4 unidades
select id, nombre, stock from productos where id in (1, 5, 6, 11, 16);
commit;

#marcar como inactivos los productos con stock bajo
select nombre, stock, stock_minimo
from productos
where stock <= stock_minimo;

start TRANSACTION;
set sql_safe_updates = 0;
update productos
set activo = false
where stock <= stock_minimo;

select nombre, stock, stock_minimo, activo
from productos where activo = false;

set sql_safe_updates = 1;

#fase 4 Delete: (soft vs hard) delete
update productos 
set deleted_at = current_timestamp
where codigo_producto = 'LAP004';
SELECT id, nombre, deleted_at FROM productos WHERE deleted_at IS NOT NULL;
#ventas viejas > 2 años
select * from ventas where fecha_venta <= '2024-01-01';
set sql_safe_updates = 0;
delete from ventas where fecha_venta <= '2024-01-01';
set sql_safe_updates = 1;
select count(*) from ventas;

#fase 5 Transaccion de venta completa (atómica)
#verificar stock de mouse pad XL (id=9)
start transaction;
select id, nombre, stock, precio
from productos
where id = 9 and stock >= 3 and deleted_at is null;
#reducir stock (-3 unidades)
update productos
set stock = stock - 3
where id = 9;
#capturar precio actual como variable
select @precio_actual := precio from productos where id = 9;
#registrar la venta usando variable de precio
INSERT INTO ventas (producto_id, cantidad, precio_venta, total)
VALUES (9, 3, @precio_actual, @precio_actual * 3);
#verificar
select id, nombre, stock from productos where id = 9;
select * from ventas where id = last_insert_id();
commit;

# Parte 6 (Bonus)

#1 Produccion en alerta de stock bajo (con prioridad)
SELECT codigo_producto, nombre, categoria, stock, stock_minimo, stock_minimo - stock AS unidades_faltantes
FROM productos
WHERE stock <= stock_minimo AND deleted_at IS NULL
ORDER BY unidades_faltantes DESC;

#2 Margen de ganacia Top 10
SELECT nombre, categoria, precio, costo, precio - costo AS margen_abs, ROUND(((precio - costo) / precio) * 100, 2) AS margen_pct
FROM productos
WHERE deleted_at IS NULL
ORDER BY margen_abs DESC
LIMIT 10;

#3 Revenue por categoria
SELECT p.categoria, COUNT(v.id) AS num_ventas, SUM(v.cantidad) AS unidades, SUM(v.total) AS revenue_total
FROM ventas v
JOIN productos p ON v.producto_id = p.id
GROUP BY p.categoria
ORDER BY revenue_total DESC;