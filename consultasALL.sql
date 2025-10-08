--                                         =========================================================
--                                                 TP INTEGRADOR BD II - Gestión de Gimnasio
--                                         =========================================================
-- =========================================================
-- Etapa 2: Consultas Dinámicas y Formateo
-- =========================================================
ALTER SESSION SET NLS_TERRITORY = 'ARGENTINA';
ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ',.';

-- =========================================================
-- 1. Empleados por cargo (dinámico)
SELECT e.id_empleado AS "ID Empleado",
       e.nombre || ' ' || e.apellido AS "Nombre Completo",
       c.nombre_cargo AS "Cargo",
       TO_CHAR(e.salario, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Salario"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
WHERE UPPER(c.nombre_cargo) = UPPER('&nombre_cargo')
ORDER BY &columna;
--recepcionista
--e.apellido
-- =========================================================
-- 2. Clientes por estado
SELECT id_cliente AS "ID Cliente",
       nombre || ' ' || apellido AS "Nombre Completo",
       estado AS "Estado",
       TO_CHAR(fecha_alta, 'DD/MM/YYYY') AS "Fecha Alta"
FROM Cliente
WHERE UPPER(estado) = UPPER('&estado')
ORDER BY &columna;
--inactivo
--id_cliente

-- =========================================================
-- 3. Pagos de un cliente (por DNI)
SELECT p.id_pago AS "Pago Nº",
       m.tipo AS "Tipo Membresía",
       TO_CHAR(p.fecha_pago, 'DD/MM/YYYY') AS "Fecha de Pago",
       TO_CHAR(p.monto, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Monto",
       p.metodo_pago AS "Método de Pago"
FROM Pago p
JOIN Membresia m ON p.id_membresia = m.id_membresia
JOIN Cliente c ON p.id_cliente = c.id_cliente
WHERE c.dni = '&dni_cliente'
ORDER BY p.fecha_pago DESC;

--39111222
-- =========================================================
-- 4. Rutinas asignadas a un cliente (por DNI)
SELECT r.id_rutina AS "Código Rutina",
       e.nombre || ' ' || e.apellido AS "Profesor Asignado",
       TO_CHAR(r.fecha_inicio, 'DD/MM/YYYY') AS "Inicio",
       TO_CHAR(r.fecha_fin, 'DD/MM/YYYY') AS "Fin",
       r.objetivo AS "Objetivo"
FROM Rutina r
JOIN Empleado e ON r.id_empleado = e.id_empleado
JOIN Cliente c ON r.id_cliente = c.id_cliente
WHERE c.dni = '&dni_cliente';

--35001100 
--46101202  No tiene rutina
-- =========================================================
-- 5. Empleados con salario superior al promedio
SELECT nombre || ' ' || apellido AS "Empleado",
       TO_CHAR(salario, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Salario"
FROM Empleado
WHERE salario > (SELECT AVG(salario) FROM Empleado)
ORDER BY salario DESC;

-- =========================================================
-- 6. Antigüedad de empleados (función MONTHS_BETWEEN)
SELECT nombre || ' ' || apellido AS "Empleado",
       TO_CHAR(fecha_ingreso, 'DD/MM/YYYY') AS "Fecha Ingreso",
       TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_ingreso) / 12) AS "Años de Antigüedad"
FROM Empleado
ORDER BY &columna;
--"Años de Antigüedad"
-- =========================================================
-- 7. Resumen de clientes (CASE + NVL)
SELECT nombre || ' ' || apellido AS "Cliente",
       NVL(telefono, 'Sin teléfono') AS "Teléfono",
       CASE 
           WHEN UPPER(estado) = UPPER('Activo') THEN 'Socio vigente'
           WHEN UPPER(estado) = UPPER('Inactivo') THEN 'Socio suspendido'
           ELSE 'Sin estado'
       END AS "Situación"
FROM Cliente
ORDER BY &columna;
--"Situación"
-- =========================================================
-- 8. Aumento de salario por cargo (DML)
UPDATE Empleado
SET salario = salario * (1 + (&porcentaje / 100))
WHERE id_cargo = (SELECT id_cargo FROM Cargo WHERE UPPER(nombre_cargo) = UPPER('&cargo'));

--Limpieza y Mantenimiento


-- =========================================================
-- MÓDULO RRHH - Consultas adicionales
-- =========================================================

-- =========================================================
-- 1. Empleado por legajo
SELECT e.id_empleado AS "Legajo",
       e.apellido AS "Apellido",
       TO_CHAR(e.salario, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Salario",
       c.nombre_cargo AS "Departamento/Cargo"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
WHERE e.id_empleado = &legajo;
--105

-- =========================================================
-- 2. Empleado por legajo con salario anual
SELECT e.id_empleado AS "Legajo",
       e.apellido AS "Apellido",
       TO_CHAR(e.salario, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Salario Mensual",
       TO_CHAR(e.salario * 12, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Salario Anual",
       c.nombre_cargo AS "Departamento/Cargo"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
WHERE e.id_empleado = &legajo;
--108
-- =========================================================
-- 3. Consulta dinámica: seleccionar columnas y orden
SELECT &columnas
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
ORDER BY &orden;
--e.nombre, e.apellido, c.nombre_cargo	
--c.nombre_cargo, e.apellido
-- =========================================================
-- Etapa 3: Consultas Gerenciales
-- =========================================================


-- =========================================================
-- 1. Antigüedad de cada empleado
SELECT e.apellido || ', ' || e.nombre AS "Apellido y Nombre",
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecha_ingreso) / 12) AS "Antigüedad"
FROM Empleado e
ORDER BY "Antigüedad" DESC;

-- =========================================================
-- 2. Categorizar empleados por nivel salarial
SELECT e.apellido || ', ' || e.nombre AS "Empleado",
       c.nombre_cargo AS "Cargo",
       e.salario AS "Salario",
       CASE
           WHEN e.salario > 11000 THEN 'Alto'
           WHEN e.salario BETWEEN 5000 AND 11000 THEN 'Medio'
           ELSE 'Bajo'
       END AS "Categoría Salarial"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
ORDER BY e.salario DESC;

-- =========================================================
-- 3. Informe de salarios con formato mejorado
SELECT e.apellido || ', ' || e.nombre AS "Empleado",
       c.nombre_cargo AS "Cargo",
       TO_CHAR(e.salario, 'L99G999D00', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Salario",
       CASE
           WHEN e.salario > 11000 THEN 'ALTO'
           WHEN e.salario BETWEEN 5000 AND 11000 THEN 'MEDIO'
           ELSE 'BAJO'
       END AS "Categoría"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
ORDER BY e.salario DESC;

-- =========================================================
-- 4. Empleados sin departamento asignado
CREATE OR REPLACE VIEW empleados_sin_departamento AS
SELECT e.id_empleado AS "Legajo",
       e.nombre || ' ' || e.apellido AS "Empleado",
       NVL(c.nombre_cargo, 'Sin asignar') AS "Cargo"
FROM Empleado e
LEFT JOIN Cargo c ON e.id_cargo = c.id_cargo
WHERE e.id_cargo IS NULL;


SELECT * FROM empleados_sin_departamento;

-- =========================================================
-- 5. Departamentos con empleados en una ciudad específica
CREATE OR REPLACE VIEW dptos_con_empleados_ciudad AS
SELECT DISTINCT d.nombre AS "Departamento",
       d.ciudad AS "Ciudad"
FROM Departamento d
JOIN Empleado e ON d.id_dpto = e.id_dpto
WHERE UPPER(d.ciudad) = UPPER('&ciudad');

SELECT * FROM dptos_con_empleados_ciudad;


-- =========================================================
-- 6. Reusabilidad

SELECT * FROM empleados_sin_departamento;

SELECT * FROM dptos_con_empleados_ciudad;
-- =========================================================
-- ETAPA 4 - Subconsultas y agregaciones
-- =========================================================

-- =========================================================
-- 1. Apellidos y cargos anteriores de empleados con historial
CREATE OR REPLACE VIEW historial_cargos_empleados AS
SELECT e.apellido AS "Apellido",
       c.nombre_cargo AS "Cargo",
       c.descripcion AS "Descripción Cargo",
       h.fecha_inicio AS "Desde",
       NVL(TO_CHAR(h.fecha_fin, 'DD/MM/YYYY'), 'Actualidad') AS "Hasta"
FROM HistorialCargo h
JOIN Empleado e ON h.id_empleado = e.id_empleado
JOIN Cargo c ON h.id_cargo = c.id_cargo
ORDER BY e.apellido, h.fecha_inicio;

SELECT * FROM historial_cargos_empleados;

-- =========================================================
-- 2. Salario más alto de la empresa
SELECT MAX(salario) AS "Salario Máximo"
FROM Empleado;
 --o
 SELECT
    nombre,
    apellido,
    salario
FROM
    Empleado
WHERE
    salario = (SELECT MAX(salario) FROM Empleado);

-- =========================================================
-- 3. Fecha de contratación más reciente
SELECT MAX(fecha_ingreso) AS "Última Contratación"
FROM Empleado;

-- =========================================================
-- 4. Payroll (costos del personal del último mes)
CREATE OR REPLACE VIEW payroll_ultimo_mes AS
SELECT e.id_empleado AS "Legajo",
       e.apellido || ', ' || e.nombre AS "Empleado",
       c.nombre_cargo AS "Cargo",
       TO_CHAR(e.salario, 'L99G999D00', 'NLS_NUMERIC_CHARACTERS='',.''') AS "Salario",
       ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1) AS "Mes Correspondiente"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo;

SELECT * FROM payroll_ultimo_mes;

SELECT SUM(salario) AS "Total Payroll Último Mes" FROM Empleado;

-- =========================================================
-- 5. Nómina de empleados con menor salario anual
SELECT e.id_empleado AS "Legajo",
       e.apellido AS "Apellido",
       c.nombre_cargo AS "Cargo",
       e.salario AS "Salario Mensual",
       e.salario * 12 AS "Salario Anual",
       c.descripcion AS "Descripción"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
WHERE e.salario * 12 = (SELECT MIN(salario * 12) FROM Empleado);

-- =========================================================
-- ETAPA 5 - Subconsultas, agregaciones y DML
-- =========================================================

-- =========================================================
-- 1. Empleados con salario superior al promedio de su cargo
SELECT e.nombre || ' ' || e.apellido AS "Empleado",
       c.nombre_cargo AS "Cargo",
       e.salario AS "Salario",
       ROUND((SELECT AVG(salario) FROM Empleado WHERE id_cargo = e.id_cargo),2) AS "Promedio del Cargo"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
WHERE e.salario > (SELECT AVG(salario) FROM Empleado WHERE id_cargo = e.id_cargo)
ORDER BY c.nombre_cargo, e.salario DESC;

-- =========================================================
-- 2. Empleados que ganan más que los gerentes
SELECT e.nombre || ' ' || e.apellido AS "Empleado",
       c.nombre_cargo AS "Cargo",
       e.salario AS "Salario"
FROM Empleado e
JOIN Cargo c ON e.id_cargo = c.id_cargo
WHERE e.salario > (
    SELECT MAX(e2.salario)
    FROM Empleado e2
    JOIN Cargo c2 ON e2.id_cargo = c2.id_cargo
    WHERE UPPER(c2.nombre_cargo) LIKE '%GERENTE%'
)
ORDER BY e.salario DESC;

-- =========================================================
-- 3. Empleados promovidos antes del año de antigüedad
CREATE OR REPLACE VIEW empleados_promovidos_temprano AS
SELECT e.id_empleado AS "Legajo",
       e.apellido || ', ' || e.nombre AS "Empleado",
       TRUNC(MONTHS_BETWEEN(h.fecha_fin, h.fecha_inicio)) AS "Meses Antes de Promoción"
FROM HistorialCargo h
JOIN Empleado e ON h.id_empleado = e.id_empleado
WHERE MONTHS_BETWEEN(h.fecha_fin, h.fecha_inicio) < 12;

SELECT * FROM empleados_promovidos_temprano;

-- =========================================================
-- 4. Incrementar salario de programadores hasta el 80% del gerente mejor pago
UPDATE Empleado
SET salario = (
    SELECT MAX(e2.salario) * 0.8
    FROM Empleado e2
    JOIN Cargo c2 ON e2.id_cargo = c2.id_cargo
    WHERE UPPER(c2.nombre_cargo) LIKE '%GERENTE%'
)
WHERE id_cargo = (
    SELECT id_cargo FROM Cargo WHERE UPPER(nombre_cargo) LIKE UPPER('%Entrenador Personal%')
);