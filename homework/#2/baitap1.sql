create database baitap1;
use baitap1;
create table users(
	id  int,
    primary key (id),
    username varchar(50) not null,
    email varchar(100) not null,
    addpress varchar(100) not null,
    phone varchar(15) not null,
    gender varchar(10) not null
);

alter table users
add birth date;

create table category(
	id int,
    primary key(id),
    namep varchar(100) not null
);

create table post(
	id int,
    primary key(id),
    titel varchar(100) not null,
    contend varchar(200) not null,
    created date not null,
    user_id int not null,
    constraint fk_user_id foreign key(user_id) references users(id),
    postcategory_id int not null,
    constraint fk_postcategory_id foreign key(postcategory_id) references category(id)
);

create table comments(
	id int,
    primary key(id),
    content varchar(100) not null,
    created date not null,
    user_comment_id int not null,
    constraint fk_user_content_id foreign key(user_comment_id) references users(id),
    post_comment_id int not null,
    constraint fk_post_comment_id foreign key(post_comment_id) references post(id)
);

-- xem thuoc tinh cua cac table
describe users;

-- doi ten cua column
alter table users change addpress address varchar(100);

-- khi tao column can tang gia tri tu dong thi them auto_increment vao sao kieu du lieu

alter table users modify column email varchar(50);

-- doi ten table 
rename table nguoidung to users;


-- xao du lieu trong bang
truncate table users;

-- them du lieu vao bang
insert into users (id, username, email, address, phone, gender, birth) values (1,"hau", "hau123","da nang","89676","nam",'2001-01-22');

