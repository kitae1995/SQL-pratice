
/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념입니다.
뷰는 기본 테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해 집니다.
뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태는 아닙니다.
뷰를 통해서 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있습니다.
*/

SELECT * FROM user_sys_privs; -- 접속해있는 HR 계정이 가진 권한

-- 단순 뷰
-- 뷰의 컬럼 이름은 함수 호출문, 연산식 등 같은 가상 표현식이면 안됩니다.
SELECT
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;

CREATE VIEW view_emp AS (
SELECT
    employee_id,
    first_name || ' ' || last_name AS FULL_NAME,
    job_id,
    salary
FROM employees
WHERE department_id = 60
); -- 괄호 안의 내용을 가상 테이블 view_emp에 넣어서 만들어줌

SELECT * FROM view_emp
WHERE salary >= 6000;

-- 복합 뷰
-- 여러 테이블을 조인하여 필요한 데이터만 저장하고 빠른 확인을 위해 사용

CREATE VIEW view_emp_dept_jobs AS(
SELECT 
e.employee_id,
first_name || ' ' || last_name AS FULL_NAME,
d.department_name,
j.job_title
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN jobs j
ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

-- 뷰의 수정 ( CREATE OR REPLACE VIEW 구문 )
-- 동일 이름으로 해당 구문을 사용하면 데이터가 변경되면서 새롭게 생성됩니다.

CREATE OR REPLACE VIEW view_emp_dept_jobs AS(
SELECT 
e.employee_id,
first_name || ' ' || last_name AS FULL_NAME,
d.department_name,
j.job_title,
e.salary -- 추가된 구문
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN jobs j
ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT 
job_title,
AVG(salary) AS avg,
count(*)
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC; -- SQL 구문이 확실히 짧아짐

-- 뷰 삭제
DROP VIEW view_emp;

/*
view에 INSERT가 일어나는 경우에는 실제 테이블에도 변경사항이 적용됨.
그래서 view의 INSERT , UPDATE , DELETE는 많은 제약 사항이 따름
원본 테이블이 NOT NULL인 경우에는 VIEW에 INSERT가 불가능하다던지
VIEW에서 사용하는 컬럼이 가상열인 경우에도 불가능
*/

INSERT INTO view_emp_dept_jobs
VALUES(300,'test','test','test',10000); -- 안됨 , 두번쨰 컬럼은 FULLNAME(first_name+last_name)이라는
                                        -- 사용자가 임의로 만든 가상컬럼이라 삽입,삭제,수정 다 불가능
                                        
INSERT INTO view_emp_dept_jobs
(employee_id,department_name,job_title,salary)
VALUES(300,'test','test',10000); -- 안됨 , JOIN된 뷰의 경우 한 번에 수정할 수 없음.

INSERT INTO view_emp
(employee_id,job_id,salary)
VALUES(300,'test',10000); -- 안됨 , 이미 view_emp는 FULLNAME이라는 가상열이 있어서
                          -- first,last name을 넣어줄 수 없음
                          
DELETE FROM view_emp
WHERE employee_id = 107; -- 실행됨

SELECT * FROM view_emp; -- 뷰에서도 삭제됐지만 , 원본 테이블에도 삭제되어 있음
SELECT * FROM employees; -- 삽입,수정,삭제 성공시 '원본테이블'에도 반영이됨 
ROLLBACK;                          
-- 결론적으로 , view는 수정을 한다기보단 그냥 보기만 하는 용도로 사용하는것이 바람직함




-- WITH CHECK OPTION -> 조건 제약 컬럼
-- 뷰를 생성할 때 사용한 조건 컬럼은 뷰를 통해서 변경할 수 없게 해주는 키워드

CREATE OR REPLACE VIEW view_emp_test AS (
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

UPDATE view_emp_test
SET job_id = 'AD_VP'
WHERE employee_id = 107; -- JOB_ID는 참조가 되는 행이라 원래 있던 이름중 하나로 써야함

SELECT * FROM view_emp_test;

-- 읽기 전용 뷰 ( 수정 절대 못하게 SELECT만 허용함 )
-- WITH READ ONLY; 붙여주면 됨
CREATE OR REPLACE VIEW view_emp_test AS (
SELECT
    employee_id,
    first_name,
    last_name,
    email,
    hire_date,
    job_id,
    department_id
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;



