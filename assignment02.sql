create schema assignment02 default character set utf8mb4;
use assignment02;
set sql_safe_updates = 0;

drop table if exists 주문;
drop table if exists 고객;
drop table if exists 도서;

CREATE TABLE  고객 (
    고객번호      INT PRIMARY KEY,  
    이름          VARCHAR(40),
    주민번호      CHAR(14),
    주소          VARCHAR(40),
    핸드폰        VARCHAR(30)
);

-- 고객(고객번호, 이름, 주민번호, 주소, 핸드폰)
INSERT INTO 고객 VALUES (1, '박지성', '810101-1111111','영국 맨체스타', '000-5000-0001');
INSERT INTO 고객 VALUES (2, '김연아', '900101-2222222','대한민국 서울', '000-6000-0001');  
INSERT INTO 고객 VALUES (3, '장미란', '830101-2333333','대한민국 강원도', '000-7000-0001');
INSERT INTO 고객 VALUES (4, '추신수', '820101-1444444','미국 클리블랜드', '000-8000-0001');

CREATE TABLE 도서 (
    도서번호      INT PRIMARY KEY,
    도서이름      VARCHAR(40),
    출판사        VARCHAR(40),
    가격          INT 
);

-- 도서(도서번호, 도서이름, 출판사, 가격)
INSERT INTO 도서 VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO 도서 VALUES(2, '축구 아는 여자', '나무수', 13000);
INSERT INTO 도서 VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO 도서 VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO 도서 VALUES(5, '피겨 교본', '굿스포츠', 8000);

CREATE TABLE 주문 (
    고객번호  INT  NOT NULL ,
    도서번호 INT  NOT NULL ,
    판매가격      INT,
    주문일자      DATE ,
    PRIMARY KEY(고객번호, 도서번호) ,
    FOREIGN KEY (고객번호) REFERENCES 고객(고객번호) ,
    FOREIGN KEY (도서번호) REFERENCES 도서(도서번호)
);

-- 주문(고객번호, 도서번호, 판매가격, 주문일자)
INSERT INTO 주문 VALUES (1, 1, 7000, '2013-07-01'); 
INSERT INTO 주문 VALUES (1, 2, 13000, '2013-07-03');
INSERT INTO 주문 VALUES (2, 5, 8000, '2013-07-03'); 
INSERT INTO 주문 VALUES (3, 2, 13000, '2013-07-04'); 
INSERT INTO 주문 VALUES (4, 4, 35000, '2013-07-05');
INSERT INTO 주문 VALUES (1, 3, 22000, '2013-07-07');
INSERT INTO 주문 VALUES (4, 3, 22000, '2013-07-07');

select * from 고객;
select * from 도서;
select * from 주문;

-- 고객(고객번호, 이름, 주민번호, 주소, 핸드폰)
-- 도서(도서번호, 도서이름, 출판사, 가격)
-- 주문(고객번호, 도서번호, 판매가격, 주문일자)
-- 질의 2-1 도서 중 8,000 원 이하인 도서를 검색하시오
select 도서번호, 도서이름, 가격
from 도서
where 가격 <= 8000;

-- 질의 2-2 고객 릴레이션에서 이름, 주소, 핸드폰을 검색하시오
select 이름, 주소, 핸드폰
from 고객;

-- 질의 2-7 고객과 고객의 주문사항을 모두 보이시오 (동등조인)
select *
from 고객 inner join 주문
on 고객.고객번호 = 주문.고객번호;

select *
from 고객, 주문
where 고객.고객번호 = 주문.고객번호;

-- 질의 2-8 고객과 고객의 주문사항을 모두 보이시오 (자연조인)
select 고객.고객번호, 이름, 주민번호, 주소, 핸드폰, 도서번호, 판매가격, 주문일자
from 고객 inner join 주문
on 고객.고객번호 = 주문.고객번호;

select 고객.고객번호, 이름, 주민번호, 주소, 핸드폰, 도서번호, 판매가격, 주문일자
from 고객, 주문
where 고객.고객번호 = 주문.고객번호;

-- 질의 2-11 도서 중 가격이 8,000 원 이하인 도서이름과 출판사를 보이시오
select 도서이름, 출판사
from 도서
where 가격 <= 8000;

-- 박지성의 고객번호, 이름, 판매가격,주문일자를 검색하라
select 이름, 판매가격, 주문일자
from 고객 inner join 주문
on 고객.고객번호 = 주문.고객번호
where 이름 = '박지성';

select 이름, 판매가격, 주문일자
from 고객, 주문
where 고객.고객번호 = 주문.고객번호 and 이름 = '박지성';
