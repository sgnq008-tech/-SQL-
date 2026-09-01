select 24*60*60 from dual

/*
  서브 쿼리
     - 서브쿼리는 하나의 select 문장의 절안에 포한된 또 하나의 select 문장이다.
     (select 문장안에 select가 또 있다는 뜻)
     그렇기 떄문에 서브쿼리를 포함하고 있는 쿼리문을 메인 쿼리, 포함된 또 하나의 쿼리는
     서브쿼리라고 한다.
*/

/*
사원의 이름이 scott인 사원이 어떤 부서 소속인지 소속 부서명을 알아내려면 
조인을 사용해서 해결했지만 조인이 아닌 서브쿼리를 이용해서 해결이 가능하다
*/
-- 먼저 scott의 부서명을 알아내려면 부서번호를 알아야함
select deptno from emp where ename=upper('scott');
select dname from dept where deptno=20;

select dname from dept where deptno=(select deptno from emp where ename=upper('scott'));
--                    메인쿼리                                  =                                       서브쿼리

/*
서브쿼리는 비교연산자(=)의 오른쪽에 기술해야 하고, 반드시 괄호안에 둘러싸여야한다.
서브쿼리는 메인쿼리가 실행되기 전에 한번만 실행된다.

단일행
     - 내부 select 문장으로부터 오직 하나의 행반을 반환받는 것이다 
        
단일행 비교연산자
    =, >, <, >=, <=, <>
*/

-- smith와 같은 부서에서 근무하는 사원의 정보를 출력하시오.(서브쿼리)
(select deptno from emp where ename= 'SMITH';) --서브쿼리
select * from emp where deptno=20; --메인쿼리

select * from emp where deptno=(
select deptno from emp where ename='SMITH');

/*
  서브쿼리에서 그룹함수의 사용
   서브쿼리를 사용하여 평균 급여보다 더 많은 급여를 받는 사원을 검색하시오.
*/
select trunc(avg(sal)) from emp;

select * from emp where sal > 2073;    --조건문

select * from emp where sal > (select trunc(avg(sal)) from emp);


-- 다중 행 서브쿼리 : 서브쿼리에서 반환되는 결과가 하나 이상일때 사용하는 서브쿼리를 의미함

/*
 다중 서브쿼리는 반드시 다중행 연산자를 사용해야함
 
종류
    IN: 메인 쿼리의 비교조건('=' 연산자로 비교할 경우)이 서브쿼리의 결과 중에서 하나라도 일치하면 참
    ANY,SOME: 메인 쿼리의 비교조건이 서브쿼리의 결과가 하나 이상일떄 일치하면 참
    ALL: 메인 쿼리의 비교조건이 서브쿼리의 결과가 모든값이 일치하면 참
    EXIST: 메인 쿼리의 비교조건이 서브쿼리의 결과 중에서 만족하는 값이 하나라도 존재하면 참
*/

/*
 IN 연산자
    결과가 2개 이상이 구해지는 쿼리문을 서브쿼리로 기술할 경우에는 다중행 연산자를 사용함
    
    급여를 3000이상 받는 사원이 소속된 부서와 동일한 부서에서 근무하는 사원을 출력하라
    서브쿼리의 결과 중에서 하나라도 일치하면 참인 결과를 구하는 IN연산자와 함께 사용함 
*/
select distinct(deptno) from emp where sal >= 3000; --서브쿼리
--          중복제거

select ename, sal, deptno from emp where deptno   -- 메인쿼리
in(select distinct(deptno) from emp where sal >= 3000);
 
/*
30번 소속 사원들 중에서 급여를 가장 많이 받은 사원보다 
더 많은 급여를 받는 사람의 이름, 급여를 출력하라   
*/
select max(sal) from emp where deptno=30;
select ename, sal from emp where sal > 2850;

select ename, sal from emp where sal > (select max(sal) from emp where deptno=30);
--                   메인쿼리                                                                    서브쿼리

