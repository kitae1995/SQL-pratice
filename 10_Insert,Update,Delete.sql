
-- Insert
-- 테이블 구조 확인

DESC departments;

-- Insert의 첫번째 방법 ( 모든 컬럼 데이터를 한번에 지정 )

INSERT INTO departments
VALUES(300,'개발부',null,null);

SELECT * FROM departments;

ROLLBACK; -- insert한것들 전부 취소

-- insert의 두번째 방법 (직접 컬럼을 지정하고 저장 , NOT NULL 확인해야함 )

INSERT INTO departments
    (department_id , department_name , manager_id , location_id)
VALUES
    (280,'개발부',103,1700);
    
INSERT INTO departments
    (department_id , department_name , location_id)
VALUES
    (290,'총무부',1700);
    
    
-- 사본 테이블 생성 (CTAS)
CREATE TABLE emps AS 
(SELECT employee_id , first_name , job_id , hire_date
FROM employees);

SELECT * FROM emps;

-- 테이블 제거
DROP TABLE emps; 


-- 사본 테이블 생성 (데이터를 제외한 구조만 가져오기)
CREATE TABLE emps AS 
(SELECT employee_id , first_name , job_id , hire_date
FROM employees WHERE 1 = 2);

-- WHERE 1 = 2를 왜 넣나 ? false값을 넣기위해 관용적으로 넣는 구문임
-- false값이 들어가면 데이터값을 가져오지 않음 ( 구조는 가져옴 )

-- INSERT (서브쿼리)
INSERT INTO emps
(SELECT employee_id , first_name , job_id , hire_date
FROM employees WHERE department_id = 50);

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- UPDATE
CREATE TABLE emps AS 
(SELECT * FROM employees);

SELECT * FROM emps;
DROP TABLE emps; 

-- UPDATE를 진행할 때에는 누구를 수정할 지 잘 지목해야 함.
-- 그렇지 않으면 수정 대상이 테이블 전체로 지정이 됨
-- 예시 

UPDATE emps SET salary = 30000; -- 모든 salary값이 30000으로 변경됨
ROLLBACK;

UPDATE emps SET salary = 30000 
WHERE employee_id = 100; -- employee_id의 값이 100인 행의 salary를 30000으로

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id = 100; -- employee_id의 값이 100인 행의 salary를 salary + salary * 0.1 값으로

UPDATE emps SET phone_number = '010.4742.8917', manager_id = 102
WHERE employee_id = 100;

-- UPDATE (서브 쿼리)

UPDATE emps SET (job_id , salary , manager_id) =
( SELECT job_id,salary,manager_id
  FROM emps
  WHERE employee_id = 100
)
WHERE employee_id = 101;

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- DELETE ( 행 자체를 삭제함 )
DELETE FROM emps    
WHERE employee_id = 103;

-- DELETE (서브쿼리)
DELETE FROM emps
WHERE department_id = ( SELECT department_id FROM departments
                        WHERE department_name = 'IT');
                        
SELECT * FROM departments;



