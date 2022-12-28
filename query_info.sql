-- sono coinvolte almeno 2 tabelle : si
/*si vedono tutti i team
si seleziona il desiderato e si visualizza gli anni selezionabili
viene visualizzato il nome del veicolo e i dati di motore, pneumatici e forse piloti che l'hanno guidata */

SELECT autovettura.nome,autovettura.squadra,autovettura.motore,autovettura.pneumatico,pilota.nome,pilota.cognome
FROM autovettura,partecipante,squadra,pilota
WHERE squadra.nome = 'Aston Martin' AND
autovettura.squadra = squadra.nome AND
autovettura.anno = 2022 AND
partecipante.vettura = autovettura.nome AND
partecipante.codice_fiscale = pilota.codice_fiscale;

/*premere i tasti per avere maggiori informazioni su ciascuno degli elementi mostrati*/

-- info squadra

WITH RECURSIVE nomi AS (
  SELECT s1.nome, s1.nome_precedente
  FROM squadra s1
  WHERE s1.nome = 'Aston Martin'
  UNION ALL
  SELECT s2.nome, s2.nome_precedente
  FROM nomi
  JOIN squadra s2 ON nomi.nome_precedente = s2.nome
)
SELECT nomi.nome FROM nomi;

-- info motore

SELECT motore.*
FROM motore,squadra,autovettura
WHERE squadra.nome = 'Aston Martin' AND
autovettura.squadra = squadra.nome AND
autovettura.anno = 2022 AND
autovettura.motore = motore.nome;

-- info pneumatico
SELECt pneumatico.*
FROM pneumatico,autovettura,squadra
WHERE squadra.nome = 'Aston Martin' AND
autovettura.squadra = squadra.nome AND
autovettura.anno = 2022 AND
autovettura.pneumatico = pneumatico.nome;