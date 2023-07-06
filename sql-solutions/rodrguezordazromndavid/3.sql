-- c) Liste los profesores que han dictado asignaturas en alguno de los lapsos del 2010-2020, en carreras que no sean de ingeniería y cuyos total  de estudiantes reprobados en cada  lapso de ese período es mayor al 50% de los alumnos del curso. (cedula, apellidos, nombres, lapso, total de reprobados) 

SELECT
  p.cedula,
  p.apellidos,
  p.nombres,
  axl.lapso,
  crc.total
FROM
  carreras AS c,
  profesores AS p,
  asignaturas_x_lapso AS axl,
  (
  SELECT
    axl1.id_profesor,
    ac1.lapso,
    ac1.cod_carrera,
    ac1.cod_asigna,
    COUNT(ac1.id_est) AS total
  FROM 
    asignaturas_cursadas AS ac1,
    asignaturas_x_lapso AS axl1
  WHERE
    ac1.cod_carrera = axl1.cod_carrera AND
    ac1.cod_asigna = axl1.cod_asigna AND
    ac1.lapso = axl1.lapso AND
    ac1.seccion = axl1.seccion
  GROUP BY
    axl1.id_profesor,
    ac1.lapso
  ) AS cec,
  (
  SELECT
    axl2.id_profesor,
    ac2.lapso,
    ac2.cod_carrera,
    ac2.cod_asigna,
    COUNT(CASE WHEN ac2.nota < 10 THEN 1 END) AS total
  FROM 
    asignaturas_cursadas AS ac2,
    asignaturas_x_lapso AS axl2
  WHERE
    ac2.cod_carrera = axl2.cod_carrera AND
    ac2.cod_asigna = axl2.cod_asigna AND
    ac2.lapso = axl2.lapso AND
    ac2.seccion = axl2.seccion
  GROUP BY
    axl2.id_profesor,
    ac2.lapso
  ) AS crc
WHERE
  c.des_carrera NOT LIKE '%Ingeniería%' AND
  c.cod_carrera = axl.cod_carrera AND
  axl.lapso BETWEEN 2010 AND 2020 AND
  axl.id_profesor = p.id_profesor AND
  axl.lapso = crc.lapso AND
  axl.id_profesor = crc.id_profesor AND
  axl.cod_carrera = crc.cod_carrera AND
  axl.cod_asigna = crc.cod_asigna AND
  axl.lapso = cec.lapso AND
  axl.id_profesor = cec.id_profesor AND
  axl.cod_carrera = cec.cod_carrera AND
  axl.cod_asigna = cec.cod_asigna AND
  crc.total > (cec.total * 0.5);
