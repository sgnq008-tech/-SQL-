select * from tab;

/*
제약 조건의 비활성화와 cascade
      - 제약조건의 비활성화란 설정된 제약 조건을 잠시 사용하지 않게 하는 것이다.
      
    1. DISABLE CONSTRAINT: 제약 조건의 일시 비활성화
    2. ENABLE CONSTRAINT: 비활성된 제약건을 해제하여 다시 활성화시킴
*/

-- dept01 테이블 삭제
 drop table dept01;
 
 create table dept01(
  deptno number(2) constraint dept01_deptno_pk primary key,
  dname varchar2(14),
  loc varchar2(10)
  );
  
-- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name 
FROM user_constraints WHERE table_name = 'DEPT01';  

-- 데이터 추가
insert into dept01 values(10,'accounting','new york');
insert into dept01 values(20,'research','dallas');

-- 확인용
SELECT * FROM dept01;


drop table emp01;

CREATE TABLE emp01 (
    empno   NUMBER(4),
    ename   VARCHAR2(10),
    job     VARCHAR2(9),
    deptno  NUMBER(2) CONSTRAINT emp01_deptno_dept_fk REFERENCES dept01(deptno)
);
  
 -- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name, status 
FROM user_constraints WHERE table_name = 'EMP01'; 

DROP TABLE emp01 PURGE;

ALTER TABLE emp01
DISABLE CONSTRAINT emp01_deptno_dept_fk;
select * from dept01;

-- 데이터 추가
insert into emp01 values(7499,'ALLEN','SALESMAN',10);
insert into emp01 values(7369,'SMITH','CLERK',20);
SELECT * FROM EMP01;

-- 자식 테이블인 emp01는 부모테이블은 dept01의 기본키인 부서번호를 참조하고 있어 삭제할 수 없다.
delete from dept01 where deptno = 10;
rollback;

/*
부서번화가 10번인 자료가 삭제되도록 하기 위해서는 아래와 같이 해야한다.
   1. 부서 테이블의 10번 부서에서 근무하는 사원을 먼저 삭제한 후 부서 테이블에서 10번 부서를 삭제하면 됨
   2. 참조 무결성 떄문에 삭제가 불가능하므로 emp01테이블의 외래키 제약 조건을 제거한 후 10번 부서를 삭제하면 됨 
*/

/*
    1. 제약조건의 비활성화와 활성화
    
      만약 제약조건이 설정되어 있다면 항상 그 규칙에 따라 무결성이 보장됨
      오라클에서는 제약조건을 비활성화 시킴으로써 제약조건을 삭제하지않고도
      제약조건 사용을 잠시 보류할 수 있으며 비활성화된 제약조건은 원하는 작업을
      한 후에 다시 활성화 상태로 되돌릴수 있다.
      
     - 제약조건 비활성화
        
        형식
         
         alter table 테이블명
         disable constraint 제약조건명:
*/

/*
제약 조건의 활성화
alter table 테이블명
         enable constraint 제약조건명:

*/
alter table emp01
enable constraint EMP01_DEPTNO_DEPT_FK;

 -- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name, status 
FROM user_constraints WHERE table_name = 'EMP01';

/*
cascade 옵션 
   - 부모테이블(dept01)과 자식테이블(emp01)간의 참조 설정이
   되어 있을 때 부모 테이블의 제약 조건을 비활성화하면 이를 참조하고 있는 
   자식 테이블의 제약 조건까지 같이 비활성화 시켜주는 옵션
   
   ex) 
        1. dept01테이블 기본키를 비활성화 한다.
        
        alter table dept01
        disable primary key;
        
        부모테이블의 기본키에 대한 제약 조건을 비활성화 하기 위한 작업 순서
       1. 부모테이블의 기본키를 참조하는 자식 테이블의 외래키에 대한 제약 조건을 비활성화 한다.
       2. 부모테이블의 기본키에 대한 제약 조건을 비활성화 한다.
*/
alter table dept01
disable primary key cascade;

 -- 제약 조건 확인
SELECT constraint_name, constraint_type, table_name, r_constraint_name, status 
FROM user_constraints WHERE table_name = 'EMP01';

