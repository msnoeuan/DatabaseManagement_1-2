create schema W14 default character set utf8mb4;
use W14;
-- (MYSQL) safe mode 해제
set sql_safe_updates = 0;

drop table if exists R;
drop table if exists S;
drop table if exists employee;
drop table if exists department;
DROP TABLE if exists emp;
DROP TABLE if exists 추천고객;
DROP TABLE if exists pro;
DROP TABLE if exists stu;

# =============== R / S table ===============
CREATE TABLE R (
	A char(1) ,
	B char(1)
);

CREATE TABLE S (
	B char(1) ,
	C char(1)
);

INSERT INTO R VALUES ('a', '2');
INSERT INTO R VALUES ('b', '3');
INSERT INTO R VALUES ('c', '3');
INSERT INTO R VALUES ('d', '5');

INSERT INTO S VALUES ('1', 'x');
INSERT INTO S VALUES ('2', 'y');
INSERT INTO S VALUES ('3', 'z');

select * from R;
select * from S;

-- 1) 자연조인
select A, R.B, C
from R, S
where R.B = S.B;

-- 2) 왼쪽외부조인
select *
from R left outer join S
on R.B = S.B;

-- 3) 오른쪽외부조인
select *
from R right outer join S
on R.B = S.B;

-- 4) 완전외부조인
select *
from R left outer join S
on R.B = S.B
union
select *
from R right outer join S
on R.B = S.B;

# =============== employee / department table ===============
CREATE TABLE department (
     deptno              int          NOT NULL ,
     deptname          varchar(10) ,
     floor                 int ,
     PRIMARY KEY(deptno)
);

INSERT INTO department VALUES(1, '영업', 8);
INSERT INTO department VALUES(2, '기획', 10);
INSERT INTO department VALUES(3, '개발', 9);
INSERT INTO department VALUES(4, '총무', 7);

CREATE TABLE employee (
    empno	         int	              NOT NULL,
    empname     varchar(10)     UNIQUE,
    title	         varchar(10)     DEFAULT '사원',
    manager       int  ,
    salary            int	 ,
    dno              int	 ,
    PRIMARY KEY(empno),
    FOREIGN KEY(dno) REFERENCES department(deptno)
);

INSERT INTO employee VALUES(2106, '김창섭','대리',1003, 2500000, 2);
INSERT INTO employee VALUES(3426, '박영권','과장',4377, 3000000, 1);
INSERT INTO employee VALUES(3011, '이수민','부장',4377, 4000000, 3);
INSERT INTO employee VALUES(1003, '조민희','과장',4377, 3000000, 2);
INSERT INTO employee VALUES(3427, '최종철','사원',3011, 1500000, 3);
INSERT INTO employee VALUES(1365, '김상원','사원',3426, 1500000, 1);
INSERT INTO employee(empno, empname, title, salary, dno) VALUES(4377, '이성래','이사', 5000000, 2);

select * from department;
select * from employee;

-- 16-1) 김창섭이 속한 부서번호와 부서의 모든 부서번호를 합집합으로 검색하라 (UNION)
select dno 
from employee 
where empname = '김창섭'
union
select deptno 
from department;

-- 16-2) 김창섭이 속한 부서번호와 부서의 모든 부서번호를 합집합으로 검색하라 (UNION ALL)
select dno
from employee
where empname = '김창섭'
union all
select deptno 
from department;

-- 17) 사원명과 부서명을 검색하라(조인)
select empname, deptname
from employee, department
where department.deptno = employee.dno;

-- 19) 사원에 대해서 부서이름, 사원이름, 직급, 급여를 검색하라.
-- 부서이름에 대해서 오름차순, 부서이름이 같을 경우에는 salary에 대해서 내림차순으로 정렬하라
select deptname, empname, title, salary
from department, employee
where department.deptno = employee.dno
order by deptname ASC, salary DESC;

-- 20) 박영권과 같은 직급을 갖는 모든 사원들의 이름과 직급을 검색하라
select empname, title
from employee
where title = ( select title
		        from employee
                where empname = '박영권');

-- 21) 영업부나 개발부에 근무하는 사원들의 이름을 검색하라(IN 사용)
select empname, dno
from employee
where dno in ( select deptno
			   from department
			   where deptname in('영업', '개발'));
        
-- 21-02) 영업부나 개발부에 근무하지 않는 사원들의 이름을 검색하라(NOT IN 사용)
select empname, dno
from employee
where dno not in ( select deptno
			       from department
			       where deptname in('영업', '개발'));

