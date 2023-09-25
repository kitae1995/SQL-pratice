
-- 그룹 함수 AVG, MAX , MIN ,SUM , COUNT;

SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM employees;

SELECT COUNT(*) -- 총 행 데이터의 수
FROM employees;

SELECT COUNT(first_name)
FROM employees;

SELECT COUNT(commission_pct) -- null값은 알아서 빼줌
FROM employees;

SELECT COUNT(manager_id) 
FROM employees;

-- 부서별로 그룹화, 그룹함수의 사용
-- 주의할 점
-- 그룹 함수는 일반 컬럼과 동시에 그냥 출력할 수는 없습니다.
SELECT
    department_id,
    TRUNC(AVG(salary))
FROM employees
GROUP BY department_id; -- 그룹별 급여의 평균

SELECT
    job_id,
    department_id,
    TRUNC(AVG(salary))
FROM employees
GROUP BY department_id,job_id -- 근데 그룹화는 보통 하나만 함 , 두개 이상은 잘 안씀
ORDER BY department_id;

-- GROUP BY를 통해 그룹화 할 때 조건을 걸 경우 HAVING을 사용.
SELECT
    department_id,
    TRUNC(AVG(salary))
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000; -- 부서별 그룹화는 하지만 부서별 급여의 합이 10만 이상인곳의 평균만 구해라

SELECT
    job_id,
    count(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5;

-- 부서 아이디가 50 이상인 것들을 그룹화 시키고, 그룹 월급 평균이 5000 이상만 조회
SELECT
department_id,
TRUNC(AVG(salary)) AS 평균
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;

SELECT
department_id,
salary 
FROM employees
WHERE department_id >= 50
ORDER BY department_id DESC;

/*
문제 1.
사원 테이블에서 JOB_ID별 사원 수를 구하세요.
사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
*/
SELECT
job_id,
COUNT(job_id) AS 직원수
FROM employees
GROUP BY job_id;

SELECT
job_id,
AVG(salary) AS 평균급여
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;


/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.)
*/
SELECT
TO_CHAR(hire_date,'YY') AS 입사년도,
count(hire_date)
FROM employees
GROUP BY TO_CHAR(hire_date,'YY');





/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상인 부서만 출력하세요.
*/
SELECT 
department_id,
TRUNC(AVG(salary))
FROM employees
WHERE salary >= 5000
GROUP BY department_id
HAVING AVG(salary) >= 7000;









/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
*/
SELECT 
department_id,
TRUNC(AVG(salary + (salary*commission_pct)),2),
SUM(salary),
COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;

/*
문제special) employees테이블에서 급여의 최대, 최소, 평균, 합을 구하시오

count(컬럼명), max(컬럼명), min(컬럼명), avg(컬럼명), sum(컬럼명) 함수

조건) 평균은 소수이하절삭, 합은 세자리마다 콤마찍고 ￦표시

*/

SELECT 
MAX(salary),MIN(salary),TRUNC(AVG(salary)),TO_CHAR(SUM(salary),'L999,999'),count(*)
FROM employees;

/*
급여가 10000미만이면 초급, 20000미만이면 중급 그 외면 고급을 출력하시오
(case 사용)

조건1) 제목은 사원번호, 사원명, 구분으로 표시하시오

조건2) 구분(오름차순)으로 정렬하고, 같으면 사원명(오름차순)으로 정렬하시오
*/


SELECT first_name , salary,
CASE WHEN salary < 10000 THEN '초급'
     WHEN salary < 20000 THEN '중급'
     ELSE '고급' 
     END AS 급여
FROM employees;

/* #문제

사원테이블에서 사원번호, 이름, 급여, 커미션, 연봉을 출력하시오

조건1) 연봉은 $ 표시와 세자리마다 콤마를 사용하시오

조건2) 연봉 = 급여 * 12 + (급여 * 12 * 커미션)

조건3) 커미션을 받지 않는 사원도 포함해서 출력하시오
=============================
*/
SELECT employee_id,first_name,salary,commission_pct,
TO_CHAR(salary*12,'$999,999') AS 연봉
FROM employees;

/*

문제
부서별 급여평균을 구하시오

조건1) 소수 이하는 반올림

조건2) 세자리 마다 콤마, 화폐 단위(￦)로 표시

조건3) 부서별로 오름차순 정렬하시오

조건4) 평균급여가 5000이상인 부서만 표시하시오

*/

SELECT
department_id,
TO_CHAR(AVG(salary),'L999,999')
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id ASC;