SELECT constraint_name, constraint_type, table_name, r_constraint_name, status 
FROM user_constraints WHERE table_name = 'DEPT1';

SELECT constraint_name, constraint_type, table_name, r_constraint_name, status
FROM user_constraints WHERE table_name IN ('DEPT01', 'EMP01');

alter table dept01
drop primary key;

/*
 cascade 옵션을 지정하여 기본키 제약 조건을 삭제하게 되면
 이를 참조하는 외래키 제약 조건도 연속적으로 삭제된다.
*/
alter table dept01
drop primary key cascade;


-----------------END constraint------------------


/*
뷰(VIEW)

  - '보다'라는 의미 갖고 있는 점을 감안해보면 알 수 있듯이 실제 테이블에
      저장된 데이터를 뷰를 통해서 볼 수 있다.
      
      뷰를 흔히 가상테이블이라고 부르는데 이유는 테이블과 거의 동일하게 사용하기때문
      뷰는 물리적인 구조인 테이블과 달리 데이터 저장 공간이 없다.
      뷰는 단지 쿼리문을 저장하고 있는 객체라고 표현할 수 있다.
      
      뷰는 중간관리자와 연결해야 볼 수 있다.
*/ 
create view view_emp10
as 
select empno, ename, job, deptno 
from emp01 where deptno=10;
--    기본테이블

desc emp01;

-- 조회
select empno, ename, job, deptno 
from emp01 where deptno=10;

select * from view_emp10;

/*
뷰의 사용 목적
1. 직접적인 테이블 접근을 제한하기 위해서 사용된다.
2. 복잡한 질의를 쉽게 만들기 위해서 사용된다.

뷰의 특징
1. 뷰는 테이블에 대한 제한을 가지고, 테이블의 일정한 부분만 보일 수 있는 가상 테이블
2. 뷰는 실제로 자료를 갖지않지만 뷰를 통해서  테이블을 관리할 수 있다.
3. 하나의 테이블에 뷰는  개수를 제한하지 않는다.

뷰의 생성과 조회

뷰를 생성하기 위해서는 테이블 생성과 같이 create문을 사용한다.

기본 테이블
뷰에 의해 제한적으로 접근해서 사용하는 실질적으로 데이터를 
저장하고 있는 물리적인 테이블을 말한다.
*/

drop table emp01;

create table emp01
as select * from emp;

select empno, ename, sal, deptno from emp01 where deptno=10;


/*
뷰 생성
   뷰는 테이블처럼 하나의 개체로서 테이블을 생성할떄와 유사하게 create view 명령어로 생성
   
   형식
       create [or replace][force | noforcs] view view_name
       as subquery 
       [with check option]
       [width read only]; 
     - 뷰를 통해서는 select만 가능하며 insert/update/delete 명령을 사용할 수 없다.
     
     - 뷰는 조회만 가능함(삽입, 수정, 삭제는 불가능함)
     
     or replace:
       - 새로운 뷰를 만들 수 있을 뿐만이 아니라 기존의 뷰가 존재하더라도
          삭제하지 않고, 새로운 구조의 뷰로 변경할 수 있다.
          
     force | noforcs:
       - 기본 테이블에 존재 여부에 상관없이 뷰를 생성함
       
     with check option:
       - 해당 뷰를 통해서 볼 수 있는 범위내에서만 update 또는 insert가 가능하다.
       
     뷰를 만들떄 권한이 불충분하다고 오류가 발생하는 경우도 있다.
     이럴 경우에는 DBA인 system(관리자2) 계정으로 로그인하여 뷰를 생성할 권한을 부여해야한다.
     특정 사용자에 대해서 아무 문제없이 뷰가 생성된다면 괜찮지만 그렇지 않을 경우
     grant 명령어로 특정 사용자에게 권한을 부여해야한다.
     scott 사용자에게 뷰를 생성할때 create view 권한을 부여하는 명령은 다음과 같다.
     grant create view to scott;
     
     뷰에 관련된 데이터 딕셔너리
       데이터 딕셔너리 user_views에 사용자가 생성한 모든 뷰에 대한 정의가 저장되어 있다.
       
       뷰의 이름을 위한 view_name이란 컬럼과 뷰를 작성할때 기술한 서브쿼리문이 저장되어
       있는 text컬럼이 있다.
*/
select view_name, text from user_views;


