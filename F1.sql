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
    nome_precedente varchar(20) NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE pilota(
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    sesso varchar(1) NOT NULL,
    nazionalita varchar(2) NOT NULL,
    anno_nascita int NOT NULL,
    anno_morte int,
    numero_in_gara int NOT NULL,
    sigla_in_gara varchar(3) NOT NULL,
    PRIMARY KEY(sigla_in_gara,numero_in_gara)
);

CREATE TABLE motore(
    nome varchar(20) NOT NULL,
    nazione varchar(2) NOT NULL,
    cilindrata int NOT NULL,
    tipologia VARCHAR(20),
    PRIMARY KEY(nome)
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

CREATE TABLE partecipante(
    sigla_in_gara varchar(3) NOT NULL,
    numero_in_gara int NOT NULL,
    vettura VARCHAR(20) NOT NULL,
    PRIMARY KEY(sigla_in_gara,vettura)
);

CREATE TABLE autovetture(
    anno int NOT NULL,
    nome varchar(20) NOT NULL,
    squadra varchar(20) NOT NULL,
    motore varchar(20) NOT NULL,
    pneumatico varchar(20) NOT NULL,
    PRIMARY KEY(anno,squadra)
);

CREATE TABLE weekend_di_gara(
    anno int NOT NULL,
    gara_num int NOT NULL,
    sigla_in_gara varchar(3) NOT NULL,
    numero_in_gara int NOT NULL,
    posizione_fp1 int, --da verificare
    tempo_fp1 int,
    posizione_fp2 int, --da verificare
    tempo_fp2 int,
    posizione_fp3 int, --da verificare
    tempo_fp3 int,
    posizione int NOT NULL,
    tempo_q1 int,
    tempo_q2 int,
    tempo_q3 int,
    posizione_arrivo int NOT NULL,
    penalita_partenza int NOT NULL,
    punti int NOT NULL, --da rivedere penso non serva perchè il sistema è sempre quello fatta eccezioni i casi di gara finita troppo presto
    ritiro int NOT NULL,
);

CREATE TABLE pilota_del_giorno(  --vedere se fare il merge anche di questi due
    anno int NOT NULL,
    gara_num int NOT NULL, 
    numero_in_gara int, 
    percentuale int,
    PRIMARY KEY(/*da definire*/)
);

CREATE TABLE giro_veloce(
    anno int NOT NULL,
    gara_num int NOT NULL,
    numero_in_gara int, 
    tempo int,
    PRIMARY KEY(/*da definire*/)
);

-- i punteggi, il punto bonus per giro veloce, la classifica e la composizione delle squadre in linea di massima penso che posso ricavarla.


-- https://it.wikipedia.org/wiki/Motori_di_Formula_1