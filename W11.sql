create schema W11 default character set utf8mb4;
use W11;
set sql_safe_updates = 0;

drop table if exists customer;
drop table if exists fruit;
drop table if exists 고객;
drop table if exists 성적;
drop table if exists 성적2;
drop table if exists 주문;
drop table if exists 제품;

# =============== customer table ===============
create table customer (
   cno char(4) not null,
   cname varchar(10) not null,
   city varchar(20),
   point int,
   primary key(cno)
);

insert into customer values('c101', '홍길동', '서울', 500);
insert into customer values('c102', '임꺽정', '인천', 300);
insert into customer values('c103', '박찬호', '안양', 800);
insert into customer values('c204', '신동엽', '과천', 350);
insert into customer values('c205', '정진우', '고양', 400);

-- 새 레코드를 추가하고 select문 예제 실습하시오
insert into customer values('c307', '정동우', '서울', null);

select * from customer;

-- [실습 1-1]
-- 1-1) 테이블의 모든 열을 검색하라
select * from customer;
-- 1-2) 테이블의 모든 열을 검색(필드명 사용)
select cno, cname, city, point from customer;
-- 1-3) 고객의 고객명, 거주지를 검색하라(테이블의 특정 열을 검색)
select cname, city from customer;
-- 1-4) cname 은 성명, city는 거주지로 출력하라(화면에 표시되는 열 이름 변경하여 검색) 
select cname 성명, city 거주지 from customer;
-- 1-5) customer 테이블에서 거주지를 검색하라
select city from customer;
-- 1-6) 거주지를 검색하는데 중복 행을 제거하여 한 번씩만 검색하라
select distinct city from customer;

-- 2-1) 고객번호가 c101 인 고객의 모든 정보를 검색하라
select * from customer where cno = 'c101';
-- 2-2) 포인트가 400 이하인 고객의 모든 정보를 검색하라
select * from customer where point <= 400;
-- 2-3) 거주지가 서울 이면서 포인트가 500 이상인 고객의 이름, 거주지, 포인트를 검색하라
select cname, city, point from customer where city = '서울' and point >= 500;
-- 2-4) 거주지가 서울 이거나 포인트가 500 이상인 고객의 이름, 거주지, 포인트를 검색하라
select cname, city, point from customer where city = '서울' or point >= 500;
-- 2-5) 포인트가 350 부터 500 사이인 고객이름, 거주지, 포인트를 검색하라
-- 부등호 사용
select cname, city, point from customer where point >= 350 and point <= 500;
-- BETWEEN … AND 사용
select cname, city, point from customer where point between 350 and 500;
-- 2-6) 거주지가 서울 이거나 안양인 고객번호, 이름, 거주지를 검색하라
-- 부등호 사용
select cno, cname, city from customer where city = '서울' or city = '안양';
-- IN 사용
select cno, cname, city from customer where city in('서울', '안양');
-- 2-7) 거주지가 서울이 아니거나 안양이 아닌 고객번호, 이름, 거주지를 검색하라
-- 부등호 사용
select cno, cname, city from customer where city <> '서울' and city <> '안양';
-- NOT IN 사용
select cno, cname, city from customer where city not in('서울', '안양');

-- 3-1) 정씨 성을 가진 고객의 모든 열을 검색하라
select * from customer where cname like '정%';
-- 3-2) 이름에 '동' 자가 들어가는 고객의 모든 열을 검색하라
select * from customer where cname like '%동%';
-- 3-3) 이름의 세번째 글자가 '우' 자가 들어가는 고객의 모든 열을 검색하라
select * from customer where cname like '_우';
-- 3-4) 성이 홍씨, 박씨, 정씨인 고객을 검색하라
select * from customer where cname like '홍%' or cname like '박%' or cname like '정%';
-- 성이 홍씨, 박씨, 정씨가 아닌 고객을 검색하라
select * from customer where cname not like '홍%' and cname not like '박%' and cname not like '정%';
-- 3-5) 포인트가 없는 고객의 번호, 이름, 포인트를 검색하라
select cno, cname, point from customer where point is null;
-- 포인트가 있는 고객의 번호, 이름, 포인트를 검색하라
select cno, cname, point from customer where point is not null;


