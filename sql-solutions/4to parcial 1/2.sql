-- b)	Listar  los alumnos extranjeros que estén cursando  “Administración de Empresas” y “Contaduría Pública ”, pertenecientes a la cohorte “2019-15” o “2020-15” y que han aprobado  más de 50 unidades de crédito antes del lapso 2021-25. (Cedula, Apellidos, Nombres, Total Unidad de Créditos )

SELECT
  e.cedula,
  e.apellidos,
  e.nombres,
  ade.uc_ade + conta.uc_conta AS total_uc
FROM
  estudiantes AS e,
  (
  SELECT
    id_est
    SUM(a1.uni_cred) AS uc_ade
  FROM
    carreras AS c1,
    est_x_carreras AS exc1,
    asignaturas_cursadas AS ac1,
    asignaturas AS a1
  WHERE
    c1.des_carrera LIKE 'Administración de Empresas' AND
    c1.cod_carrera = exc1.cod_carrera AND
    exc1.cohorte IN ('2019-15', '2020-15') AND
    exc1.id_est = ac1.id_est AND
    exc1.nota > 10 AND
    exc1.cod_carrera = ac1.cod_carrera AND
    exc1.cod_carrera = a1.cod_carrera AND
    exc1.cod_asigna = a1.cod_asigna
  ) AS ade,
  (
  SELECT
    id_est
    SUM(a2.uni_cred) AS uc_conta
  FROM
    carreras AS c2,
    est_x_carreras AS exc2,
    asignaturas_cursadas AS ac2,
    asignaturas AS a2
  WHERE
    c2.des_carrera LIKE 'Contaduría Pública' AND
    c2.cod_carrera = exc2.cod_carrera AND
    exc2.cohorte IN ('2019-15', '2020-15') AND
    exc2.id_est = ac2.id_est AND
    exc2.nota > 10 AND
    exc2.cod_carrera = ac2.cod_carrera AND
    exc2.cod_carrera = a2.cod_carrera AND
    exc2.cod_asigna = a2.cod_asigna
  ) AS conta
WHERE
  e.id_est = ade.id_est AND
  e.id_est = conta.id_est AND
  total_uc > 50;
