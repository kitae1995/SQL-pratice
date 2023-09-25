
/*
# 서브쿼리 
: SQL 문장 안에 또다른 SQL를 포함하는 방식 ( 왜 씀 ? 더 간략하게 하기 위해 )
여러개의 질의를 동시에 처리할 수 있음
WHERE,SELECT,FROM절에 작성가능

- 서브쿼리의 사용방법은 () 안에 명시함.
 서브쿼리절의 리턴행이 1줄 이하여야 합니다.
- 서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 합니다.
- 해석할 때는 서브쿼리절 부터 먼저 해석하면 됩니다.
*/

-- 급여를 nancy보다 많이 받는 직원들의 이름을 조사하려면 ? ( 서브쿼리를 안쓰고 )
SELECT salary FROM employees
WHERE first_name = 'nancy';

SELECT first_name FROM employees
WHERE salary > 12000;

-- 서브쿼리를 쓰지 않으면 이런식으로 2번 틀어야함

-- nancy의 급여보다 많은 급여를 받는 사람 조사하려면? ( 서브쿼리 사용 )
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
WHERE first_name = 'Nancy');

-- employee_id가 103번인 사람의 job_id와 동일한 job_id를 가진 사람을 조회하자.
SELECT *
FROM employees
WHERE job_id = (SELECT job_id FROM employees
WHERE employee_id = 103);

-- 위의 서브쿼리문과 비슷해보이는데 오류가 남
-- 다음 문장은 서브쿼리가 리턴하는 행이 여러개라 단일행 연산자를 사용 할 수 없음
-- IT_PROG를 job_id로 가진 job_id는 값이 5개가 넘게 나오기 때문 
-- 단일 행 연산자 : 주로 비교 연산자 ( = , > , < , >= , <= , <> )
-- 이런 경우엔 다중행 연산자를 사용해야 함
SELECT *
FROM employees
WHERE job_id = (SELECT job_id FROM employees
WHERE job_id = 'IT_PROG'); -- 오류

-- 다중행 연산자 (IN,ANY,ALL)

SELECT * -- IN (포함되어있는 값들을 가져오는 연산자)
FROM employees
WHERE job_id IN (SELECT job_id FROM employees
WHERE job_id = 'IT_PROG');

-- first_name이 David인 사람들의 급여와 같은 급여를 받는 사람들을 조회
SELECT *
FROM employees
WHERE salary IN (SELECT salary FROM employees
                 WHERE first_name = 'David');

