select * from tab; //정상적으로 출력하는지 알아보기 위해서 만듬

//소문자나 대문자로 써도 상관없음

/*
duel 테이블과 sql함수
     - 한 행으로 결과를 출력하기 위한 테이블인 duel테이블임
 
 duel 테이블
     - 오라클에서 1일이 몇 초인지를 환산하고자 한다
         1일 24시간이고 1시간은 60분이며, 1분은 60초이므로 24*60*60하면 하루가 몇초인지를 계산됨
         이 산출식을 오라클 프롬프트에 바로 입력하면 오류가 발생한다.         
*/

select 24*60*60 from dept;
select 24*60*60 from dual;

- 테이블 구조 확인
desc dual;

/*
dual 테이블은 산술연산이나 가상 컬럼등의 값을 한번만 출력하고 싶을 떄 많이
사용하는 아주 유용한 테이블이다.
dummy라는ㄴ 한개의 컬럼으로 구성되어 있다.
*/

select*from dual;

select deptno,sum(sal) from emp GROUP by deptno HAVING deptno=30;

/*
단일행 함수
  - 행마다 함수가 적용되어 결과를 반환함
  
  
단일행 함수 종류
  문자함수: 문자열을 다른 형태로 변환
  숫자함수: 숫자 값을 다른 형태로 변환
  날짜함수: 날짜 값을 다른 형태로 변환
  변환함수: 문자,날짜,숫자값을 서로 다른 타입으로 변환함
  일반함수: 기타 함수
  
  
 그룹함수 
 - 하나 이상으로 행을 그룹으로 묶어 연산하여 합계, 평균 등의 하나의 결과로 반환함
    sum: 그룹의 누적 합계 반환
    avg: 그룹의 평균 반환
    max: 그룹의 최대값 반환
    min: 그룹의 최소값 반환
    count: 그룹의 총 개수를 반환
    stddev: 그룹의 표준편차를 반환
    variance: 그룹의 분산을 반환
*/

/*
문자함수
  - 문자형의 값을 조작하여 변환된 문자값을 반환
  LOWER: 소문자로 변환
  UPPER: 대문자로 변환
  INITCAP: 첫글자만 대문자로 변환
  CONCAT: 문자의 값을 연결
  SUBSTR: 문자를 잘라서 추출함 
  LENGTH: 문자의 길이를 반횐
  INSTR: 특정 문자의 위치
  LPAD,RPAD: 입력받은 문자열과 기호를 정렬
  TRIM: 잘라내고 남은 문자를 표시
  CONVERT: 문자를 변환
  CHR: 아스키코드 값으로 변환
  ASCIT: 아스키코드 값을 문자로 변환
  REPLACE: 문자열에서 특정문자를 변경함
*/

-- <입력한 문자값을 소문자로 변환 하는 함수>
select 'DataBase', lower('Datebase') from dual;
-- 사원 테이블에서 부서번호가 10번인 사원명을 모두 소문자로 변환하여 출력하시오.
select lower(ename) from emp where deptno=10;


select 'DataBase', upper('Datebase') from dual;
-- 직급이(manager)인 사원을 검색하여 출력하시오.
select empno, ename, job from emp where job= upper('manager');
select empno, ename, job from emp where lower(JOB)='manager';


--INITCAP : 첫글자만 대문자로 변환하고, 나머지는 소문자로 변환
select initcap('DATABASE PROGRAM') from dual;
-- 'Smith' 란 이름을 갖은 사원의 사원번호,이름,급여와 커미션을 출력하시오.
select empno,initcap(ename),sal,comm from emp where ename='SMITH';


--concat: 두 문자를 연결(3개 이상부터는 연결 불가능)
select concat('Data','Base') from dual


-- SUBSTR: 문자열 일부만 추출하는 함수
-- SUBSTR(문자열, 시작위치, 추출할 개수)
select substr('Data Base',1,7)from dual; //공백도 포함시켜서 추출하니 주의
select substr('DataBase',-4,3)from dual; // -4면 a부터니 3칸을 출력하면 Bas가 추출됨
-- 20번 부서 사원들의 입사년도 알아보기
select ename, hiredate,SUBSTR(hiredate, 1, 2) from emp where deptno=20;
-- 87년도에 입사한 사원의 정보를 출력하시오
select ename,hiredate,substr(hiredate,1,2) from emp where substr(hiredate,1,2)=87;  
-- 이름이 k로 끝나는 사원의 정보를 출력하시오
select * from emp where ename like'%K'
select * from emp where substr(ename,-1,1)='K';


