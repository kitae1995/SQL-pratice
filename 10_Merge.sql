
-- MERGE : ���̺� ����

/*
UPDATE�� INSERT�� �� �濡 ó��.

�� ���̺� �ش��ϴ� �����Ͱ� �ִٸ� UPDATE��,
������ INSERT�� ó���ض�.
*/

CREATE TABLE emps_it AS (SELECT * FROM employees WHERE 1 = 2 );

INSERT INTO emps_it
    (employee_id , first_name , last_name , email , hire_date , job_id)
VALUES (106,'���','Ŵ','choonsik',sysdate,'IT_PROG');

SELECT * FROM emps_it;

SELECT * FROM employees
WHERE job_id = 'IT_PROG';   

-- emps_it�� IT PROG�ε� 105,106�� ���̵� ���� ����� �ְ�
-- employees���� IT PROG�ε� 105 106�� ���̵� ���� ����� ����
-- ��ġ�� ������ ���� �ߺ��̵Ǽ�
-- �̷��� MERGE�� ����ؾ���

MERGE INTO emps_it a -- (������ �� Ÿ�� ���̺�)
    USING -- ���ս�ų ������
        (SELECT * FROM employees
         WHERE job_id = 'IT_PROG') b -- �����ϰ��� �ϴ� �����͸� ���������� ǥ��
    ON -- ���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id)
WHEN MATCHED THEN -- ������ ��ġ�ϴ� ��쿡�� Ÿ�� ���̺� �̷��� �����϶�.
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
         /*
        DELETE�� �ܵ����� �� ���� �����ϴ�.
        UPDATE ���Ŀ� DELETE �ۼ��� �����մϴ�.
        UPDATE �� ����� DELETE �ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� UPDATE�� �����ϰ�
        DELETE�� WHERE���� �Ʊ� ������ ������ ���� �����ؼ� �����մϴ�.
        */
    DELETE
        WHERE a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN
    INSERT /*�Ӽ� (�÷�) */ VALUES
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
----------------------------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');


/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ��������.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
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

-- PDF ���� 1~5��

CREATE TABLE DEPTS AS (SELECT * FROM departments);

SELECT * FROM DEPTS;

INSERT INTO DEPTS(department_id,department_name,manager_id,location_id)
VALUES(320,'����',303,1700);

UPDATE DEPTS SET department_name = 'IT BANK' 
WHERE department_name = 'IT Support'; --

UPDATE DETPS 

UPDATE DEPTS SET manager_id = 301 
WHERE department_id = 290;

UPDATE DEPTS SET department_name = 'IT Help' , manager_id = 303 , location_id = 1800
WHERE department_name = 'IT Helpdesk';

UPDATE DEPTS SET manager_id = 301
WHERE department_name = 'ȸ���' OR department_name = '����' OR department_name = '�λ�' OR
      department_name = '����';
      
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = 220;

CREATE TABLE NDEPTS AS (SELECT * FROM DEPTS);

UPDATE NDEPTS SET manager_id = 100
WHERE manager_id IS NOT NULL;

MERGE INTO DEPTS a -- (������ �� Ÿ�� ���̺�)
    USING -- ���ս�ų ������
        (SELECT * FROM departments) b -- �����ϰ��� �ϴ� �����͸� ���������� ǥ��
    ON -- ���ս�ų �������� ���� ����
        (a.department_id = b.department_id)
WHEN MATCHED THEN -- ������ ��ġ�ϴ� ��쿡�� Ÿ�� ���̺� �̷��� �����϶�.
    UPDATE SET
        a.department_name = b.department_name,
        a.manager_id = b.manager_id,
        a.location_id = b.location_id
            
WHEN NOT MATCHED THEN -- ��ġ���� ������ ���������ʰ� �׳� �������
    INSERT /*�Ӽ� (�÷�) */ VALUES
    (b.department_id, b.department_name, b.manager_id,
    b.location_id);
    
--------------------------------------- ���� 5��
SELECT * FROM jobs_it;

CREATE TABLE jobs_it AS (SELECT * FROM jobs WHERE min_salary > 6000);

INSERT INTO jobs_it(job_id,job_title,min_salary,max_salary)
VALUES('SEC_DEV','���Ȱ�����',6000,19000);

MERGE INTO jobs_it a -- (������ �� Ÿ�� ���̺�)
    USING -- ���ս�ų ������
        (SELECT * FROM jobs WHERE min_salary > 5000) b -- �����ϰ��� �ϴ� �����͸� ���������� ǥ��
    ON -- ���ս�ų �������� ���� ����
        (a.job_id = b.job_id)
WHEN MATCHED THEN -- ������ ��ġ�ϴ� ��쿡�� Ÿ�� ���̺� �̷��� �����϶�.
    UPDATE SET
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
        
    WHEN NOT MATCHED THEN
    INSERT /*�Ӽ� (�÷�) */ VALUES
    (b.job_id, b.job_title,b.min_salary,b.max_salary);