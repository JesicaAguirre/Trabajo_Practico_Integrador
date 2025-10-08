-- Ejecutar en Oracle SQL Developer o cualquier herramienta SQL
-- =========================================================

-- La limpieza y las deshabilitaciones de restricciones se dejan comentadas
-- por si deseas un script de inserción limpio y sin acciones de limpieza.
/*
-- Deshabilitar restricciones
ALTER TABLE Empleado DISABLE CONSTRAINT FK_EMP_CARGO;
ALTER TABLE Cliente DISABLE ALL CONSTRAINTS; -- Asumiendo que no tiene FKs hacia otras tablas
ALTER TABLE Pago DISABLE CONSTRAINT FK_PAGO_CLIENTE;
ALTER TABLE Pago DISABLE CONSTRAINT FK_PAGO_MEMBRESIA;
ALTER TABLE Rutina DISABLE CONSTRAINT FK_RUTINA_CLIENTE;
ALTER TABLE Rutina DISABLE CONSTRAINT FK_RUTINA_EMPLEADO;
ALTER TABLE DetalleRutina DISABLE CONSTRAINT FK_DETRUT_RUTINA;
ALTER TABLE DetalleRutina DISABLE CONSTRAINT FK_DETRUT_EJERCICIO;

-- Limpieza de datos (Opcional: Descomentar si se va a re-ejecutar)
DELETE FROM DetalleRutina;
DELETE FROM Rutina;
DELETE FROM Ejercicio;
DELETE FROM Pago;
DELETE FROM Cliente;
DELETE FROM Membresia;
DELETE FROM Empleado;
DELETE FROM Cargo;
*/
-- =========================================================
-- 1. TABLA CARGO 
-- =========================================================
INSERT INTO Cargo (id_cargo, nombre_cargo, descripcion) VALUES (1, 'Gerente', 'Liderazgo y gestión operativa del gimnasio.');
INSERT INTO Cargo (id_cargo, nombre_cargo, descripcion) VALUES (2, 'Entrenador Personal', 'Diseño y supervisión de programas de entrenamiento para clientes.');
INSERT INTO Cargo (id_cargo, nombre_cargo, descripcion) VALUES (3, 'Recepcionista', 'Atención al cliente, gestión de pagos y registro de membresías.');
INSERT INTO Cargo (id_cargo, nombre_cargo, descripcion) VALUES (4, 'Limpieza y Mantenimiento', 'Responsable de mantener las instalaciones en óptimas condiciones.');
INSERT INTO Cargo (id_cargo, nombre_cargo, descripcion) VALUES (5, 'Especialista en Nutrición', 'Asesoramiento nutricional y planes alimenticios.');
INSERT INTO Cargo (id_cargo, nombre_cargo, descripcion) VALUES (6, 'Instructor de Clases', 'Liderar y enseñar clases grupales (Ej. Yoga, Spinning, Zumba).');

---
-- =========================================================
-- 2. TABLA EMPLEADO 
-- =========================================================
-- Gerente (id_cargo = 1)
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (101, 'Martín', 'Acosta', '30123456', '1122334455', 'martin.acosta@gimnasio.com', DATE '2018-01-10', 65000.00, 1);

-- Entrenadores (id_cargo = 2)
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (102, 'Sofía', 'Ramírez', '35678901', '1155667788', 'sofia.ramirez@gimnasio.com', DATE '2020-03-20', 45000.00, 2);
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (103, 'Pablo', 'Gómez', '38901234', '1199887766', 'pablo.gomez@gimnasio.com', DATE '2021-07-01', 42000.00, 2);
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (105, 'Andrea', 'Núñez', '37456789', '1188776655', 'andrea.nunez@gimnasio.com', DATE '2019-11-15', 47000.00, 2);

-- Recepcionistas (id_cargo = 3)
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (104, 'Lucía', 'Fernández', '40123457', '1144332211', 'lucia.fernandez@gimnasio.com', DATE '2022-11-05', 30000.00, 3);
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (106, 'Javier', 'Rojas', '42001002', '1133221100', 'javier.rojas@gimnasio.com', DATE '2023-04-12', 28000.00, 3);

-- Limpieza y Mantenimiento (id_cargo = 4)
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (107, 'Carmen', 'Pérez', '33112233', '1177665544', 'carmen.perez@gimnasio.com', DATE '2017-05-01', 25000.00, 4);

-- Especialista en Nutrición (id_cargo = 5)
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (108, 'Alejandro', 'Castro', '41223344', '1110009988', 'alejandro.castro@gimnasio.com', DATE '2024-01-20', 50000.00, 5);

