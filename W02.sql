create schema W02 default character set utf8mb4;
use W02;


create table customer (
   cno char(4) not null primary key,
   cname varchar(10) not null,
   city varchar(20),
   point int
);

insert into customer values('c101', '홍길동', '서울', 500);
insert into customer values('c102', '임꺽정', '인천', 300);
insert into customer values('c103', '박찬호', '안양', 800);
insert into customer values('c204', '신동엽', '과천', 350);
insert into customer values('c205', '정진우', '고양', 400);

select * from customer;