/*
    ANY 연산자
       - 메인쿼리에 비교조건이 서브 쿼리의 검색 결과와 하나 이상만 일치하면 참입니다.
          찾아진 값에서 가장 작은 값 즉, 최소값보다 참이면 됨
          
    문] 부서 번화가 30번인 사원들의 급여 중 가장 작은값보다 많은 급여를 받는 사원의 이름, 급여를 출력하시오.
*/
select min(sal) from emp where deptno=30 서브

select ename, sal from emp where sal > 950; 메인

SELECT ename, sal FROM emp WHERE sal > 
ANY (SELECT sal FROM emp WHERE deptno = 30);



-----서브 쿼리-------

-- 문1] SCOTT의 급여와 동일하거나 더 많이 받는 사원명과 급여를 출력하시오.
select sal from emp where ename='SCOTT'; --서브
select ename, sal from emp where sal >= 3000; --메인

select ename, sal from emp where sal >= (select sal from emp where ename='SCOTT');

-- 문2] 직급(job)이 사원(CLERK)인 사람의 부서를 검색해서 부서번호와 부서명과 지역명을 출력하시오. //단일 연산자
SELECT distinct(deptno) FROM emp WHERE job = 'CLERK'; --서브

SELECT deptno, dname, loc FROM dept WHERE deptno IN ( SELECT distinct(deptno) FROM emp WHERE job = 'CLERK');
--                                                                                                                   중복방지

-- 문3] 이름에 T를 포함하고 있는 사원들과 같은 부서에서 근무하고 있는 사원의 번호, 이름을 출력하시오.  //단일 연산자
SELECT distinct(deptno) FROM emp WHERE ename LIKE '%T%'; --서브

SELECT ename, empno FROM emp WHERE deptno IN (select distinct(deptno) FROM emp WHERE ename LIKE '%T%');

-- 문4] 부서위치가 DALLAS인 모든 사원의 이름, 부서번호를 출력하시오. //단일 연산자
select deptno from dept where loc = 'DALLAS'; -- 서브

select ename, deptno from emp where deptno =( select deptno from dept where loc = 'DALLAS'); 

-- 문5] SALES 부서의 모든 사원의 이름과 급여를 출력하시오.  //단일 연산자
select deptno from dept where dname= 'SALES'; -- 서브
select ename,sal from emp where deptno = 30;  -- 메인

select ename,sal from emp where deptno = (select deptno from dept where dname= 'SALES');

-- 문6] KING에게 보고하는 모든 사원의 이름과 급여를 출력하시오.  //다중 연산자
--        KIGN에게 보고하는 사원이란 의미는 상관(MGR)이 KING인 사원을 의미합니다.
select empno from emp where ename ='KING'; --서브
select ename, sal, mgr from emp where mgr = 7839;

select ename, sal, mgr from emp where mgr IN(select empno from emp where ename ='KING');

-- 문7] 자신의 급여가 평균 급여보다 많고, 이름에 S가 들어가는 사원과 
--        동일한 부서에서 근무하는 사원의 번호, 이름, 급여를 출력하시오. 
SELECT trunc(AVG(sal)) FROM emp where sal > 2073 and ename like '%S%'; --서브
SELECT empno, ename, sal FROM emp where deptno=20;

SELECT empno, ename, sal FROM emp where deptno
IN (SELECT deptno FROM emp where sal > (SELECT trunc(AVG(sal)) from emp) and ename like '%S%');



