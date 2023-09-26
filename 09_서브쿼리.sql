
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
                 

-- ANY : 값을 서브쿼리에 의해 리턴된 각각의 값과 비교함
-- 하나라도 만족하면 OK
-- david의 최소급여는 4800(david 동명이인 급여 4800,6500,9600)
-- 이니까 4800보다 큰 사람 전부

SELECT *
FROM employees
WHERE salary > ANY (SELECT salary FROM employees
                 WHERE first_name = 'David');
                 
-- ALL : 값을 서브쿼리에 의해 리턴된 각각의 값과 모두 비교해서
-- 모두 만족해야 함.
-- DAVID의 모든 급여보다 큰 급여를 가진사람을 가져오라는건데
-- DAVID(4800,6500,9600)보다 큰 사람을 말하는건데 결국 9600보다 크면 4800,6500보다도 큰거니까
-- 9600보다 크면 됨
SELECT *
FROM employees
WHERE salary > ALL (SELECT salary FROM employees
                 WHERE first_name = 'David');
     
                 
-- EXIST : 서브쿼리가 하나 이상의 행을 반환하면 참으로 간주.
-- job history에 존재하는 직원이 employees에도 존재한다면 조회함
SELECT * 
FROM employees e 
WHERE EXISTS (SELECT 1 FROM job_history jh
              WHERE e.employee_id = jh.employee_id);
              
SELECT * 
FROM employees e 
WHERE EXISTS (SELECT 1 FROM departments d
              WHERE e.manager_id = d.manager_id);

--조건을 하나만 건다면 참,거짓만 판단함
-- 이경우 참이니까 employees의 값을 전부 리턴함
SELECT *
FROM employees
WHERE EXISTS (SELECT 1 FROM departments
              WHERE department_id = 10); 
              
--------------------------------------------------------------------------------



-- SELECT 절에 서브쿼리 붙이기.
-- 스칼라 서브쿼리라고도 칭함.
-- 스칼라 서브쿼리 : 실행 결과가 단일 값을 반환하는 서브쿼리.
-- 주로 SELECT절이나 WHERE 절에서 사용됨.

SELECT
    e.first_name,
    d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT
    e.first_name,
    (
    SELECT
        department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY first_name ASC;

/*
- 스칼라 서브쿼리(SELECT 쿼리)가 조인보다 좋은 경우
: 함수처럼 한 레코드당 정확히 하나의 값만을 리턴할 때.

- 조인이 스칼라 서브쿼리보다 좋은 경우
: 조회할 데이터가 대용량인 경우, 해당 데이터가
수정, 삭제 등이 빈번한 경우(sql 가독성이 조인이 좀 더 뛰어납니다)
*/

-- 각 부서의 매니저 이름 조회 ( LEFT 조인 )

SELECT
d.*,
e.first_name
FROM departments d LEFT JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

-- 각 부서의 매니저 이름 조회 (스칼라 서브쿼리)
SELECT
d.*,
(SELECT
first_name
FROM employees e
WHERE e.employee_id = d.manager_id) AS manager_name
FROM departments d
ORDER BY d.manager_id ASC;

-- 각 부서별 사원 수 뽑기
SELECT
    d.*,
(SELECT 
    count(*)
FROM employees e
WHERE e.department_id = d.department_id
GROUP BY department_id) AS 사원수
FROM departments d;

--------------------------------------------------------------------------------

-- 인라인 뷰 (FROM 구문에 서브쿼리가 오는 것.)
-- 특정 테이블 전체가 아닌 SELECT를 통해 일부 데이터를 조회한 것을 가상 테이블로
-- 사용하고 싶을 때.
-- 순번을 정해놓은 조회 자료를 범위를 지정해서 가지고 오는 경우.

SELECT
ROWNUM AS rn,
employee_id,
first_name,
salary
FROM employees
ORDER BY salary DESC;

-- salary로 정렬을 진행하면서 바로 ROWNUM을 붙이면
-- ROWNUM이 정렬이 되지 않는 상황이 발생합니다.
-- 이유: ROWNUM이 먼저 붙고 정렬이 진행되기 때문. ORDER BY는 항상 마지막에 진행.
-- 해결: 정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는 것이 좋을 것 같아요.

-- 해결법을 사용한 수정본
SELECT
ROWNUM AS rn,tbl.*
FROM (
SELECT
employee_id,first_name,salary
FROM employees
ORDER BY salary DESC
) tbl;


-- rn을 0부터 10까지 순위를 보고싶을때
SELECT
ROWNUM AS rn,tbl.*
FROM (
SELECT
employee_id,first_name,salary
FROM employees
ORDER BY salary DESC
) tbl
WHERE rn > 0 AND rn <= 10;

-- 근데 오류가 남 , 왜 오류가 나냐 ? FROM 다음에 WHERE이 진행되기때문에 ( sql의 진행순서가 이래서 중요함 )
-- ROWNUM을 붙이고 나서 범위를 지정해서 조회하려고 하는데,
-- 범위 지정도 불가능하고, 지목할 수 없는 문제가 발생하더라.
-- 이유: WHERE절부터 먼저 실행하고 나서 ROWNUM이 SELECT 되기 때문에.
-- 해결: ROWNUM까지 붙여 놓고 다시 한 번 자료를 SELECT 해서 범위를 지정해야 되겠구나.

-- 해결법을 쓴 수정본

SELECT *
FROM(
SELECT
ROWNUM AS rn,tbl.*
FROM (
SELECT
employee_id,first_name,salary
FROM employees
ORDER BY salary DESC
) tbl 
)
WHERE rn > 20 AND rn <= 30;

/*
가장 안쪽 SELECT 절에서 필요한 테이블 형식(인라인 뷰)을 생성.
바깥쪽 SELECT 절에서 ROWNUM을 붙여서 다시 조회
가장 바깥쪽 SELECT 절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회.

** SQL의 실행 순서
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/







