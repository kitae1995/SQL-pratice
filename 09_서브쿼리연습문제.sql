/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/

SELECT
   *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- ��� ����� ��ձ޿��� ���� �׷�ȭ ���ص��� ( �׷�ȭ ���ϸ� ���̺� ��ü�� �׷�ȭ�� )

SELECT
   count(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT
   *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees
                WHERE job_id = 'IT_PROG');
                

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
*/
SELECT
*
FROM employees
WHERE department_id = (SELECT
    department_id
FROM departments 
WHERE manager_id = 100);


/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/
SELECT
*
FROM employees
WHERE manager_id > (SELECT
manager_id
FROM employees
WHERE first_name = 'Pat');

SELECT
*
FROM employees
WHERE manager_id IN (SELECT
manager_id
FROM employees
WHERE first_name = 'James');






/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT
*
FROM(
SELECT
ROWNUM rn,tbl.*
FROM(
(SELECT
first_name
FROM employees
ORDER BY first_name DESC) tbl))
WHERE rn>40 AND rn<=50;

/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȣ, �Ի����� ����ϼ���.
*/
SELECT
*
FROM(
SELECT
ROWNUM rn,tbl.*
FROM(
(SELECT
employee_id,first_name,phone_number,hire_date
FROM employees
ORDER BY hire_date ASC) tbl))
WHERE rn>30 AND rn<=40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/
SELECT
e.employee_id,
e.first_name || ' ' || e.last_name AS �̸�,
e.department_id,
d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id ASC;
/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
employee_id,
first_name || ' ' || last_name AS �̸�,
department_id,
(SELECT
department_name
FROM departments d
WHERE d.department_ID = e.department_ID) AS deparment_name
FROM employees e;


/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/
SELECT
d.*,
l.street_address,
l.postal_code,
l.city
FROM departments d LEFT JOIN locations l
ON d.location_id = l.location_id
ORDER BY d.department_id ASC;



/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT
d.* ,
(SELECT
l.street_address
FROM locations l
WHERE l.location_id = d.location_id) AS street_address
FROM departments d;
/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/
SELECT
l.location_id,
l.street_address,
l.city,
c.country_id,
c.country_name
FROM locations l LEFT JOIN countries c
ON l.country_id = c.country_id
ORDER BY country_name ASC;

/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/
SELECT 
loc.location_id,
loc.street_address,
loc.city,
(SELECT
c.country_id
FROM countries c
WHERE loc.country_id = c.country_id
) AS country_id,
(SELECT
c.country_name
FROM countries c
WHERE loc.country_id = c.country_id
) AS country_name
FROM locations loc
ORDER BY country_name ASC;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
1-10��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/
SELECT
*
FROM
(SELECT
ROWNUM rn,
tal.*
FROM
(
SELECT
e.employee_id,
e.first_name,
e.phone_number,
e.hire_date,
e.department_id,
d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY hire_date ASC
) tal)
WHERE rn > 30 AND rn <= 40;


SELECT
ROWNUM rn,
e.employee_id,
e.first_name,
e.phone_number,
e.hire_date,
e.department_id,
d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY hire_date ASC;
/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/
SELECT
e.last_name,
e.job_id,
e.department_id,
d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE e.job_id = 'SA_MAN';
/*
���� 14
--DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
--�ο��� ���� �������� �����ϼ���.
--����� ���� �μ��� ������� ���� �ʽ��ϴ�.
*/
SELECT
d.department_id,
count(*)
FROM departments d LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id;



/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/

/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/
