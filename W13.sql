create schema W13 default character set utf8mb4;
use W13;
set sql_safe_updates = 0;

drop table if exists R1;
drop table if exists S1;
drop table if exists omember;
drop table if exists group_ex;
drop table if exists emp;
drop table if exists project;
drop table if exists 정회원;
drop table if exists 준회원;
drop table if exists employee;
drop table if exists department;
drop table if exists R;
drop table if exists S;

# =============== R1 / S1 table ===============
CREATE TABLE R1 (
	A int ,
	B int 
);

CREATE TABLE S1 (
	A int ,
	C int ,
	D int 
);

INSERT INTO R1 VALUES (1, 4);
INSERT INTO R1 VALUES (2, 5);

INSERT INTO S1 VALUES (1,3,4);
INSERT INTO S1 VALUES (2,2,6);
INSERT INTO S1 VALUES (3,1,9);

select * from R1;
select * from S1;

-- 1. 카티션 프로덕트
select *
from R1, S1;

-- 2. 동등 조인
select *
from R1, S1
where R1.A = S1.A;

-- 3. 자연 조인
select R1.A, B, C, D
from R1, S1
where R1.A = S1.A;

select R1.A, B, C, D
from R1 inner join S1
on R1.A = S1.A;

-- 4. 세타 조인
select *
from R1, S1
where R1.A >= S1.C;

# =============== omember / group_ex table ===============
CREATE TABLE omember ( 
   id         CHAR(3)     NOT NULL ,
   groupid CHAR(1)
);

CREATE TABLE group_ex ( 
   groupid   CHAR(1)   NOT NULL ,
   position   VARCHAR(12)
);

INSERT INTO omember VALUES('100', 'A');
INSERT INTO omember VALUES('101', 'B');
INSERT INTO omember VALUES('102', 'A');
INSERT INTO omember VALUES('103', 'F');

INSERT INTO group_ex VALUES('A', '서울');
INSERT INTO group_ex VALUES('B', '대구');
INSERT INTO group_ex VALUES('C', '광주');
INSERT INTO group_ex VALUES('D', '부산');
INSERT INTO group_ex VALUES('E', '대전');

SELECT * FROM omember;
SELECT * FROM group_ex;

select id, omember.groupid, position
from omember, group_ex
where omember.groupid = group_ex.groupid;

select *
from omember RIGHT OUTER JOIN group_ex
on omember.groupid = group_ex.groupid;

select *
from omember left outer join group_ex
on omember.groupid = group_ex.groupid
UNION
select *
from omember right outer join group_ex
on omember.groupid = group_ex.groupid;

# =============== emp / project table ===============
CREATE TABLE emp ( 
    ename    VARCHAR(12)  NOT NULL ,
    pno       int
);

CREATE TABLE project ( 
   pno        int                  NOT NULL ,
   pname    VARCHAR(20)
);

INSERT INTO emp VALUES('홍길동', 101);
INSERT INTO emp VALUES('임꺽정', 102);
INSERT INTO emp VALUES('박찬호', 101);
INSERT INTO emp VALUES('박찬호', 103);
INSERT INTO emp VALUES('신동엽', NULL);

INSERT INTO project VALUES(101, '작전중');
INSERT INTO project VALUES(102, '특공대');
INSERT INTO project VALUES(103, '유레카');
INSERT INTO project VALUES(104, '다모여');

SELECT * FROM emp;
SELECT * FROM project;

-- 1. 카티션 프로덕트
select *
from emp, project;

-- 2. 동등 조인
select *
from emp, project
where emp.pno = project.pno;

-- 3. 자연 조인
select ename, emp.pno, pname
from emp, project
where emp.pno = project.pno;

select ename, emp.pno, pname
from emp inner join project
on emp.pno = project.pno;

-- 4. 왼쪽 외부 조인
select *
from emp left outer join project
on emp.pno = project.pno;

-- 5. 오른쪽 외부 조인
select *
from emp right outer join project
on emp.pno = project.pno;

