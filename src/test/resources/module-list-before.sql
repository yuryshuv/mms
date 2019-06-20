delete from module;

insert into module(module_id, module_name, module_description) values
(1, 'first', 'desc1'),
(2, 'second', 'desc2'),
(3, 'third', 'desc3'),
(4, 'fourth', 'desc4');

alter sequence hibernate_sequence restart with 10;