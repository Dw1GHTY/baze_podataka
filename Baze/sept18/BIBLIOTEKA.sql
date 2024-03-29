CREATE TABLE PISAC
(
    ID NUMBER(5) CONSTRAINT PISAC_PK PRIMARY KEY,
    IME VARCHAR(30),
    PREZIME VARCHAR(30),
    POL CHAR(1) CONSTRAINT POL_CK CHECK (POL = 'M' OR POL = 'Z'), 
    GOD_RODJENJA NUMBER(4)
);


CREATE TABLE KNJIGA
(
    ID NUMBER(5) CONSTRAINT KNJIGA_CK PRIMARY KEY,
    PISAC_ID NUMBER(5) REFERENCES PISAC(ID),
    NASLOV VARCHAR(60) NOT NULL,
    GOD_PUBL NUMBER(4) NOT NULL,
    BROJ_STR NUMBER(4),
    TIRAZ NUMBER(10),
    CENA NUMBER(6)
);


CREATE TABLE POGLAVLJE
(
    ID NUMBER(5) CONSTRAINT POGLAVLJE_PK PRIMARY KEY,
    ROD_POGL_ID REFERENCES POGLAVLJE(ID),
    KNJIGA_ID REFERENCES KNJIGA(ID),
    BROJ_RECI NUMBER(10),
    BROJ_SLIKA NUMBER(5),
    BROJ_TABELA NUMBER(5)
);
            
            