
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
    TIM VARCHAR(30)
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
