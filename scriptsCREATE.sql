CREATE TABLE Cargo (
    id_cargo INT PRIMARY KEY,
    nombre_cargo VARCHAR(50) NOT NULL,
    descripcion VARCHAR2(500)
);

CREATE TABLE Departamento (
    id_dpto INT PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    ciudad VARCHAR2(50) NOT NULL
);

CREATE TABLE Empleado (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_ingreso DATE,
    salario DECIMAL(10,2),
    id_cargo INT NOT NULL, 
    id_dpto INT NOT NULL,
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo)
);

CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_alta DATE NOT NULL,
    estado VARCHAR(20)
);

CREATE TABLE Membresia (
    id_membresia INT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    duracion_meses INT NOT NULL 
);

CREATE TABLE Pago (
    id_pago INT PRIMARY KEY,
    id_cliente INT NOT NULL,    
    id_membresia INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_membresia) REFERENCES Membresia(id_membresia)
);

CREATE TABLE Rutina (
    id_rutina INT PRIMARY KEY,
    id_cliente INT NOT NULL,   
    id_empleado INT NOT NULL,   
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    objetivo VARCHAR2(500),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

CREATE TABLE HistorialCargo (
    id_historial INT PRIMARY KEY,
    id_empleado INT NOT NULL,
    id_cargo INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
    FOREIGN KEY (id_cargo) REFERENCES Cargo(id_cargo)
);

-- Tablas de la relación de muchos a muchos (Rutina <-> Ejercicio)
CREATE TABLE Ejercicio (
    id_ejercicio INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    grupo_muscular VARCHAR(50),
    descripcion VARCHAR2(500)
);

CREATE TABLE DetalleRutina (
    id_detalle INT PRIMARY KEY,
    id_rutina INT NOT NULL, 
    id_ejercicio INT NOT NULL, 
    series INT NOT NULL,
    repeticiones INT NOT NULL,
    descanso_segundos INT,
    FOREIGN KEY (id_rutina) REFERENCES Rutina(id_rutina),
    FOREIGN KEY (id_ejercicio) REFERENCES Ejercicio(id_ejercicio)
);


ALTER TABLE Empleado
ADD CONSTRAINT fk_empleado_departamento
FOREIGN KEY (id_dpto) REFERENCES Departamento(id_dpto);





UPDATE Empleado SET id_dpto = 1 WHERE id_cargo IN (1, 3, 4);

-- Entrenador Personal, Especialista en Nutrición -> Fitness (Dpto 2)
UPDATE Empleado SET id_dpto = 2 WHERE id_cargo IN (2, 5);

-- 2. Asignar un empleado al departamento de MARKETING (Dpto 5) para que su consulta funcione:
-- Asignaremos al Instructor de Clases (id_cargo 6, Empleado 109) al Dpto 5.
UPDATE Empleado SET id_dpto = 5 WHERE id_cargo = 6