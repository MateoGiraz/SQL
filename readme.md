[Doc para editar](https://docs.google.com/document/d/1C5YyI4ZGE8aLO2fYO_k13kTdU5d0-ti2l6oU0lvz7bk/edit#)

## Consigna 1)
Obtener para los equipos que sean de categoría vial, el nombre de los contactos que los
alquilaron. Considerar aquellos equipos que fueron alquilados al menos una vez y dicho
alquiler haya iniciado en junio de 2022.
## Ejercicio 1)
#### AR
EquipoVial ← σ e.Categoria = ‘Vial’ (ρ (EQUIPO) e)

AlquilerJunio ← σ a.FInicio >= ‘01/06/2022’ ∧  a.FInicio <= ‘30/06/2022’ (ρ (ALQUILA) a)

Documento ← π Documento (EquipoVial \* AlquilerJunio)

π Nombre (Documento \* CONTACTO)
#### SQL
```
SELECT DISTINCT c.NOMBRE

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON a.DOCUMENTO = c.DOCUMENTO

WHERE e.CATEGORIA = 'VIAL' AND

a.FINICIO BETWEEN '01/06/2022' AND '30/06/2022'
```

## Consigna 2)
Obtener el nombre, teléfono y tipo de contacto para aquellos contactos que hayan alquilado
equipos de construcción o vial pero no de ambas categorías. Considerar solo los alquileres de
la primera quincena de setiembre de 2022.
## Ejercicio 2)
#### AR
EquipoVial ← σ e.Categoria = ‘Vial’ (ρ (EQUIPO) e)

EquipoConstruccion ← σ e.Categoria = ‘Construccion’ (ρ (EQUIPO) e)

AlquierQuincena ← σ a.FInicio >= ‘01/09/2022’

DocVial ← π Documento (EquipoVial \* AlquierQuincena)

DocConstruccion ← π Documento (EquipoConstruccion \* AlquierQuincena)

DocFinal ← (DocVial ∪ DocConstruccion) - (DocVial ∩ DocConstruccion)

π Nombre, Telefono, Tipo (DocFinal \* CONTACTO)
#### SQL
```
SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON c.DOCUMENTO = a.DOCUMENTO

WHERE (e.CATEGORIA = 'VIAL' OR e.CATEGORIA = 'CONSTRUCCION')

AND a.FINICIO >= '01/09/2022'

MINUS

(SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON c.DOCUMENTO = a.DOCUMENTO

WHERE e.CATEGORIA = 'VIAL'

AND a.FINICIO >= '01/09/2022'

INTERSECT

SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON c.DOCUMENTO = a.DOCUMENTO

WHERE e.CATEGORIA = 'CONSTRUCCION'

AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022')
```
## Consigna 3)
Obtener la descripción y la fecha de realización de la tarea que se realizó primero dentro del
proyecto “Renovación hidráulica”. Si hay más de una tarea con esta condición, mostrarlas
todas
## Ejercicio 3)
#### AR
TareasH ← π Descripcion, FRealizacion (TAREA \* (σ p.Nombre = ‘Renovación hidráulica’  (ρ (PROYECTO) p)))

TareasNuevas ← π t1.Descripcion, t1.FRealizacion(ρ (TareasH) t1) |x| σ t1.FRealizacion > t2.FRealizacion (ρ (TareasH) t2)

TareasH - TareasNuevas
#### SQL
```
SELECT FREALIZACION, DESCRIPCION

FROM TAREA

WHERE FREALIZACION in(SELECT MIN(FREALIZACION)

                    FROM TAREA t

                    INNER JOIN PROYECTO p ON t.NROPROYECTO = p.NROPROYECTO

                    WHERE p.NOMBRE = 'RENOVACION HIDRAULICA')
```

## Consigna 4)
Obtener el documento y nombre de los contactos que hayan contratado más de un proyecto,
así como también los números de los proyectos que contrató. Considerar aquellos proyectos
que aún no estén terminados
## Ejercicio 4)
#### AR
DocRecurrente ← π Documento, NroProy (ρ (Contrata) c1) |x| σ c1.Documento == c2.Documento ∧ c1.NroProy != c2.NroProy (ρ (Contrata) c2)

Contratados ← π Documento, NroProy (ρ (DocRecurrente) d) |x| d.NroProy == p.NroProy ∧ p.FFinalizacion == NULL (ρ (Proyecto) t2)

Res ← π Documento, NroProy, Nombre (Contratados \* Contacto)
#### SQL
```
SELECT DISTINCT c.NOMBRE, c1.DOCUMENTO, c1.NROPROYECTO

FROM CONTRATA c1

INNER JOIN CONTACTO c ON c1.DOCUMENTO = c.DOCUMENTO

INNER JOIN CONTRATA c2 ON c1.DOCUMENTO = c2.DOCUMENTO AND c1.NROPROYECTO != c2.NROPROYECTO

INNER JOIN PROYECTO p ON p.NROPROYECTO = c1.NROPROYECTO

INNER JOIN PROYECTO p2 ON c2.NROPROYECTO = p2.NROPROYECTO

WHERE p.FFINALIZACION is null AND p2.FFINALIZACION is null
```
## Consigna 5)
Obtener el id de los equipos que hayan sido alquilados por todos los contactos. Considerar
únicamente aquellos equipos cuyo estado sea “Service” y la fecha adquirida haya sido en el
2022.
## Ejercicio 5)
#### AR
EquiposService2022 ←π Id (σ e.Estado = ‘Service’ ∧ e.FechaAdquirido >= ‘01/01/2022’ ∧  e.FechaAdquirido <= ‘31/12/2022’ (ρ (EQUIPO) e))

R ← π Documento, Id (ALQUILA \* EquiposService2022)

S ← π Documento (ρ (CONTACTO) e))

