create sequence hibernate_sequence start 1 increment 1;


create table usr (
    id int8 not null,
    activation_code varchar(255),
    active boolean not null,
    email varchar(255) ,
    password varchar(255) not null,
    username varchar(255) not null,
    primary key (id)
);

create table module (
    module_id int8 not null,
    module_description varchar(255),
    module_name varchar(255) not null,
    user_id int8,
    primary key (module_id)
);

create table unit (
    unit_id int8 not null,
    unit_description varchar(255),
    unit_name varchar(255) not null,
    user_id int8,
    module_module_id int8,
    primary key (unit_id)
);

create table part (
    part_id int8 not null,
    part_description varchar(255),
    part_name varchar(255) not null,
    user_id int8,
    unit_unit_id int8,
    primary key (part_id)
);

create table document (
    document_id int8 not null,
    document_description varchar(255),
    document_name varchar(255) not null,
    user_id int8,
    unit_unit_id int8,
    primary key (document_id)
);

create table orders (
    order_id int8 not null,
    end_time varchar(255),
    expected_time varchar(255),
    is_finished boolean not null,
    order_description varchar(255),
    order_name varchar(255) not null,
    start_time varchar(255),
    user_id int8,
    unit_unit_id int8,
    primary key (order_id)
);

create table user_orders (
    job_id int8 not null,
    employee_id int8 not null,
    primary key (employee_id, job_id)
);

create table user_role (
    user_id int8 not null,
    roles varchar(255)
);

alter table if exists document
    add constraint document_user_fk
    foreign key (user_id) references usr;

alter table if exists document
    add constraint document_unit_fk
    foreign key (unit_unit_id) references unit;

alter table if exists module
    add constraint module_user_fk
    foreign key (user_id) references usr;

alter table if exists orders
    add constraint order_user_fk
    foreign key (user_id) references usr;

alter table if exists orders
    add constraint order_unit_fk
    foreign key (unit_unit_id) references unit;

alter table if exists part
    add constraint part_user_fk
    foreign key (user_id) references usr;

alter table if exists part
    add constraint part_unit_fk
    foreign key (unit_unit_id) references unit;

alter table if exists unit
    add constraint unit_user_fk
    foreign key (user_id) references usr;

alter table if exists unit
    add constraint uni_module_fk
    foreign key (module_module_id) references module;

alter table if exists user_orders
    add constraint order_user_fk
    foreign key (employee_id) references usr;

alter table if exists user_orders
    add constraint user_order_fk
    foreign key (job_id) references orders;

alter table if exists user_role
    add constraint user_role_user_fk
    foreign key (user_id) references usr;
