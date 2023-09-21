
SELECT * FROM employees;

-- WHERE 절 비교 (데이터 값은 대/소문자를 구분합니다.)
SELECT first_name,last_name,job_id
FROM employees
WHERE job_id = 'IT_PROG'; -- 대입 연산자가 아님 , 같냐는 뜻 

SELECT * FROM employees
where last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 90;

SELECT *
FROM employees
WHERE salary >= 15000
AND salary <= 20000; -- BETWEEN 으로 더 쉽게 작성가능

SELECT * FROM employees
WHERE hire_date = '04/01/30';  -- sql은 int,string이 아닌 date 날짜 타입도 존재함

-- 데이터 행 제한
SELECT * FROM employees
WHERE salary BETWEEN 15000 and 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' and '03/12/31';

-- IN 연산자의 사용 ( 특정 값들과 비교할 때 사용 ) 다중으로 검색하고 싶을때
SELECT * FROM employees
WHERE manager_id IN (100,101,102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP'); -- 위에 했던 job_id찾기의 연장선

-- LIKE 연산자
-- %는 어떠한 문자든, _는 데이터의 자리(위치)를 찾아낼 때

SELECT first_name, last_name
FROM employees
WHERE hire_date Like '03%'; -- 03으로 시작하는 모든 hiredate를 찾음

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%03'; -- 15로 끝나는 모든 hiredate를 찾음

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'; -- 05가 있는 모든 hiredate를 찾음 (중앙이 아님)

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___03%'; -- 앞에 3글자빼고 03으로 끝나는 경우
                               -- 말이 좀 어려운데 01/03/20 일 경우 가운데 03만 있으면 통과
                               
-- IS NULL (null값을 찾음)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NULL; -- commisionpct를 받지 않는 사람들

SELECT * FROM employees
WHERE commission_pct IS NOT NULL; --commisionpct를 받는 사람들
                               
--AND,OR
--AND가 OR보다 연산 순서가 빠름.
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
and salary >= 6000; -- 이러면 and를 먼저 연산해주기 때문에 salary가 6000인 이상인 FIMGR 그리고
                    -- ITPROG을 전부 데려옴 , 내가 원하는 값을 원하려면?
                    
--AND,OR
--AND가 OR보다 연산 순서가 빠름.
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
and salary >= 6000; -- 아예 연산순서를 바꾸던지 아니면 먼저 연산해야할 곳에 () 처리해줌

-- 데이터의 정렬 (SELECT 구문의 가장 마지막에 배치됩니다.)
-- ASC: ascending 오름차순
-- DESC: descending 내림차순 

SELECT * FROM employees
ORDER BY hire_date ASC; -- employees 테이블 전체를 hire_date 오름차순으로 정렬
                        -- 근데 사실 ORDER BY만 붙여도 오름차순이 디폴트값이긴 함

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC;

SELECT
    first_name,
    salary*12 AS pay
FROM employees
ORDER BY pay ASC; -- 자기가 임의로 이름붙은 별칭컬럼으로도 정렬 가능