-- Instructor de Clases (id_cargo = 6)
INSERT INTO Empleado (id_empleado, nombre, apellido, dni, telefono, email, fecha_ingreso, salario, id_cargo)
VALUES (109, 'Valeria', 'Díaz', '39556677', '1154321098', 'valeria.diaz@gimnasio.com', DATE '2022-08-01', 35000.00, 6);

---
-- =========================================================
-- 3. TABLA MEMBRESIA 
-- =========================================================
INSERT INTO Membresia (id_membresia, tipo, precio, duracion_dias) VALUES (1, 'Básica Mensual', 2500.00, 30);
INSERT INTO Membresia (id_membresia, tipo, precio, duracion_dias) VALUES (2, 'Premium Trimestral', 6500.00, 90);
INSERT INTO Membresia (id_membresia, tipo, precio, duracion_dias) VALUES (3, 'Anual Total', 25000.00, 365);
INSERT INTO Membresia (id_membresia, tipo, precio, duracion_dias) VALUES (4, 'Pase Diario', 500.00, 1);
INSERT INTO Membresia (id_membresia, tipo, precio, duracion_dias) VALUES (5, 'Clases Grupales Mensual', 3500.00, 30);
INSERT INTO Membresia (id_membresia, tipo, precio, duracion_dias) VALUES (6, 'Familiar Semestral', 15000.00, 180);

