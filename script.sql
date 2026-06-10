-- =========================================================
-- ACTIVIDAD TEMA 8: ÍNDICES Y RESTRICCIONES EN ORACLE
-- Asignatura: Bases de Datos Avanzadas
-- =========================================================

-- 1. CONSULTAR LOS ÍNDICES DISPONIBLES
SELECT index_name, table_name, uniqueness 
FROM user_indexes 
WHERE table_name IN ('EMPLOYEES', 'DEPARTMENTS');

-- 2. DESACTIVAR LAS RESTRICCIONES
ALTER TABLE departments DISABLE CONSTRAINT dept_id_pk CASCADE;
ALTER TABLE employees DISABLE CONSTRAINT emp_emp_id_pk CASCADE;
ALTER TABLE employees DISABLE CONSTRAINT emp_dept_fk;

-- 3. INSERTAR TUPLAS QUE NO CUMPLAN LAS RESTRICCIONES
INSERT INTO departments (department_id, department_name) 
VALUES (10, 'Innovación Digital');

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id) 
VALUES (999, 'Dubier', 'Gómez', 'dubier1821@gmail.com', SYSDATE, 'IT_PROG', 9999);

COMMIT;

-- 4. VOLVER A ESTABLECER LAS RESTRICCIONES
ALTER TABLE departments ENABLE CONSTRAINT dept_id_pk;

-- 5. CREAR UN DUPLICADO DE LA TABLA DEPARTMENTS
CREATE TABLE departments2 AS SELECT * FROM departments;

-- 6. INSERTAR TRES TUPLAS EN DEPARTMENTS2
INSERT INTO departments2 (department_id, department_name, manager_id, location_id) 
VALUES (500, 'Cloud Architecture', NULL, 1700);

INSERT INTO departments2 (department_id, department_name, manager_id, location_id) 
VALUES (501, 'Seguridad ISO 27001', NULL, 1700);

INSERT INTO departments2 (department_id, department_name, manager_id, location_id) 
VALUES (502, 'E-commerce Management', NULL, 1700);

-- 7. BLOQUE ANÓNIMO DE TRANSACCIÓN
DECLARE
    v_nombre_dept VARCHAR2(50) := 'Auditoría de Sistemas';
BEGIN
    INSERT INTO departments2 (department_id, department_name) 
    VALUES (600, v_nombre_dept);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transacción completada y guardada con éxito.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en la transacción. Se ha aplicado ROLLBACK.');
END;
/
