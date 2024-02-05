-- TABLE
CREATE TABLE EMPLEADO (
 ID INT(8),
 NOMBRE VARCHAR(50),
 APELLIDO VARCHAR(59),
 SEXO CHAR(1),
 FECHA_NACIMIENTO DATE,
 SALARIO DOUBLE(10,2)
 );
CREATE TABLE VACACIONES(
 ID INT(8),
 ID_EMP INT(8),
 FECHA_INICIO DATE,
 FECHA_FIN DATE,
 ESTADO CHAR(1),
 CANTIDAD_DIAS INT(8)
);
 
SELECT nombre, apellido, salario FROM EMPLEADO; /* Seleccionar todos los empleados*/

SELECT nombre, apellido, salario FROM EMPLEADO WHERE salario > 4000000; /* Seleccionar todos los empleados que ganen mas de 4 millones*/

SELECT sexo, COUNT(*) as cantidad_empleados FROM EMPLEADO GROUP by sexo; /* Contar los empleados por sexo*/

SELECT * from EMPLEADO where id NOT IN (SELECT id_emp FROM VACACIONES); /* Seleccionar empleados que no han solicitado vacaciones */

SELECT e.*, COUNT(v.ID) as numero_solicitudes /* Selecciona los empleados que han solicitado vacaciones más de una vez y cuenta las veces que han solicitado vacaciones*/
FROM EMPLEADO e 
JOIN VACACIONES v on e.ID = v.id_emp
GROUP by e.id
HAVING COUNT(v.id) > 1;


SELECT AVG(salario) as salario_promedio from EMPLEADO; /* Calcula el valor promedio del salario entre los empleados*/

SELECT e.id, e.nombre, e.apellido, COALESCE(AVG(v.cantidad_dias), 0) AS dias_vacaciones_promedio /* Calcula el promedio de los dias de vacaciones solicitados por empleado*/
FROM EMPLEADO e
LEFT JOIN VACACIONES v ON e.id = v.id_emp
GROUP BY e.id, e.nombre, e.apellido;

SELECT e.nombre, e.apellido, SUM(v.cantidad_dias) AS dias_totales_solicitados /* Esta función encuentra el empleado que más días de vacaciones ha solicitado en total y muestra su nombre, apellido y los días totales solicitados.*/
FROM EMPLEADO e
JOIN VACACIONES v ON e.id = v.id_emp
GROUP BY e.nombre, e.apellido
ORDER BY dias_totales_solicitados DESC
LIMIT 1;

SELECT e.id, e.nombre, e.apellido, /* Muestra la cantididad de días de vacaciones aprovados y rechazados para cada empleado*/
       COALESCE(SUM(CASE WHEN v.estado = 'A' THEN v.cantidad_dias ELSE 0 END), 0) AS dias_aprobados,
       COALESCE(SUM(CASE WHEN v.estado = 'R' THEN v.cantidad_dias ELSE 0 END), 0) AS dias_rechazados
FROM EMPLEADO e
LEFT JOIN VACACIONES v ON e.id = v.id_emp
GROUP BY e.id, e.nombre, e.apellido;
