
-- Insert
-- ���̺� ���� Ȯ��

DESC departments;

-- Insert�� ù��° ��� ( ��� �÷� �����͸� �ѹ��� ���� )

INSERT INTO departments
VALUES(300,'���ߺ�',null,null);

SELECT * FROM departments;

ROLLBACK; -- insert�Ѱ͵� ���� ���

-- insert�� �ι�° ��� (���� �÷��� �����ϰ� ���� , NOT NULL Ȯ���ؾ��� )

INSERT INTO departments
    (department_id , department_name , manager_id , location_id)
VALUES
    (280,'���ߺ�',103,1700);
    
INSERT INTO departments
    (department_id , department_name , location_id)
VALUES
    (290,'�ѹ���',1700);
    
    
-- �纻 ���̺� ���� (CTAS)
CREATE TABLE emps AS 
(SELECT employee_id , first_name , job_id , hire_date
FROM employees);

SELECT * FROM emps;

-- ���̺� ����
DROP TABLE emps; 


-- �纻 ���̺� ���� (�����͸� ������ ������ ��������)
CREATE TABLE emps AS 
(SELECT employee_id , first_name , job_id , hire_date
FROM employees WHERE 1 = 2);

-- WHERE 1 = 2�� �� �ֳ� ? false���� �ֱ����� ���������� �ִ� ������
-- false���� ���� �����Ͱ��� �������� ���� ( ������ ������ )

-- INSERT (��������)
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

-- UPDATE�� ������ ������ ������ ������ �� �� �����ؾ� ��.
-- �׷��� ������ ���� ����� ���̺� ��ü�� ������ ��
-- ���� 

UPDATE emps SET salary = 30000; -- ��� salary���� 30000���� �����
ROLLBACK;

UPDATE emps SET salary = 30000 
WHERE employee_id = 100; -- employee_id�� ���� 100�� ���� salary�� 30000����

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id = 100; -- employee_id�� ���� 100�� ���� salary�� salary + salary * 0.1 ������

UPDATE emps SET phone_number = '010.4742.8917', manager_id = 102
WHERE employee_id = 100;

-- UPDATE (���� ����)

UPDATE emps SET (job_id , salary , manager_id) =
( SELECT job_id,salary,manager_id
  FROM emps
  WHERE employee_id = 100
)
WHERE employee_id = 101;

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- DELETE ( �� ��ü�� ������ )
DELETE FROM emps    
WHERE employee_id = 103;

-- DELETE (��������)
DELETE FROM emps
WHERE department_id = ( SELECT department_id FROM departments
                        WHERE department_name = 'IT');
                        
SELECT * FROM departments;



