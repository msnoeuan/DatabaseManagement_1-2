create schema W10 default character set utf8mb4;
use W10;
-- (MYSQL) safe mode 해제
set sql_safe_updates = 0;

-- 테이블 구조 확인
DESC 테이블명;

drop table if exists 사원;
drop table if exists 부서;
drop table if exists 고객;
drop table if exists 제품;
drop table if exists 주문;

# =============== 부서 table ===============
create table 부서 (
   부서번호 int not null,
   부서이름 varchar(10),
   primary key(부서번호)
);

insert into 부서 values(1, '인사부');
insert into 부서 values(2, '연구부');
insert into 부서 values(3, '홍보부');

select * from 부서;

# =============== 사원 table ===============
create table 사원 (
   사원번호 int not null,
   사원이름 varchar(10),
   소속부서 int,
   primary key(사원번호),
   foreign key(소속부서) references 부서(부서번호)
      #on delete no action
      #on delete cascade
      #on delete set null
);

insert into 사원 values(1001, '홍길동', 3);
insert into 사원 values(1002, '임꺽정', 1);
insert into 사원 values(1003, '차명석', 1);

select * from 사원;


-- 1) 부서번호 3인 홍보부를 삭제하라
delete from 부서 where 부서번호 = 3;  #자식 테이블에 참조되는 값이 있으므로 오류 발생

-- 2) 임꺽정 소속부서를 5로 수정하라
update 사원 set 소속부서 = 5 where 사원이름 = '임꺽정';  #부모 테이블에 참조값이 없으므로 오류 발생

-- 3) 부서번호 1을 부서번호 9로 수정하라
update 부서 set 부서번호 = 9 where 부서번호 = 1;  #자식 테이블에 참조되는 값이 있으므로 오류 발생

-- 4) 부서 테이블에 새로운 레코드를 입력하라
insert into 부서 values(4, '개발부');

-- 5) 사원 테이블에서 차명석을 삭제하라
delete from 사원 where 사원이름 = '차명석';

# =============== 고객 table ===============
create table 고객 (
   고객아이디 varchar(20) not null,
   고객이름 varchar(10),
   나이 int,
   등급 varchar(10) not null,
   직업 varchar(20),
   적립금 int default 0,
   primary key(고객아이디)
);

desc 고객;

# =============== 제품 table ===============
-- 1) 제품번호 속성이 기본키다
-- 2) 재고량이 항상 0개 이상 10,000개 이하를 유지한다
create table 제품 (
   제품번호 char(3),
   제품명 varchar(20),
   재고량 int,
   단가 int,
   제조업체 varchar(20),
   primary key(제품번호),
   check(재고량 >= 0 and 재고량 <= 10000)
);


# =============== 주문 table ===============
-- 1) 주문번호 속성이 기본키다
-- 2) 주문고객 속성이 고객 테이블의 고객아이디를 참조하는 외래키이다
-- 3) 주문제품 속성이 제품 테이블의 제품번호 속성을 참조하는 외래키이다
create table 주문 (
   주문번호 char(3) not null,
   주문고객 varchar(20),
   주문제품 char(3),
   수량 int,
   배송지 varchar(30),
   주문일자 date,
   primary key(주문번호),
   foreign key(주문고객)
      references 고객(고객아이디),
  foreign key(주문제품)
     references 제품(제품번호)
);

desc 주문;

