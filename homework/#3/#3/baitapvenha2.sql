-- bai 2
use baitap1;

select *from student;

select *from student
where city = 'da nang';

select *from student order by birthday;
select *from student order by birthday desc;

select *from student
where city = 'da nang' and year(birthday) = '2006';

insert into class(id) values ('k24-1');

select name_st from student where name_st is null;

update student 
set name_st = 'nguyen van hau', city = 'quang nam'
where id = 7;

delete from student where name_st = 'nguyen van hau';

select * from student limit 2;

select min(age) from student where city = 'da nang';

select avg(age) from student;

select * from student where city like 'd%';

select * from student 
where city in ('da nang', 'gia lai');

select * from student where age not between 15 and 18;

select name_st as ten, age as tuoi from student;