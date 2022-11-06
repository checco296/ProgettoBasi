# F1 DB

# Abstract
La Formula 1 (F1), è la massima categoria di vetture monoposto a ruote scoperte da corsa su circuito definita dalla Federazione Internazionale dell'Automobile (FIA). 
Si è sviluppato una base di dati contenente uno storico di tutti i piloti, auto, circuiti e i risultati delle varie stagioni.
Questi dati servono per la consultazione all'interno del sito ufficiale nel quale i tifosi potranno vedere i risultati della stagione in corso e di quelle passate.
Ogni stagione è composta da un numero deciso dalla FIA di weekend di gara, un weekend di gara è composto da prove libere, qualifiche e infine gara.
Il pilota che a fine stagione ha più punti diventa il campione, stesso vale per la scuderia con più punti.

# Analisi dei requisiti
Il progetto per ovvi motivi logistici non prenderà in considerazione i risultati di tutti i gran premi dal 1950, bensì dal XXXX(Da definire)

Ogni stagione di F1 è caratterizzata da un calendario e dai partecipanti,

Il calendario contiene informazioni riguardo l'anno di svolgimento e l'ordine con il quale si disputano le varie gare

Ogni gara si disputa su un circuito il quale è caratterizzato dal suo nome/alias dalla nazione e dalla lunghezza

Ogni weekend di gara si suddivide in più sessioni: 3 prove libere dove i piloti provano la pista e varie strategie, 3 sessioni di qualifiche nei quali i piloti cercano di segnare il giro più veloce in modo da garantirsi una posizione di partenza favorevole, infine vi è la gara nella quale alla partenza si somma alla posizione eventuali penalità rimediate, alla fine della gara si stila una graduatoria di arrivo, inoltre si registrano il giro più veloce e il pilota che secondo i tifosi è stato il più meritevole

Ogni partecipante è un pilota che gareggia per conto di una squadra in una vettura

Ogni pilota è caratterizzato da dei connotati(nome,cognome, sesso,nazionalità...) e dalla sigla in gara e dal numero in gara, Per regolamento non si possono avere storicamente due piloti con la medesima sigla e numero.

Ogni squadra è caratterizzata dal paese di appartenenza e dall'eventuale nome precedente della medesima scuderia.

Ogni autovettura è caratterizzata dall'anno di utilizzo, la squadra che la utilizzava e dal motore e pneumatici montati.

Ogni motore è caratterizzato dal nome, nazione di produzione, cilindrata e tipologia

Ogni pneumatico è caratterizzato dal nome e dalla nazione dell'azienda produttrice.

























Realizzazione di una base di dati rappresentanti il campionato mondiale di F1 negli anni(anno di partenza da definire) prima di quella data non c’era il campionato costruttori.
Ogni stagione di F1 è caratterizzata da: Piloti in gara, Team partecipanti, circuiti del calendario, vincitore piloti, vincitore costruttori
I circuiti sono scelti dalla federazione da un insieme di piste sparse in tutto il mondo, ogni nazione può contenere più di una pista o nessuna.
I piloti vengono assunti dai vari team a inizio stagione ogni scuderia ha 2 piloti “guidanti” e un numero variabile di piloti di riserva, ogni pilota ha i propri dati anagrafici, il numero pilota
I Team sono un numero variabile, ogni team compete con 2 vetture, è guidato da un team principal ed appartiene ad una determinata nazione
Ogni anno il pilota che conclude le gare del calendario con più punti si aggiudica il titolo di campione del mondo piloti
Ogni anno il team che conclude le gare del calendario con più punti si aggiudica il titolo di campione del campionato mondiale dei costruttori




weekend:
-dove
-anno
-classifica libere (libere 1-2-3) (tabella assestante penso)
-classifica qualifiche (1-2-3) (tabella assestante penso)
-soste e gomme (idem)
-dnf
-giro veloce
-arrivo e punteggio (idem)


+weekend costituiscono una stagione

stagione:
-anno
-piste
-classifica piloti
-classifica costruttori


pilota:
-nome
-cognome
-sesso
-data nascita
-nazionalità
-gp vinti
-punti in carriera
-volte sul podio
-giri veloci
-mondiali vinti

scuderia:
-nome
-sponsor
-nazione
-piloti
-riserve
-giri veloci
-mondiali costruttori vinti

auto:
-nome
-scuderia
-anno
-potenza
-vittorie
-dnf


biglietti venduti
-uomo
-donna ? really?
-bambini 
-prezzo uomo
-prezzo donna?
-prezzo bambini

 ----------------------------------------------------------------------


Campionato:
-Anno
