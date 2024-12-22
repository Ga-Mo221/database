
create database baitap1;

use classicmodels;

-- drop database classicmodels;

create table class(
	stt int not null auto_increment,
	id varchar(10)
);

alter table class add primary key(id);

-- drop table class;

create table student(
	id varchar(10) unique,
    name_st varchar(50) not null,
    age int,
    birthday date,
    class_id varchar(10)
);

alter table student 
add constraint fk_class_id 
foreign key (class_id) references class(id);

alter table student add city varchar(50);
alter table student modify city varchar(100);
alter table student drop column city;

alter table student 
add constraint check_student 
check (age > 15 and city ='da nang');

alter table student alter city set default 'da nang';

create index index_city on student (city);
