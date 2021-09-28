create graph g;
select set_graph_path('g');
SET search_path TO 'g';

CREATE VLABEL person;
CREATE ELABEL knows;

CREATE (:person {name: 'Tom'})-[:knows {fromdate:'2011-11-24'}]->(:person {name: 'Summer'});
CREATE (:person {name: 'Pat'})-[:knows {fromdate:'2013-12-25'}]->(:person {name: 'Nikki'});
CREATE (:person {name: 'Olive'})-[:knows {fromdate:'2015-01-26'}]->(:person {name: 'Todd'});

MATCH (p:person {name: 'Tom'}),(k:person{name: 'Pat'}) 
CREATE (p)-[:knows {fromdate:'2017-02-27'} ]->(k);

MATCH (n:person {name: 'Tom'})-[:knows]->(m:person) RETURN n.name AS n, m.name AS m;
