/*selezionato un anno e il numero di gara stampa il nome della gara, la griglia di partenza*/
SELECT ROW_NUMBER() OVER (ORDER BY prestazione.tempo_q3,prestazione.tempo_q2,prestazione.tempo_q1) AS Posizione_Partenza,pilota.nome,pilota.cognome,pilota.sigla_in_gara,partecipante.numero_in_gara
FROM pilota,partecipante,prestazione,autovettura
WHERE prestazione.codice_fiscale = partecipante.codice_fiscale AND
	partecipante.vettura = prestazione.vettura AND
	partecipante.codice_fiscale = pilota.codice_fiscale AND
	prestazione.anno = 2022 AND
	prestazione.gara_num = 1 AND
	autovettura.anno = 2022 AND
	partecipante.vettura = autovettura.nome;