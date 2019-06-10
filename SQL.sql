1.

SELECT id,nome from candidato join autarquia using (cod) 
WHERE designacao='Lisboa'

2.

SELECT COUNT(*) from candidato join partido using (sigla)
where partido.nome='Partido da Direita' AND votos>1

3.

SELECT partido.nome, AVG(idade) from candidato join partido using (sigla)
GROUP BY partido.nome

4.

SELECT partido.nome from candidato join partido using(sigla) 
group by partido.nome having avg(idade)>45

5.

SELECT cod, designacao FROM

(SELECT candidato.cod, partido.nome
FROM candidato JOIN partido using (sigla)
WHERE partido.nome='Partido do Meio') as a1

RIGHT JOIN autarquia using(cod)
WHERE a1 is NULL

6.

select designacao, count(ne) from
eleitor join autarquia using (cod)
where votou='F'
group by designacao

UNION

select designacao, 0 from
eleitor right join autarquia using (cod)
where ne is null
group by designacao

UNION

select designacao, 0 from
eleitor right join autarquia using (cod)
where  votou != 'F' AND brancos!=0 
group by designacao

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