-- LENGTH: 문자열의 길이를 구함
select length('database') from dual;
-- 직원중 이름이 4글자인 직원의 이름을 소문자로 출력하시오 
select empno,lower(ename) from emp where length(ename)=4;


-- INSTR: 특정 문자의 위치를 구할떄 사용함
-- INSTR(문자열, 찾을 글자, 시작위치, 몇번쨰)
select instr('DataBase','a',3,1) from dual; // 해당 문자의 위치를 찾을떄는 대소문자를 구분해야함
// 뜻: 4 (3번째부터 찾았을 때 1번째로 나오는 a)  
  
-- LPAD,RPAD: 입력받은 문자열과 기호를 왼쪽이나 오른쪽으로 정렬함
select lpad('DataBase',20,'$')from dual; 왼쪽으로 정렬함
select rpad('DataBase',20,'$')from dual; 오른쪽으로 정렬함

 
-- <숫자함수: 숫자형 데이터를 조작하여 반환된 숫자값을 반환하는 함수>
/*
abs: 절대값  1  -> 1, -1 -> 1 (무조건 양수로 만듬)
cos: 코사인(Cosine) 값 반환 
exp: 승수를 구함
floor: 소수점 이하는 잘라버림
log: log값 반환
power: 제곱
sin: 사인(Sine) 값 반환
tan: 탄젠트(Tangent) 값 반환
round: 반올림
trunc: 버림
mod: 나머지
*/


--abs: 무조건 양수로 만듬
select abs(-15)from dual;


--floor: 소수점을 없애버림
select floor(34.5678)from dual;


--round: 반올림 시키거나 원하는 부분만 반올림 시켜버림
select round(34.5678), round(34.5678,2), round(34.5678,-1), round(34.5678,-2)from dual;
                                                                          10의 단위로 끊기          100의 단위로 끊기
                                                                       
                                                                          
--trunc; 특정 자릿수에서 잘라버림
select trunc(12.345,2), trunc(12.345, -1)from dual;


--mod: 나머지 구하는 함수
select mod(34,7)from dual;
-- 4번이 짝수인  사원들의 사번과 이름과 직급을 출력하라
select empno,ename,job from emp where mod(empno,2)= 0;

/*
-- <날짜 함수: 날짜값을 다른 형태로 변환>

   SYSDATE: 시스템에 저장된 현재 날짜 반환
   MONTHS_BETWEEN: 두 날짜 사이가 몇 개월인지를 반환함
   ADD_MONHTS: 특정날짜에 개월수를 더함 
   NEXT_DAY: 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜라 반환
   LAST_DAY: 해당 월의 마지막 날짜
   ROUND: 인자로 받은 날짜를 기준으로 반올림
   TRUNC: 인자로 받은 날짜를 기준으로 버림
*/

--sysdate: 시스템에 저장된 현재 날짜 반환
select sysdate 오늘,sysdate-1 어제, sysdate +1 내일 from dual;


--MONTHS_BETWEEN: 두 날짜 사이가 몇 개월인지를 반환함
select sysdate, hiredate, trunc(months_between(sysdate, hiredate)) from emp;


--ADD_MONHTS: 특정날짜에 개월수를 더함 
-- 입사일에서 3개월이 지난 날짜를 구하시오
select ename, hiredate, add_months(hiredate,3) from emp;


--NEXT_DAY: 해당 요일의 가장 가까운 날짜를 반환함  
-- 오늘의 기준으로 최초로 다가오는 수요일은 몇일인가?
select sysdate, next_day(sysdate, '수요일') from dual;
select sysdate, next_day(sysdate, '수') from dual;
select sysdate, next_day(sysdate, 4) from dual; //첫시작이 일요일을 기준이다

