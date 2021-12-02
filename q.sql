drop graph g cascade;
create graph g;
select set_graph_path('g');

CREATE VLABEL person;
CREATE ELABEL knows;
insert into person (id, properties) values (1, '{"name": "Tom", "emb": [5.0, 8, 9 ]}');
insert into person (id, properties) values (2, '{"name": "Summer", "emb": [ 5.0, 8, 9 ]}');
insert into person (id, properties) values (3, '{"name": "Pat", "emb": [ 5.0, 8, 9 ]}');
insert into person (id, properties) values (4, '{"name": "Nikki", "emb": [ 5.0, 8, 9 ]}');
insert into person (id, properties) values (5, '{"name": "Olive", "emb": [ 5.0, 8, 9 ]}');
insert into person (id, properties) values (6, '{"name": "Todd", "emb": [ 5.0, 8, 9 ]}');

insert into knows (id, start, stop, properties) values (10, 1, 2, '{"data": "11"}');
insert into knows (id, start, stop, properties) values (11, 3, 4, '{"data": "12"}');
insert into knows (id, start, stop, properties) values (12, 5, 6, '{"data": "13"}');


select (properties->>'emb')::vector <-> '[1, 2, 3.0]'::vector from g.person;