---
-- =========================================================
-- 4. TABLA CLIENTE 
-- =========================================================
INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (201, 'Elena', 'Torres', '45123123', '1111223344', 'elena.torres@mail.com', DATE '2023-08-10', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (202, 'Ricardo', 'López', '44000111', '1166778899', 'ricardo.lopez@mail.com', DATE '2023-09-01', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (203, 'Mariana', 'Vidal', '42999888', '1133445566', 'mariana.vidal@mail.com', DATE '2024-01-25', 'Inactivo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (204, 'Federico', 'Sánchez', '39111222', '1188990011', 'federico.sanchez@mail.com', DATE '2024-02-01', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (205, 'Laura', 'Guerra', '41555666', '1177889900', 'laura.guerra@mail.com', DATE '2023-10-15', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (206, 'Diego', 'Méndez', '43777888', '1120203030', 'diego.mendez@mail.com', DATE '2024-03-01', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (207, 'Victoria', 'Ríos', '46101202', '1151525354', 'victoria.rios@mail.com', DATE '2023-11-20', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (208, 'Juan', 'Pérez', '35001100', '1190908080', 'juan.perez@mail.com', DATE '2024-04-10', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (209, 'Camila', 'Herrera', '40506070', '1124252627', 'camila.herrera@mail.com', DATE '2024-05-01', 'Activo');

INSERT INTO Cliente (id_cliente, nombre, apellido, dni, telefono, email, fecha_alta, estado)
VALUES (210, 'Gonzalo', 'Castro', '37890123', '1161626364', 'gonzalo.castro@mail.com', DATE '2023-07-05', 'Inactivo');

---
-- =========================================================
-- 5. TABLA PAGO (Múltiples pagos y métodos)
-- =========================================================
-- Elena (201) - Premium Trimestral (2)
INSERT INTO Pago (id_pago, id_cliente, id_membresia, fecha_pago, monto, metodo_pago)
VALUES (301, 201, 2, DATE '2024-03-01', 6500.00, 'Tarjeta de Crédito');

-- Ricardo (202) - Básica Mensual (1)
INSERT INTO Pago (id_pago, id_cliente, id_membresia, fecha_pago, monto, metodo_pago)
VALUES (302, 202, 1, DATE '2024-04-15', 2500.00, 'Transferencia Bancaria');

-- Federico (204) - Anual Total (3)
INSERT INTO Pago (id_pago, id_cliente, id_membresia, fecha_pago, monto, metodo_pago)
VALUES (303, 204, 3, DATE '2024-02-01', 25000.00, 'Efectivo');

-- Laura (205) - Clases Grupales Mensual (5)
INSERT INTO Pago (id_pago, id_cliente, id_membresia, fecha_pago, monto, metodo_pago)
VALUES (304, 205, 5, DATE '2024-05-01', 3500.00, 'Tarjeta de Débito');

-- Diego (206) - Básica Mensual (1)
INSERT INTO Pago (id_pago, id_cliente, id_membresia, fecha_pago, monto, metodo_pago)
VALUES (305, 206, 1, DATE '2024-05-01', 2500.00, 'Transferencia Bancaria');

-- Victoria (207) - Familiar Semestral (6)
INSERT INTO Pago (id_pago, id_cliente, id_membresia, fecha_pago, monto, metodo_pago)
VALUES (306, 207, 6, DATE '2023-11-20', 15000.00, 'Tarjeta de Crédito');

---
-- =========================================================
-- 6. TABLA EJERCICIO 
-- =========================================================
INSERT INTO Ejercicio (id_ejercicio, nombre, grupo_muscular, descripcion)
VALUES (401, 'Press de Banca', 'Pectorales', 'Ejercicio compuesto para el desarrollo de la fuerza en el pecho, hombros y tríceps.');

INSERT INTO Ejercicio (id_ejercicio, nombre, grupo_muscular, descripcion)
VALUES (402, 'Sentadilla', 'Piernas', 'Ejercicio fundamental para el tren inferior, trabajando cuádriceps, glúteos y femorales.');

INSERT INTO Ejercicio (id_ejercicio, nombre, grupo_muscular, descripcion)
VALUES (403, 'Dominadas', 'Espalda', 'Ejercicio de peso corporal que trabaja principalmente la espalda y bíceps. Variante para dorsales.');

INSERT INTO Ejercicio (id_ejercicio, nombre, grupo_muscular, descripcion)
VALUES (404, 'Press Militar', 'Hombros', 'Levantamiento por encima de la cabeza para desarrollo de deltoides.');

INSERT INTO Ejercicio (id_ejercicio, nombre, grupo_muscular, descripcion)
VALUES (405, 'Peso Muerto Rumano', 'Femorales/Glúteos', 'Trabajo de cadena posterior con énfasis en isquiotibiales.');

INSERT INTO Ejercicio (id_ejercicio, nombre, grupo_muscular, descripcion)
VALUES (406, 'Remo con Barra', 'Espalda', 'Ejercicio de tracción horizontal para la espalda media.');

INSERT INTO Ejercicio (id_ejercicio, nombre, grupo_muscular, descripcion)
VALUES (407, 'Extensiones de Tríceps', 'Tríceps', 'Aislamiento para el músculo tríceps.');

---
-- =========================================================
-- 7. TABLA RUTINA 
-- =========================================================
-- Elena (201) - Entrenador Sofía (102)
INSERT INTO Rutina (id_rutina, id_cliente, id_empleado, fecha_inicio, fecha_fin, objetivo)
VALUES (501, 201, 102, DATE '2024-03-05', DATE '2024-06-05', 'Ganancia de masa muscular y fuerza en tren superior.');

-- Ricardo (202) - Entrenador Pablo (103)
INSERT INTO Rutina (id_rutina, id_cliente, id_empleado, fecha_inicio, fecha_fin, objetivo)
VALUES (502, 202, 103, DATE '2024-04-20', DATE '2024-05-20', 'Pérdida de peso y mejora de resistencia cardiovascular.');

-- Federico (204) - Entrenador Andrea (105)
INSERT INTO Rutina (id_rutina, id_cliente, id_empleado, fecha_inicio, fecha_fin, objetivo)
VALUES (503, 204, 105, DATE '2024-02-10', DATE '2024-08-10', 'Aumento de fuerza general (Powerlifting).');

-- Diego (206) - Entrenador Sofía (102)
INSERT INTO Rutina (id_rutina, id_cliente, id_empleado, fecha_inicio, fecha_fin, objetivo)
VALUES (504, 206, 102, DATE '2024-03-05', DATE '2024-04-05', 'Rehabilitación y acondicionamiento general.');

-- Juan (208) - Entrenador Pablo (103)
INSERT INTO Rutina (id_rutina, id_cliente, id_empleado, fecha_inicio, fecha_fin, objetivo)
VALUES (505, 208, 103, DATE '2024-04-12', DATE '2024-07-12', 'Definición muscular y resistencia de media distancia.');

---
-- =========================================================
-- 8. TABLA DETALLE RUTINA 
-- =========================================================
-- Detalle para Rutina 501 (Elena) - PPL (Push Pull Legs)
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (601, 501, 401, 4, 10, 90); -- Press de Banca
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (602, 501, 403, 3, 8, 120); -- Dominadas
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (604, 501, 404, 3, 12, 60); -- Press Militar

-- Detalle para Rutina 502 (Ricardo) - Full Body
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (603, 502, 402, 3, 15, 60); -- Sentadilla
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (605, 502, 406, 3, 12, 60); -- Remo con Barra
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (606, 502, 407, 3, 15, 45); -- Extensiones de Tríceps

-- Detalle para Rutina 503 (Federico) - Fuerza
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (607, 503, 402, 5, 5, 180); -- Sentadilla (Pesado)
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (608, 503, 401, 5, 5, 180); -- Press de Banca (Pesado)
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (609, 503, 405, 3, 8, 120); -- Peso Muerto Rumano

-- Detalle para Rutina 505 (Juan) - Definición
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (610, 505, 404, 4, 15, 45); -- Press Militar
INSERT INTO DetalleRutina (id_detalle, id_rutina, id_ejercicio, series, repeticiones, descanso_segundos)
VALUES (611, 505, 406, 4, 12, 60); -- Remo con Barra


COMMIT;