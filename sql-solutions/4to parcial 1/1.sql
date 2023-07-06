-- a)	Listar los nombre de los estudiantes (cédula, apellido y nombres) que más asignaturas hayan reprobado en “Ingeniería Informática”

SELECT DISTINCT 
  e.cedula,
  e.apellidos,
  e.nombres,
  COUNT(CASE WHEN ac.nota < 10 THEN 1 END)
FROM
  carreras AS c,
  asignaturas_cursadas AS ac,
  estudiantes AS e
WHERE
  c.des_carrera LIKE '%Ingeniería Informática%' AND
  c.cod_carrera = ac.cod_carrera AND
  ac.nota < 10 AND
  ac.id_est = e.id_est
GROUP BY
  e.cedula,
  e.apellidos,
  e.nombres;