SELECT * 
FROM info;

SELECT *
FROM AUTH;

-- �̳�(����) ����
SELECT 
    *
FROM info i INNER JOIN AUTH A
ON i.auth_id = A.auth_id;

-- ����Ŭ ���� ( �� ��� ���ϱ� �� )
SELECT
    *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;



-- auth_id �÷��� �׳� ���� ��ȣ�ϴ� ��� ��ϴ�.
-- �� ������ ���� ���̺� ��� �����ϱ� �����Դϴ�.
-- �̷� ����, �÷��� ���̺� �̸��� ���̴���, ��Ī�� ���ż�
-- Ȯ���ϰ� ������ ���ּ���.

SELECT
    auth.auth_id,title,content,name
FROM info INNER JOIN auth -- INNER JOIN�� ����Ʈ�� INNER ���� join�� �ᵵ ��
on info.auth_id = auth.auth_id;

-- �ʿ��� �����͸� ��ȸ�ϰڴ�! ��� �Ѵٸ�
-- WHERE ������ ���� �Ϲ� ������ �ɾ� �ֽø� �˴ϴ�.

SELECT
    a.auth_id,title,content,name
FROM info i
JOIN auth a
on i.auth_id = a.auth_id
WHERE a.name = '�̼���';

-- �ƿ��� (�ܺ�) ���� /�Ƚ�/
SELECT 
*
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT 
*
FROM info i RIGHT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT
*
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+); // ���� �ƿ���(�ܺ�)������ ����Ŭ ��������

-- ���� ���̺�� ���� ���̺� �����͸� ��� �о� �ߺ��� �����ʹ� �����Ǵ� �ܺ� ���� (FULL JOIN)
SELECT
    *
FROM info i FULL JOIN auth a
ON i.auth_id = a.auth_id;

--CROOS join ��� �÷��� ������ ���� (������ �ȵ�)

SELECT
    *
FROM info i CROSS JOIN auth a
ORDER BY id asc;

SELECT
    *
FROM employees CROSS JOIN departments;

-- ������ ���̺� ���� -> Ű ���� ã�Ƽ� ������ �����ؼ� ���� �˴ϴ�.
SELECT
    *
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN locations loc on d.location_id = loc.location_id;



/*
- ���̺� ��Ī a, i�� �̿��Ͽ� LEFT OUTER JOIN ���.
- info, auth ���̺� ���
- job �÷��� scientist�� ����� id, title, content, job�� ���.
*/

SELECT 
i.id,i.title,i.content,a.job
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.job = 'scientist';

-- ���������̶� ���� ���̺� ������ ������ ���Ѵ�
-- ���� ���̺� �÷��� ���� ������ �����ϴ� ���� ��Ī���� ������ �� ����մϴ�.
SELECT
    e1.employee_id,e1.first_name,e1.manager_id,
    e2.first_name,e2.employee_id
FROM employees e1 JOIN employees e2
on e1.manager_id = e2.employee_id
ORDER BY e1.employee_id ASC;



