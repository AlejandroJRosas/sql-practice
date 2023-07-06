-- d)	Para un estudiante de cédula y código de carrera dado, insertar en una tabla llamada Record_Académico los siguientes datos: lapso, cod_asigna, des_asigna,  nota, nombre del profesor que dicto la asignatura., siempre que el profesor sea Extranjero

INSERT INTO Record_Académico (
  lapso,
  cod_asigna,
  des_asigna,
  nota,
  nombre del profesor
)
SELECT
  ac.lapso,
  a.cod_asigna,
  a.des_asigna,
  ac.nota,
  p.apellidos
  p.nombres
FROM
  asignaturas_cursadas AS ac,
  asignaturas_por_lapso AS axl,
  asignaturas AS a,
  profesores AS p
WHERE
  ac.id_est = 'Dado' AND
  ac.cod_carrera = 'Dado' AND
  ac.cod_carrera = a.cod_carrera AND
  ac.cod_asigna = a.cod_asigna AND
  ac.cod_carrera = axl.cod_carrera AND
  ac.cod_asigna = axl.cod_asigna AND
  ac.lapso = axl.lapso AND
  ac.seccion = axl.seccion AND
  axl.id_profesor = p.id_profesor AND
  p.nacionalidad = 'Extranjero';
  