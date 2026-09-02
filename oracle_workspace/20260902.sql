-- 오늘 트랜젝션 ,뷰, 시퀄스 배움 
select * from tab;

/*
테이블의 내용을 수정하기 위한 update
  - 기존의 행을 수정하는것을 의미함
     그러므로 어떤 행을 수정할지를 where절을 이용하여 조건을 지정함
     where절을 사용하지 않을 경우는 테이블에 있는 모든 행을 수정한다.
     테이블내용 전체를 수정할지, 조건을 주어 하나의 행만 수정할지를 판단해야함

   형식
       update 테이블명 set 컬럼1=값1, 컬럼2=값2, 컬럼3=값3 where 조건:
*/

-- 테이블의 모든 행 변경 -> where절을 추가지 않으면 테이블을 모든행을 변경한다.
select * from emp01;
drop table emp01;
create table emp01 as select * from emp;

-- 모든 사원의 부서번호를 30번으로 변경하시오.
update emp01 set deptno =30;

-- 전상태로 되돌리기(맨 처음 생성된 상태로 돌아간다)
rollback;

-- 모든 사원의 급여를 10% 인상하는 쿼리문을 작성하시오
select sal from emp;
select sal from emp01;
update emp01 set sal= sal*1.1;
rollback;

-- 입사일을 오늘 날짜로 바꾸시오
select hiredate from emp01;
--           입사일
select sysdate from dual;
update emp01 set hiredate=sysdate;

/*
테이블의 특정 행만 변경
   update 문에 where절을 추가하면 조건을 만족하는 테이블을 행을 변경할 수 있다.
*/

select * from emp01 where deptno=10;
select * from emp01 where deptno=20;
select * from emp01 where deptno=30;
-- 문] 부서번호가 10번인 사원을 부서번호를 30번으로 수정하시오
update emp01 set deptno=30 where deptno=10;
rollback;

-- 문] 급여가 3000이상인 사원만 급여를 10% 인상합니다.

-- 10% 인상 전
select * from emp01 where sal >=3000; 

-- 10% 인상 후
update emp01 set sal= sal*1.1 where sal >=3000;
rollback;

-- 1987년에 입사한 사원의 입사일을 오늘로 변경하시오.

-- 확인용
select * from  emp01;

-- 입사일 변경 적용 코드
update emp01 set hiredate = sysdate where substr(hiredate,1,2)=87;
rollback;


/*
     테이블에서 2개 시상의 컬럼 값 변경
       테이블에서 하나의 컬럼이 아닌 복수개의 컬럼값을 변경하려면 기존 set절에
       ,를 추가하고 컬럼=값 형식으로 추가하면 된다.
*/

-- 문] scott의 부서번호는 20번으로, 지급은 MANAGER로 수정하시오.
update emp01 set deptno=20, job='MANAGER' where ename='SCOTT';
select ename, deptno, job from emp01 where ename='SCOTT';

select * from emp01;

-- scott의 입사일의 오늘로, 급여 50, 커미션의 4000으로 수정하시오.
update emp01 set hiredate=sysdate, sal=50, comm=4000 where ename='SCOTT';

/*
   테이블에 불필요한 행을 삭제하시오 위한 delete
      - 특정 행의 삭제함
      
      형식: delete from 테이블명 where 조건;
*/
-- 부서 테이블의 모든 데이터 삭제(조건이 없는 경우)
delete from dept01;select ename, deptno, job from emp01 where ename='SCOTT';

-- 부서번호가 30번 부서를 삭제하시오.
delete from dept01 where deptno=30;

-- 테이블 dept01 생성
create table dept01 as select * from dept;

-- 테이블 dept01 삭제
drop table dept01;
select * from dept01;
select * from emp01;
rollback;


----------- END DML --------------




