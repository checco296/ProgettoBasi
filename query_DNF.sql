-- coinvolge almeno 2 tabelle: si
-- usa il group by: si
-- usa having
/*query che in base all'anno restituisce tutti i piloti che hanno avuto almeno 5 DNF*/
SELECT pilota.nome,pilota.cognome, COUNT(*) AS ritiri_stagionali
FROM prestazione,partecipante,pilota
WHERE prestazione.anno = 2022 AND
	prestazione.ritiro = 'Y' AND 
	prestazione.codice_fiscale = partecipante.codice_fiscale AND
	prestazione.vettura = partecipante.vettura AND
	partecipante.codice_fiscale = pilota.codice_fiscale
GROUP BY pilota.codice_fiscale
HAVING COUNT(*) >= 5
ORDER BY ritiri_stagionali DESC;