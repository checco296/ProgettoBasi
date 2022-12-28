-- coinvolge almeno 2 tabelle: si
-- usa il group by: si
SELECT pilota.nome,pilota.cognome, SUM(punti_gara.punti) as punti_totali
FROM(
  SELECT prestazione.codice_fiscale,
  	prestazione.posizione_arrivo,
    CASE 
      WHEN prestazione.posizione_arrivo = 1 THEN 25
      WHEN prestazione.posizione_arrivo = 2 THEN 18
      WHEN prestazione.posizione_arrivo = 3 THEN 15
      WHEN prestazione.posizione_arrivo = 4 THEN 12
      WHEN prestazione.posizione_arrivo = 5 THEN 10
      WHEN prestazione.posizione_arrivo = 6 THEN 8
      WHEN prestazione.posizione_arrivo = 7 THEN 6
      WHEN prestazione.posizione_arrivo = 8 THEN 4
      WHEN prestazione.posizione_arrivo = 9 THEN 2
      WHEN prestazione.posizione_arrivo = 10 THEN 1
      ELSE 0
    END punti
  FROM prestazione
  WHERE prestazione.anno = 2022
  ORDER BY prestazione.gara_num,prestazione.posizione_arrivo
  )AS punti_gara/* LEFT JOIN
  (SELECT gara.pilota_veloce,COUNT(*) AS punto_extra
  FROM gara
  WHERE gara.anno = 2022
  GROUP BY gara.pilota_veloce) AS giro_veloce
  ON punti_gara.codice_fiscale = giro_veloce.pilota_veloce*/,
  pilota,
  partecipante,
  autovettura
WHERE punti_gara.codice_fiscale = partecipante.codice_fiscale AND
	partecipante.vettura = autovettura.nome AND
	autovettura.anno = 2022 AND 
	partecipante.codice_fiscale = pilota.codice_fiscale
GROUP BY pilota.codice_fiscale
ORDER BY punti_totali DESC;