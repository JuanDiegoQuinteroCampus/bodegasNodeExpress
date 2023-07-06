CREATE DATABASE db_prueba_backend_sql;

USE db_prueba_backend_sql;

CREATE TABLE
    historiales (
        id BIGINT(20) UNSIGNED PRIMARY KEY AUTO_INCREMENT,
        cantidad INT(11),
        id_bodega_origen BIGINT(20) UNSIGNED,
        id_bodega_destino BIGINT(20) UNSIGNED,
        id_inventario BIGINT(20) UNSIGNED,
        created_by BIGINT(20) UNSIGNED,
        update_by BIGINT(20) UNSIGNED,
        created_at TIMESTAMP NULL,
        updated_at TIMESTAMP NULL,
        deleted_at TIMESTAMP NULL,
        Foreign Key (created_by) REFERENCES users(id),
        Foreign Key (update_by) REFERENCES users(id),
        Foreign Key (id_bodega_origen) REFERENCES bodegas(id),
        Foreign Key (id_bodega_destino) REFERENCES bodegas(id),
        Foreign Key (id_inventario) REFERENCES inventarios(id)
    );

CREATE TABLE
    inventarios (
        id BIGINT(20) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        id_bodega BIGINT(20) UNSIGNED NOT NULL ,
        id_producto BIGINT(20) UNSIGNED NOT NULL ,
        cantidad INT(11),
        created_by BIGINT(20) UNSIGNED,
        update_by BIGINT(20) UNSIGNED,
        created_at TIMESTAMP NULL,
        updated_at TIMESTAMP NULL,
        deleted_at TIMESTAMP NULL,
        Foreign Key (id_bodega) REFERENCES bodegas(id),
        Foreign Key (id_producto) REFERENCES productos(id),
        Foreign Key (created_by) REFERENCES users(id),
        Foreign Key (update_by) REFERENCES users(id)
    );

CREATE TABLE
    productos (
        id BIGINT(20) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(225),
        descripcion VARCHAR(225),
        estado TINYINT(4),
        created_by BIGINT(20) UNSIGNED,
        update_by BIGINT(20) UNSIGNED,
        created_at TIMESTAMP NULL,
        updated_at TIMESTAMP NULL,
        deleted_at TIMESTAMP NULL,
        Foreign Key (created_by) REFERENCES users(id),
        Foreign Key (update_by) REFERENCES users(id)
    );

CREATE TABLE
    users (
        id BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(225),
        email VARCHAR(225) UNIQUE,
        email_verified_at TIMESTAMP,
        estado TINYINT(4),
        created_by BIGINT(20) UNSIGNED,
        update_by BIGINT(20) UNSIGNED,
        foto VARCHAR(225),
        password VARCHAR(225),
        created_at TIMESTAMP NULL,
        updated_at TIMESTAMP NULL,
        deleted_at TIMESTAMP NULL
        
    );

CREATE TABLE
    bodegas (
        id BIGINT(20) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(225) NULL,
        id_responsable BIGINT(20) UNSIGNED NOT NULL,
        estado TINYINT(4),
        created_by BIGINT(20) UNSIGNED,
        update_by BIGINT(20) UNSIGNED,
        created_at TIMESTAMP NULL,
        updated_at TIMESTAMP NULL,
        deleted_at TIMESTAMP NULL,
        Foreign Key (id_responsable) REFERENCES users(id),
        Foreign Key (created_by) REFERENCES users(id),
        Foreign Key (update_by) REFERENCES users(id)
    );

DROP TABLE historiales;

DROP TABLE productos;

DROP TABLE users;

DROP TABLE bodegas;
DROP TABLE inventarios;

SELECT * FROM users;