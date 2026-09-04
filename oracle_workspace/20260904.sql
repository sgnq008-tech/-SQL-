select * from tab;

-- 쓰레기통 비우기
purge recyclebin;


-- 학과 테이블 생성: department
-- 필드: deptno(3), dname(30), college(3), loc(10)
-- constraint DEPARTMENT_PK primary key(DEPTNO)


-- 준비상태
create table department(
deptno number(3), 
-- 기본키 생성
dname varchar2(30), 
college number(3), 
loc varchar2(10),
constraint DEPARTMENT_PK primary key(DEPTNO)
);
--                                                                   기본키 생성

select * from department;

drop table PROFESSOR;

create table PROFESSOR(
PROFNO      NUMBER(5)not null,            -- 교수번호
NAME          VARCHAR2(10) not null,    -- 한글이름
ENAME         VARCHAR(20) not null,      -- 영문이름
POSITION    VARCHAR2(20) not null,   -- 전입, 시간
SAL               NUMBER(4) not null,        -- 급여
HIREDATE      DATE not null,                 -- 입사일
AGE               NUMBER(3) not null,       -- 나이
DEPTNO         NUMBER(3) not null,      -- 학과번호
constraint PROFESSOR_PK primary key(PROFNO)
);

alter table PROFESSOR add constraint PROFESSOR_FK
FOREIGN KEY(deptno)references department(deptno);

select * from professor;

desc professor;