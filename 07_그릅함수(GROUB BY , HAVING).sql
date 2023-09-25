
-- �׷� �Լ� AVG, MAX , MIN ,SUM , COUNT;

SELECT
    AVG(salary),
    MAX(salary),
    MIN(salary),
    SUM(salary),
    COUNT(salary)
FROM employees;

SELECT COUNT(*) -- �� �� �������� ��
FROM employees;

SELECT COUNT(first_name)
FROM employees;

SELECT COUNT(commission_pct) -- null���� �˾Ƽ� ����
FROM employees;

SELECT COUNT(manager_id) 
FROM employees;

-- �μ����� �׷�ȭ, �׷��Լ��� ���
-- ������ ��
-- �׷� �Լ��� �Ϲ� �÷��� ���ÿ� �׳� ����� ���� �����ϴ�.
SELECT
    department_id,
    TRUNC(AVG(salary))
FROM employees
GROUP BY department_id; -- �׷캰 �޿��� ���

SELECT
    job_id,
    department_id,
    TRUNC(AVG(salary))
FROM employees
GROUP BY department_id,job_id -- �ٵ� �׷�ȭ�� ���� �ϳ��� �� , �ΰ� �̻��� �� �Ⱦ�
ORDER BY department_id;

-- GROUP BY�� ���� �׷�ȭ �� �� ������ �� ��� HAVING�� ���.
SELECT
    department_id,
    TRUNC(AVG(salary))
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000; -- �μ��� �׷�ȭ�� ������ �μ��� �޿��� ���� 10�� �̻��ΰ��� ��ո� ���ض�

SELECT
    job_id,
    count(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5;

-- �μ� ���̵� 50 �̻��� �͵��� �׷�ȭ ��Ű��, �׷� ���� ����� 5000 �̻� ��ȸ
SELECT
department_id,
TRUNC(AVG(salary)) AS ���
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;

SELECT
department_id,
salary 
FROM employees
WHERE department_id >= 50
ORDER BY department_id DESC;

/*
���� 1.
��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
*/
SELECT
job_id,
COUNT(job_id) AS ������
FROM employees
GROUP BY job_id;

SELECT
job_id,
AVG(salary) AS ��ձ޿�
FROM employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;


/*
���� 2.
��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
(TO_CHAR() �Լ��� ����ؼ� ������ ��ȯ�մϴ�. �׸��� �װ��� �׷�ȭ �մϴ�.)
*/
SELECT
TO_CHAR(hire_date,'YY') AS �Ի�⵵,
count(hire_date)
FROM employees
GROUP BY TO_CHAR(hire_date,'YY');





/*
���� 3.
�޿��� 5000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. 
�� �μ� ��� �޿��� 7000�̻��� �μ��� ����ϼ���.
*/
SELECT 
department_id,
TRUNC(AVG(salary))
FROM employees
WHERE salary >= 5000
GROUP BY department_id
HAVING AVG(salary) >= 7000;









/*
���� 4.
��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
*/
SELECT 
department_id,
TRUNC(AVG(salary + (salary*commission_pct)),2),
SUM(salary),
COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY department_id;

/*
����special) employees���̺��� �޿��� �ִ�, �ּ�, ���, ���� ���Ͻÿ�

count(�÷���), max(�÷���), min(�÷���), avg(�÷���), sum(�÷���) �Լ�

����) ����� �Ҽ���������, ���� ���ڸ����� �޸���� ��ǥ��

*/

SELECT 
MAX(salary),MIN(salary),TRUNC(AVG(salary)),TO_CHAR(SUM(salary),'L999,999'),count(*)
FROM employees;

/*
�޿��� 10000�̸��̸� �ʱ�, 20000�̸��̸� �߱� �� �ܸ� ����� ����Ͻÿ�
(case ���)

����1) ������ �����ȣ, �����, �������� ǥ���Ͻÿ�

����2) ����(��������)���� �����ϰ�, ������ �����(��������)���� �����Ͻÿ�
*/


SELECT first_name , salary,
CASE WHEN salary < 10000 THEN '�ʱ�'
     WHEN salary < 20000 THEN '�߱�'
     ELSE '���' 
     END AS �޿�
FROM employees;

/* #����

������̺��� �����ȣ, �̸�, �޿�, Ŀ�̼�, ������ ����Ͻÿ�

����1) ������ $ ǥ�ÿ� ���ڸ����� �޸��� ����Ͻÿ�

����2) ���� = �޿� * 12 + (�޿� * 12 * Ŀ�̼�)

����3) Ŀ�̼��� ���� �ʴ� ����� �����ؼ� ����Ͻÿ�
=============================
*/
SELECT employee_id,first_name,salary,commission_pct,
TO_CHAR(salary*12,'$999,999') AS ����
FROM employees;

/*

����
�μ��� �޿������ ���Ͻÿ�

����1) �Ҽ� ���ϴ� �ݿø�

����2) ���ڸ� ���� �޸�, ȭ�� ����(��)�� ǥ��

����3) �μ����� �������� �����Ͻÿ�

����4) ��ձ޿��� 5000�̻��� �μ��� ǥ���Ͻÿ�

*/

SELECT
department_id,
TO_CHAR(AVG(salary),'L999,999')
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id ASC;