-- 테이블 구조를 결정하는 DDL로 생성, 변형, 삭제
/*
creat table
      - 테이블 구조 정의
      
      형식
         creat table 테이블명(
         
         컬럼명(필드명)    자료형(데이터 타입),
         컬럼명(필드명)    자료형(데이터 타입),
         컬럼명(필드명)    자료형(데이터 타입),
         컬럼명(필드명)    자료형(데이터 타입)
         );
         
         필드(컬럼)명을 정의할떄 지정할 수 있는 자료형
         
         char: 고정 길이 문자 데이터를 의미함 최소크기 1바이트, 최대크기 2000바이트
         varchar2: 가변 길이 문자 데이터, 최소 크기 1바이트, 최대크기 4000바이트  // var란 ? "가변"이란 뜻
         number: 최대 40자리까지의 숫자 데이터를 의미함 
         number(w): w자리까지의 수치로 38자리까지 가능
         number(w,d): w는 전체길이, d는 소숫점 이하자리
         date: BC 4712년 1월 1일 ~ AD 4712년 12월 31일까지의 날짜 
         long: 가변길이 문자형 데이터 타입, 최대 크기 2gb
         lob: 2gb까지의 가변길이 바이너리 데이터를 저장할 수 있다.(문서,이미지,실행파일)
         rowid: DB에 저장되어 있지 않으며, DB데이터도 아님
                     테이블 내 행의 고유 주소를 가지는 64진수 문자
                     해당 6바이트 또는 10바이트
         
         테이블명과 컬럼명을 부여하기 위한 규칙
         1. 반드시 문자로 시작해야한다.
         2. 1 ~ 30자까지만 가능한다.
         3. A ~ Z까지를 대소문자와 0 ~ 5까지 숫자, 특수기호(_,$,#)만 가능하다.
         4. 오라클에서 사용되는 예약어나 다른 객체명(테이블)과 중복 불가
         5. 공백을 허용 안함
*/

-- 사원번호, 사원이름, 급여 3개의 컬럼으로 구성된 emp01 테이블을 작성하시오.
create table emp01(

empno number(4),  -- 사원번호
ename varchar2(20),  -- 사원이름
sal       number(7,2) -- 급여
);
select * from emp01; -- 데이터가 있나없나 확인용

select * from tab;

DESC emp01; 
-- 테이블 구조 확인용 
-- 옆에 주석을 달아도 인식하니 그 밑에 줄에 써주기 


-- 기존 테이블 복사
create table emp02 as select * from emp; -- 제약 조건은 복사 불가
select * from emp02;
DESC emp;
desc emp02;

/*
-- alter table 로 기존 컬럼 삭제
        alter table 테이블명령으로 테이블에서 
        컬럼 추가, 삭제, 컬럼의 데이터유형이나 길이를 변경할떄 사용함
        
        add column: 새로운 컬럼 추가
        modify column: 기존 컬럼을 수정
        drop column: 기존 컬럼을 삭제
*/

-- emp01 테이블에 직급(job) 컬럼 추가
alter table emp01
add(job varchar2(9));

desc emp01;

 /*
  alter table 기존 컬럼 수정
    modify 절을 사용하여 컬럼을 수정함
       데이터 타입, 크기를 변경할 수 있다.
  형식
     alter table 테이블명
     modify(컬럼명 데이터 타입);
     
     alter table로 컬럼명을 수정시 주의 사항
     
     -해당 컬럼의 자료가 없을 경우
       1. 컬럼의 데이터 타입을 변경할 수 있다.
       2. 컬럼의 크기를 변경할 수 있다.
       
     -해당 컬럼의 자료가 있는 경우 
       1. 컬럼의 데이터 타입은 변결할 수 없다.
       2.컬럼의 크기를 늘릴 수는있지만 
       현재 가지고 있는 데이터 크기보다 작은 크기로는 변경이 불가능함
*/

-- 직급을 최대 30자까지 변경하시오.
alter table emp01
modify(job varchar2(30));

desc emp01;


/*
alter table로 기존 컬럼 삭제
    형식
    alter table 테이블명
    drop column 컬럼명;
*/
-- 직급 컬럼을 삭제하시오.
alter table emp01
DROP column job;

desc emp01;

/*
drop table로 테이블 구조 삭제

drop table 문은 기존 테이블을 삭제한다. 
테이블 제거하면 테이블에 저장된 데이터도 함께 삭제된다.
제거된 데이터는 다시 복구하기 힘들기 떄문에 유의해야함
*/
-- emp01 테이블 삭제
drop table emp01;
SELECT* FROM tab; -- 휴지통같은 존재(테이블들을 삭제하거나 복구도 가능)

-- 휴지통 보기
desc recyclebin;
select * from recyclebin;

-- 휴지통 비우기
purge recyclebin;

-- 휴지통에 넣지 않고 바로 삭제처리
drop table emp01 purge;
create table emp01 as select * from emp;

