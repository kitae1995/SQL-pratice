
/*
# �������� 
: SQL ���� �ȿ� �Ǵٸ� SQL�� �����ϴ� ��� ( �� �� ? �� �����ϰ� �ϱ� ���� )
�������� ���Ǹ� ���ÿ� ó���� �� ����
WHERE,SELECT,FROM���� �ۼ�����

- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/

-- �޿��� nancy���� ���� �޴� �������� �̸��� �����Ϸ��� ? ( ���������� �Ⱦ��� )
SELECT salary FROM employees
WHERE first_name = 'nancy';

SELECT first_name FROM employees
WHERE salary > 12000;

-- ���������� ���� ������ �̷������� 2�� Ʋ�����

-- nancy�� �޿����� ���� �޿��� �޴� ��� �����Ϸ���? ( �������� ��� )
SELECT first_name FROM employees
WHERE salary > (SELECT salary FROM employees
WHERE first_name = 'Nancy');

-- employee_id�� 103���� ����� job_id�� ������ job_id�� ���� ����� ��ȸ����.
SELECT *
FROM employees
WHERE job_id = (SELECT job_id FROM employees
WHERE employee_id = 103);

-- ���� ������������ ����غ��̴µ� ������ ��
-- ���� ������ ���������� �����ϴ� ���� �������� ������ �����ڸ� ��� �� �� ����
-- IT_PROG�� job_id�� ���� job_id�� ���� 5���� �Ѱ� ������ ���� 
-- ���� �� ������ : �ַ� �� ������ ( = , > , < , >= , <= , <> )
-- �̷� ��쿣 ������ �����ڸ� ����ؾ� ��
SELECT *
FROM employees
WHERE job_id = (SELECT job_id FROM employees
WHERE job_id = 'IT_PROG'); -- ����

-- ������ ������ (IN,ANY,ALL)

SELECT * -- IN (���ԵǾ��ִ� ������ �������� ������)
FROM employees
WHERE job_id IN (SELECT job_id FROM employees
WHERE job_id = 'IT_PROG');

-- first_name�� David�� ������� �޿��� ���� �޿��� �޴� ������� ��ȸ
SELECT *
FROM employees
WHERE salary IN (SELECT salary FROM employees
                 WHERE first_name = 'David');
                 

-- ANY : ���� ���������� ���� ���ϵ� ������ ���� ����
-- �ϳ��� �����ϸ� OK
-- david�� �ּұ޿��� 4800(david �������� �޿� 4800,6500,9600)
-- �̴ϱ� 4800���� ū ��� ����

SELECT *
FROM employees
WHERE salary > ANY (SELECT salary FROM employees
                 WHERE first_name = 'David');
                 
-- ALL : ���� ���������� ���� ���ϵ� ������ ���� ��� ���ؼ�
-- ��� �����ؾ� ��.
-- DAVID�� ��� �޿����� ū �޿��� ��������� ��������°ǵ�
-- DAVID(4800,6500,9600)���� ū ����� ���ϴ°ǵ� �ᱹ 9600���� ũ�� 4800,6500���ٵ� ū�Ŵϱ�
-- 9600���� ũ�� ��
SELECT *
FROM employees
WHERE salary > ALL (SELECT salary FROM employees
                 WHERE first_name = 'David');
     
                 
-- EXIST : ���������� �ϳ� �̻��� ���� ��ȯ�ϸ� ������ ����.
-- job history�� �����ϴ� ������ employees���� �����Ѵٸ� ��ȸ��
SELECT * 
FROM employees e 
WHERE EXISTS (SELECT 1 FROM job_history jh
              WHERE e.employee_id = jh.employee_id);
              
SELECT * 
FROM employees e 
WHERE EXISTS (SELECT 1 FROM departments d
              WHERE e.manager_id = d.manager_id);

--������ �ϳ��� �Ǵٸ� ��,������ �Ǵ���
-- �̰�� ���̴ϱ� employees�� ���� ���� ������
SELECT *
FROM employees
WHERE EXISTS (SELECT 1 FROM departments
              WHERE department_id = 10); 
              
--------------------------------------------------------------------------------



-- SELECT ���� �������� ���̱�.
-- ��Į�� ����������� Ī��.
-- ��Į�� �������� : ���� ����� ���� ���� ��ȯ�ϴ� ��������.
-- �ַ� SELECT���̳� WHERE ������ ����.

SELECT
    e.first_name,
    d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY first_name ASC;

SELECT
    e.first_name,
    (
    SELECT
        department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY first_name ASC;

/*
- ��Į�� ��������(SELECT ����)�� ���κ��� ���� ���
: �Լ�ó�� �� ���ڵ�� ��Ȯ�� �ϳ��� ������ ������ ��.

- ������ ��Į�� ������������ ���� ���
: ��ȸ�� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ�
����, ���� ���� ����� ���(sql �������� ������ �� �� �پ�ϴ�)
*/