/*
    트랜젝션(Transaction)
       - 데이터 베이스에서 데이터를 처리하는 한아ㅢ 논리적인 작업 단위를 의미함
          데이터의 일관성을 유지하고 안정적으로 데이터를 복구 시키기 위함
        
       - insert, update, delete 명령으로 메모리상에서만 변경되다가 특정단위로
          하드디스크의 실제 파일인 데이터베이스에 저장되는 단위임
          
        ex) 
              안씨 계좌에서 돈이 인출되었는데, 한씨 계좌로 일급 처리 도중에 
              문제가 발생했다면 한씨 계좌에 정상적으로 입금되지 않는다면 
              안씨 계좌의 인출 작업도 취소 되어야하고, 처리 중간에 무슨
              - 문제가 발생한다면 진행되던 인출과정 전체를 취소하고, 다시
              처음으로 시작해야 하기 떄문에 이런 작업을 트랜젝션이라 한다.-
              
              commit과 rollback 
              
              commit
                - 모든 작업들을 정상적으로 처리하겠다고, 확정하는 명령어로 
                    트랜잭션 처리과정을 데이터베이스에 모두 반영하기 위해서
                    변경된 내용을 모두 영구 저장한다는 의미
                    commit 명령어를 수행하게 되면 하나의 트랜잭션 과정이 종료가됨
              
               rollback
                 - 작업 도중에 문제가 발생되서 트랜젝션의 처리과정에서 발생한 변경 사항을 취소하는 명령임
                    rollback 명령어 역시 트랜잭션 과정을 종료하게됨
                    rollback은 트랜잭션으로 인한 하나의 묶음처리가 시작되기 이저의 상태로 되돌림
                    
              commit 명령어와 rollback 명령어의 장점
                 1. 데이터의 무결성을 보장함
                 2. 영구적인 변경 전에 데이터의 변경 사항을 확인이 가능함
                 3. 논리적으로 연관된 작업을 그룹화 할 수 있음
                 
              commit 명령어
                 1. 트랜잭션(insert, update, delete) 작업 내용을 실제 데이터베이스에 저장함
                 2. 이전 데이터가 완전히 수정됨
                 3. 모든 사용자가 변경된 데이터의 결과를 볼 수 가 있음
                 
              rollback 명령어
                 1. 트랜잭션(insert, update, delete)작업 내용을 모두 취소함
                 2. 이전 commit한 곳까지 작업을 되돌림
                 
              자동 commit명령과 자동 rollback 명령이 되는 경우
                 sql developer를 종료하면 자동으로 commit 되지만 
                 비정상 종료가 되면 자동으로 rollback됨
*/
-- dept01 삭제
drop table dept01;

-- dept01 생성
create table dept01 as select * from dept;

-- dept01 확인
select * from dept01;

-- dept01 삭제
delete from dept01;

-- dept01 이전 상태로 되돌리기
rollback;


-- 부서 번호 20번 사원에 대한 정보만 삭제한 후 확인
delete from dept01 where deptno=20;

commit; 
-- 삭제한 후 commit을 하게되면 rollback을 해도 되돌아오지 않음

select * from dept01;
rollback;



/* 
무결성 제약 조건의 개념과 종류
   무결성 제약 조건은 데이터를 추가, 수정, 삭제하는 과정에서 무결성을 유지할 수 있도록
   제약을 주는 것을 의미함
   
   무결성이란? 
   데이터 베이스 내에 데이터의 확장성을 유지하는 것을 의미하고,
   계약조건은 바람직하지 않은 데이터가 저장되는 것을 방지하는 것을 말한다.
   
   무결성 제약조건의 종류
   
   NOT NULL: NULL을 허용하지 않는다.
   UNIQUE: 중복값을 허용하지 않는다. 즉 항상 유일한 값을 갖도록 한다.
   PRIMARY KEY: NULL을 허용하지 않고, 중복된 값도 허용하지 않는다.
                            즉, NOT NULL 조건과 UNIQUE 조건을 결합한 형태임
   FOREING KEY: 참조되는 테이블의 컬럼의 값이 존재하면 허용함
   CHECK: 저장 가능한 데이터값의 범위나 조건을 조정하여 설정된 값만을 사용함
*/

select * from tab;
purge recyclebin;
drop table emp01;

create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4)
);

-- not null 제약 조건을 지정하기 않았기 때문에 null 값이 저장된다.
insert into emp01 values(null, null, 'SALESMAN', 30);
select * from emp01;

