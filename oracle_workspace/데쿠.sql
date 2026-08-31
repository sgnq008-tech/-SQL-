--테이블 조회
select*from tab;
--테이블을 안에 저장된 레코드
select*from emp;
--테이블 구조 확인
desc emp;
select*from dept;

desc dept;
/*
selct 분으로 특정 데이터를 검색
-데이터 조회
selct [distinct]*, 컬럼명 from 테이블명

distinct: 중복데이터가 있을 경우 한번만 출력
*/
--dept의 테이블의 모든 내용을 출력하시오
select*from dept;
select*from emp;

--컬럼명을 명시해서 특정 컬럼만 검색
select ename,sal from emp;

--dept 테이블에서 부서번호와 부서명만 출력하시오.
select deptno, dname from dept;
--emp 테이블을 이름, 급여 ,입사일자만 출력하시오.
select ename, sal,hiredate from emp;

--컬럼명에 별칭(닉네임) 을 부여하기
--컬럼명을 기술한 바로 뒤에 as라는 키워드를 쓴후 별칭을 기술하면 된다.
select deptno as DepartmentNo, dname as DepartmentName from dept;

--별칭에 공백문자, $,_# 등 특수문자를 표현하고 싶거나 대소문자를 구별하고 싶으면 
--" "을 사용한다.as를 생략하고 " "을 사용하여 별칭을 부여해도 가능하다.
select deptno  "DepartmentNo", dname "DepartmentName" from dept;
select deptno  DepartmentNo, dname "DepartmentName" from dept;

--별칭에 한글도 가능하다.
select deptno 부서번호, dname 부서이름 from dept;
--중복된 데이터를 한번만 출력하는 명령어 : distinct
select distinct job from emp;
--문] 사원들이 어떤 부서에 소속되어 있는지 소속 부서번호를 출력하되,
-- 중복되지 않고 학번만 출력하시오.
select DISTINCT deptno from emp;

/*
where 조건과 비교연산자
select*from 테이블명 where 조건;
*/
--급어가 3000이상인 사원을 출력하시오.
select empnom, ename, sal from emp where sal>=3000;
/*
=, > , >=, <=,
같지않다. -> <>, !=, ^=
*/
-- 급여가 3000미만은 사원을 출력하시오
select empno,ename,sal from emp where sal<3000;
-- emp 테이블에서 부서번호가 10인 사원에 대하여 모든 정보를 출력하시오.
select *from emp where deptno= 10;
-- emp 테이블에서 급여가 2000미만이 되는 사원정보 중 사원번호,이름, 급여만 출력
select empno, ename, sal from emp where sal>2000;
-- 문자 데이터 조회; 문자데이터는 반드시 싱글쿼터''안에 대소문자를 구분하여 기술한다.
-- 문 이름이 scott인 사원에 대하여 번호, 이름 , 급여를 출력하시오.
select empno, ename, sal from emp where ename='SCOTT';
-- 문 이름이 MILLER인 사원에 대하여 번호, 이름, 급여를 출력하시오.
select empno, ename, sal from emp where ename = 'MILLER';
-- 날짜 데이터 조회: 반드시 싱글 쿼터안에 기술한다(형식: 년/월/일)으로 기술함
-- 문] 1985년 이후에 입사한 사원에 이름과 입사일을 출력하시오.
select ename, hiredate from emp where hiredate>='85/01/01';
-- 논리 연산자
-- AND : 여러 조건을 모두 만족해야할 경우 사용하는 연산자
-- 부서번호가 10번이고, 직급이MANAGER인 사원에 대한 정보를 출력하시오.
select ename, deptno, jop from emp where deptno = 10 and job ='MANAGER';
-- 급여가 1000에서 3000사이에 있는 사원에 정보를 출력하시오.
select ename, sal from emp where sal>= 1000 and sal <= 3000;

--or :두가지 조건중 하나만 만족하더라도 검색할 수 있는 연산자.
--부서번호가 10번이거나 직급이 MANAGER인 사원에 대한 정보를 출력하시오.
select ename, deptno, job from emp where deptno = 10 or jab='MANAGER';
--사원번호가 7844이거나 7654이거나 7521인 사원에 대한 정보를 출력하시오.
select empno, ename, sal from emp where empno=7844 or empno =7654 or empno=7521;

--not 
--반대되는 논리 연산자
--부서번호가 10번이 아닌 사원에 대한 모든 정보를 출력하시오.
select *from emp where not deptno = 10;
-- 직급이 MANAGER가 아닌 사원에 대한 모든 정보를 출력하시오.
select*from emp where not job='MANAGER';

