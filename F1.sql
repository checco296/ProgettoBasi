-- da aggiungere le chiavi interne ed esterne e modificare eventuali parametri ridondanti
DROP TABLE IF EXISTS circuito;
DROP TABLE IF EXISTS squadra;
DROP TABLE IF EXISTS pilota;
DROP TABLE IF EXISTS motore;
DROP TABLE IF EXISTS pneumatico;
DROP TABLE IF EXISTS calendario;
DROP TABLE IF EXISTS partecipante;
DROP TABLE IF EXISTS autovetture;
DROP TABLE IF EXISTS weekend_di_gara;
DROP TABLE IF EXISTS pilota_del_giorno;
DROP TABLE IF EXISTS giro_veloce;

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
    tempo_q1 int,
    tempo_q2 int,
    tempo_q3 int,
    posizione_arrivo int NOT NULL,
    ritiro varchar(1) NOT NULL,
    pilota_del_giorno varchar(1) NOT NULL,
    giro_veloce int
);

-- i punteggi, il punto bonus per giro veloce, la classifica e la composizione delle squadre in linea di massima penso che posso ricavarla.

/*drop table if exists "tempistiche";
create table tempistiche (tempo time);

insert into tempistiche(tempo)
values ('04:30.457');
        
select * from scientist
where tempo < '04:30.456';*/