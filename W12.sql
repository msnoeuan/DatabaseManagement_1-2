create schema W12 default character set utf8mb4;
use W12;
set sql_safe_updates = 0;

drop table if exists 부서;
drop table if exists 사원;
drop table if exists freshman;
drop table if exists dmember;
drop table if exists 수강;
drop table if exists 학생;
drop table if exists 과목;

# =============== 부서 / 사원 table ===============
CREATE TABLE 부서 (
        부서코드   char(1)     NOT NULL ,
        부서이름    varchar(10) ,
        constraint pk_부서_부서코드 PRIMARY KEY(부서코드)
);

CREATE TABLE 사원 (
        사원번호   int     NOT NULL ,
        사원이름   varchar(20) ,
        부서코드   char(1) ,
        constraint pk_사원_사원번호 PRIMARY KEY(사원번호) ,
        constraint fk_사원_부서코드 FOREIGN KEY (부서코드) 
               REFERENCES 부서(부서코드) 
               ON DELETE CASCADE
);

insert into 부서(부서코드, 부서이름) values('A','인사부');
insert into 부서(부서코드, 부서이름) values('B','연구부');
insert into 부서(부서코드, 부서이름) values('C','홍보부');

insert into 사원 values(1,'홍길동','C');
insert into 사원 values(2,'임꺽정','A');
insert into 사원 values(3,'차명석','A');

select * from 부서;
select * from 사원;

-- 1) 부서코드, 부서명, 사원이름을 검색하라
-- 방법 1)
select 부서.부서코드, 부서이름, 사원이름
from 부서, 사원
where 부서.부서코드 = 사원.부서코드;

-- 방법 2)
select 부서.부서코드, 부서이름, 사원이름
from 부서  inner join 사원
on 부서.부서코드 = 사원.부서코드;

# =============== freshman / dmember table ===============
CREATE TABLE freshman ( 
    name    VARCHAR(12) NOT NULL ,
    address VARCHAR(9)
);

CREATE TABLE dmember ( 
     name      VARCHAR(12) NOT NULL ,
     dept_name VARCHAR(30)
);

INSERT INTO freshman VALUES('김광식', '서울');
INSERT INTO freshman VALUES('김현정', '대전');
INSERT INTO freshman VALUES('조영수', '대전');

INSERT INTO dmember VALUES('김광식', '컴퓨터공학과');
INSERT INTO dmember VALUES('김현정', '산업공학과');
INSERT INTO dmember VALUES('이진영', '전자공학과');

SELECT * FROM freshman;
SELECT * FROM dmember;

-- 1. 내부조인
# 1-1) 동등 조인(equi join)
# 방법1) name, address, name, dept_name
select *
from freshman, dmember
where freshman.name = dmember.name;
         
# 방법2) name, address, name, dept_name
select *
from freshman INNER JOIN dmember
ON freshman.name = dmember.name;
                 
#1-2) 자연 조인(natural join)  # 동등조인에서 공통된 필드를 빼고 보여줌
# 방법1) name, address, dept_name
select F.name, address, dept_name  #혹은 select D.name, address, dept_name
from freshman as F, dmember as D  #별명 붙이면 select와 where절 모두 별명으로 사용해야 함
where F.name = D.name;
         
# 방법2) name, address, dept_name
select freshman.name, address, dept_name 
from freshman INNER JOIN dmember 
ON freshman.name = dmember.name;
         
-- 2. 외부조인
# 2-1) 왼쪽 외부조인
select *
from freshman LEFT OUTER JOIN dmember
ON freshman.name = dmember.name;
      
# 2-2) 오른쪽 외부조인
select *
from freshman RIGHT OUTER JOIN demember
on freshman.name = demember.name;
      
# 2-3) 완전 외부조인
select *
from freshman LEFT OUTER JOIN dmember
ON freshman.name = dmember.name
union
select *
from freshman RIGHT OUTER JOIN demember
on freshman.name = demember.name;

# =============== 학생 / 과목 / 수강 table ===============
create table 학생 (
    학번     char(5) ,
    학생명  varchar(20),
    primary key(학번)
);

create table 과목 (
    과목번호  char(5) ,
    과목명     varchar(30 ),
    primary key(과목번호)
);
 
create table 수강 (
    학번        char(5),
    과목번호  char(5),
    성적        int,
    primary key(학번, 과목번호),
    foreign key (학번) references 학생(학번),
    foreign key (과목번호) references 과목(과목번호)
);

insert into 학생 values('11002','이홍근');
insert into 학생 values('24036','김순미');
insert into 학생 values('30419','박상웅');
insert into 학생 values('30555','홍서범');
insert into 학생 values('31890','유동희');
insert into 학생 values('31892','이정무');
insert into 학생 values('32000','김윤식');

insert into 과목 values('CS310','데이터베이스');
insert into 과목 values('CS313','운영체제');
insert into 과목 values('CS345','자료구조');
insert into 과목 values('CS326','자바');
insert into 과목 values('CS546','DB프로그래밍');
insert into 과목 values('CS378','멀티미디어');
insert into 과목 values('CS388','웹프로그래밍');

insert into 수강 values('11002','CS310',98);
insert into 수강 values('11002','CS313',88);
insert into 수강 values('24036','CS345',90);
insert into 수강 values('30419','CS326',78);
insert into 수강 values('31892','CS388',86);
insert into 수강 values('32000','CS378',94);
insert into 수강 values('31890','CS310',92);
 
select * from 학생;
select * from 과목;
select * from 수강;

-- 3-1) 수강한 학생의 학생명, 과목명, 성적을 검색하라(내부조인)
# 방법 1
select 학생명, 과목명, 성적
from 학생, 수강, 과목
where 학생.학번 = 수강. 학번
   AND 수강.과목번호 = 과목.과목번호; # 비교조건절은 테이블수 - 1개

# 방법 2
select 학생명, 과목명, 성적
from 학생 INNER JOIN 수강
on 학생.학번 = 수강.학번
         INNER JOIN 과목
ON 수강.과목번호 = 과목.과목번호;

-- 3-2) 이홍근의 학생명, 과목명, 성적을 검색하라
# 방법 1
select 학생명, 과목명, 성적
from 학생, 수강, 과목
where 학생.학번 = 수강.학번 
   AND 수강.과목번호 = 과목.과목번호 
   AND 학생명 = '이홍근';
   
# 방법 2
select 학생명, 과목명, 성적
from 학생 INNER JOIN 수강
on 학생.학번 = 수강.학번
         INNER JOIN 과목
ON 수강.과목번호 = 과목.과목번호
	where 학생명 = '이홍근';