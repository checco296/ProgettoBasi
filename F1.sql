DROP TABLE  IF EXISTS circuito CASCADE;
DROP TABLE IF EXISTS squadra CASCADE;
DROP TABLE IF EXISTS pilota CASCADE;
DROP TABLE IF EXISTS motore CASCADE;
DROP TABLE IF EXISTS pneumatico CASCADE;
DROP TABLE IF EXISTS prestazione CASCADE;
DROP TABLE IF EXISTS partecipante CASCADE;
DROP TABLE IF EXISTS autovettura CASCADE;
DROP TABLE IF EXISTS gara CASCADE;

CREATE TABLE circuito(
    nome varchar(60),
    alias varchar(60) NOT NULL,
    nazione varchar(2) NOT NULL,
    lunghezza int NOT NULL,
    PRIMARY KEY(nome)
);

CREATE TABLE squadra(
    nome varchar(40),
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
    nome varchar(60),
    squadra varchar(40) NOT NULL,
    anno int NOT NULL,
    motore varchar(40) NOT NULL,
    pneumatico varchar(20) NOT NULL,
    PRIMARY KEY(nome/*,squadra*/),
    FOREIGN KEY(squadra)    REFERENCES squadra(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(motore)     REFERENCES motore(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(pneumatico) REFERENCES pneumatico(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE partecipante(
    codice_fiscale varchar(20),
    vettura varchar(60),
    numero_in_gara int,
    PRIMARY KEY(codice_fiscale,vettura),
    FOREIGN KEY(codice_fiscale) REFERENCES pilota(codice_fiscale)  ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(vettura)        REFERENCES autovettura(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE gara(
    anno int,
    gara_num int,
    nome_gara varchar(60) NOT NULL,
    pilota_del_giorno varchar(20) NOT NULL,
    pilota_veloce varchar(20) NOT NULL,
    hot_lap time NOT NULL,
    PRIMARY KEY(anno,gara_num),
    FOREIGN KEY(pilota_del_giorno) REFERENCES /*partecipante*/pilota(codice_fiscale) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(pilota_veloce) REFERENCES /*partecipante*/pilota(codice_fiscale) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(nome_gara) REFERENCES circuito(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE prestazione(
    anno int,
    gara_num int,
    codice_fiscale varchar(20),
    vettura varchar(60),
    tempo_q1 time,
    tempo_q2 time,
    tempo_q3 time,
    posizione_arrivo int NOT NULL,
    ritiro varchar(1) NOT NULL,
    PRIMARY KEY(anno,gara_num,vettura,codice_fiscale),
    FOREIGN KEY(anno,gara_num)              REFERENCES gara(anno,gara_num) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(vettura,codice_fiscale)     REFERENCES partecipante(vettura,codice_fiscale) ON UPDATE CASCADE ON DELETE CASCADE,
);



-- i punteggi, il punto bonus per giro veloce, la classifica e la composizione delle squadre in linea di massima penso che posso ricavarla.

/*drop table if exists "tempistiche";
create table tempistiche (tempo time);

insert into tempistiche(tempo)
values ('04:30.457');
        
select * from scientist
where tempo < '04:30.456';*/

/*SELECT pilota.nome, pilota.cognome, prestazione.anno,prestazione.posizione_arrivo
FROM pilota,partecipante,prestazione,gara,circuito
WHERE prestazione.posizione_arrivo = 1 AND prestazione.anno = gara.anno AND prestazione.gara_num = gara.gara_num 
		AND gara.nome_gara = circuito.nome AND circuito.nome = 'Sochi'
		AND prestazione.codice_fiscale = partecipante.codice_fiscale AND prestazione.vettura = partecipante.vettura 
		AND pilota.codice_fiscale = partecipante.codice_fiscale
*/