-- 4-1) 고객 테이블에서 이름을 오름차순 정렬하라	
select * from customer order by cname asc;
-- 4-2) 거주지가 서울인 고객의 모든 데이터를 검색하는데, 이름의 오름차순 정렬하여 출력하라
select * from customer where city = '서울' order by cname;
-- 4-3) 거주지의 오름차순으로 정렬하고, 거주지가 같으면 포인트의 내림차순으로 정렬하라
select * from customer order by city asc, point desc;
-- 4-4) 포인트가 많은 순으로(내림차순) 먼저 정렬하고, 같은 포인트는 이름의 오름차순으로 정렬하고 이름이 같으면 거주지의 오름차순으로 정렬하여 검색하라
select * from customer order by point desc, cname asc, city asc;
-- 4-5) 다음의 의미는?
SELECT      cno,  cname,  city,  point  
FROM        customer  
ORDER  BY  3;
-- 의미 : select에 나타난 세 번째 필드(city)를 기준으로 오름차순 정렬

# =============== fruit table ===============
create table fruit (
   과일번호 int not null,
   과일이름 varchar(30),
   가격 int,
   색상 char(12),
   원산지 varchar(30),
   primary key(과일번호)
);

insert into fruit values('1', '사과', 2000, '빨간색', '한국');
insert into fruit values('2', '배', 5000, '노란색', '한국');
insert into fruit values('3', '바나나', 1500, '노란색', '인도네시아');
insert into fruit values('4', '키위', 4000, '초록색', '호주');
insert into fruit values('5', '수박', 8000, '초록색', '한국');

select * from fruit;

-- [Quiz 1]
-- 2-1) 노란색 과일의 이름, 색상을 검색하라.
select 과일이름, 색상 from fruit where 색상 = '노란색';
-- 2-2) 과일이름을 오름차순으로 정렬하여 모든 필드를 검색하라
select * from fruit order by 과일이름;
-- 2-3) 가격이 5000 이하인 빨간색 과일의 이름을 검색하라
select 과일이름 from fruit where 가격 <= 5000;
-- 2-4) 가격이 2000 ~ 5000 사이의 과일이름과 가격, 원산지를 검색하라(BETWEEN AND)
select 과일이름, 가격, 원산지 from fruit where 가격 between 2000 and 5000;
-- 2-5) 색상이 노란색이거나 초록색인 과일이름, 색상을 검색하라(IN 사용)
select 과일이름, 색상 from fruit where 색상 in('노란색', '초록색');
-- 2-6) 색상이 노란색이거나 초록색인 과일이름, 색상을 검색하라(논리연산자 OR 사용)
select 과일이름, 색상 from fruit where 색상 = '노란색' or 색상 = '초록색';
-- 2-7) 원산지가 한국이 아닌 과일이름, 원산지를 검색하라
select 과일이름, 원산지 from fruit where 원산지 <> '한국';

# =============== 고객 table ===============
-- 조건 1) 고객 테이블은 고객아이디, 고객이름, 나이, 등급, 직업, 적립금 속성으로 구성된다
-- 조건 2) 고객아이디 속성이 기본키다
-- 조건 3) 고객이름과 등급 속성은 값을 반드시 입력해야 한다
-- 조건 4) 적립금 속성은 값을 입력하지 않으면 0이 기본으로 입력되도록 한다
create table 고객 (  
   고객아이디 varchar(20) not null,
   고객이름 varchar(10) not null,
   나이 int,
   등급 varchar(10) not null,
   직업 varchar(20),
   적립금 int default 0,
   primary key(고객아이디)
);

insert into 고객 values('apple', '정소화', 20, 'gold', '학생', 1000);
insert into 고객 values('banana', '김선우', 25, 'vip', '간호사', 2500);
insert into 고객 values('carrot', '고명석', 28, 'gold', '교사', 4500);
insert into 고객 values('orange', '김용축', 22, 'silver', '학생', null);
insert into 고객 values('melon', '성원용', 35, 'gold', '회사원', 5000);
insert into 고객 values('peach', '오형준', null, 'silver', '의사', 300);
insert into 고객 values('pear', '채광주', 31, 'silver', '회사원', 500);

select * from 고객;

