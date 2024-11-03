-- Crear las tablas independientes primero

CREATE TABLE MARCA (
    id_marca SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE ESTADO (
    id_estado SERIAL PRIMARY KEY,
    descripcion VARCHAR(20) NOT NULL
);

CREATE TABLE TIPO (
    id_tipo SERIAL PRIMARY KEY,
    descripcion VARCHAR(20) NOT NULL,
    descripcion_ampliada VARCHAR(1000) NOT NULL,
    costo_alquiler DECIMAL(10,2) NOT NULL
);

CREATE TABLE CLIENTE (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE EMPLEADO (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    usuario VARCHAR(20) NOT NULL,
    clave VARCHAR(20) NOT NULL
);

CREATE TABLE METODO (
    id_metodo SERIAL PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

-- Crear las tablas que dependen de otras

CREATE TABLE VEHICULO (
    id_vehiculo SERIAL PRIMARY KEY,
    placa VARCHAR(10) NOT NULL,
    id_marca INT NOT NULL,
    id_tipo INT NOT NULL,
    id_estado INT NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES MARCA(id_marca),
    FOREIGN KEY (id_tipo) REFERENCES TIPO(id_tipo),
    FOREIGN KEY (id_estado) REFERENCES ESTADO(id_estado)
);

CREATE TABLE ALQUILER (
    id_alquiler SERIAL PRIMARY KEY,
    id_empleado INT REFERENCES EMPLEADO(id_empleado),
    id_cliente INT NOT NULL,
    id_vehiculo INT NOT NULL,
    fecha_inicio TIMESTAMP NOT NULL,
    fecha_fin TIMESTAMP NOT NULL,
    fecha_entrega TIMESTAMP,
    costo DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo)
);

CREATE TABLE PAGO (
    id_pago SERIAL PRIMARY KEY,
    id_empleado INT REFERENCES EMPLEADO(id_empleado),
    id_alquiler INT NOT NULL,
    id_metodo INT NOT NULL,
    fecha TIMESTAMP NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_alquiler) REFERENCES ALQUILER(id_alquiler),
    FOREIGN KEY (id_metodo) REFERENCES METODO(id_metodo)
);

-- Insertar registros en las tablas independientes primero

INSERT INTO MARCA (nombre) VALUES ('Toyota');
INSERT INTO MARCA (nombre) VALUES ('Ford');

INSERT INTO ESTADO (descripcion) VALUES ('Disponible');
INSERT INTO ESTADO (descripcion) VALUES ('Mantenimiento');

INSERT INTO TIPO (descripcion, descripcion_ampliada, costo_alquiler) 
VALUES ('SUV', 'Vehículo utilitario deportivo', 75.50);
INSERT INTO TIPO (descripcion, descripcion_ampliada, costo_alquiler) 
VALUES ('Sedan', 'Vehículo de tipo sedán', 55.00);

INSERT INTO CLIENTE (nombre, email, telefono) 
VALUES ('Juan Perez', 'juan.perez@example.com', '1234567890');
INSERT INTO CLIENTE (nombre, email, telefono) 
VALUES ('Maria Gomez', 'maria.gomez@example.com', '0987654321');

INSERT INTO EMPLEADO (nombre, email, telefono, usuario, clave) 
VALUES ('Carlos Ramirez', 'carlos.ramirez@empresa.com', '1122334455', 'carlos_r', 'clave123');
INSERT INTO EMPLEADO (nombre, email, telefono, usuario, clave) 
VALUES ('Ana Torres', 'ana.torres@empresa.com', '5566778899', 'ana_t', 'clave456');

INSERT INTO METODO (descripcion) VALUES ('Efectivo');
INSERT INTO METODO (descripcion) VALUES ('Tarjeta de Crédito');

-- Insertar registros en VEHICULO, que depende de MARCA, TIPO y ESTADO

INSERT INTO VEHICULO (placa, id_marca, id_tipo, id_estado) 
VALUES ('ABC123', 1, 1, 1);
INSERT INTO VEHICULO (placa, id_marca, id_tipo, id_estado) 
VALUES ('XYZ789', 2, 2, 2);

-- Insertar registros en ALQUILER, que depende de EMPLEADO, CLIENTE y VEHICULO

INSERT INTO ALQUILER (id_empleado, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, fecha_entrega, costo) 
VALUES (1, 1, 1, '2024-10-01 10:00:00', '2024-10-05 10:00:00', '2024-10-05 09:30:00', 302.00);
INSERT INTO ALQUILER (id_empleado, id_cliente, id_vehiculo, fecha_inicio, fecha_fin, fecha_entrega, costo) 
VALUES (2, 2, 2, '2024-10-10 12:00:00', '2024-10-15 12:00:00', '2024-10-15 11:45:00', 275.00);

-- Insertar registros en PAGO, que depende de EMPLEADO, ALQUILER y METODO

INSERT INTO PAGO (id_empleado, id_alquiler, id_metodo, fecha, importe) 
VALUES (1, 1, 1, '2024-10-05 10:00:00', 302.00);
INSERT INTO PAGO (id_empleado, id_alquiler, id_metodo, fecha, importe) 
VALUES (2, 2, 2, '2024-10-15 12:00:00', 275.00);
