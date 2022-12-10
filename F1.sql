-- da aggiungere le chiavi interne ed esterne e modificare eventuali parametri ridondanti
DROP TABLE IF EXISTS circuito;
DROP TABLE IF EXISTS squadra;
DROP TABLE IF EXISTS pilota;
DROP TABLE IF EXISTS motore;
DROP TABLE IF EXISTS pneumatico;
DROP TABLE IF EXISTS prestazione;
DROP TABLE IF EXISTS partecipante;
DROP TABLE IF EXISTS autovettura;
DROP TABLE IF EXISTS gara;

CREATE TABLE circuito(
    nome varchar(60),
    alias varchar(60),
    nazione varchar(2) NOT NULL,
    lunghezza int NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE squadra(
    nome varchar(40) NOT NULL,
    nazione varchar(2) NOT NULL,
    nome_precedente varchar(40),
    PRIMARY KEY(nome)
);

CREATE TABLE pilota(
    codice_fiscale varchar(20),
    nome varchar(20) NOT NULL,
    cognome varchar(20) NOT NULL,
    sesso varchar(1) NOT NULL,
    nazionalita varchar(2) NOT NULL,
    anno_nascita int NOT NULL,
    anno_morte int,
    sigla_in_gara varchar(3) NOT NULL,
    PRIMARY KEY(codice_fiscale)
);

CREATE TABLE motore(
    nome varchar(40),
    nazione varchar(2) NOT NULL,
    cilindrata int NOT NULL,
    tipologia VARCHAR(20),
    PRIMARY KEY(nome)
);

CREATE TABLE pneumatico(
    nome varchar(20),
    nazione varchar(2) NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE autovettura(
    nome varchar(40),
    squadra varchar(20),
    anno int NOT NULL,
    motore varchar(40) NOT NULL,
    pneumatico varchar(20) NOT NULL,
    PRIMARY KEY(nome,squadra),
    FOREIGN KEY(squadra)    REFERENCES squadra(nome),
    FOREIGN KEY(motore)     REFERENCES motore(nome),
    FOREIGN KEY(pneumatico) REFERENCES pneumatico(nome)
);

CREATE TABLE partecipante(
    codice_fiscale varchar(20),
    vettura VARCHAR(60),
    numero_in_gara int NOT NULL,
    PRIMARY KEY(codice_fiscale,vettura),
    FOREIGN KEY(codice_fiscale) REFERENCES pilota(codice_fiscale),
    FOREIGN KEY(vettura)        REFERENCES autovettura(nome)
);

CREATE TABLE prestazione( --entità DA AGGIUNGERE VETTURA :(
    anno int,
    gara_num int,
    codice_fiscale varchar(20),
    tempo_q1 time,
    tempo_q2 time,
    tempo_q3 time,
    posizione_arrivo int NOT NULL,
    ritiro varchar(1) NOT NULL,
    PRIMARY KEY(anno,gara_num,codice_fiscale),
    FOREIGN KEY(anno)           REFERENCES gara(anno),
    FOREIGN KEY(gara_num)       REFERENCES gara(gara_num),
    FOREIGN KEY(codice_fiscale) REFERENCES partecipante(codice_fiscale)
);

CREATE TABLE gara{
    anno int,
    gara_num int,
    nome_gara varchar(60) NOT NULL,
    pilota_del_giorno varchar(20) NOT NULL,
    pilota_veloce varchar(20) NOT NULL,
    hot_lap time NOT NULL,
    PRIMARY KEY(anno,gara_num),
    FOREIGN KEY(pilota_del_giorno) REFERENCES partecipante(codice_fiscale),
    FOREIGN KEY(pilota_veloce) REFERENCES partecipante(codice_fiscale),
    FOREIGN KEY(nome_gara) REFERENCES circuito(nome)
};

-- i punteggi, il punto bonus per giro veloce, la classifica e la composizione delle squadre in linea di massima penso che posso ricavarla.

/*drop table if exists "tempistiche";
create table tempistiche (tempo time);

insert into tempistiche(tempo)
values ('04:30.457');
        
select * from scientist
where tempo < '04:30.456';*/