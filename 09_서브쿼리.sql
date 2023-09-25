
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