-- 요일을 영어로 사용할 경우 언어를 바꾸어 주어야한다 -> 한국어 ->korean, 영어 -> american

-- 요일을 영어로 사용할 경우 언어를 american 으로 변경해야함
ALTER SESSION SET NLS_LANGUAGE=AMERICAN;
select sysdate, next_day(sysdate, 'wedesday') from dual;
select sysdate, next_day(sysdate, 'wed') from dual;
select sysdate, next_day(sysdate, 4) from dual; //첫시작이 일요일을 기준이다

-- 요일을 한글로 사용할 경우 언어를 korean 으로 변경해야함
ALTER SESSION SET NLS_LANGUAGE=KOREAN;
-- 한글과 영어는 동시에는 사용 불가!! 


--LAST_DAY: 해당 월의 마지막 날짜
select sysdate, last_day(sysdate)from dual;


--ROUND: 인자로 받은 날짜를 기준으로 반올림
select hiredate, round(hiredate,'month')from emp where deptno=10;


/*
     TRUNC: 인자로 받은 날짜를 기준으로 버림
         - 숫자를 잘라내는 것 뿐만이 아니라 날짜도 잘라냄
*/
select hiredate, trunc(hiredate,'month')from emp;


/*
     변환함수
        자료형을 변환시켜주는 함수
        
        to_char: 날짜형 혹은 숫자형을 문자형으로 변환시킴
        to_date: 문자형을 날짜형으로 변환
        to_number: 문자형을 숫자형으로 변환
*/
select sysdate, to_char(sysdate,'yyyy-mm-dd') from dual;
--사원들의 입사일을 출력하되, 요일까지 출력하시오
select to_char(hiredate, 'yyyy-mm-dd day') from emp; // 요일의 전체 이름 출력  
select to_char(hiredate, 'yyyy-mm-dd dy') from emp; // 요일의 한자리 이름 출력 
select to_char(sysdate, 'yyyy-mm-dd dy, hh24:mi:ss') from dual; // 시간도 출력 

/*
숫자형을 문자형으로 변환
0: 자릿수를 나타내며 자릿수가 맞지 않을 경우 0으로 채움
9: 자릿수를 나타내며 자릿수가 맞지 않아도 채우지 않음
L: 각 지역별 통화 기호를 앞에 표시함
.: 소수점
,: 천단위 자리 구분
*/
select to_char(12345.67, '999,999,999')from dual;
select to_char(12345.67, '999999')from dual;
select to_char(12345.67, '$999,999,999')from dual;
select to_char(12345.67, 'L999,999,999')from dual;
select to_char(12345.67, 'S999,999,999')from dual;

--1981년 2월 20일에 입사한 사원에 대한 정보를 출력하시오
select ename, hiredate from emp where hiredate=to_date(19810220, 'yyyy-mm-dd');

--올해 며칠이 지났는지 날짜 계산
select trunc(sysdate-to_date('2026/01/01', 'yyyy-mm-dd')) from dual;


--숫자형으로 변환
select '10.000'+'20.000' from dual;
select to_number('10,000', '999,999,999')+to_number('20,000', '999,999,999') from dual;


/*
--일반함수
       NVL: 첫번쨰 인자로 받은 값이 null과 같으면 두번째 인자 값으로 변경함
       DECODE: 첫번쨰 인자로 받은 값을 조건에 맞춰 변경(if)
       CASE: 조건에 맞는 문장을 수행(switch)
*/       

--null을 0또는 다른값으로 변환하기 위해서 사용함수
select ename, sal, comm, job from emp;

select ename, sal, nvl(comm,0), job from emp;
--연봉을 계산하기 위해서 급여에 12를 곱한 후 커미션을 더함

select ename,sal*12,sal*12+comm from emp; 
-- 커미션이 null인 경우는 연봉 역시 null이다 

select ename,sal,comm,sal*12,sal*12+nvl(comm,0) 연봉 from emp; 


/*
문]
 모든 사원은 자신의 상관(manager)이 있다. 하지만 
 emp 테이블에 유일하게 상관이없는 행이있다. 
 그 사원의 MGR 컬럼값이 null이다
 상관이 없는 사원만 출력하되 MGR 컬럽갑 null대신 CEO로 변경해서 출력하시오.
*/