/*
뷰의 동작 원리
  1. 사용자가 뷰에 대해서 질의를 하면 user_views에서 뷰에 대한 정의를 조회한다.
  2. 기본 테이블에 대한 뷰의 접근 권한을 살핀다.
  3. 뷰에 대한 질의를 기본 테이블에 대한 질의로 변환한다.
  4. 기본 테이블에 대한 질의를 통해 데이터를 검색한다.
  5. 검색이 다 끝나면 검색된 결과를 출력한다.
  
뷰의 종류
   - 뷰를 정의하기 위해서 사용되는 기본 테이블의 수에 따라 
   단순뷰와 복합뷰로 나뉜다.
   
                단순뷰                                                                복합뷰
     하나의 테이블로 생성                                             여러개의 테이블로 생성
     그룹 함수의 사용이 불가능                                       그룹 함수의 사용이 가능
     DISTINCT 사용이 불가능                                        DISTINCT 사용이 가능
     DML(INSERT/UPDATE/DELETE)사용가능             DML(INSERT/UPDATE/DELETE)불가능     
*/
-- 단순 부에 대한 데이터 조작
-- 단순 뷰는 DML NSERT/UPDATE/DELETE문을 사용 할 수 있음
insert into view_emp10 values(8000,'ANGEL',7000,10);
select * from view_emp10;
rollback;

-- 단순뷰를 대상으로 실행한 DML 명령문의 처리 결과는 뷰를 정의할떄 사용한 기본 테이블에도 적용된다.
select * from emp01;
select view_name, text from user_views;


/*
단순뷰의 컬럼에 별칭 부여
    사원번호, 사원명, 급여, 부서번허로 구성된 뷰를 작성하되 기본 테이블은 EMP01로 하고, 컬럼명은 한글로 한다. 
*/
desc view_emp10;
drop view view_emp10;
select * from emp01;
select * from view_emp10;
delete from emp01 where empno=8000;l

insert into view_emp10 values(8000,'ANGEL',7000,10);

create view view_emp10
as 
select empno, ename, sal, deptno 
from emp01 where deptno=10;

--                                                            한글로쓸떄는 ' ' 안넣어도 됨
create or REPLACE view view_emp(사원번호, 사원명, 급여, 부서번호)
as select empno, ename, sal, deptno from emp01;

select * from view_emp where 부서번호=10;
--        이제 한글로 변경되서 deptno가 아닌 부서번호를 넣어줘야 찾는게 가능


/*
컬럼의 별칭을 사용해서 뷰를 생성하면 view_emp의 컬럼 이름만 별칭으로
데이터 규조에 반영되고, emp01테이블인 기본테이블에는 영향을 미치지 못한다. 
*/


/*
그룹함수를 사용한 단순 뷰
     부서별 급여총액과 평균을 구하는 작업를 자주 한다면
     이를 view로 생성해 놓고 가져다 사용하면 편리하다.
*/
-- 생성하기
create or replace view view_sal
as
select deptno, sum(sal) as"SalSum",
trunc(avg(sal)) as "SalAvg" from emp01 group by deptno;

-- 조회
select * from view_sal;

/*
급여 총액은 SUM이란 그룹함수의 결과는 물리적인 컬럼이 존재하지 않는
가상 컬럼명이기 때문에 컬럼도 상속 받을 수 없다.

사용자가 반드시 이름을 따로 설정해 주어야한다.

단순뷰에서 DML 명령어로 조작이 불가능한 경우

   1. 뷰 정의에 포함되지 않은 컬럼 중에 기본 테이블의 NOT NULL제약 조건이 
       지정되어 있는 경우 insert into문이 불가능 하다.
   
   2. sal * 12와 같이 산술 표현식으로 정의된  가상 컬럼이 뷰에 정의되면
       insert 나 update가 불가능하다.
   
   3. DISTINCT을 포함한 경우에는 DML 명령어를 사용 할 수 없습니다.
   
   4. 그룹함수나 GROUP BY 절을 포함한 경으에도 DML 명령어를  사용할 수 없습니다.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
*/