/*
사원 테이블에 사원의 정보를 저장할떄 사원번호와 사원의 이름이 반드시 저장되도록 하기위해서
사원 테이블를 생성할떄 사원번호와 사원이름을 not null 조건을 지정해야한다.
not null 제약 조건은 해당 컬럼에 null 값을 추가하거나 null값을 변경하는 것을 막는 것

제약조건은 컬럼명과 자료형을 기술한 후에 연이어서 not null을 기술하면 된다.
*/

-- 사원번호, 사원명, 직급, 부서번호 4개의 컬럼으로 구성하되 사원번호와 사원명에 not null
-- 조건을 지정하여 emp02 테이블을 생성하시오.

create table emp02(
empno number(4)UNIQUE not null,
ename varchar2(10)not null,
job varchar2(9),
deptno number(4)
);

-- not null 제약 조건떄문에 사원번호, 사원명은 필수 입력란으로 null은 값에 저장되지 않아 오류가 발생함
insert into emp02 values(7499, 'DEKU', 'SALESMAN', 30);
select * from emp02;

/*
  unique 제약 조건
     - 특정 컬럼에 대해 자료가 중복되지 않게 하는 것이다.
       즉, 지정된 컬럼에는 유일한 값이 저장되게 하는 것
       
*/

/*
  사원테이블의 사원번호를 유일키로 지정하기 위해 제약조건은 컬럼명과
  자료형을 기술한 후에 이어서 unique를 기술하면 됨
*/
create table emp03(
empno number(4)UNIQUE,
ename varchar2(10)not null,
job varchar2(9),
deptno number(4)
);

-- 둘 중 누가 먼저 7499에 넣으면 그 값에 그 값만 넣어져서 중복으로 같은 곳에 값을 저장하지 못함
insert into emp03 values(7499, 'MIDORIYA', 'SALESMAN', 30);
insert into emp03 values(null, 'IZUKU', 'MANAGER', 30);
insert into emp03 values(null, 'IZUKU', 'MANAGER', 10);

-- NULL은 값에서 제외되므로 유일한 조건인지를 체크하는 값에서 제외가 된다.
select * from emp03;

-- UNOQUE는 NULL값을 예외로 간주한다. 만약 NULL 값마저도 입력되지 않게 제한하려면
-- 테이블 생성시 EMPNO NUMBER(4) UNIQUE NOT NULL 두 가지 제약 조건을 기술해야한다.
create table emp04(
--                        제약 조건을 2가지를 넣음(UNIQUE, NOT NULL)
empno number(4)UNIQUE NOT NULL,
ename varchar2(10)not null,
job varchar2(9),
deptno number(4)
);


insert into emp04 values(7499, 'MIDORIYA', 'SALESMAN', 30);
insert into emp04 values(null, 'IZUKU', 'MANAGER', 30);
insert into emp04 values(null, 'IZUKU', 'MANAGER', 10);


create table emp06(
empno number(4)primary KEY,
ename varchar2(10)not null,
job varchar2(9),
deptno number(4)
);

insert into emp06 values(7499, 'MIDORIYA', 'SALESMAN', 30);
insert into emp06 values(null, 'IZUKU', 'MANAGER', 30);
insert into emp06 values(null, 'IZUKU', 'MANAGER', 10);

select * from emp06;

-- 생성한 테이블을 정보를 검색하려면
desc user_tables;
  
-- 현재 오라클 서버에 접속한 사용자 계정과 테이블을 조회
show user;
select table_name from user_tables order by table_name desc;

/*
계약 조건 확인
  계약조건(constraints)의 에러 메시지에 대한 정확한 원인을 알기 위해
  오라클에서 제공해 주는 user_constraints 데이터 딕셔너리가 있다.
  user_constraints 데이터 딕셔너리는 제약 조건의 정보를 위해서 많은
  컬럼으로 구성되어 있지만 제약 조건명(user_constraints), 제약
  조건유형(constraint_type), 제약 조건이 설정된 테이블명만을 알아본다.
*/
SELECT constraint_name, constraint_type, table_name 
FROM user_constraints WHERE table_name = 'EMP01';

SELECT constraint_name, constraint_type, table_name 
FROM user_constraints WHERE table_name = 'EMP02';

