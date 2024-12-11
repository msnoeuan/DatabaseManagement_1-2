-- 1. 데이터베이스 생성
-- use database;
-- 2. 테이블 생성
-- 3. 데이터 입력
-- 4. 데이터 조회

create schema W04 default character set utf8mb4;
use W04;

drop table if exists 고객;
drop table if exists 제품;
drop table if exists 학과;

# =============== 고객 table ===============
create table 고객 (
   고객번호 char(4) not null primary key,
   고객명 varchar(10) not null,
   거주지 varchar(20),
   포인트 int
);

insert into 고객 values('c101', '홍길동', '서울', 500);
insert into 고객 values('c102', '임꺽정', '인천', 300);
insert into 고객 values('c103', '박찬호', '안양', 800);
insert into 고객 values('c204', '신동엽', '과천', 350);
insert into 고객 values('c205', '정진우', '고양', 400);

-- 고객 테이블에서 데이터를 검색하라
select * from 고객;

-- 고객 테이블에서 고객명과 거주지를 검색하라
select 고객명, 거주지 from 고객;

-- 고객 테이블에서 고객번호가 c101인 고객을 검색하라
select * from 고객 where 고객번호 = 'c101';

# =============== 제품 table ===============
create table 제품 (
   제품번호 char(3) not null,
   제품명 varchar(20),
   재고량 int,
   단가 int,
   제조업체 varchar(20),
   primary key(제품번호)
);

insert into 제품 values('p01', '그냥만두', 5000, 4500, '대한식품');
insert into 제품 values('p02', '매운쫄면', 2500, 5500, '민국푸드');
insert into 제품 values('p03', '쿵떡파이', 3600, 2600, '한빛제과');
insert into 제품 values('p04', '맛난초콜렛', 1250, 2500, '한빛제과');
insert into 제품 values('p05', '얼큰라면', 2200, 1200, '대한식품');

select * from 제품;

# =============== 학과 table ===============
create table 학과 (
   학과번호 int,
   학과명 varchar(45),
   primary key(학과번호)
);

insert into 학과 values(1, '컴퓨터소프트웨어공학과');
insert into 학과 values(2, '컴퓨터정보공학과');
insert into 학과 values(3, '인공지능소프트웨어공학과');

select * from 학과;