
--1
CREATE TABLE SPORTISTA
(
    ID NUMBER(5) CONSTRAINT SPORTISTA_PK PRIMARY KEY,
    IME VARCHAR(30) NOT NULL,
    PREZIME VARCHAR(30) NOT NULL,
    BROJ_TELEFONA CHAR(10),
    GOD_ROD NUMBER (4) NOT NULL,
    GRAD VARCHAR(25),
    PLATA NUMBER (7)
);

CREATE TABLE KLUB
(
    ID NUMBER(5) CONSTRAINT KLUB_PK PRIMARY KEY,
    NAZIV VARCHAR(25) NOT NULL,
    LOKACIJA VARCHAR(30),
    GOD_OSNIVANJA NUMBER(4),
    SPORT VARCHAR(20) NOT NULL
);

CREATE TABLE CLAN
(
    ID NUMBER(5) CONSTRAINT CLAN_PK PRIMARY KEY,
    ID_SPORTISTE NUMBER(5) CONSTRAINT SPORTISTA_FK REFERENCES SPORTISTA,
    ID_KLUBA NUMBER(5) CONSTRAINT KLUB_FK REFERENCES KLUB,
    DATUM_OD DATE NOT NULL,
    DATUM_DO DATE,
    TIM VARCHAR(30) CONSTRAINT TIM_CK CHECK (TIM='skola' OR TIM='prvi' OR TIM='mladi')
);

--2------------------------------------------------------------------------------------------------------------------

CREATE TABLE KOMPANIJA
(
    ID NUMBER(5) CONSTRAINT KOMPANIJA_PK PRIMARY KEY,
    NAZIV VARCHAR(30) NOT NULL,
    ULICA VARCHAR(30),
    BROJ VARCHAR(10),
    GRAD VARCHAR(30),
    POSTANSKI_BROJ CHAR(6),
    DRZAVA VARCHAR(20),
    PIB NUMBER(5)
);

CREATE TABLE FAKTURA
(
    ID NUMBER(5) CONSTRAINT FAKTURA_PK PRIMARY KEY,
    DATUM_PLACANJA DATE,
    DAT_KREIRANJA DATE,
    VALUTA VARCHAR(6) CONSTRAINT VALUTA_CK CHECK (VALUTA LIKE 'EUR' OR VALUTA LIKE 'RSD'),
    IZNOS NUMBER(7,2),
    POREZ NUMBER(7,2),
    KOMP_SALJE NUMBER(5) CONSTRAINT FAKT_KOMPANIJA_SALJE_FK REFERENCES KOMPANIJA,
    KOMP_PRIMA NUMBER(5) CONSTRAINT FAKT_KOMPANIJA_PRIMA_FK REFERENCES KOMPANIJA

);

CREATE TABLE STAVKA
(
    ID NUMBER(5) CONSTRAINT STAVKA_PK PRIMARY KEY,
    NAZIV VARCHAR(30),
    KOLICINA NUMBER(6),
    IZNOS NUMBER(7,2),
    POPUST NUMBER(3,2),
    POREZ NUMBER(7,2),
    FAKT_ID NUMBER(5) CONSTRAINT STAVKA_FAKTURA_FK REFERENCES FAKTURA(ID)
);


--3--------------------------------------------------------------------------

CREATE TABLE BIRACKO_MESTO
(
    ID NUMBER(5) CONSTRAINT BIRACKO_MESTO_PK PRIMARY KEY,
    OPSTINA VARCHAR(40) NOT NULL,
    R_BROJ NUMBER(6) NOT NULL,
    ADRESA VARCHAR(50) NOT NULL,
    UKUPNO_GLASACA NUMBER(8) NOT NULL,
    UKUPNO_LISTICA NUMBER(8) NOT NULL,
    VAZECI_LISTICI NUMBER(12),
    NEVAZECI_LISTICI NUMBER(12)
);

CREATE TABLE UCESNIK
(
    ID NUMBER(5) CONSTRAINT UCESNIK_PK PRIMARY KEY,
    NAZIV VARCHAR (25) NOT NULL,
    NOSILAC_LISTE (25),
    REDNI_BROJ NUMBER(2) NOT NULL
);

CREATE TABLE REZULTATI
(
    ID_BIRACKO_MESTO NUMBER(5) REFERENCES BIRACKO_MESTO(ID),
    ID_UCESNIK NUMBER(5) REFERENCES UCESNIK(ID),
    BROJ_GLASOVA NUMBER(10)
);

--4---------------------------------------------------------------------------

CREATE TABLE PISAC
(
    ID NUMBER(5) CONSTRAINT PISAC_PK PRIMARY KEY,
    IME VARCHAR(30) NOT NULL,
    PREZIME VARCHAR(30) NOT NULL,
    POL CHAR(1) CONSTRAINT POL_CK CHECK (POL='M' OR P='Z'),
    GOD_RODJ NUMBER(4) CONSTRAINT PISAC_CK CHECK (GOD_RODJ BETWEEN 1900 AND 2005)
);

CREATE TABLE KNJIGA
(
    ID NUMBER(5) CONSTRAINT KNJIGA_PK PRIMARY KEY,
    PISAC_ID NUMBER(5) REFERENCES PISAC(ID),
    NASLOV VARCHAR(25),
    GOD_PUBL NUMBER(4),
    BROJ_STR NUMBER(4),
    TIRAZ NUMBER(7),
    CENA NUMBER(4)
);

CREATE TABLE POGLAVLJE
(
    ID NUMBER(5) CONSTRAINT POGLAVLJE_PK PRIMARY KEY,
    ROD_POGL_ID NUMBER(5),
    KNJIGA_ID NUMBER(5),
    BROJ_RECI NUMBER(8),
    BROJ_SLIKA NUMBER(6),
    BROJ_TABELA NUMBER(3)
    CONSTRAINT POGLAVLJE_POGLAVLJE_FK FOREIGN KEY (POGLAVLJE) REFERENCES POGLAVLJE(ID),
    CONSTRAINT POGLAVLJE_KNJIGA_ID FOREIGN KEY (KNJIGA) REFERENCES KNJIGA(ID)


);


