
-- MERGE : 테이블 병합

/*
UPDATE와 INSERT를 한 방에 처리.

한 테이블에 해당하는 데이터가 있다면 UPDATE를,
없으면 INSERT로 처리해라.
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1 = 2 );

INSERT INTO emps_it
    (employee_id , first_name , last_name , email , hire_date , job_id)
VALUES (106,'춘식','킴','choonsik',sysdate,'IT_PROG');

SELECT * FROM emps_it;

SELECT * FROM employees
WHERE job_id = 'IT_PROG';   

-- emps_it에 IT PROG인데 105,106의 아이디를 가진 사람이 있고
-- employees에도 IT PROG인데 105 106의 아이디를 가진 사람이 있음
-- 합치면 문제가 생김 중복이되서
-- 이럴때 MERGE를 사용해야함

MERGE INTO emps_it a -- (머지를 할 타겟 테이블)
    USING -- 병합시킬 데이터
        (SELECT * FROM employees
         WHERE job_id = 'IT_PROG') b -- 병합하고자 하는 데이터를 서브쿼리로 표현
    ON -- 병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN -- 조건이 일치하는 경우에는 타겟 테이블에 이렇게 실행하라.
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
         /*
        DELETE만 단독으로 쓸 수는 없습니다.
        UPDATE 이후에 DELETE 작성이 가능합니다.
        UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
        DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
        */
    DELETE
        WHERE a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN
    INSERT /*속성 (컬럼) */ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
----------------------------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');


/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
*/

MERGE INTO emps_it a
    USING
        (SELECT * FROM employees) b
    ON
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET
        a.phone_number = b.phone_number,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id,
        a.email = b.email
WHEN NOT MATCHED THEN
    INSERT VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
SELECT * 
FROM emps_it
ORDER BY employee_id ASC;

ROLLBACK;

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- PDF 문제 1~5번

CREATE TABLE DEPTS AS (SELECT * FROM departments);

SELECT * FROM DEPTS;

INSERT INTO DEPTS(department_id,department_name,manager_id,location_id)
VALUES(320,'영업',303,1700);

UPDATE DEPTS SET department_name = 'IT BANK' 
WHERE department_name = 'IT Support'; --

UPDATE DETPS 

UPDATE DEPTS SET manager_id = 301 
WHERE department_id = 290;

UPDATE DEPTS SET department_name = 'IT Help' , manager_id = 303 , location_id = 1800
WHERE department_name = 'IT Helpdesk';

UPDATE DEPTS SET manager_id = 301
WHERE department_name = '회계부' OR department_name = '재정' OR department_name = '인사' OR
      department_name = '영업';
      
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = 220;

CREATE TABLE NDEPTS AS (SELECT * FROM DEPTS);

UPDATE NDEPTS SET manager_id = 100
WHERE manager_id IS NOT NULL;

MERGE INTO DEPTS a -- (머지를 할 타겟 테이블)
    USING -- 병합시킬 데이터
        (SELECT * FROM departments) b -- 병합하고자 하는 데이터를 서브쿼리로 표현
    ON -- 병합시킬 데이터의 연결 조건
        (a.department_id = b.department_id)
WHEN MATCHED THEN -- 조건이 일치하는 경우에는 타겟 테이블에 이렇게 실행하라.
    UPDATE SET
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
            
WHEN NOT MATCHED THEN -- 일치하지 않을시 수정하지않고 그냥 집어넣음
    INSERT /*속성 (컬럼) */ VALUES
    (b.department_id, b.department_name, b.manager_id,
    b.location_id);
    
--------------------------------------- 문제 5번
SELECT * FROM jobs_it;

CREATE TABLE jobs_it AS (SELECT * FROM jobs WHERE min_salary > 6000);

INSERT INTO jobs_it(job_id,job_title,min_salary,max_salary)
VALUES('SEC_DEV','보안개발팀',6000,19000);

MERGE INTO jobs_it a -- (머지를 할 타겟 테이블)
    USING -- 병합시킬 데이터
        (SELECT * FROM jobs WHERE min_salary > 5000) b -- 병합하고자 하는 데이터를 서브쿼리로 표현
    ON -- 병합시킬 데이터의 연결 조건
        (a.job_id = b.job_id)
WHEN MATCHED THEN -- 조건이 일치하는 경우에는 타겟 테이블에 이렇게 실행하라.
    UPDATE SET
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
        
    WHEN NOT MATCHED THEN
    INSERT /*속성 (컬럼) */ VALUES
    (b.job_id, b.job_title,b.min_salary,b.max_salary);