R%S
#### CRT

{ t.Id / Equipo(t) and t.Estado = 'Service' and t.FechaAdquirido < ‘01/01/2022’ and t.FechaAdquirido > ‘31/12/2022’ and                                                                                           (∀u) (Contacto(u) → (∃v) (Alquiler(v) and v.Id = t.Id and v.Documento = u.Documento) )           and (∃q)(Contacto(q) ) }
#### SQL
```
SELECT e.ID

FROM EQUIPO e

WHERE e.ESTADO = 'SERVICE' AND e.FECHAADQUIRIDO BETWEEN '01/01/2022' AND '31/12/2022'

AND NOT EXISTS(SELECT 1

                FROM CONTACTO c

                WHERE NOT EXISTS(SELECT 1

                                 FROM ALQUILA a

                                 WHERE a.DOCUMENTO = c.DOCUMENTO

                                 AND a.ID = e.ID))

AND EXISTS(SELECT 1

            FROM CONTACTO)
```
## Consigna 6)
Obtener todos los datos de las tareas, así como también el nombre del proyecto al que
pertenecen. Para las tareas realizadas, mostrar la fecha de realización y para aquellas
pendientes, mostrar el texto “Pendiente de realización”. Considerar aquellos proyectos que
tengan al menos 3 tareas.
## Ejercicio 6)
#### SQL
```
SELECT p.NOMBRE, t.IDTAREA, t.DESCRIPCION,

NVL(TO_CHAR(t.FREALIZACION), 'Pendiente de realización')

FROM TAREA t

INNER JOIN PROYECTO p ON t.NROPROYECTO = p.NROPROYECTO

WHERE p.NROPROYECTO IN (SELECT NROPROYECTO

                          FROM TAREA

                          GROUP BY NROPROYECTO

                          HAVING COUNT(*) >= 3)
```
## Consigna 7)
Obtener para cada ingeniero, la cantidad de equipos que alquiló. Considerar únicamente los
tipos “Construcción” y “Terreno”.
## Ejercicio 7) 
#### SQL
```
SELECT a.DOCUMENTO, COUNT(*)

FROM ALQUILA a

INNER JOIN CONTACTO c ON a.DOCUMENTO = c.DOCUMENTO

INNER JOIN EQUIPO e ON e.ID = a.ID

WHERE c.TIPO = 'INGENIERO' AND

(e.CATEGORIA = 'CONSTRUCCION' OR e.CATEGORIA = 'TERRENO')

GROUP BY a.DOCUMENTO
```
## Consigna 8)
Obtener el documento y nombre de los contactos que alquilaron la mayor cantidad de equipos
distintos. Considerar solamente contactos que hayan contratado proyectos que finalizaron
dentro de los últimos 30 días.
## Ejercicio 8)
#### SQL
```
SELECT DOCUMENTO, NOMBRE

FROM CONTACTO

WHERE DOCUMENTO IN (SELECT DOCUMENTO

                     FROM ALQUILA a

                     GROUP BY DOCUMENTO

                     HAVING COUNT(DISTINCT a.ID) = (SELECT MAX(COUNT(DISTINCT a.ID))

                                                 FROM ALQUILA a

                                                 GROUP BY DOCUMENTO))

AND DOCUMENTO IN (SELECT C.DOCUMENTO

                   FROM CONTRATA c

                   INNER JOIN PROYECTO p ON c.NROPROYECTO = p.NROPROYECTO

                   WHERE p.FFINALIZACION > SYSDATE - 30)
```
## Consigna 9)
Obtener el nombre y la fecha de adquisición de los equipos que tuvieron la mayor cantidad de
alquileres. Además, dichos equipos deben haber sido alquilados por algún contacto que haya
contratado la menor cantidad de proyectos.
## Ejercicio 9) 
#### SQL
```
SELECT e.NOMBRE, e.FECHAADQUIRIDO

FROM EQUIPO e

WHERE e.ID IN(SELECT a.ID

                FROM ALQUILA a

                GROUP BY ID

                HAVING COUNT(*) = (SELECT MAX(COUNT(*))

                                     FROM ALQUILA

                                     GROUP BY ID))

AND e.ID IN (SELECT ID

             FROM ALQUILA a

             WHERE a.DOCUMENTO IN(SELECT DOCUMENTO

                                 FROM CONTRATA

                                 GROUP BY DOCUMENTO

                                 HAVING COUNT(*) = (SELECT MIN(COUNT(*))

                                                     FROM CONTRATA

                                                     GROUP BY DOCUMENTO)))
```
## Consigna 10)
Obtener para las categorías de equipo vial y construcción los contactos que alquilaron equipos
de dichas categorías y la cantidad total de alquileres que realizó dicho contacto para esa
categoría. Obtener el porcentaje que representa esta cantidad sobre el total de alquileres para
cada categoría solicitada. Además, obtener el nombre del proyecto en el cual se realizaron la
mayor cantidad de tareas dentro de cada categoría solicitada (si hay más de un proyecto con
la mayor cantidad de tareas, se deben listar todos ellos).
## Ejercicio 10)
#### SQL
```
SELECT distinct cantAlq.CAT, c.NOMBRE, cantAlq.CANT, round((cantAlq.CANT/total.CANT)*100, 2), p.NOMBRE
FROM
    (SELECT e.CATEGORIA as CAT, a.DOCUMENTO as DOC, COUNT(*) AS CANT
    FROM ALQUILA a
    INNER JOIN EQUIPO e ON e.ID = a.ID
    WHERE e.CATEGORIA = 'VIAL' OR e.CATEGORIA = 'CONSTRUCCION'
    GROUP BY a.DOCUMENTO, e.CATEGORIA) cantAlq,
   
    ((SELECT 'VIAL' as cat, count(*) as CANT
    FROM ALQUILA a
    INNER JOIN EQUIPO e ON e.ID = a.ID
    WHERE e.CATEGORIA = 'VIAL')
    UNION
    (SELECT 'CONSTRUCCION' as cat, count(*) as CANT
    FROM ALQUILA a
    INNER JOIN EQUIPO e ON e.ID = a.ID
    WHERE e.CATEGORIA = 'CONSTRUCCION')) total,
   
    ((SELECT distinct t.NROPROYECTO as nro, 'VIAL' as cat
   FROM TAREA t
   INNER JOIN PROYECTO p ON p.NROPROYECTO = t.NROPROYECTO
   INNER JOIN CONTRATA c ON c.NROPROYECTO = p.NROPROYECTO
   INNER JOIN ALQUILA a ON a.DOCUMENTO = c.DOCUMENTO
   INNER JOIN EQUIPO e ON e.ID = a.ID
   WHERE e.CATEGORIA = 'VIAL'
   GROUP BY t.NROPROYECTO
   HAVING COUNT(DISTINCT T.IDTAREA) = (SELECT MAX(COUNT(DISTINCT t.IDTAREA))
                                       FROM TAREA t
                                       INNER JOIN PROYECTO p ON p.NROPROYECTO = t.NROPROYECTO
                                       INNER JOIN CONTRATA c ON c.NROPROYECTO = p.NROPROYECTO
                                       INNER JOIN ALQUILA a ON a.DOCUMENTO = c.DOCUMENTO
                                       INNER JOIN EQUIPO e ON e.ID = a.ID
                                       WHERE e.CATEGORIA = 'VIAL'
                                       GROUP BY t.NROPROYECTO)
   UNION
   SELECT distinct t.NROPROYECTO as nro, 'CONSTRUCCION' as cat
   FROM TAREA t
   INNER JOIN PROYECTO p ON p.NROPROYECTO = t.NROPROYECTO
   INNER JOIN CONTRATA c ON c.NROPROYECTO = p.NROPROYECTO
   INNER JOIN ALQUILA a ON a.DOCUMENTO = c.DOCUMENTO
   INNER JOIN EQUIPO e ON e.ID = a.ID
   WHERE e.CATEGORIA = 'CONSTRUCCION'
   GROUP BY t.NROPROYECTO
   HAVING COUNT(DISTINCT T.IDTAREA) = (SELECT MAX(COUNT(DISTINCT t.IDTAREA))
                                       FROM TAREA t
                                       INNER JOIN PROYECTO p ON p.NROPROYECTO = t.NROPROYECTO
                                       INNER JOIN CONTRATA c ON c.NROPROYECTO = p.NROPROYECTO
                                       INNER JOIN ALQUILA a ON a.DOCUMENTO = c.DOCUMENTO
                                       INNER JOIN EQUIPO e ON e.ID = a.ID
                                       WHERE e.CATEGORIA = 'CONSTRUCCION'
                                       GROUP BY t.NROPROYECTO))) proyecto,
   
    CONTACTO c,
    PROYECTO p
   
WHERE cantAlq.CAT = total.CAT AND c.DOCUMENTO = cantAlq.DOC
AND cantAlq.CAT = proyecto.CAT AND p.NROPROYECTO = proyecto.nro
ORDER BY cantAlq.CAT DESC

```
