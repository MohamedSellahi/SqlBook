/* List qualifications  */
select *
from gesperso.qualif
;


/* Creer la table unité */
INSERT INTO gesperso.unite
VALUES("CEOS","Direction",10000,null)
;

INSERT INTO `gesperso`.`unite`(`UNITE`,`UNITCOD`,`BUDGET`,`UNITCOD_1`)
VALUES("unité d'investissement","INVE",5000,null);

INSERT INTO gesperso.unite
VALUES("FAB","unité de Fabrication",10000,null);

INSERT INTO gesperso.unite
VALUES("DEVL","unité de Recherche et dev",1000,null);

insert into gesperso.unite
values("MONT","unité de montage",1000,"FAB");

insert into gesperso.unite
values("SECU","unité de sécurité",500,null);


/* Insert some postes */
/* CEO */
INSERT INTO gesperso.postes
VALUES(1,1000,"DIRC","CEOS");

/* TECHOS*/
INSERT INTO gesperso.postes
VALUES(10,100,"TECH","MONT");

/* ENG */
INSERT INTO gesperso.postes
VALUES
(5,1000,"INGE","DEVL");

/* ENG */
INSERT INTO gesperso.postes
VALUES
(5,1000,"AGSC","DEVL");

INSERT INTO gesperso.postes
VALUES
(2,200,"AGSC","SECU");

