SELECT constraint_name, constraint_type, table_name 
FROM user_constraints WHERE table_name = 'EMP03';

SELECT constraint_name, constraint_type, table_name 
FROM user_constraints WHERE table_name = 'EMP04';

SELECT constraint_name, constraint_type, table_name 
FROM user_constraints WHERE table_name = 'EMP05';

/*
constraint_type은 P,R,U,C 4가지 유형이 있다.

   P: primary key
   R: foreign key
   U: unique
   C: check not null
*/

/*
user_cons_columns 데이터 딕셔너리 제약조건이 지정된 컬럼명도 저장함
*/
select * from user_cons_columns where table_name='EMP02';
select * from user_cons_columns where table_name='EMP03';
select * from user_cons_columns where table_name='EMP04';
select * from user_cons_columns where table_name='EMP05';


/*
참조 무결성을 위한 FOREIGN KEY 제약 조건

    - 두 테이블 사이의 주종관계에서 설정된다.
    
    즉, 먼저 존재해야 하는 테이블(부서)이 주체가 되는 테이블이므로
    부모 테이블이 되고, 이를 참조하는 테이블인 사원테이블이 자식 테이블이 된다.
    
    소속이란 관계는 두 테이블 간의 참조 무결성이란 개념을 포함한 외래키 제약 조건을
    명시 해야만 설정된다.
    
    외래키 제약 조건은 자식 테이블인 사원테이블 부서번호 컬럼ㅇ에 부모 테이블인 
    부서 테이블의 부서번호를 부모키로 설정하는 것이다.
    
    부모: 키가 되기위한 컬럼은 반드시 부모 테이블의 기본키나 유일키롤 설정되어 있어야한다.
*/
-- 외래키 제약 조건에 지정하지 않은 emp06테이블에 부서 테이블에 존재하지 않은 50번 부서를
-- 50번 부서 번호를 저장하도록 해보자

desc emp04;
select * from emp04;
select * from dept;
insert into emp04 values(7566,'JONES','MANAGER',50);

/*
외래키 제약 조건은 emp05 테이블 생성시 컬럼명과 자료형을 기술한 후
REFERENCES를 기술하면 된다.
DEPTNO 컬럼을 참조하게 외래키 제약조건을 설정하면 된다.
*/
select * from tab;
drop table emp05;
select * from emp05;

create table emp05(
empno number(4)primary KEY,
ename varchar2(10)not null,
job varchar2(9),
deptno number(4)REFERENCES DEPT(DEPTNO)
);

insert into emp05 values(7499, 'ALLEN', 'SALESMAN',30);

-- 50번이 없기때문에 실행이 안됨
insert into emp05 values(7499, 'ALLEN', 'SALESMAN',50);

-- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name 
FROM user_constraints WHERE table_name = 'EMP05';


/*
CHECK 계약 조건
    - 입력되는 값을 체크하여 설정된 값 이외에 값이 들어오면
       오류 메시지와 함께 명령이 수행되지 못하게 하는 것이다.
       
  ex)emp06 사원테이블에 GENDER(성별) 컬럼을 추가하되,
        GENDER 컬럼에는 'M'또는 'F'의 두 값만 저장할 수 있는
        CHECK 제약조건을 설정함
*/

select * from emp07;
create table emp07(
empno number(4) primary key,
ename varchar2(10) not null,
gender varchar2(1) check(gender in('M','F'))
);

insert into emp07 values(7566, 'jones','M');
insert into emp07 values(7566, 'allen','F');

-- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name 
FROM user_constraints WHERE table_name = 'EMP07';

/*
제약 조건명 지정하기
     사용자가 의미 있게 제약 조건명을 명시하여 제약 조건명만으로도 어떤 제약 조건을
     위배했는지 알 수 있게 지정방법이 있다.
     
     형식
          column_name data_type constraint constraint_name constraint_type
          
          제약 조건명 명명규칙
               테이블명 컬럼명 제약조건유형
               
          ex) 기본키 제약 조건명을 EMP05_EMPNO_PK로 지정했다면
                 EMP05_EMPNO_PK
                 테이블명 컬럼명 제약조건유형
*/

