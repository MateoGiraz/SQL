--1
SELECT DISTINCT c.NOMBRE
FROM ALQUILA a, EQUIPO e, CONTACTO c
WHERE e.ID = a.ID AND a.DOCUMENTO = c.DOCUMENTO 
AND a.FINICIO BETWEEN '01/06/2022' AND '30/06/2022'
AND e.CATEGORIA = 'VIAL'

--2
SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO 
FROM ALQUILA a, EQUIPO e, CONTACTO c
WHERE e.CATEGORIA = 'VIAL'
AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022'
AND c.DOCUMENTO = a.DOCUMENTO
AND e.ID = a.ID

UNION

SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO 
FROM ALQUILA a, EQUIPO e, CONTACTO c
WHERE e.CATEGORIA = 'CONSTRUCCION'
AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022'
AND c.DOCUMENTO = a.DOCUMENTO
AND e.ID = a.ID

MINUS

(SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO 
FROM ALQUILA a, EQUIPO e, CONTACTO c
WHERE e.CATEGORIA = 'VIAL'
AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022'
AND c.DOCUMENTO = a.DOCUMENTO
AND e.ID = a.ID

INTERSECT

SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO 
FROM ALQUILA a, EQUIPO e, CONTACTO c
WHERE e.CATEGORIA = 'CONSTRUCCION'
AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022'
AND c.DOCUMENTO = a.DOCUMENTO
AND e.ID = a.ID)

--3
SELECT FREALIZACION, DESCRIPCION
FROM TAREA
WHERE FREALIZACION in(SELECT min(FREALIZACION)
                    FROM TAREA t, PROYECTO p
                    WHERE t.NROPROYECTO = p.NROPROYECTO
                    AND p.NOMBRE = 'RENOVACION HIDRAULICA')

--4
SELECT DISTINCT c.NOMBRE, c1.DOCUMENTO, c1.NROPROYECTO
FROM CONTRATA c1, CONTRATA c2, PROYECTO p, PROYECTO p2, CONTACTO c
WHERE c1.DOCUMENTO = c2.DOCUMENTO
AND c1.DOCUMENTO = c.DOCUMENTO
AND p.NROPROYECTO = c1.NROPROYECTO
AND p.FFINALIZACION is null 
AND c2.NROPROYECTO = p2.NROPROYECTO
AND p2.FFINALIZACION is null 
AND c1.NROPROYECTO != c2.NROPROYECTO
