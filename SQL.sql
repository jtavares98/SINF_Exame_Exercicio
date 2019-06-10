1.

2.

3.

4.

5.

6.

7.

SELECT designacao FROM

(SELECT designacao, COUNT(ne) as inscritos FROM eleitor join autarquia using(cod)
  WHERE ne is not null
  GROUP by designacao) as a1
 
order by inscritos desc limit 2

8.

SELECT a2.cod FROM

(SELECT cod, sum(votos) as total FROM candidato
 JOIN autarquia using(cod)
 JOIN partido using(sigla)
 GROUP BY cod) as a1
 INNER JOIN
 (SELECT cod, sum(votos)*2 as favor FROM candidato
 JOIN autarquia using(cod)
 JOIN partido using(sigla)
 WHERE sigla='PD'
 GROUP BY cod) as a2
 
 on a1.cod=a2.cod and a2.favor > a1.total