select ename, mgr from emp;
select ename, nvl( to_char (mgr,'9999'),'CEO') from emp;


/*
  decode
        -if문이나 case 문과 같이 여러 가지 경우에 대해서 선택할 수 있도록 하는 기능을 제공함
        
        형식
           decode(표현식,조건1,결과1,
                                   조건2,결과2,
                                   조건3,결과3,
                                     기본 결과n)
*/

--부서번호에 해당하는 부서명을 출력하시오,
select deptno,
decode(deptno,10, 'ACCOUNTING',
                            20, 'RESEARCH',
                            30, 'SALES',
                            40, 'OPERATIONS')
as dname from emp;


/*
조건에 따라 서로 다른 처리가 가능한 함수 // ,는 안 넣어두됨
    case 표현식 when 조건1 then 결과1
                       when 조건2 then 결과2
                       when 조건3 then 결과3
                         else 결과 n
     end      
*/
select ename,deptno,
                case  when deptno=10 then 'ACCOUNTING'
                when deptno=20 then 'RESEARCH'
                when deptno=30 then 'SALES'
                when deptno=40 then 'OPERATIONS'
                end dname from emp;
                
                
/*
  문]
    직급에 따라 급여를 인상하도록 하자.(사원번호, 사원명, 직급, 급여)
    직급이 'ANALYST'인 사원은 5%
    직급이 'SALESMAN'인 사원은 10%
    직급이 'MANAGER'인 사원은 15%
    직급이 'CLERK'인 사원은 20% 인상한다.
*/                
select empno,ename,job,sal,
  case when job='CLERK' then sal*1.20
           when job='MANAGER' then sal*1.15
           when job='SALESMAN' then sal*1.10
           when job='ANALYST' then sal*1.05
           else sal end as salary
  from emp;
  
  
  /*
  그룹함수
    - 전체 테이터를 그룹별로 구분하여 통계적인 결과를 구하기 위해서
       사용하는 함수이다.
 
  종류   
   sum: 합계
   avg: 평균
   max: 최대값
   min: 최소값
   count: 개수/행 수
   stddev: 표준편차
   variance: 분산
  */
select sum(sal) from emp;
select  TRUNC(avg(sal)) from emp;
select  max(sal) from emp;
select min(sal) from emp;

-- 커미션을 받은 사원
select count(*),count(comm) from emp;
select trunc(stddev(sal)) from emp;
select trunc(variance(sal)) from emp;


-- group by절
-- 특정 컬럼값을 기준으로 테이블을 그룹별로 나누기 위해서 group by절을 사용함
-- 사원들을 사원번호로 기준으로 3개로 그룹을 지어라
select deptno from emp Group BY deptno;
select deptno, sum(sal), trunc(avg(sal)), max(sal), min(sal) from emp Group BY deptno;

--부서별로 사원수와 커미션을 받는 사원수를 구해보자
SELECT count(*),count(comm)from emp;

-- having 조건절
-- 그룹의 조건 결과를 보고자 할떄 having절을 사용함
select deptno, avg(sal) from emp group by deptno having avg(sal) >=2000;
select deptno, max(sal),min(sal) from emp group by deptno having max(sal) >2900;


/*
   join
        - 한 개 이상의 테이블에서 원하는 결과를 얻기 위한 방법이다.
        
            종류
        Equi join: 동일 컴럴을 기준으로 조인한다.
        Non Equi join: 동일 컬럼이 없이 다른 조건을 사용하여 조인
        Outer join: 조인 조건에 만족하지 않는 행도 나타낸다. 
        Self join: 한 테이블 내에서 조인함       
*/

/*
    Cross join
        -2개 이상의 테이블이 조인될때 where절에 의해 공동된 컬럼에 의해
          결합되지 않는 경우를 의미한다. 그렇기 떄문에 테이블에 존재하는
          모든 데이터가 검색 결과로 나타낸다.
*/

select * from emp dept; //2개이상의 테이블 조인될떄 Cross

