/*------------------------------------------------------------
*        Script SQLSERVER 
------------------------------------------------------------*/


/*------------------------------------------------------------
-- Table: EMPLOYE
------------------------------------------------------------*/
CREATE TABLE EMPLOYE(
	EMPCOD    INT  NOT NULL auto_increment,
	NOM       VARCHAR (20) NOT NULL ,
	JOBCODE   CHAR (4)   ,
	NIVEAU    CHAR (4)  NOT NULL ,
	TITRE     VARCHAR (30) NOT NULL ,
	SEX       CHAR (1)  NOT NULL CHECK (SEX = 'F' OR SEX = 'M'),
	DATENAISS DATETIME NOT NULL ,
	SALAIRE   INT  NOT NULL ,
	CODQUALIF CHAR (4)  NOT NULL ,
	UNITCOD   CHAR (4)  NOT NULL ,

	CONSTRAINT prk_constraint_EMPLOYE PRIMARY KEY NONCLUSTERED (EMPCOD)
);


/*------------------------------------------------------------
-- Table: QUALIF
------------------------------------------------------------*/
CREATE TABLE QUALIF(
	CODQUALIF CHAR (4)  NOT NULL ,
	QUALIBEL  VARCHAR (30) NOT NULL ,
	CONSTRAINT prk_constraint_QUALIF PRIMARY KEY NONCLUSTERED (CODQUALIF)
);


/*------------------------------------------------------------
-- Table: UNITE
------------------------------------------------------------*/
CREATE TABLE UNITE(
	UNITCOD   CHAR (4)  NOT NULL ,
	UNITE     VARCHAR (40) NOT NULL ,
	BUDGET    INT  NOT NULL ,
	UNITCOD_1 CHAR (4)  NULL ,
	CONSTRAINT prk_constraint_UNITE PRIMARY KEY NONCLUSTERED (UNITCOD)
);


/*------------------------------------------------------------
-- Table: EMPSQUAL
------------------------------------------------------------*/
CREATE TABLE EMPSQUAL(
	CODQUALIF CHAR (4)  NOT NULL ,
	EMPCOD    int  NOT NULL ,
	CONSTRAINT prk_constraint_EMPSQUAL PRIMARY KEY NONCLUSTERED (CODQUALIF,EMPCOD)
);


/*------------------------------------------------------------
-- Table: POSTES
------------------------------------------------------------*/
CREATE TABLE POSTES(
	NOMBRE      INT  NOT NULL CHECK(NOMBRE > 0 AND NOMBRE < 101),
	BUDGETPOSTE CHAR (5)  NOT NULL CHECK(BUDGETPOSTE > 0),
	CODQUALIF   CHAR (4)  NOT NULL ,
	UNITCOD     CHAR (4)  NOT NULL ,
	CONSTRAINT prk_constraint_POSTES PRIMARY KEY NONCLUSTERED (CODQUALIF,UNITCOD)
);


-- Contrainte de la base de donnée

-- Le code UNITE dans la table Employe doit exister dans la table UNITE
ALTER TABLE EMPLOYE ADD CONSTRAINT FK_EMPLOYE_UNITCOD FOREIGN KEY (UNITCOD) REFERENCES UNITE(UNITCOD);

-- Le code Qualif dans la table Employe doit exister dans la table QUALIF
ALTER TABLE EMPLOYE ADD CONSTRAINT FK_EMPLOYE_CODQUALIF FOREIGN KEY (CODQUALIF) REFERENCES QUALIF(CODQUALIF);


ALTER TABLE UNITE ADD CONSTRAINT FK_UNITE_UNITCOD_1 FOREIGN KEY (UNITCOD_1) REFERENCES UNITE(UNITCOD);

-- Le code EMPCOD dans la tabme EMPSQUAL doit exister dans la table EMPLOYE
ALTER TABLE EMPSQUAL ADD CONSTRAINT FK_EMPSQUAL_EMPCOD FOREIGN KEY (EMPCOD) REFERENCES EMPLOYE(EMPCOD);

-- Le code QUALIF dans la table EMPSQUAL doit exister dans la table QUALIF
ALTER TABLE EMPSQUAL ADD CONSTRAINT FK_EMPSQUAL_CODQUALIF FOREIGN KEY (CODQUALIF) REFERENCES QUALIF(CODQUALIF);


-- Le code UNITCOD dans la table POSTES doit exister dans la table UNITE
ALTER TABLE POSTES ADD CONSTRAINT FK_POSTES_UNITCOD FOREIGN KEY (UNITCOD) REFERENCES UNITE(UNITCOD);

-- Le code CODQUALIF dans la table POSTES doit exister dans la table QUALIF
ALTER TABLE POSTES ADD CONSTRAINT FK_POSTES_CODQUALIF FOREIGN KEY (CODQUALIF) REFERENCES QUALIF(CODQUALIF);

