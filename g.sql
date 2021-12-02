drop graph g cascade;
create graph g;
select set_graph_path('g');

CREATE VLABEL person;
CREATE ELABEL knows;


insert into person (id, properties) values (2, '{"name": "Tom"}');
insert into person (id, properties) values (3, '{"name": "Summer"}');
insert into person (id, properties) values (4, '{"name": "Pat"}');
insert into person (id, properties) values (5, '{"name": "Nikki"}');
insert into person (id, properties) values (6, '{"name": "Olive"}');
insert into person (id, properties) values (7, '{"name": "Todd"}');


insert into knows (id, start, stop, properties) values (10, 1, 2, '{"data": "11"}');
insert into knows (id, start, stop, properties) values (11, 4, 5, '{"data": "12"}');
insert into knows (id, start, stop, properties) values (12, 6, 7, '{"data": "13"}');


insert into glikes (id, start, stop, properties) values (10, 2, 2, '{"data": "11"}');