-- 복합뷰: 두 개 이상의 기본테이블에 의해 정의된 뷰

CREATE OR REPLACE VIEW view_emp_dept AS
SELECT e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;
select * from view_emp_dept;

/*
뷰 삭제
      뷰는 실체가 없는 가상 테이블이기 떄문에 뷰를 삭제한다는 것은
      user_views 데이터 딕셔너리에 저장되어있는 뷰의 정의를 삭제하는 것이다.
*/    
  select view_name, text from user_views;
  drop view view_sal;
  
  /*
  뷰 수정을 위한 or replace 옵션
        create view 대신 create or replace view를 사용하면 존재하지 않는 뷰이면
        새로운 뷰를 생성하고 기존에 뷰가 존재하는 뷰에 내용을 변경한다.
  */
  
    select view_name, text from user_views;
  
  select * from view_emp10;
  create or replace view view_emp10
  as select empno, ename, sal, comm, deptno from emp01 where deptno=10;
  
  /*
  기본 테이블 없이 뷰를 생성하기 위한 FORCE옵션
       - 기본 테이블이 존재하지 않더라도 뷰를 생성할면 FORCE 옵션을 추가해야 한다.       
  */
  select * from tab;
  
CREATE TABLE emp08 AS 
SELECT * FROM emp;
  
CREATE OR REPLACE FORCE VIEW view_notable
AS 
SELECT empno, ename, deptno 
FROM emp08 
WHERE deptno = 10;
  
SELECT * FROM view_notable;


/*
with check option
   - 뷰 생성시 조건으로 지정한 컬럼 값을 변경하지 못하도록 하는 것이다.
*/

-- 뷰 생성
CREATE OR REPLACE VIEW view_chk20

-- option 지정
as select empno, ename, sal, comm, deptno from emp01
where deptno=20 with check option;

-- 확인
SELECT* FROM view_chk20;

-- 문] 급여가 5000이상인 사원을 10번 부서로 이동하는 쿼리문을 작성하시오.
update view_chk20 set deptno=10 where sal > 5000;
-- 부서번호 옵션에 with check option을 지정했기 떄문에 부서번호를 변경할 수 없다.


/*
with read only
  - 뷰를 통해서는 기본 테이블의 어떤 컬럼에 대해서도 
     내용을 절대 변경할 수 없도록 하는 것이다.
*/
CREATE OR REPLACE VIEW view_read30
as select empno, ename, sal, comm, deptno from emp01
where deptno=30 with read only;

update view_read30 set comm=1000;


/*
시퀀스
     유일(unique)한 값을 생성해 주는 오라클 객체이다.
     시퀀스를 생성하면 기본키와 같이 순차적으로 증가하는 컬럼을 자동적으로
     생성할 수 있게 해준다.
     
시퀀스 생성하는 형식
       create sequence 시퀀스명
       start with n
       increment by
       maxvalue n | nomaxvalue
       minvalue n | nominvalue
       cycle | nocycle
       cache | nocache
       
       start with n
         - 시퀀스의 시작값을 지정함, n을 지정하면 1부터 순차적으로 시퀀스 번호가 증가한다,
        
       increment by
         - 시퀀스의 증가값을 말한다. n을 2로 하면 2싹 중가한다. 
            즉, start with를 1로하고, increment by 2로 하면 1,3,5,7로 시퀀스  번호가 증가하게 된다.
            
       maxvalue n | nomaxvalue
         - 시퀀스가 증가할 수 있는 최대값을 말한다.
            nomaxvalue는 시퀀스의 값을 무한대로 지정한다.
       
       minvalue n | nominvalue
         - 시퀀스가 최소값을 지정한다.
            nominvalue는 시퀀스의 값을 무한소로 지정한다.
       
       cycle | nocycle
         - 지정된 사원값이 최대값까지 증거가 완료되면 다시 최소값에서부터
            시퀀스를 시작하도록 하면 cycle로 지정하면 됨
            nocycle은 최대값을넘어서면 오류거 발생한다(기본값: nocycle;
       
       cache | nocache
            메모라 상에 시퀀스값을 관리하도록 하는 것이다
            기본값은 20입니다. nocache는 관리하지 않는다.         
*/

