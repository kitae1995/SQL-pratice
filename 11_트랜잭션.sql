
--오토커밋 여부 확인 ( 트랜잭션같은건 이게 꺼져있어야 관리하기 편함 )
SHOW AUTOCOMMIT;    

--오토커밋 키기
SET AUTOCOMMIT ON;

--오토커밋 끄기
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (306, 'kim', 'kim1234@gmail.com', sysdate, 1800);
    
DELETE FROM emps
WHERE employee_id = 304;
    
-- ROLLBACK;    
-- 보류중인 모든 데이터 변경사항을 취소(폐기)
-- 직전 커밋 단계로 회귀(돌아기기) 및 트랜잭션 종료
-- 커밋하기 전으로 돌아감, 바로 직전에했던 걸 돌려주는게 아님(이걸 원하면
-- 뭐 할때마다 커밋해야함 , 오토커밋을 키던지)
ROLLBACK;

-- 보류중인 모든 데이터 변경사항을 '영구'적으로 적용하면서 트랜잭션 종료
-- 커밋 후에는 어떠한 방법을 사용하더라도 되돌릴수 없음 !
COMMIT;

-- SAVEPOINT 이름; 
-- 안시문법이 아니라 오라클에서만 사용가능 ( 그래서 잘 안씀 )
SAVEPOINT insert_park;

ROLLBACK TO SAVEPOINT insert_park;  

-- DML = CRUD
-- DDL = CREATE, ALTER , DROP
-- TCL = COMMIT ROLLBACK

