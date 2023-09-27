
/*
view�� �������� �ڷḸ ���� ���� ����ϴ� ���� ���̺��� �����Դϴ�.
��� �⺻ ���̺�� ������ ���� ���̺��̱� ������
�ʿ��� �÷��� ������ �θ� ������ ������ ���ϴ�.
��� �������̺�� ���� �����Ͱ� ���������� ����� ���´� �ƴմϴ�.
�並 ���ؼ� �����Ϳ� �����ϸ� ���� �����ʹ� �����ϰ� ��ȣ�� �� �ֽ��ϴ�.
*/

SELECT * FROM user_sys_privs; -- �������ִ� HR ������ ���� ����

-- �ܼ� ��
-- ���� �÷� �̸��� �Լ� ȣ�⹮, ����� �� ���� ���� ǥ�����̸� �ȵ˴ϴ�.
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
); -- ��ȣ ���� ������ ���� ���̺� view_emp�� �־ �������

SELECT * FROM view_emp
WHERE salary >= 6000;

-- ���� ��
-- ���� ���̺��� �����Ͽ� �ʿ��� �����͸� �����ϰ� ���� Ȯ���� ���� ���

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

-- ���� ���� ( CREATE OR REPLACE VIEW ���� )
-- ���� �̸����� �ش� ������ ����ϸ� �����Ͱ� ����Ǹ鼭 ���Ӱ� �����˴ϴ�.

CREATE OR REPLACE VIEW view_emp_dept_jobs AS(
SELECT 
e.employee_id,
first_name || ' ' || last_name AS FULL_NAME,
d.department_name,
j.job_title,
e.salary -- �߰��� ����
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
ORDER BY AVG(salary) DESC; -- SQL ������ Ȯ���� ª����

-- �� ����
DROP VIEW view_emp;

/*
view�� INSERT�� �Ͼ�� ��쿡�� ���� ���̺��� ��������� �����.
�׷��� view�� INSERT , UPDATE , DELETE�� ���� ���� ������ ����
���� ���̺��� NOT NULL�� ��쿡�� VIEW�� INSERT�� �Ұ����ϴٴ���
VIEW���� ����ϴ� �÷��� ������ ��쿡�� �Ұ���
*/

INSERT INTO view_emp_dept_jobs
VALUES(300,'test','test','test',10000); -- �ȵ� , �ι��� �÷��� FULLNAME(first_name+last_name)�̶��
                                        -- ����ڰ� ���Ƿ� ���� �����÷��̶� ����,����,���� �� �Ұ���
                                        
INSERT INTO view_emp_dept_jobs
(employee_id,department_name,job_title,salary)
VALUES(300,'test','test',10000); -- �ȵ� , JOIN�� ���� ��� �� ���� ������ �� ����.

INSERT INTO view_emp
(employee_id,job_id,salary)
VALUES(300,'test',10000); -- �ȵ� , �̹� view_emp�� FULLNAME�̶�� ������ �־
                          -- first,last name�� �־��� �� ����
                          
DELETE FROM view_emp
WHERE employee_id = 107; -- �����

SELECT * FROM view_emp; -- �信���� ���������� , ���� ���̺��� �����Ǿ� ����
SELECT * FROM employees; -- ����,����,���� ������ '�������̺�'���� �ݿ��̵� 
ROLLBACK;                          
-- ��������� , view�� ������ �Ѵٱ⺸�� �׳� ���⸸ �ϴ� �뵵�� ����ϴ°��� �ٶ�����




-- WITH CHECK OPTION -> ���� ���� �÷�
-- �並 ������ �� ����� ���� �÷��� �並 ���ؼ� ������ �� ���� ���ִ� Ű����

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
WHERE employee_id = 107; -- JOB_ID�� ������ �Ǵ� ���̶� ���� �ִ� �̸��� �ϳ��� �����

SELECT * FROM view_emp_test;

-- �б� ���� �� ( ���� ���� ���ϰ� SELECT�� ����� )
-- WITH READ ONLY; �ٿ��ָ� ��
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