-- 시작값이 1이고 1씩 증가하고, 최대값이 100000이 되는 시퀀스 emp_seq를 생성하시오
create sequence emp_seq
start with 1
increment by 1
maxvalue 100000;

drop table emp01;

create table emp01 as select empno, ename, hiredate from emp where 1=0;
select * from emp01;

insert into emp01 values(emp_seq.nextval,'JULLIA', sysdate);
insert into emp01 values(emp_seq.nextval,'JULLIA', sysdate);
insert into emp01 values(emp_seq.nextval,'JULLIA', sysdate);
insert into emp01 values(emp_seq.nextval,'JULLIA', sysdate);

-- 시퀀스의 현재값 알아보기
select emp_seq.currval from dual;
/*
currval ;현재값을 반환함
nextval: 현재 시퀀스의 다음값을 반환함

currval, nextval을 사용할 수 있는 경우
1. 서브쿼리가 아닌 select문
2. insert문의 select 절
3. insert문의 valeus 절
4. update문의 set절

currval, nextval을 사용할 수 없는 경우
1. view의 select 절
2. distinct 키워드가 있는 select 절
3. group by, having, ordey by 절이 있는 select 절
4. select, delete, updat의 서브쿼리
5. create table, alt table 명령의 기본값
*/

drop table dept01;

-- dept 테이블의 구조만 복사하고 내용은 비어 있는 더미를 생성
create table dept01
as select * from dept where 1=0;

select * from dept01;

DROP SEQUENCE dept_seq;

-- 10부터 10씩 증가하면서 최대 30까지의 값을 갖는 시퀀스를 생성하자
create sequence dept_seq
start with 10
increment by 10
maxvalue 30;

-- dept_seq 시퀀스로 부터 부서번호를 자동으로 할당받아 데이터 추가
insert into dept01 values(dept_seq.nextval,'ACCOUNTING','NEW YORK');
insert into dept01 values(dept_seq.nextval,'RESERCH','DALLAS');
insert into dept01 values(dept_seq.nextval,'SALES','CHICAGO');
insert into dept01 values(dept_seq.nextval,'OPERATIONS','BOSTON');

-- dept_seq 시퀀스가 nocycle 상태이므로 maxvalue값인 30을 초과하게 되면 오류가 발생함
select * from dept01;


/*
nextval은 해당 시퀀스의 다음값을 자동으로 할당하면서 유효성을 검사하게 된다.
dept_seq 시퀀스를 생성할떄 maxvalue 값으로 30을 지정했고, nocycle(기본값)상태이므로
이 값을 넘게되면 오류가 발생한다.

시퀀스에 대한 정보는 데이터 딕셔너리 user_sequences가 있다.
*/

-- 해당 시퀀스 삭제
DROP SEQUENCE seq_board_bno;

-- user_sequences 데이터 딕셔너리 시퀀스 정보를 확인
select sequence_name, min_value, max_value, increment_by, cycle_flag from user_sequences;


/*
 시퀀스 변경하려면 alter sequence 문을 사용해야한다.
 
 시퀀스 변경 형식
 
       alter sequence 시퀀스명
       start with n
       increment by
       maxvalue n | nomaxvalue
       minvalue n | nominvalue
       cycle | nocycle
       cache | nocache
*/
-- dept_seq 시퀀스의 최대값을 100000변경
       alter sequence dept_seq
       maxvalue 100000;
       

/*
시퀀스의 삭제
   - 시퀀스를 삭제하려면 drop sequence 명령을 사용하여 삭제
   
     형식
    drop sequence 시퀀스명; 
*/
drop sequence dept_seq;


-- 사용자 생성


*/