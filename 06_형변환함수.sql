
-- �� ��ȯ �Լ� TO_CHAR , TO_NUMBER , TO_DATE

-- ��¥�� ���ڷ� TO_CHAR(��,����)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate,'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate,'YY-MM-DD PM HH24:MI:SS') FROM dual;

SELECT
    first_name, TO_CHAR(hire_date,'YYYY"��" MM"��" DD"��" HH:MI:SS')
FROM employees; -- ���� ���ڰ� �ƴ� (��ǥ������ �ѱ�)�� ""�ȿ� �־ �����ؾ��� 

-- ���ڸ� ���ڷ� TO_CHAR(��,����)
-- ���Ŀ��� ����ϴ� '9'�� ���� ���� 9�� �ƴ϶� �ڸ����� ǥ���ϱ� ���� ��ȣ�Դϴ�.
SELECT TO_CHAR(20000,'99999') FROM dual;

-- �־��� �ڸ����� ���ڸ� ��� ǥ���Ҽ� ��� �̷� ��쿣 #���� ǥ���
SELECT TO_CHAR(20000,'9999') FROM dual;
SELECT TO_CHAR(20000.29,'99999.9') FROM dual;

SELECT TO_CHAR(salary,'L99,999') AS salary   -- L�� ���̸� ������ ǥ�ð� ��
FROM employees;

-- ���ڸ� ���ڷ� TO_NUMBER(��, ����)
SELECT '2000' + 2000 FROM dual; -- �ڵ� �� ��ȯ (���� -> ����)
SELECT TO_NUMBER('2000') + 2000 FROM dual; -- ����� �� ��ȯ
SELECT '$3,300' + 2000 FROM dual; 
-- �޷�ǥ�ÿ� �޸� ������ �ڵ� ����ȯ �ȵ� ������
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;

-- ���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��, ����)
SELECT TO_DATE('2023-04-13') FROM dual;
SELECT sysdate - '2021-03-26' FROM dual; -- ����ȵ� ������
SELECT sysdate - TO_DATE('2021-03-26') FROM dual;
SELECT TO_DATE('2020/12/25', 'YY-MM-DD') FROM dual;
SELECT TO_DATE('2021-03-31 12:23:50', 'YY-MM-DD') FROM dual; 
--�̰� ������ ���� �ð����� �ִ� ���̶� YY-MM-DD�δ� ǥ���� �ȵ�. ���� �� ���� ǥ���ؾ� ��
SELECT TO_DATE('2021-03-31 12:23:50', 'YY-MM-DD HH:MI:SS') FROM dual;

--XXXX�� xx�� xx�� ���ڿ� �������� �����غ�����
-- ��ȸ �÷����� dateInfo��� �ϰڽ��ϴ�
SELECT TO_CHAR(TO_DATE('20050102'),'YYYY"��" MM"��" DD"��"') AS dateInfo
FROM dual;
-- TO_CHAR �Լ��� ��¥�� ���ڷ� �ٲ��ִ°��� ���ڸ� ���ڷ� �ٲ��ִ°� �ƴ�
-- 20050102�� ��¥ó���������� �����̱� ������
-- TO_DATE�� 20050102�� ��¥�� �ٲ������ ( ���� �Ȱ��� )

-- NULL ���¸� ��ȯ�ϴ� �Լ� NVL(�÷�, ��ȯ�� Ÿ�ٰ�)
SELECT NULL FROM dual;
SELECT NVL(NULL,0) FROM dual;

-- NVL�� ����
SELECT
first_name,
NVL(commission_pct,0) -- commission_pct�� �ִ� NULL���� ���� 0���� �ٲ���
FROM employees;

-- NULL ��ȯ �Լ� NVL2(�÷�,null�� �ƴҰ���� �� , null�� ����� ��)
SELECT
    NVL2(NULL,'�ξƴ�','����')
FROM dual;

SELECT
    first_name,
    NVL2(commission_pct,'true','false') AS commission
FROM employees;

SELECT
    first_name,
    salary,
    commission_pct,
    NVL2(commission_pct,salary+(salary*commission_pct),salary) AS realSalary
FROM employees;

-- DECOCE(�÷� Ȥ�� ǥ����,�׸�1,���1,�׸�2,���2 .... default)
-- IF��, Ư�� Switch case���� ������ 
SELECT
    DECODE('C','A','A�Դϴ�','B','B�Դϴ�','C','C�Դϴ�','��')
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(job_id,
    'IT_PROG',salary*1.1,
    'FI_MGR',salary*1.2,
    'AD_VP',salary*1.3,
    salary)
    AS result
FROM employees;

--CASE WHEN THEN END ( DECODE ���� ����� ������ )
SELECT
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        WHEN 'FI_ACCOUNT' THEN salary*1.4
        ELSE salary
        END
    )AS realSalary
FROM employees;

/*
���� 1.
�������ڸ� �������� employees���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
*/
SELECT 
employee_id AS �����ȣ,
CONCAT(first_name,last_name) AS �����,
hire_date AS �Ի�����,
TRUNC((sysdate - hire_date)/365) AS �ټӳ��
FROM employees
WHERE (sysdate - hire_date)/365 > 17 -- ORDER BY�� �ټӳ���� ġȯ�ؼ� ��µ�
                                     -- �� WHERE���� �ټӳ���� �Ⱦ��� (sysdate ...) ���� �Է��߳�?
                                     -- �ſ� �߿���. SQL���� �ٽɰ���
                                     -- SQL���� ��������� WHERE���� SELECT������ ������ ������
                                     -- FROM -> WHERE -> SELECT ��
                                     -- SELECT������ �������� �ټӳ���� �����ٰ� ��������
                                     -- �ڹٰ����������� ������ �ϰ� sysout�� �ϸ� ������
                                     -- sysout�� �������� �������ϸ� ����� �ȵǴ°�ó��
ORDER BY �ټӳ�� DESC;



/*
���� 2.
EMPLOYEES ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/
SELECT -- CASE ������
first_name,manager_id,(CASE manager_id WHEN 100 THEN '���'
WHEN 120 THEN '����'
WHEN 121 THEN '�븮'
WHEN 122 THEN '����'
ELSE '�ӿ�' END)
AS ����
FROM employees
WHERE department_id = 50;

SELECT -- DECODE ������
first_name,manager_id,DECODE(manager_id,120,'����',121,'�븮',122,'����','�ӿ�') AS ����
FROM employees
WHERE department_id = 50;

-- DECODE���� �� �� ���������� ������ ������ CASE���� �� ������
