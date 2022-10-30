-- da aggiungere le chiavi interne ed esterne e modificare eventuali parametri ridondanti

CREATE TABLE circuito(
    nome varchar(20) NOT NULL,
    alias varchar(20),
    nazione varchar(2) NOT NULL,
    lunghezza int NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE squadra(
    nome varchar(20) NOT NULL,
    nazione varchar(2) NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE motore( --non so se serva
    nome varchar(20) NOT NULL,
    nazione varchar(2) NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE nazione( --non so se serve
    nome varchar(20) NOT NULL,
    PRIMARY KEY(nome)
)

CREATE TABLE pilota(
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    sesso varchar(1) NOT NULL,
    nazionalita varchar(2) NOT NULL,
    anno_nascita int NOT NULL,
    anno_morte int,    --dipende da che anno inizio!
    numero_in_gara int NOT NULL,
    sigla_in_gara varchar(3) NOT NULL,
    PRIMARY KEY(nome,cognome,anno_nascita)
);

CREATE TABLE pneumatico(
    nome varchar(20) NOT NULL,
    nazione varchar(2) NOT NULL,
    PRIMARY KEY(nome)
);


-- STAGIONE

CREATE TABLE calendario(
    anno int NOT NULL,
    gara_num int NOT NULL,
    nome_gara varchar(20) NOT NULL,
    PRIMARY KEY(anno,gara_num)
);

CREATE TABLE pilota_del_giorno(
    anno int NOT NULL,
    gara_num int NOT NULL, --da vedere se va bene
    nome varchar(20), --non metto NOT NULL per casi come il belgio
    cognome varchar(20),
    numero_in_gara int, --forse non serve
    percentuale int,
    PRIMARY KEY(/*da definire*/)
);

CREATE TABLE giro_veloce(
    anno int NOT NULL,
    gara_num int NOT NULL,
    nome varchar(20), --da definire se ci va NOT NULL
    cognome varchar(20),
    numero_in_gara int, --forse non serve
    tempo int,
    PRIMARY KEY(/*da definire*/)
);

CREATE TABLE prove_libere_1( --vedere se tenerla o se compattarlo in una
    anno int NOT NULL,
    gara_num int NOT NULL,
    numero_in_gara int, --da verificare
    posizione int, --da verificare
    tempo int,
);

CREATE TABLE prove_libere_2( --vedere se tenerla
    anno int NOT NULL,
    gara_num int NOT NULL,
    numero_in_gara int, --da verificare
    posizione int, --da verificare
    tempo int,
);

CREATE TABLE prove_libere_3( --vedere se tenerla
    anno int NOT NULL,
    gara_num int NOT NULL,
    numero_in_gara int, --da verificare
    posizione int, --da verificare
    tempo int,
);

CREATE TABLE qualifiche(
    anno int NOT NULL,
    gara_num int NOT NULL,
    numero_in_gara int,
    posizione int NOT NULL,
    tempo_q1 int,
    tempo_q2 int,
    tempo_q3 int,
    PRIMARY KEY(anno,gara_num,numero_in_gara)
);

CREATE TABLE gara(
    anno int NOT NULL,
    gara_num INT NOT NULL,
    numero_in_gara int,
    posizione_arrivo int NOT NULL,
    penalita_partenza int NOT NULL,
    punti int NOT NULL, --da rivedere penso non serva perchè il sistema è sempre quello fatta eccezioni i casi di gara finita troppo presto
    ritiro int NOT NULL,
);

-- i punteggi, il punto bonus per giro veloce, la classifica e la composizione delle squadre in linea di massima penso che posso ricavarla.