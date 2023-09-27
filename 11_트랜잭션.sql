
--����Ŀ�� ���� Ȯ�� ( Ʈ����ǰ����� �̰� �����־�� �����ϱ� ���� )
SHOW AUTOCOMMIT;    

--����Ŀ�� Ű��
SET AUTOCOMMIT ON;

--����Ŀ�� ����
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps
    (employee_id, last_name, email, hire_date, job_id)
VALUES
    (306, 'kim', 'kim1234@gmail.com', sysdate, 1800);
    
DELETE FROM emps
WHERE employee_id = 304;
    
-- ROLLBACK;    
-- �������� ��� ������ ��������� ���(���)
-- ���� Ŀ�� �ܰ�� ȸ��(���Ʊ��) �� Ʈ����� ����
-- Ŀ���ϱ� ������ ���ư�, �ٷ� �������ߴ� �� �����ִ°� �ƴ�(�̰� ���ϸ�
-- �� �Ҷ����� Ŀ���ؾ��� , ����Ŀ���� Ű����)
ROLLBACK;

-- �������� ��� ������ ��������� '����'������ �����ϸ鼭 Ʈ����� ����
-- Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ����� ���� !
COMMIT;

-- SAVEPOINT �̸�; 
-- �Ƚù����� �ƴ϶� ����Ŭ������ ��밡�� ( �׷��� �� �Ⱦ� )
SAVEPOINT insert_park;

ROLLBACK TO SAVEPOINT insert_park;  

-- DML = CRUD
-- DDL = CREATE, ALTER , DROP
-- TCL = COMMIT ROLLBACK