-- 6. 완전 외부 조인
select *
from emp left outer join project
on emp.pno = project.pno
union
select *
from emp right outer join project
on emp.pno = project.pno;

# =============== 정회원 / 준회원 table ===============
CREATE TABLE 정회원 (
    번호 		INT 	PRIMARY KEY  ,
    이름 		varCHAR(12) 	NOT NULL ,
    주민번호 	CHAR(14) 	NOT NULL ,
    휴대폰번호 	CHAR(14) 	NOT NULL,
    이메일 	VARCHAR(30) ,
    등록일 	CHAR(8)
);

CREATE TABLE 준회원 (
    번호 		INT 	PRIMARY KEY  ,
    이름 		varCHAR(12) 	NOT NULL ,
    주민번호 	CHAR(14) 	NOT NULL ,
    휴대폰번호 	CHAR(14) 	NOT NULL,
    이메일 	VARCHAR(30) ,
    등록일 	CHAR(8)
);

INSERT INTO 정회원 ( 번호, 이름, 주민번호, 휴대폰번호, 이메일, 등록일)
VALUES ( 1, '홍길동', '820416-1234567', '(011) 123-1231','gdhong@hitel.net','20070302');
INSERT INTO 정회원 ( 번호, 이름, 주민번호, 휴대폰번호, 이메일, 등록일)
VALUES ( 2, '임꺽정', '830507-2345678', '(010) 122-1222','jung@hanmail.net','20050422');
 
INSERT INTO 준회원 ( 번호, 이름, 주민번호, 휴대폰번호, 이메일, 등록일)
VALUES ( 1, '홍길동', '820416-1234567', '(011) 123-1231','gdhong@hitel.net','20070302');
INSERT INTO 준회원 ( 번호, 이름, 주민번호, 휴대폰번호, 이메일, 등록일)
VALUES ( 3, '박찬호', '850321-1456789', '(010) 133-1231','chpark@hanmail.net','20090512');
INSERT INTO 준회원 ( 번호, 이름, 주민번호, 휴대폰번호, 이메일, 등록일)
VALUES ( 4, '선동열', '761122-1889911', '(010) 144-1222','sun@naver.com','20080605');
 
SELECT * FROM 정회원;
SELECT * FROM 준회원;

select * from 정회원
UNION
select * from 준회원;

# =============== department / employee table ===============
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

-- 16-1) 김창섭이 속한 부서번호와 부서의 모든 부서번호를 합집합으로 검색하라 (UNION)'
select dno from employee where empname = '김창섭'
union
select deptno from department;

-- 16-2) 김창섭이 속한 부서번호와 부서의 모든 부서번호를 합집합으로 검색하라 (UNION ALL)
select dno from employee where empname = '김창섭'
union ALL
select deptno from department;

-- 17) 사원의 이름과 이 사원이 속한 부서이름을 검색하라 (조인)
select empname, deptname
from employee, department
where department.deptno = employee.dno;

-- 19) 사원에 대해서 부서이름, 사원이름, 직급, 급여를 검색하라.
-- 부서이름에 대해서 오름차순, 부서이름이 같을 경우에는 salary에 대해서 내림차순으로 정렬하라
select deptname, empname, title, salary
from employee, department
where department.deptno = employee.dno
order by deptname asc, salary desc;

# =============== R / S table ===============
CREATE TABLE R (
	A char(2) ,
	B char(2) ,
              C char(2) 
);

CREATE TABLE S (
	B char(2) ,
	C char(2) ,
              D char(2) 
);

INSERT INTO R VALUES ('a1','b1','c1');
INSERT INTO R VALUES ('a2','b1','c1');
INSERT INTO R VALUES ('a2','b1','c2');
INSERT INTO R VALUES ('a4','b2','c3');

INSERT INTO S VALUES ('b1','c1','d1');
INSERT INTO S VALUES ('b1','c1','d2');
INSERT INTO S VALUES ('b2','c2','d3');

select * from R;
select * from S;