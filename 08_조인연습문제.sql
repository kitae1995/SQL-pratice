/*
���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ�� /���� �ּ�����/)
*/
SELECT
*
FROM employees e INNER JOIN departments d -- 106
ON e.department_id = d.department_id;

SELECT
*
FROM employees e LEFT OUTER JOIN departments d -- 107
ON e.department_id = d.department_id;

SELECT
*
FROM employees e RIGHT OUTER JOIN departments d -- 122
ON e.department_id = d.department_id;

SELECT
*
FROM employees e FULL OUTER JOIN departments d -- 123
ON e.department_id = d.department_id;
/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/
SELECT
e.first_name || ' ' || e.last_name AS NAME,
e.department_id
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.employee_id = 200;

/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����Ǿ� �ִ��� Ȯ��
*/
SELECT
e.first_name,e.last_name,e.department_id,j.job_title
FROM employees e INNER JOIN jobs j
ON e.job_id = j.job_id
ORDER BY first_name;

/*
���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/

SELECT
    *
FROM jobs j LEFT OUTER JOIN job_history jh
ON j.job_id = jh.job_id;

/*
���� 5.
--Steven King�� �μ����� ����ϼ���.
*/
SELECT
e.first_name,e.last_name,d.department_name AS �μ���
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.employee_id = 100;
-- �̸����� �ص� �� '��ҹ��� Ȯ���ϰ�'



/*
���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/
SELECT
    *
FROM employees  CROSS JOIN departments;

/*
���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
*/
SELECT
e.employee_id,e.first_name || ' ' || e.last_name AS �̸� , e.salary, d.department_name, loc.city
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id INNER JOIN locations loc
ON d.location_id = loc.location_id
WHERE e.job_id = 'SA_MAN';

/*
���� 8.
-- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� 
���� ������ ����ϼ���.
*/
SELECT 
 *
FROM employees e INNER JOIN jobs j
ON e.job_id = j.job_id
WHERE j.job_title = 'Stock Manager' OR j.job_title = 'Stock Clerk';


/*
���� 9.
-- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
*/
SELECT
   
    d.department_name
FROM departments d LEFT OUTER JOIN employees e
ON d.manager_id = e.manager_id
WHERE d.manager_id IS NULL;

/*
���� 10. 
-join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
*/
SELECT
    e1.employee_id,e1.first_name,e1.manager_id,
    e2.first_name,e2.employee_id
FROM employees e1 JOIN employees e2 
ON e1.manager_id = e2.employee_id
ORDER BY e1.employee_id ASC;

/*
���� 11. 
-- EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
*/
SELECT
    e1.manager_id,
    e1.first_name,e2.salary
FROM employees e1 LEFT JOIN employees e2 
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e2.salary DESC;

SELECT *
FROM employees;
