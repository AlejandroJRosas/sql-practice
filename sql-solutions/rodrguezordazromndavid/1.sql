-- a)	Listar  todos los estudiantes venezolanos de sexo  masculino que han estudiado alguna asignatura con un estudiante de  apellido y  nombre dado.

SELECT DISTINCT
  e1.id_est
  e1.cedula,
  e1.apellidos,
  e1.nombre
FROM
  estudiantes AS e1,
  asignaturas_cursadas AS ac1,
  (
  SELECT
    ac.cod_carrera,
    ac.cod_asignatura,
    ac.lapso
  FROM
    estudiantes AS e,
    asignaturas_cursadas AS ac
  WHERE 
    est.apellidos = 'Dado' AND 
    est.nombre = 'Dado' AND
    est.id_est = ac.id_est
  ) AS result
WHERE
  e1.sexo = 'Masculino' AND
  e1.nacionalidad = 'Venezolano' AND
  ac1.cod_carrera = result.cod_carrera AND
  ac1.cod_asignatura = result.cod_asignatura AND
  ac1.lapso = result.lapso;
