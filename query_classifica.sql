SELECT points.codice_fiscale, SUM(points) as total_points
FROM(
  SELECT prestazione.codice_fiscale,
  prestazione.posizione_arrivo,
    CASE 
      WHEN posizione_arrivo = 1 THEN 25
      WHEN posizione_arrivo = 2 THEN 18
      WHEN posizione_arrivo = 3 THEN 15
      WHEN posizione_arrivo = 4 THEN 12
      WHEN posizione_arrivo = 5 THEN 10
      WHEN posizione_arrivo = 6 THEN 8
      WHEN posizione_arrivo = 7 THEN 6
      WHEN posizione_arrivo = 8 THEN 4
      WHEN posizione_arrivo = 9 THEN 2
      WHEN posizione_arrivo = 10 THEN 1
      ELSE 0
    END points
  FROM prestazione
  WHERE prestazione.anno = 2020
  ORDER BY prestazione.gara_num,prestazione.posizione_arrivo
  )as points
GROUP BY points.codice_fiscale
ORDER BY total_points DESC;