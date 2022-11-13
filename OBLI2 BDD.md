
`											`**Universidad ORT Uruguay**



**Facultad de Ingeniería**



**Bernard Wand Polak**




**Base de Datos 1** 

**Obligatorio 2**











**Santiago Cabrera Nro. 266191** 

**Pablo Durán Nro. 270956** 

**Mateo Giraz Nro. 241195**



**Grupo M4A** 

**Docente: Leticia Pintos** 

**ÍNDICE**

[**Ejercicio 1)](#_rm3s1osgmos2)	**3****

[AR](#_xo1pz4q6oytp)	3

[SQL](#_g8195hjs17ci)	3

[**Ejercicio 2)](#_opmb289d1p6g)	**3****

[AR](#_tvjs7gug4un9)	3

[SQL](#_cgpuyi8os3yq)	3

[**Ejercicio 3)](#_pkk6hycf0bla)	**4****

[AR](#_dmr9nu1obary)	4

[SQL](#_kgygcyo0jvta)	4

[**Ejercicio 4)](#_s4lv71ry3izv)	**5****

[AR](#_u2u9mxv1fugc)	5

[SQL](#_b7swe06yjenl)	5

[**Ejercicio 5)](#_fk2wnwvf2upd)	**5****

[AR](#_a2tmkljiio3s)	5

[CRT](#_xzynj24urxm3)	5

[SQL](#_qn3rughs4x7k)	6

[**Ejercicio 6) HAY QUE TESTEAR](#_i4kvzzm7ttiz)	**6****

[SQL](#_55kl70ifihgq)	6

[**Ejercicio 7) HAY QUE TESTEAR](#_itychmsvw0bl)	**6****

[SQL](#_di2tkmk1d2ga)	6

[**Ejercicio 8) HAY QUE TESTEAR](#_vx62vyxnewsg)	**7****

[SQL](#_bzmnpukq5qny)	7

[**Ejercicio 9) HAY QUE TESTEAR](#_mrpc0vij5c4r)	**7****

[SQL](#_kscep41vzkv1)	7





## Ejercicio 1)
#### AR
EquipoVial ← σ e.Categoria = ‘Vial’ (ρ (EQUIPO) e)

AlquilerJunio ← σ a.FInicio >= ‘01/06/2022’ ∧  a.FInicio <= ‘30/06/2022’ (ρ (ALQUILA) a)

Documento ← π Documento (EquipoVial \* AlquilerJunio)

π Nombre (Documento \* CONTACTO)
#### SQL
SELECT DISTINCT c.NOMBRE

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON a.DOCUMENTO = c.DOCUMENTO

WHERE e.CATEGORIA = 'VIAL' AND

a.FINICIO BETWEEN '01/06/2022' AND '30/06/2022'

## Ejercicio 2)
#### AR
EquipoVial ← σ e.Categoria = ‘Vial’ (ρ (EQUIPO) e)

EquipoConstruccion ← σ e.Categoria = ‘Construccion’ (ρ (EQUIPO) e)

AlquierQuincena ← σ a.FInicio >= ‘01/09/2022’ ∧  a.FFIN <= ‘15/09/2022’ (ρ (ALQUILA) a)

DocVial ← π Documento (EquipoVial \* AlquierQuincena)

DocConstruccion ← π Documento (EquipoConstruccion \* AlquierQuincena)

DocFinal ← (DocVial ∪ DocConstruccion) - (DocVial ∩ DocConstruccion)

π Nombre, Telefono, Tipo (DocFinal \* CONTACTO)
#### SQL
SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON c.DOCUMENTO = a.DOCUMENTO

WHERE (e.CATEGORIA = 'VIAL' OR e.CATEGORIA = 'CONSTRUCCION')

AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022'

MINUS

(SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON c.DOCUMENTO = a.DOCUMENTO

WHERE e.CATEGORIA = 'VIAL'

AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022'

INTERSECT

SELECT DISTINCT c.NOMBRE, c.TELEFONO, c.TIPO

FROM ALQUILA a

INNER JOIN EQUIPO e ON e.ID = a.ID

INNER JOIN CONTACTO c ON c.DOCUMENTO = a.DOCUMENTO

WHERE e.CATEGORIA = 'CONSTRUCCION'

AND a.FINICIO >= '01/09/2022' AND a.FFIN <= '15/09/2022')

## Ejercicio 3)
#### AR
TareasH ← π Descripcion, FRealizacion (TAREA \* (σ p.Nombre = ‘Renovación hidráulica’  (ρ (PROYECTO) p)))

TareasNuevas ← π t1.Descripcion, t1.FRealizacion(ρ (TareasH) t1) |x| σ t1.FRealizacion > t2.FRealizacion (ρ (TareasH) t2)

TareasH - TareasNuevas
#### SQL
SELECT FREALIZACION, DESCRIPCION

FROM TAREA

WHERE FREALIZACION in(SELECT MIN(FREALIZACION)

`                   `FROM TAREA t

`                   `INNER JOIN PROYECTO p ON t.NROPROYECTO = p.NROPROYECTO

`                   `WHERE p.NOMBRE = 'RENOVACION HIDRAULICA')

## Ejercicio 4)
#### AR
DocRecurrente ← π Documento, NroProy (ρ (Contrata) c1) |x| σ c1.Documento == c2.Documento ∧ c1.NroProy != c2.NroProy (ρ (Contrata) c2)

Contratados ← π Documento, NroProy (ρ (DocRecurrente) d) |x| d.NroProy == p.NroProy ∧ p.FFinalizacion == NULL (ρ (Proyecto) t2)

Res ← π Documento, NroProy, Nombre (Contratados \* Contacto)
#### SQL
SELECT DISTINCT c.NOMBRE, c1.DOCUMENTO, c1.NROPROYECTO

FROM CONTRATA c1

INNER JOIN CONTACTO c ON c1.DOCUMENTO = c.DOCUMENTO

INNER JOIN CONTRATA c2 ON c1.DOCUMENTO = c2.DOCUMENTO AND c1.NROPROYECTO != c2.NROPROYECTO

INNER JOIN PROYECTO p ON p.NROPROYECTO = c1.NROPROYECTO

INNER JOIN PROYECTO p2 ON c2.NROPROYECTO = p2.NROPROYECTO

WHERE p.FFINALIZACION is null AND p2.FFINALIZACION is null

## Ejercicio 5)
#### AR
EquiposService2022 ←π Id (σ e.Estado = ‘Service’ ∧ e.FechaAdquirido >= ‘01/01/2022’ ∧  e.FechaAdquirido <= ‘31/12/2022’ (ρ (EQUIPO) e))

R ← π Documento, Id (ALQUILA \* EquiposService2022)

S ← π Documento (ρ (CONTACTO) e))

R%S
#### CRT

{ t.Id / Equipo(t) and t.Estado = 'Service' and t.FechaAdquirido < ‘01/01/2022’ and t.FechaAdquirido > ‘31/12/2022’ and                                                                                           (∀u) (Contacto(u) → (∃v) (Alquiler(v) and v.Id = t.Id and v.Documento = u.Documento) )           and (∃q)(Contacto(q) ) }
#### SQL
SELECT e.ID

FROM EQUIPO e

WHERE e.ESTADO = 'SERVICE' AND e.FECHAADQUIRIDO BETWEEN '01/01/2022' AND '31/12/2022'

AND NOT EXISTS(SELECT 1

`              `FROM CONTACTO c

`              `WHERE NOT EXISTS(SELECT 1

`                               `FROM ALQUILA a

`                               `WHERE a.DOCUMENTO = c.DOCUMENTO

`                               `AND a.ID = e.ID))

AND EXISTS(SELECT 1

`          `FROM CONTACTO)

## Ejercicio 6)
#### SQL
SELECT p.NOMBRE, t.IDTAREA, t.DESCRIPCION,

NVL(TO\_CHAR(t.FREALIZACION), 'Pendiente de realización')

FROM TAREA t

INNER JOIN PROYECTO p ON t.NROPROYECTO = p.NROPROYECTO

WHERE p.NROPROYECTO IN (SELECT NROPROYECTO

`                        `FROM TAREA

`                        `GROUP BY NROPROYECTO

`                        `HAVING COUNT(\*) >= 3)

## Ejercicio 7) 
#### SQL
SELECT a.DOCUMENTO, COUNT(\*)

FROM ALQUILA a

INNER JOIN CONTACTO c ON a.DOCUMENTO = c.DOCUMENTO

INNER JOIN EQUIPO e ON e.ID = a.ID

WHERE c.TIPO = 'INGENIERO' AND

(e.CATEGORIA = 'CONSTRUCCION' OR e.CATEGORIA = 'TERRENO')

GROUP BY a.DOCUMENTO

## Ejercicio 8)
#### SQL
SELECT DOCUMENTO, NOMBRE

FROM CONTACTO

WHERE DOCUMENTO IN (SELECT DOCUMENTO

`                   `FROM ALQUILA a

`                   `GROUP BY DOCUMENTO

`                   `HAVING COUNT(DISTINCT a.ID) = (SELECT MAX(COUNT(DISTINCT a.ID))

`                                                `FROM ALQUILA a

`                                                `GROUP BY DOCUMENTO))

AND DOCUMENTO IN (SELECT C.DOCUMENTO

`                  `FROM CONTRATA c

`                  `INNER JOIN PROYECTO p ON c.NROPROYECTO = p.NROPROYECTO

`                  `WHERE p.FFINALIZACION > SYSDATE - 30)

## Ejercicio 9) 
#### SQL
SELECT e.NOMBRE, e.FECHAADQUIRIDO

FROM EQUIPO e

WHERE e.ID IN(SELECT a.ID

`              `FROM ALQUILA a

`              `GROUP BY ID

`              `HAVING COUNT(\*) = (SELECT MAX(COUNT(\*))

`                                   `FROM ALQUILA

`                                   `GROUP BY ID))

AND e.ID IN (SELECT ID

`            `FROM ALQUILA a

`            `WHERE a.DOCUMENTO IN(SELECT DOCUMENTO

`                                `FROM CONTRATA

`                                `GROUP BY DOCUMENTO

`                                `HAVING COUNT(\*) = (SELECT MIN(COUNT(\*))

`                                                    `FROM CONTRATA

`                                                    `GROUP BY DOCUMENTO)))







8