select * from emp05;
-- emp05 테이블 삭제
drop table emp05;

create table emp05(
empno number(4) constraint emp05_empno_pk primary key,
ename varchar2(10)constraint emp05_ename not null,
job varchar2(9) constraint emp05_job_uk unique,
deptno NUMBER(4)constraint emp05_deptno_fk references dept(deptno) 
);

-- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name 
FROM user_constraints WHERE table_name = 'EMP05';

insert into emp05 values(7499, 'ALLEN', 'SALESMAN',30);
insert into emp05 values(7499, 'NULL','SALESMAN',50);
insert into emp05 values(7499, 'ALLEN', 'SALESMAN',50);
insert into emp05 values(7500, 'ALLEN', 'SALESMAN',30);
select * from emp05;

/*
테이블에 라벨 방식으로 제약 조건을 지정하기

   1. 복합키로 기본키를 지정할 경우 컬럼 라벨형식으로는 
       불가능하고, 반드시 테이블 라벨 방식을 사용해야한다. 
       
   2. alter table로 제약 조건을 추가할떄
       테이블의 정의가 완료되어서 이미 테이블의 구조가 결정된 후에
       나중에 테이블에 제약 조건을 추가하고자 할떄 테이블 라벨
       방식으로 제약 조건을 지정해야함
       
       테이블 라벨 정의 방식의 기본 형식
       create table table_name(
         column_name1 datatype1,
         column_name2 datatype2,
         
         constraint constraint_name column_name_type(column_name)
         );
*/
-- 컬럼 라벨로 제약 조건을 지정하는 방식
select * from tab;
create table emp04(
empno number(4)primary key,
ename varchar2(10)not null,
job varchar2(9),
deptno number(4) references dept(deptno)
);

drop table emp04;

-- 테이블 라벨로 제약조건을 지정하는 방식
drop table emp04;

create table emp04(
empno number(4),
ename varchar2(10) not null,
job varchar2(9),
deptno number(4),

primary key(empno),
unique(job),
foreign key(deptno)references dept(deptno)
);

insert into emp04 values(7499, 'MIDORIYA', 'SALESMAN', 30);
insert into emp04 values(null, 'IZUKU', 'MANAGER', 30);
insert into emp04 values(null, 'IZUKU', 'MANAGER', 10);

-- 테이블 라벨이서 컬럼의 제약 조건명을 명시적으로 지정해 줄 경우 constraint 키워드를 사용하면 됨
drop table emp03;

create table emp03(
empno number(4),
ename varchar2(10)constraint emp03_ename_nn not null,
job varchar2(9),
deptno number(4),

constraint emp03_empno_pk primary key(empno),
constraint emp03_job_uk unique(job),
constraint emp03_deptno_fk foreign key(deptno) references dept(deptno)
);

-- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name 
FROM user_constraints WHERE table_name = 'EMP03';

/*
제약 조건 변경하기

  1. 추가: 
              테이블 생성이 끝난 후에 제약 조건을 추가하기 위해서 alter table로 추가해 줘야한다.
              alter table 테이블명
              add 제약 조건 제약조건 유형(컬럼명);
*/
drop table emp01;

create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4)
);

-- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name 
FROM user_constraints WHERE table_name = 'EMP01';

-- emp01 테이블의 empno 컬럼에 기본키 설정하고, deptno 외래키를 설정함
alter table emp01
add primary key(empno);

alter table emp01
add constraint emp01_deptno_fk 
foreign key(deptno) references dept(deptno);

/*
  2. 삭제:
              제약 조건을 제거하기 위해서는 DROP CONSTRAINT 다음에 
              제거하고자하는 제약 조건명을 명시하면 됨
              
              ALTER TABLE 테이블명
              DROP CONSTRAINT 제약 조건명;
*/  
 select * from emp05;
 insert into emp05 values(7499,'ALLEN','MANAGER',50);
 
 -- 제약 조건 삭제
 alter table emp05
 drop constraint emp05_empno_pk;
 
 alter table emp05
 drop constraint emp05_deptno_fk;
 
 -- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name 
FROM user_constraints WHERE table_name = 'EMP05';           
            
  3. 수정:


