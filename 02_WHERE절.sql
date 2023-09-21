
SELECT * FROM employees;

-- WHERE �� �� (������ ���� ��/�ҹ��ڸ� �����մϴ�.)
SELECT first_name,last_name,job_id
FROM employees
WHERE job_id = 'IT_PROG'; -- ���� �����ڰ� �ƴ� , ���Ĵ� �� 

SELECT * FROM employees
where last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 90;

SELECT *
FROM employees
WHERE salary >= 15000
AND salary <= 20000; -- BETWEEN ���� �� ���� �ۼ�����

SELECT * FROM employees
WHERE hire_date = '04/01/30';  -- sql�� int,string�� �ƴ� date ��¥ Ÿ�Ե� ������

-- ������ �� ����
SELECT * FROM employees
WHERE salary BETWEEN 15000 and 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' and '03/12/31';

-- IN �������� ��� ( Ư�� ����� ���� �� ��� ) �������� �˻��ϰ� ������
SELECT * FROM employees
WHERE manager_id IN (100,101,102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP'); -- ���� �ߴ� job_idã���� ���弱

-- LIKE ������
-- %�� ��� ���ڵ�, _�� �������� �ڸ�(��ġ)�� ã�Ƴ� ��

SELECT first_name, last_name
FROM employees
WHERE hire_date Like '03%'; -- 03���� �����ϴ� ��� hiredate�� ã��

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%03'; -- 15�� ������ ��� hiredate�� ã��

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'; -- 05�� �ִ� ��� hiredate�� ã�� (�߾��� �ƴ�)

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___03%'; -- �տ� 3���ڻ��� 03���� ������ ���
                               -- ���� �� ���� 01/03/20 �� ��� ��� 03�� ������ ���
                               
-- IS NULL (null���� ã��)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NULL; -- commisionpct�� ���� �ʴ� �����

SELECT * FROM employees
WHERE commission_pct IS NOT NULL; --commisionpct�� �޴� �����
                               
--AND,OR
--AND�� OR���� ���� ������ ����.
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
and salary >= 6000; -- �̷��� and�� ���� �������ֱ� ������ salary�� 6000�� �̻��� FIMGR �׸���
                    -- ITPROG�� ���� ������ , ���� ���ϴ� ���� ���Ϸ���?
                    
--AND,OR
--AND�� OR���� ���� ������ ����.
SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
and salary >= 6000; -- �ƿ� ��������� �ٲٴ��� �ƴϸ� ���� �����ؾ��� ���� () ó������

-- �������� ���� (SELECT ������ ���� �������� ��ġ�˴ϴ�.)
-- ASC: ascending ��������
-- DESC: descending �������� 

SELECT * FROM employees
ORDER BY hire_date ASC; -- employees ���̺� ��ü�� hire_date ������������ ����
                        -- �ٵ� ��� ORDER BY�� �ٿ��� ���������� ����Ʈ���̱� ��

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC;

SELECT
    first_name,
    salary*12 AS pay
FROM employees
ORDER BY pay ASC; -- �ڱⰡ ���Ƿ� �̸����� ��Ī�÷����ε� ���� ����

