create graph g;
select set_graph_path('g');

CREATE VLABEL person;
CREATE ELABEL knows;
insert into person (id, properties) values (1, '{"name": "Tom"}');
insert into person (id, properties) values (2, '{"name": "Summer"}');
insert into person (id, properties) values (3, '{"name": "Pat"}');
insert into person (id, properties) values (4, '{"name": "Nikki"}');
insert into person (id, properties) values (5, '{"name": "Olive"}');
insert into person (id, properties) values (6, '{"name": "Todd"}');

insert into knows (id, start, end, properties) values (2, 1, 2, '{"data": "11"}');
insert into knows (id, start, end, properties) values (3, 3, 4, '{"data": "12"}');
insert into knows (id, start, end, properties) values (4, 5, 6, '{"data": "13"}');
