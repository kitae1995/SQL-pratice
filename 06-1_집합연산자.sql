
-- 집합 연산자
-- 서로 다른 쿼리 결과의 행들을 하나로 결합, 비교 , 차이를 구할 수 있게 해주는 연산자
-- UNION(합집합 중복x), UNION ALL(합집합 중복O), INTERSECT(교집합), MINUS(차집합)
-- 위 아래 column 개수와 데이터 타입의 정확히 일치해야 한다.

SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION -- 합집합
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL -- 합집합(중복O)
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

-- INTERSECT
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT -- 교집합
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

-- A-B 차집합
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
MINUS -- 합집합(중복O)
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;
-- A에서 조회된 내용에서 B를 뺌 만약 B가 값이 없다 ? 그럼 사실 A 출력문이랑 똑같음


SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';