/*
    조인의 규칙
    1. 기본키와 외래키 열을 통한 다른 테이블의 행과 연결
    2. 연결 키 사용으로 테이블과 테이블이 결합한다.
    3. where절에 조인 조건을 사용함
    4. 명확성을 위해 컬럼 이름 앞에 테이블명 또는 테이블 명칭을 사용함
*/
SELECT emp.ename, dept.dname, emp.deptno, dept.deptno FROM emp, dept WHERE emp.deptno = dept.deptno;
SELECT e.ename, d.dname, e.deptno, d.deptno FROM emp e, dept d WHERE e.deptno = d.deptno;

-- scott인 사람의 정보만 출력하시오
SELECT e.ename, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.ename = 'SCOTT';

/*
 Non Equi join
     - 조인할 테이블 사이에 컬럼의 값이 일치하지 않을 시 사용하는 조인으로 '='을 제외한 연산자를 사용함
*/
select * from salgrade;
SELECT e.ename, e.sal, s.grade FROM emp e, salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal;
SELECT e.ename, e.sal, s.grade FROM emp e, salgrade s WHERE e.sal >= s.losal AND e.sal <= s.hisal; 

/*
 부서 테이블의 40번 부서와 조인할 사원테이블의 부서가 없지만,
 40번 부서로 출력되도록 하려면 Outer join을 사용한다.
 Outer join을 하기 위해서 사용하는 기호는 (+)이며 조인 조건에서
 정보가 부족한 컬럼명 뒤에 위치하게 하면 된다.
 즉, 사원테이블에 부서번호 40번이 없기 떄문에 emp,deptno(+) 기호를 덧붙임
*/
select e.ename, d.deptno, d.dname from emp e, dept d where e.deptno(+)=d.deptno;


-- emp, dept 테이블 조인하여 사원이름, 부서번호, 부서명을 출력
select e.ename, d.deptno, d.dname from emp e, dept d where e.deptno=d.deptno order by d.deptno;


/*
Self join
  - 자기 자신과 조인을 맺는 것을 의마함, from 절 다음에 동일한 테이블명을 2번 기술하고,
     where절에도 조인 조건을 주어야 하는데 이떄 서로 다른 테이블인 것처럼 인식할 수 잇도록
     별칭을 사용함
*/
select work.ename ||'의 매니저는 ' || manager.ename ||'이다' as "그 사원의 매니저" from emp work,emp 
manager where work.mgr = manager.empno;


-- 문1] 사원들의 이름, 부서번호, 부서이름을 출력하시오.(emp, dept 테이블을 조인)
SELECT e.ename, e.deptno, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno;

-- 문2] 부서번호가 30번인 사원들의 이름, 직급, 부서번호, 부서위치를 출력하시오.
select d.deptno, e.ename, e.job, d.loc from emp e, dept d where e.deptno=d.deptno and e.deptno =30; 

-- 문3] 커미션을 받는 사원의 이름, 커미션, 부서이름, 부서위치를 출력하시오.
SELECT e.ename, e.comm, d.dname, d.loc FROM emp e, dept d WHERE e.deptno = d.deptno 
AND e.comm IS NOT NULL AND e.comm NOT IN (0);

-- 문4] DALLAS에 근무하는 사원의 이름, 직급, 부서번호, 부서이름을 출력하시오.
select e.ename, e.job, d.deptno, d.dname from emp e, dept d where e.deptno=d.deptno and d.loc='DALLAS';

-- 문5] 이름의 A가 들어가는 사원들의 이름과 부서이름을 출력하시오.
select e.ename, d.dname from emp e, dept d where e.deptno=d.deptno and e.ename like '%A%';

-- 문6] 사원이름과 직급, 급여, 급여 등급을 출력하시오.
select e.ename, e.job, e.sal, s.grade from emp e, salgrade s where e.sal between s.losal and s.hisal;

-- 문7] 사원이름, 부서번호, 해당 사원과 같은 부서에서 근무하는 사원의 출력하시오.(self join)
select e.ename "자신", e.deptno, c.ename "동료", c.deptno from emp e, emp c 
where e.ename<> c.ename and e.deptno= c.deptno order by e.ename;

내일은 수업은 서브커리와 테이블 만들기 