-- [Quiz 2]
-- 1) 직업이 학생, 간호사, 교사인 고객의 이름, 직업, 등급을 검색
select 고객이름, 직업, 등급 from 고객 where 직업 in('학생', '간호사', '교사');
-- 2) 적립금이 300 이상인 고객 중에서 나이를 알 수 없는 고객아이디, 나이, 적립금을 검색하라
select 고객아이디, 나이, 적립금 from 고객 where 적립금 >= 300 and 나이 is null;
-- 3) 등급이 gold인 고객 중에서 고객아이디, 등급, 적립금을 검색하라. 단, 등급을 오름차순 정렬하고 등급이 같으면 적립금의 내림차순 정렬하라
select 고객아이디, 등급, 적립금 from 고객 where 등급 = 'gold' order by 등급, 적립금 desc;
-- 4) 등급별 적립급 평균을 검색하라, 단, 적립금 평균이 1000원 이상인 등급에 대해 검색
select avg(적립금) from 고객 group by 등급 having avg(적립금) >= 1000;

# =============== 성적 table ===============
create table 성적 (
   이름 varchar(9) not null primary key,
   점수 int
);

insert into 성적(이름, 점수) values('홍길동', 87);
insert into 성적(이름, 점수) values('임꺽정', 60);
insert into 성적(이름, 점수) values('박찬호', 75);
insert into 성적(이름, 점수) values('선동열', 70);
insert into 성적(이름, 점수) values('홍명보', 90);
insert into 성적(이름, 점수) values('차범근', 75);
insert into 성적(이름, 점수) values('강성범', 68);
insert into 성적(이름, 점수) values('신동엽', null);

select * from 성적;

-- [실습 2-2]  SELECT (집계함수)
-- 1-1) 최고 점수를 검색하라 
select max(점수) from 성적;
-- 1-2) 최저 점수를 검색하라
select min(점수) from 성적;
-- 1-3) 점수합계를 검색하라
select sum(점수) from 성적; 
-- 1-4) 평균점수를 검색하라
select avg(점수) from 성적;
-- 1-5) 학생수는 모두 몇 명인지 검색하라
select count(*) from 성적;
-- 1-6) 시험에 응시한 학생수는 모두 몇 명인지 검색하라
select count(점수) as '응시 학생수' from 성적;

# =============== 성적2 table ===============
create table 성적2 (
   이름 varchar(9) not null primary key,
   과목 varchar(8),
   점수 int
);

insert into 성적2 values('홍길동', '영어',87 );
insert into 성적2 values('임꺽정', '수학',60 );
insert into 성적2 values('박찬호', '국어',75 );
insert into 성적2 values('선동열', '영어',70 );
insert into 성적2 values('홍명보', '수학',90 );
insert into 성적2 values('차범근', '수학',75 );
insert into 성적2 values('강성범', '수학',68 );
insert into 성적2 values('신동엽', '영어',null);

select * from 성적2;

-- [실습 2-03]
-- 2-1) 각 과목수는 몇 개인지 검색하라(DISTINCT 사용)
select count(distinct 과목) from 성적2;
-- 2-2) 과목별 수강생은 몇 명인지 검색하라(GROUP BY)
select 과목, count(*) from 성적2 group by 과목;
-- 2-3) 과목별 평균점수를 검색하라(GROUP BY)
select 과목, avg(점수) from 성적2 group by 과목;
select 과목, round(avg(점수)) from 성적2 group by 과목;
-- 2-4) 과목별 평균점수 75 보다 높은 학생의 과목별 평균점수를 검색하라(HAVING)
select 과목, avg(점수) from 성적2 group by 과목 having avg(점수) >= 75;
-- 2-5) 점수가 70 이상인 과목이름, 과목 평균점수를 과목의 과목별 평균점수가 75 이상인 것만 과목별 평균점수가 높은 순으로 검색하라(ORDER  BY)
select 과목, avg(점수) from 성적2 where 점수 >= 70 group by 과목 having avg(점수) >= 75 order by avg(점수) desc;

# =============== 제품 table ===============
create table 제품 ( 
   제품번호 char(3) not null,
   제품명 varchar(20),
   재고량 int,
   단가 int,
   제조업체 varchar(20),
   primary key(제품번호)
   -- check(재고량 >= 0 and 재고량 <= 10000)
);

