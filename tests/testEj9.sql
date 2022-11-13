--correr script de creacion de tablas previo a cualquier test

/*Test case ej9.
  Debería devolver:
  E4 - 01/01/2022
*/

--insert contactos

INSERT INTO CONTACTO VALUES ('52682880','HUGO@GMAIL.COM','HUGO',095911940,'CLIENTE');
INSERT INTO CONTACTO VALUES ('57345671','MIGUEL@GMAIL.COM','MIGUEL',092944156,'INGENIERO');
INSERT INTO CONTACTO VALUES ('52846994','ANA@GMAIL.COM','ANA',099972723,'TECNICO');

--insert equipos

INSERT INTO EQUIPO VALUES (1,'E1','SERVICE','01/01/2022','VIAL');
INSERT INTO EQUIPO VALUES (2,'E2','SERVICE','01/01/2022','VIAL');
INSERT INTO EQUIPO VALUES (3,'E3','SERVICE','01/01/2020','VIAL');
INSERT INTO EQUIPO VALUES (4,'E4','REPARACION','01/01/2022','CONSTRUCCION');

--insert proyectos

INSERT INTO PROYECTO VALUES (1,'N1','D1','01/01/2020');
INSERT INTO PROYECTO VALUES (2,'N2','D2',NULL);
INSERT INTO PROYECTO VALUES (3,'N3','D3','01/01/2020');
INSERT INTO PROYECTO VALUES (4,'N4','D4','01/01/2021');
INSERT INTO PROYECTO VALUES (5,'N5','D5','01/01/2022');


--insert contrata (Ana contacto con menos proyectos contratados)

INSERT INTO CONTRATA VALUES (1,'52682880');
INSERT INTO CONTRATA VALUES (2,'52682880');
INSERT INTO CONTRATA VALUES (3,'57345671');
INSERT INTO CONTRATA VALUES (4,'57345671');
INSERT INTO CONTRATA VALUES (5,'52846994');

--insert alquila

--alquileres Equipo 1 todos los contactos (Ana incluida - 3 alquileres)
INSERT INTO ALQUILA VALUES (1,'52682880','01/09/2022','10/09/2022');
INSERT INTO ALQUILA VALUES (1,'57345671','01/09/2022','10/09/2022');
INSERT INTO ALQUILA VALUES (1,'52846994','01/09/2022','10/09/2022');

--alquileres Equipo 2 algunos contactos (Ana no incluida - 2 alquileres)
INSERT INTO ALQUILA VALUES (2,'52682880','01/09/2022','10/09/2022');
INSERT INTO ALQUILA VALUES (2,'57345671','01/09/2022','10/09/2022');

--alquileres Equipo 3 algunos contactos (Ana no incluida - 4 alquileres) 
INSERT INTO ALQUILA VALUES (3,'52682880','01/09/2022','10/09/2022');
INSERT INTO ALQUILA VALUES (3,'57345671','01/09/2022','10/09/2022');
INSERT INTO ALQUILA VALUES (3,'57345671','01/10/2022','10/12/2022');
INSERT INTO ALQUILA VALUES (3,'57345671','01/10/2020','10/09/2021');

--alquileres Equipo 4 algunos contactos (Ana incluida - 4 alquileres) 
INSERT INTO ALQUILA VALUES (4,'52682880','01/09/2022','10/09/2022');
INSERT INTO ALQUILA VALUES (4,'52846994','01/09/2022','10/09/2022');
INSERT INTO ALQUILA VALUES (4,'52846994','01/09/2021','11/09/2021');
INSERT INTO ALQUILA VALUES (4,'52846994','01/11/2022','10/12/2022');