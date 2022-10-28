# F1 DB

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


