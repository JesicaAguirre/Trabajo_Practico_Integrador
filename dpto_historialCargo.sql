-- =========================================================
-- Tabla Departamento
-- =========================================================
CREATE TABLE Departamento (
    id_dpto INT PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    ciudad VARCHAR2(50) NOT NULL
);
-- =========================================================
-- Inserción de datos de ejemplo en Departamento
-- =========================================================
INSERT INTO Departamento (id_dpto, nombre, ciudad)
VALUES (1, 'Administración', 'Paraná');

INSERT INTO Departamento (id_dpto, nombre, ciudad)
VALUES (2, 'Fitness', 'Paraná');

INSERT INTO Departamento (id_dpto, nombre, ciudad)
VALUES (3, 'Tecnología', 'Paraná');

INSERT INTO Departamento (id_dpto, nombre, ciudad)
VALUES (4, 'Ventas', 'Rosario');

INSERT INTO Departamento (id_dpto, nombre, ciudad)
VALUES (5, 'Marketing', 'Santa Fe');

-- Ejemplo de relación estimada: cada empleado tiene un departamento
ALTER TABLE Empleado ADD (id_dpto INT);

ALTER TABLE Empleado
ADD CONSTRAINT fk_empleado_departamento
FOREIGN KEY (id_dpto) REFERENCES Departamento(id_dpto);


CREATE TABLE HistorialCargo (
    id_historial INT PRIMARY KEY,
    id_empleado INT NOT NULL,
    id_cargo INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo)
);



DROP TABLE HistorialCargo CASCADE CONSTRAINTS;

-- =========================================================
-- Inserción de datos de ejemplo en HistorialCargo
-- =========================================================
-- Martín Acosta (101) - Gerente desde ingreso, no hay cambios anteriores
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (1, 101, 1, DATE '2018-01-10', NULL);

-- Sofía Ramírez (102) - Entrenador Personal desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (2, 102, 2, DATE '2020-03-20', NULL);

-- Pablo Gómez (103) - Entrenador Personal desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (3, 103, 2, DATE '2021-07-01', NULL);

-- Lucía Fernández (104) - Recepcionista desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (4, 104, 3, DATE '2022-11-05', NULL);

-- Andrea Núñez (105) - Entrenador Personal desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (5, 105, 2, DATE '2019-11-15', NULL);

-- Javier Rojas (106) - Recepcionista desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (6, 106, 3, DATE '2023-04-12', NULL);

-- Carmen Pérez (107) - Limpieza y Mantenimiento desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (7, 107, 4, DATE '2017-05-01', NULL);

-- Alejandro Castro (108) - Especialista en Nutrición desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (8, 108, 5, DATE '2024-01-20', NULL);

-- Valeria Díaz (109) - Instructor de Clases desde ingreso
INSERT INTO HistorialCargo (id_historial, id_empleado, id_cargo, fecha_inicio, fecha_fin)
VALUES (9, 109, 6, DATE '2022-08-01', NULL);