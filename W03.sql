create schema W03 default character set utf8mb4;
use W03;
set sql_safe_updates = 0;

drop table if exists 사원;
drop table if exists 고객;
drop table if exists R;
drop table if exists S;

# =============== 사원 table ===============
create table 사원 (
    직원코드  varchar(8)      NOT NULL  ,
    성명        varchar(20)    NOT NULL  ,
    직책        varchar(10) ,
    연봉        int            ,
    성별        char(1) ,    
    PRIMARY KEY(직원코드)
);

-- 사원(직원코드,성명,직책,연봉)
insert into 사원 values('161353','김미나','대리',2300,'여');
insert into 사원 values('181323','최영락','사원',1900,'남');
insert into 사원 values('151453','홍진호','과장',2800,'남');
insert into 사원 values('135485','구준표','과장',3000,'남');
insert into 사원 values('104895','김나래','팀장',3600,'남');
insert into 사원 values('165484','김하늘','대리',2400,'남');

select * from 사원;

-- 1) 최대 연봉을 구하시오
select max(연봉) as '최대 연봉'
from 사원;

-- 2) 사원수를 구하시오
select count(*) as 사원수
from 사원;

-- 3) 직책의 개수를 중복없이 검색하시오(DISTINCT)
select count(distinct 직책)
from 사원;

-- 4) 직책별 연봉의 평균을 구하시오
select 직책, avg(연봉)
from 사원
group by 직책;

-- 5) 직책별 사원수를 구하시오
select 직책, count(*)
from 사원
group by 직책;

-- 6) 연봉이 2500 이상인 사원이 2명 이상인 직책의 사원수를 구하시오
select 직책, count(*) as '사원수'
from 사원
where 연봉 >= 2500
group by 직책
having count(*)>=2;

# =============== 고객 table ===============
CREATE TABLE 고객 (
      고객아이디   VARCHAR(20)             NOT NULL,
      고객이름      VARCHAR(10),
      나이            INT,
      등급            VARCHAR(10)              NOT NULL,
      직업            VARCHAR(20),
      적립금         INT                            DEFAULT 0,
      PRIMARY KEY(고객아이디)
);

INSERT INTO 고객 VALUES ('apple', '정소화', 20, 'gold', '학생', 1000);
INSERT INTO 고객 VALUES ('banana', '김선우', 25, 'vip', '간호사', 2500);
INSERT INTO 고객 VALUES ('carrot', '고명석', 28, 'gold', '교사', 4500);
INSERT INTO 고객 VALUES ('orange', '김용축', 22, 'silver', '학생', NULL);
INSERT INTO 고객 VALUES ('melon', '성원용', 35, 'gold', '회사원', 5000);
INSERT INTO 고객 VALUES ('peach', '오형준', NULL, 'silver', '의사', 300);
INSERT INTO 고객 VALUES ('pear', '채광주', 31, 'silver', '회사원', 500);

select * from 고객;

-- 1) 다음 실행결과는 무엇인가?
select count(*), count(적립금), count(distinct 직업)
from 고객;

-- 2) 뷰 작성: 고객_학생 뷰 생성(고객아이디, 등급, 직업,적립금 으로 이루어진다)
-- 2) 다음 실행결과는 무엇인가?
create view 고객_학생
as
   select 고객아이디, 등급, 직업, 적립금
   from 고객
   where 직업 = '학생';

insert into 고객_학생 values('shinme', 'gold', '학생', 500);
select * from 고객 where 고객아이디 = 'shinme';

# 뷰에 대한 데이터를 입력하면 기존 table에도 데이터 들어감(안 적은 필드는 NULL로 들어감)

# =============== R / S table ===============
create table R (
   A char(1),
   B int
);

create table S (
   C char(1),
   D int
);


insert into R value('a', 2);
insert into R value('b', 4);
insert into R value('c', 2);
insert into R value('c', 4);
insert into R value('c', 6);

insert into S values('a', 1);
insert into S values('b', 2);
insert into S values('c', 4);

select * from R;
select * from S;

-- 1)
select count(*)
from R
where B = some(select D from S);

-- 2)
select D, AVG(B)
from R, S
WHERE A = C
GROUP BY D
HAVING COUNT(*) > 1;