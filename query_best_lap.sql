/*selezionata una pista ritorna informazioni su di essa, restituisce il giro più veloce in assoluto in gara e chi l'ha fatto e in quale macchina*/
SELECT circuito.nome,gara.anno,gara.hot_lap,pilota.nome,pilota.cognome,prestazione.vettura
FROM circuito,gara,pilota,prestazione
WHERE circuito.nome = 'Monza' AND
gara.nome_gara = circuito.nome AND
gara.pilota_veloce = pilota.codice_fiscale AND
gara.hot_lap = (SELECT MIN(gara.hot_lap) FROM gara WHERE gara.nome_gara = 'Monza') AND
gara.pilota_veloce = prestazione.codice_fiscale AND
gara.anno = prestazione.anno AND
gara.gara_num = prestazione.gara_num;