-- �� �μ��� �Ŵ��� �̸� ��ȸ ( LEFT ���� )

SELECT
d.*,
e.first_name
FROM departments d LEFT JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

-- �� �μ��� �Ŵ��� �̸� ��ȸ (��Į�� ��������)
SELECT
d.*,
(SELECT
first_name
FROM employees e
WHERE e.employee_id = d.manager_id) AS manager_name
FROM departments d
ORDER BY d.manager_id ASC;

-- �� �μ��� ��� �� �̱�
SELECT
    d.*,
(SELECT 
    count(*)
FROM employees e
WHERE e.department_id = d.department_id
GROUP BY department_id) AS �����
FROM departments d;

--------------------------------------------------------------------------------

-- �ζ��� �� (FROM ������ ���������� ���� ��.)
-- Ư�� ���̺� ��ü�� �ƴ� SELECT�� ���� �Ϻ� �����͸� ��ȸ�� ���� ���� ���̺��
-- ����ϰ� ���� ��.
-- ������ ���س��� ��ȸ �ڷḦ ������ �����ؼ� ������ ���� ���.

SELECT
ROWNUM AS rn,
employee_id,
first_name,
salary
FROM employees
ORDER BY salary DESC;

-- salary�� ������ �����ϸ鼭 �ٷ� ROWNUM�� ���̸�
-- ROWNUM�� ������ ���� �ʴ� ��Ȳ�� �߻��մϴ�.
-- ����: ROWNUM�� ���� �ٰ� ������ ����Ǳ� ����. ORDER BY�� �׻� �������� ����.
-- �ذ�: ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ���� �� ���ƿ�.

-- �ذ���� ����� ������
SELECT
ROWNUM AS rn,tbl.*
FROM (
SELECT
employee_id,first_name,salary
FROM employees
ORDER BY salary DESC
) tbl;


-- rn�� 0���� 10���� ������ ���������
SELECT
ROWNUM AS rn,tbl.*
FROM (
SELECT
employee_id,first_name,salary
FROM employees
ORDER BY salary DESC
) tbl
WHERE rn > 0 AND rn <= 10;

-- �ٵ� ������ �� , �� ������ ���� ? FROM ������ WHERE�� ����Ǳ⶧���� ( sql�� ��������� �̷��� �߿��� )
-- ROWNUM�� ���̰� ���� ������ �����ؼ� ��ȸ�Ϸ��� �ϴµ�,
-- ���� ������ �Ұ����ϰ�, ������ �� ���� ������ �߻��ϴ���.
-- ����: WHERE������ ���� �����ϰ� ���� ROWNUM�� SELECT �Ǳ� ������.
-- �ذ�: ROWNUM���� �ٿ� ���� �ٽ� �� �� �ڷḦ SELECT �ؼ� ������ �����ؾ� �ǰڱ���.

-- �ذ���� �� ������

SELECT *
FROM(
SELECT
ROWNUM AS rn,tbl.*
FROM (
SELECT
employee_id,first_name,salary
FROM employees
ORDER BY salary DESC
) tbl 
)
WHERE rn > 20 AND rn <= 30;

/*
���� ���� SELECT ������ �ʿ��� ���̺� ����(�ζ��� ��)�� ����.
�ٱ��� SELECT ������ ROWNUM�� �ٿ��� �ٽ� ��ȸ
���� �ٱ��� SELECT �������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ.

** SQL�� ���� ����
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/







