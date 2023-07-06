-- b)	Liste los estudiantes egresados de las carreras de “Ingeniería” (considere todas las careras de Ingeniería: Ej: Ingeniería en Informática, Ingeniería Industrial, etc), cuyo promedio de notas sea mayor a 10 puntos. El listado debe estar ordenados alfabéticamente. (Apellidos, Nombres, Carrera, Promedio, total de UC aprobadas)

SELECT
  e1.apellidos,
  e1.nombres,
  result.des_carrera,
  AVG(ac.nota) AS promedio_notas,
  SUM(asig.uni_cred) AS total_uc_aprobadas
FROM 
  estudiantes AS e1,
  asignatura AS asig,
  asignaturas_cursadas AS ac,
  ( -- Tabla con todos los estudiantes egresados de ingeniería
  SELECT DISTINCT
    e.id_est
    c.des_carrera
  FROM 
    estudiantes AS e,
    estudiantes_por_carrera AS exc,
    carreras AS c
  WHERE
    c.des_carrera LIKE '%Ingeniería%' AND
    c.cod_carrera = exc.cod_carrera AND
    exc.fec_egreso IS NOT NULL AND
    exc.id_est = e.id_est AND
  ) AS result
WHERE
  e1.id_est = result.id_est AND
  e1.id_est = ac.id_est AND
  ac.cod_carrera = asig.cod_carrera AND
  ac.cod_asignatura = asig.cod_asignatura
GROUP BY
  e1.apellidos,
  e1.nombres,
  result.des_carrera
HAVING
  promedio_notas > 10
ORDER BY 
  apellidos,
  nombres;