/*
BETWEEN AND 연산자
특정 범위 내에 속하는 데이터를 알아보려고 할때 BETWEEN AND 연산자를 사용한다.
형식: 컬럼명BETWEEN A and B
*/
--문 금여가 1000에서 3000 사이에 있는 사원에 정보를 출력하시오
select ename, sal from emp where sal BETWEEN 1000 AND 3000;
--문 급여가 1500과 2500 사이인 사원의 사원번호 , 이름 , 급여를 출력하시오.
select empno,ename, sal from emp where sal BETWEEN 1500 AND 2500;
/*
 in 연산자
 -동일한 컬럼이 여러개의 값중에 하나인지를 살펴보기 위해서 간단하게 표현할 수있는 연산자
 형식 : 컬럼명 in(값1, 값2, 값3)
*/
--문 사원 번호가 7844이거나 7654 이거나 7521잉ㄴ 사원에 대한 정보를 출력하시오
select empno, ename, sal from emp where empno in(7844,7654,7521);
--문 커미션이 300이거나, 500이거나 , 1400중 하나인 사원의 이름, 급여 커미션을 출력
select ename, sal, comm from emp where comm in (300,500,1400);
/*
like 연산자
-검색 하고자 하는 값을 정확히 모를 경우 와일드카드와 함꼐 사용하여 원하는 내용을 검색하는 연산자
형식: 컬럼명 like pattern
    와일드 카드
    %: 문자가 없거나, 하나 이상의 문자가 어떤 값이 오든 상관이 없다.
    검색하고자 하는 값을 정확히 모를
*/

--문 K로 시작하는 사원의 정보를 출력하시오.
select empno, ename from emp where ename like 'K%';
--문 이름중에 K를 포함하는 사원의 정보를 출력하시오
select empno, ename from emp where ename like'%K%';

--와일드 카드(__)
--문 이름의 두번째 글자가 A인것
select empno, ename from emp where ename like'_A%';
--문 이름에 A를 포함하지 않는 사원을 정보를 출력하시오.
select empno, ename from emp where ename not like '%A%';

/*
null 을 위한 연산자
오라클 에서는 컬럼에 null값이 저장되는 것을 허용한다.
null은 미확정, 알 수 없는 값을 의미함, 0도 빈공간도 아닌 어떤값이 존재하기는 
하지만 어떤 값인지 알아낼수 없는 것을 희망
null은 연산, 할당, 비교가 불가능 한다
*/
select 100+null from dual;
select comm from emp;
select ename, comm, job from emp where comm=null;
/*
is null 과 is not null
특정 컬럼 값인지를 비교할 경우에는 비교연산자를(=)사용하지 않고 is null연산자를 사용함
null 값이 아닌지를 알아보려면 비고연산자를(<>)를 사용하지 않고 is not null연산자를 사용
*/
select ename, comm, job from emp where comm is null;
select ename, comm, job from emp where comm is not null;

--커미션을 받지 않는 사원
select ename, comm, job from emp where comm is null;
--커미션을 받는 사원
select ename, comm, job from emp where comm is not null;
--문 자신의 직속 상관이 없는 사원의 이름과 직급과 직속을 출력하시오.
select empno, ename, mgr, job from emp where mgr is null;

/*
정렬을 위한 order by 절
-order by 절은 행을 정렬한느데 사용하며 워리문 맨 뒤에 기술해야하며,
정렬의 기준이 되는 컬럼이름 또는 select 절에서 명시된 별칭을 사용할 수있다.
            오름차순                    내림차순
숫자   작은 값부터 정렬              큰값부터 정렬
문자   사전 순서로 정렬              사전 반대 순서로 정렬
날짜   빠른 날짜 순서로 정렬         늦은 날짜 순서로 정렬
NULL   가장 마지막에 출력됨          가장 먼저 출력됨
*/
--오름차순 정렬을 위한 ASC(생략가능)
-- 문 사원번호를 기준으로 오름차순 정렬하시오.
select empno, ename from emp order by empno asc;
--문 사원번호를 기준으로 내림차순 정렬하시오.
select empno, ename from emp order by empno desc;
--문 사원의 사원번호, 이름, 급여를 급여가 높은 순으로 출력하시오.
select empno, ename, sal from emp order by sal desc;
--문 입사일이 가장 최근인 사원 순으로 사원번호, 이름, 입사일을 출력하시오.
select empno, ename, hiredate from emp order by hiredate desc;
