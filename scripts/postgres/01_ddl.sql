/*
===============================================================================
File: 01_ddl.sql
Description: Data Definition Language script for the Billing System.
             Handles the creation of all required tables and constraints.
===============================================================================
*/

-- System Requirement 2: Database schema creation

-- 1. Client Table Definition
CREATE TABLE e01_cliente(
    nro_cliente INT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL,
    apellido VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    activo SMALLINT
);

-- 2. Phone Table Definition
CREATE TABLE e01_telefono(
    codigo_area SMALLINT CHECK (codigo_area <= 999),
    nro_telefono INTEGER CHECK (nro_telefono <= 9999999),
    tipo CHAR(1),
    nro_cliente INT,

    PRIMARY KEY(codigo_area, nro_telefono),

    CONSTRAINT fk_nrocliente_telefono
    FOREIGN KEY (nro_cliente) REFERENCES e01_cliente(nro_cliente)
);

-- 3. Bill Table Definition
CREATE TABLE e01_factura(
    nro_factura INT PRIMARY KEY,
    fecha DATE,
    total_sin_iva NUMERIC(12, 2),
    iva NUMERIC(12, 2),
    total_con_iva NUMERIC(12, 2),
    nro_cliente INT,

    CONSTRAINT fk_nrocliente_factura
    FOREIGN KEY (nro_cliente) REFERENCES e01_cliente(nro_cliente)
);

-- 4. Product Table Definition
CREATE TABLE e01_producto(
    codigo_producto INT PRIMARY KEY,
    marca VARCHAR(45),
    nombre VARCHAR(45),
    descripcion VARCHAR(45),
    precio NUMERIC(12, 2),
    stock INT
);

-- 5. Bill Details Table Definition
CREATE TABLE e01_detalle_factura(
    nro_item INT, 
    nro_factura INT,
    cantidad FLOAT,
    codigo_producto INT,

    PRIMARY KEY(nro_item, nro_factura),

    CONSTRAINT fk_nrofactura_detalle
    FOREIGN KEY (nro_factura) REFERENCES e01_factura(nro_factura),

    CONSTRAINT fk_codigoproducto_detalle
    FOREIGN KEY (codigo_producto) REFERENCES e01_producto(codigo_producto)
);