insert into 제품 values('p01', '그냥만두', 5000, 4500, '대한식품');
insert into 제품 values('p02', '매운쫄면', 2500, 5500, '민국푸드');
insert into 제품 values('p03', '쿵떡파이', 3600, 2600, '한빛제과');
insert into 제품 values('p04', '맛난초콜렛', 1250, 2500, '한빛제과');
insert into 제품 values('p05', '얼큰라면', 2200, 1200, '대한식품');
insert into 제품 values('p06', '통통우동', 1000, 1550, '민국푸드');
insert into 제품 values('p07', '달콤비스켓', 1650, 1500, '한빛제과');

select * from 제품;

# =============== 주문 table ===============
create table 주문 ( 
   주문번호 char(3) not null,
   주문고객 varchar(20),
   주문제품 char(3),
   수량 int,
   배송지 varchar(30),
   주문일자 date,
   primary key(주문번호),
   foreign key(주문고객) references 고객(고객아이디),
   foreign key(주문제품) references 제품(제품번호)
);

insert into 주문 values('o01', 'apple', 'p03', 10, '서울시 마포구', '13/01/01');
insert into 주문 values('o02', 'melon', 'p01', 5, '인천시 계양구', '13/01/10');
insert into 주문 values('o03', 'banana', 'p06', 45, '경기도 부천시', '13/01/11');
insert into 주문 values('o04', 'carrot', 'p02', 8, '부산시 금정구', '13/02/01');
insert into 주문 values('o05', 'melon', 'p06', 36, '경기도 용인시', '13/02/20');
insert into 주문 values('o06', 'banana', 'p01', 19, '충청북도 보은군', '13/03/02');
insert into 주문 values('o07', 'apple', 'p03', 22, '서울시 영등포구', '13/03/15');
insert into 주문 values('o08', 'pear', 'p02', 50, '강원도 춘천시', '13/04/10');
insert into 주문 values('o09', 'banana', 'p04', 15, '전라남도 목포시', '13/04/11');
insert into 주문 values('o10', 'carrot', 'p03', 20, '경기도 안양시', '13/05/22');

select * from 주문;

-- [과제2]
-- [실습 1] 다음에 대하여 SQL문법과 실행결과를 작성하라 
-- 예제7-9 고객 테이블에서 고객아이디, 고객이름, 등급 속성을 검색한다
SELECT 고객아이디, 고객이름, 등급
FROM 고객;

-- 예제7-10 고객 테이블에 존재하는 모든 속성을 검색한다
-- (속성명으로 검색)
SELECT 고객아이디, 고객이름, 나이, 등급, 직업, 적립금
FROM 고객;

-- 예제7-11 고객 테이블에 존재하는 모든 속성을 검색한다
-- (* 로 검색)
SELECT *
FROM 고객;

-- 예제7-12 제품 테이블에서 제조업체를 검색한다
SELECT 제조업체
FROM 제품;

-- 예제7-13) 제품 테이블에서 제조업체를 검색하되, ALL 키워드를 사용한다
SELECT       ALL 제조업체
FROM        제품;

-- 예제7-14) 제품 테이블에서 제조업체 속성을 중복 없이 검색한다(중복 제거)
SELECT      distinct 제조업체
FROM         제품      ;

-- 예제7-15 제품 테이블에서 제품명과 단가를 검색하되, 단가를 가격이라는 새 이름으로 출력한다
SELECT     제품명, 단가 as '단가'
FROM       제품        ;

-- 예제7-16 제품 테이블에서 제품명과 단가 속성을 검색하되, 단가에 500원을 더해 조정단가라는 새 이름으로 출력한다
select 제품명, 단가 + 500 as 조정단가 from 제품;

-- 예제7-17) 제품 테이블에서 한빛제과가 제조한 제품의 제품명, 재고량, 단가를 검색한다
SELECT 제품명, 재고량, 단가
FROM 제품
WHERE 제조업체 = '한빛제과' ;

-- 예제7-18) 주문 테이블에서 apple 고객이 15개 이상 주문한 주문제품, 수량, 주문일자를 검색한다-- 주문(주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자)
SELECT 주문제품, 수량, 주문일자
FROM 주문
WHERE 주문고객 = 'apple' ;

