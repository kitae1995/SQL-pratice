-- ����Ŭ�� �� �� �ּ�

/*
����Ŭ�� ���� �� �ּ�
!!!!
*/

-- SELECT [�÷���(���� �� ����)] FROM [���̺� �̸�]

SELECT
    *
FROM
    employees;
    
SELECT employee_Id, first_name, last_name
FROM employees;

select email, phone_number,hire_date
FROM employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�.

SELECT
employee_id,
first_name,
last_name,
salary,
salary + salary*0.1 AS ���ʽ�
FROM employees;

-- NULL ���� Ȯ�� (���� 0�̳� �����̶��� �ٸ� ����)

SELECT department_id , commission_pct
FROM employees;

-- alias (�÷��� , ���̺���� �̸��� �����ؼ� ��ȸ�մϴ�.)
-- �÷� �ڿ� AS �� �̸� ���̸� ��

SELECT 
first_name AS �̸�,
last_name AS ��,
salary AS �޿�
FROM employees;

/*
����Ŭ�� Ȭ����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� Ȭ����ǥ��
ǥ���ϰ� �ʹٸ�, '' �ι� �������� ���� �˴ϴ� '' -> '�� ��
������ �����ϰ� �ʹٸ� ||�� ����մϴ�.
*/

SELECT
 first_name || ' ' || last_name || '''s'' Salary is $' || salary AS �޿�����
FROM employees; 


-- DISTINCT �ߺ� ���� Ű����
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

-- ROWNUM , ROWID
-- (** �ο�� : ������ ���� ��ȯ�Ǵ� �� ��ȣ�� ���)
-- (** �ο���̵� : �����ͺ��̽� ���� ���� �ּҸ� ���)

SELECT ROWNUM,ROWID, employee_id
FROM employees;