-- emp01테이블의 이름을 emp02로 변경하시오.
rename emp01 to emp02;
SELECT* FROM tab; 

-- 생성
CREATE TABLE emp01 AS 
SELECT * FROM emp;

-- 테이블의 모든 행을 제거해 주는 truncate문
-- 형식: truncate table 테이블 이름
truncate table emp01;
delete from emp02;
SELECT* FROM emp01;

/*
truncate 명령과 delete명령의 차이점

테이블을 truncate하면 테이블의 모든 행이 삭제되고, 사용된 공간이 해제됨
truncate table 명령은 DDL명령이므로 롤백 데이터가 생성되지 않는다.
delete 명령으로 데이터를 삭제하면 롤백 명령어 복구할 수 있다.
truncate명령어로 데이터를 삭제하면 롤백을 할 수가 없다.

1. 행의 인덱스도 같이 잘려나간다.
2. 외래키가 참조중인 테이블은 truncate을 할 수 없다.
3. truncate 명령을 사용하면 삭제 트리거가 실행되지 않는다.

  DDL(Date Define Language) -> 데이터 정의어
*/


/*
DML: 테이블에 새로 내용을 추가, 수정, 삭제하기 위한 것

테이블에 새로운 행을 추가하는 insert문

1. 특정한 컬럼에만 데이터를 입력하는 
    insert into 테이블명(컬럼명1, 컬럼명2,...) values(값1, 값2,...) //둘다 1대 1로 매칭이 되야함(컬럼명 1개면 values도 1개만)

2. 모든 컬럼에 데이터를 입력하는 방법
    insert nto 테이블명 values(값1, 값2,...);
    
새로운 행을 추가하기 위해 insert문을 사용하면 한번에 하나의 행만 삽입한다.
기술한 컬럼 목록 순서대로  values에 지정된 값이 삽입됨

  만약 컬럼 목록에 기술하지 않으면 테이블에 있는 컬럼의 기본 순서대로
  values이하의 값이 삽입되며 문자와 날짜 값은 반드시 싱클쿼터(' ')을 사용해야함
*/

-- 먼저 dept01 테이블 생성함
-- 컬러명: 부서번호(deptno) ->2, 부서이름(dname)-> 14, 부서위치(loc)-> 13
CREATE TABLE dept01 (
deptno number(2),  
dname varchar2(14),  
loc       varchar2(13) 
);

desc dept;
select * from dept01;

-- 데이터를 추가하는 방법
--  부서번호 10번 부서: 부서이름은 ACCOUNTING로 하고 위치는 NEW YORK로 데이터를 추가
insert into dept01(deptno, dname, loc) values(10,'ACCOUNTING','NEW YORK');
insert into dept01 values(20,'RESEARCH','DALLAS');


/*
NULL 값의 삽입
    데이터를 입력하는 시점에서 해당 컬럼 값을 모르거나 확정되지 않았을 경우에는
    NULL값을 입력해야한다. NULL값을 삽입시에는 암시적인 방법과 명시적인 방법이 있다. 

암시적으로 NULL 값 삽입
    컬럼명 리스트에 컬럼을 생략하는 것이다.
    즉, 다른 컬럼명은 값을 입력하지만 이렇게 생략한 컬럼에는 자동적으로 NULL값이 할당됨
*/
desc dept; 
-- 번호가 없으면 데이터 삽입하면 안됨

desc dept01; 
-- 번호가 없어도 데이터 삽입해도됨

select * from dept01;
-- 확인용

-- 지역명이 결정되지 않은 경우(암시적인 방법)
insert into dept01(deptno, dname)values(30,'SALES');

/*
명시적으로 NULL 값 삽입
    values 리스트에 null이라고 직접 기술해서 입력하는 방법이다.
*/
-- 지역명이 결정되지 않아서 2개의 컬럼명만 입력하면 오류가 발생
insert into dept01 values(40,'OPERATIONS',null);
-- null값을 갖는 컬럼을 추가하기 위해서 null 대신 ' '를 사용할 수 있다.

insert into dept01 values(40,'OPERATIONS',' ');