-- 예제7-19) 주문 테이블에서 apple 고객이 주문했거나 15개 이상 주문된 제품의 주문제품, 수량, 주문일자, 주문고객을 검색한다
SELECT 주문제품, 수량, 주문일자, 주문고객
FROM 주문
WHERE 주문고객 = 'apple' or 수량 >= 15 ;

-- 예제7-20) 제품 테이블에서 단가가 2000원 이상이면서 3000원 이하인 제품의 제품명, 단가, 제조업체를 검색한다
SELECT 제품명, 단가, 제조업체
FROM 제품
WHERE 단가 between 2000 and 3000 ;

-- 예제7-21) 고객 테이블에서 성이 김씨인 고객의 고객이름, 나이, 등급, 적립금을 검색한다
SELECT 고객이름, 나이, 등급, 적립금
FROM 고객
WHERE 고객이름 like '김%' ;

-- 예제7-22) 고객 테이블에서 고객아이디가 5자인 고객의 고객아이디, 고객이름, 등급을 검색한다
SELECT     고객아이디, 고객이름, 등급
FROM      고객
WHERE    고객아이디 LIKE '____';

SELECT     고객아이디, 고객이름, 등급
FROM      고객
WHERE    char_length(고객아이디) = 5 ;


-- 예제7-23) 고객 테이블에서 나이가 아직 입력되지 않은 고객의 고객이름을 검색한다
SELECT     고객이름
FROM      고객
WHERE    나이 is null;

-- 예제7-24) 고객 테이블에서 나이가 이미 입력된 고객의 고객이름을 검색한다
SELECT     고객이름
FROM      고객
WHERE    나이 is not null;

-- 예제7-25) 고객 테이블에서 고객이름, 등급, 나이를 검색하되, 나이를 기준으로 내림차순 정렬한다
SELECT     고객이름, 등급, 나이
FROM      고객
order by 나이 desc;

-- 예제7-26) 주문 테이블에서 수량이 10개 이상인 주문의 주문고객, 주문제품, 수량, 주문일자를 검색한다. 단, 주문제품을 기준으로 오름차순 정렬하고, 동일 제품은 수량을 기준으로 내림차순 정렬한다
SELECT    주문고객, 주문제품, 수량, 주문일자
FROM      주문
where 수량 >= 10
order by 주문제품, 수량 desc;

-- [실습 2] 집계함수, group by
-- 예제7-27) 제품 테이블에서 모든 제품의 단가 평균을 검색한다
SELECT   avg(단가)
FROM    제품;

-- 예제7-28) 한빛제과에서 제조한 제품의 재고량 합계를 제품 테이블에서 검색한다
SELECT  sum(재고량)
FROM    제품
where 제조업체 = '한빛제과';

-- 예제7-29) 고객 테이블에 고객이 몇 명 등록되어 있는지 검색한다
-- 1) 고객아이디 속성을 이용해 계산하는 경우
select count(고객아이디) 
from 고객;

-- 2) 나이 속성을 이용해 계산하는 경우(널 값 제외)
select count(*) 
from 고객
where 나이 is not null;

-- 3)  * 을 이용해 계산하는 경우
select count(*) 
from 고객;

-- 예제7-30) 제품 테이블에서 제조업체의 수를 검색한다
SELECT  distinct count(제조업체)
FROM    제품;

-- 예제7-31) 주문 테이블에서 주문제품별 수량의 합계를 검색한다
select sum(수량)
from 주문
group by 주문제품;

-- 예제7-32) 제품 테이블에서 제조업체별로 제조한 제품의 개수와 제품 중 가장 비싼 단가를 검색하되, 제품의 개수는 제품수라는 이름으로 출력하고 가장 비싼 단가는 최고가라는 이름으로 출력한다
select 재고량 as '제품수', max(단가) as '최고가'
from 제품
group by 제조업체;

-- 예제7-33) 제품 테이블에서 제품을 3개 이상 제조한 제조업체별로 제품의 개수와 제품 중 가장 비싼 단가를 검색한다
select 재고량, max(단가)
from 제품
where 재고량 >= 3
group by 제조업체;

-- 예제7-34) 고객 테이블에서 적립금 평균이 1000원 이상인 등급에 대해 등급별 고객 수와 적립금 평균을 검색한다

-- 예제7-35) 주문 테이블에서 각 주문고객이 주문한 제품의 총주문수량을 주문제품별로 검색한다