-- 24) 사원들이 한 명도 소속되지 않은 부서명을 검색하라 (NOT EXISTS 사용)
select deptname
from department D
where not exists(select *
                 from employee E
				 where D.deptno = E.dno);
                 
-- 25) 자신이 속한 붜의 사원들의 평균급여보다 많은 급여를 받는 사원들에 대해서 이름, 부서번호, 급여를 검색하라(상관중첩질의)
select empname, dno, salary
from employee E1
where salary > (select avg(salary)
                from employee E2
				where E1.dno = E2.dno);

# =============== emp table ===============
create table emp (
    empno       char(4) PRIMARY KEY ,
    empname   varchar(12) ,
    manager    char(4) ,
    dno          char(1) ,
    FOREIGN KEY (manager) REFERENCES emp(empno)
);

insert into emp values('3011','이수민',NULL,'1');
insert into emp values('3426','박영권','3011','3');
insert into emp values('1003','조민희','3011','1');
insert into emp values('2106','김창섭','3426','2');
insert into emp values('3427','최종철','2106','3');

select * from emp;

-- 사원명과 직속상사명을 검색하라
select E.empname 사원명, M.empname as 직속상사명
from emp as E, emp as M
where E.manager = M.empno;

# =============== 추천고객 table ===============
create table 추천고객 (
    고객아이디   char(20)    NOT NULL PRIMARY KEY ,
    고객이름     varchar(20)  ,
    나이         int ,
    등급         varchar(10) ,
    직업         varchar(10) ,
    적립금       int ,
    추천고객     char(20) ,
    foreign key(추천고객) references 추천고객(고객아이디)
);

insert into 추천고객 values('orange','정지영',22,'silver','학생',0, NULL);
insert into 추천고객 values('apple','김현준',20,'gold','학생',1000, 'orange');
insert into 추천고객 values('banana','정소화',25,'vip','간호사',2500, 'orange');
insert into 추천고객 values('carrot','원유선',28,'gold','교사',4500, 'apple');

select * from 추천고객;

-- [Quiz 2-2] 고객명과 추천고객명을 검색하라
select C1.고객이름 고객명, C2.고객이름 추천고객명
from 추천고객 C1, 추천고객 C2
where C1.추천고객 = C2.고객아이디;

# 정지영 - null까지 나옴
select C1.고객이름 고객명, C2.고객이름 추천고객명
from 추천고객 C1 left outer join 추천고객 C2
on C1.추천고객 = C2.고객아이디;

# =============== pro / stu table ===============
CREATE TABLE pro (
    pno   char(2),
    pname varchar(20), 
    dept  varchar(20),
    page  int,
    primary key(pno)
);

CREATE TABLE stu (
    sno   char(2),
    sname varchar(20), 
    dept  varchar(20),
    sage  int,
    primary key(sno)
);

insert into pro values('p1','이정무','컴퓨터',36);
insert into pro values('p2','우태하','컴퓨터',32);
insert into pro values('p3','이성민','건축',45);

insert into stu values('s1','유준호','컴퓨터',23);
insert into stu values('s2','오정민','컴퓨터',34);
insert into stu values('s3','이태현','건축',22);
insert into stu values('s4','신현주','건축',21);

select * from pro;
select * from stu;

-- 3-1) 교수 테이블에서 이정무 의 학과와 같은 학생 이름, 학과, 나이를 검색하라
select sname, dept, sage
from stu
where dept = (select dept
			  from pro
			  where pname = '이정무');

-- 3-2) 교수 테이블에서 pno 가 p1 이거나 p2 인 학과와 같은 학생 이름, 학과, 나이를 검색하라
select sname, dept, sage
from stu
where dept in (select dept
			   from pro
			   where pno in('p1', 'p2'));

-- 3-3) 학생 테이블과 교수 테이블에서 모든 학생들보다 나이가 많은 교수의 교번, 이름, 나이를 ALL 구문을 이용하여 검색하라
select pno, pname, page
from pro
where page > all (select sage
                  from stu);

-- 3-4) 학생 테이블과 교수 테이블에서 한 명 이상 교수보다 나이가 많은 학생이 있을 경우 학생의 학번, 이름, 나이를 SOME 구문으로 검색하라
select sno,sname,sage
from stu
where sage > any (select page
                  from pro);

-- 3-5) 가장 나이가 많은 학생 이름, 나이를 검색하라
select sname,sage
from stu
where sage = (select max(sage)
              from stu);
                  
-- 3-6) 각 학과마다 가장 나이가 많은 학생 이름, 학과, 나이를 검색하라
select sname,dept,sage
from stu
where sage in (select max(sage)
               from stu
               group by dept);
                  