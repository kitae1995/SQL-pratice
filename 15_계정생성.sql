
-- ����� ���� Ȯ��
SELECT * FROM all_users;

-- ���� ���� ��� (hr-pratice�� �ƴ� �ٸ� ����(system)���� �α��� �ؾ��� �̸� : �ƹ��ų� , system/oracle )
CREATE USER user1 IDENTIFIED BY user1; -- USER : ���̵� IDENTIFIED : ��й�ȣ

/*
DCL: GRANT(���� �ο�), REVOKE(���� ȸ��)

CREATE USER -> �����ͺ��̽� ���� ���� ����
CREATE SESSION -> �����ͺ��̽� ���� ����
CREATE TABLE -> ���̺� ���� ����
CREATE VIEW -> �� ���� ����
CREATE SEQUENCE -> ������ ���� ����
ALTER ANY TABLE -> ��� ���̺� ������ �� �ִ� ����
INSERT ANY TABLE -> ��� ���̺��� �����͸� �����ϴ� ����.
SELECT ANY TABLE...

SELECT ON [���̺� �̸�] TO [���� �̸�] -> Ư�� ���̺� ��ȸ�� �� �ִ� ����.
INSERT ON....
UPDATE ON....

- �����ڿ� ���ϴ� ������ �ο��ϴ� ����.
RESOURCE, CONNECT, DBA TO [���� �̸�]
*/

GRANT CREATE SESSION TO user1;

SELECT * FROM hr.departments;

GRANT SELECT ON hr.departments TO user1; -- user1�̶�� ������ hr������ departments ���̺���
                                        -- ��ȸ�Ҽ��ְ� ������ �ִ°�
                                        
GRANT SELECT ANY TABLE TO user1; -- user1�̶�� ������ ��� ���̺��� ��ȸ�Ҽ��ִ� ������ �ִ°�
                                 -- ���� ���̺� �տ� hr.�� �ٿ����� 
                                        
GRANT INSERT ON hr.departments TO user1; -- ���� �����ϰ� INSERT(����)������ �ִ°�
                                         -- ���� �������� ���̺��̸� ���� ���ص� �̹� ����

GRANT CREATE TABLE TO user1; -- user1���� ���̺��� ������ִ� ���� �ο�

ALTER USER user1 -- user1�� ���̺��� �����
DEFAULT TABLESPACE users -- TABLESPAE�� �⺻���� ����ǰ� ����
QUOTA UNLIMITED ON users; -- �뷮�� ������

GRANT RESOURCE, CONNECT , DBA TO user1; -- user1���� �����ڱ��� ������ �ټ�����

REVOKE RESOURCE , CONNECT , DBA FROM user1; -- user1���� ���� �м��� 

--------------------------------------------------------------------
-- ����� ���� ����
-- DROP USER [�����̸�] CASCADE;
-- CASCADE ���� �� -> ���̺� or ������ �� ��ü�� �����Ѵٸ� ���� ���� �ȵ�.
DROP USER user1 CASCADE; -- user1 ����


/*
���̺� �����̽��� �����ͺ��̽� ��ü �� ���� �����Ͱ� ����Ǵ� �����Դϴ�.
���̺� �����̽��� �����ϸ� ������ ��ο� ���� ���Ϸ� ������ �뷮��ŭ��
������ ������ �ǰ�, �����Ͱ� ���������� ����˴ϴ�.
�翬�� ���̺� �����̽��� �뷮�� �ʰ��Ѵٸ� ���α׷��� ������������ �����մϴ�.
*/

SELECT * FROM dba_tablespaces; -- �⺻������ �����ϴ� ���̺����̽� ���

CREATE USER test1 IDENTIFIED BY test1;

GRANT CREATE SESSION TO test1;

GRANT CONNECT , RESOURCE TO test1;


-- user_tablespace ���̺� �����̽��� �⺻ ��� �������� �����ϰ� ��뷮 ����
ALTER USER test1 DEFAULT TABLESPACE user_tablespace
QUOTA UNLIMITED ON user_tablespace;

-- ���̺� �����̽� ���� ��ü�� ��ü ����
DROP TABLESPACE user_tablespace INCLUDING CONTENTS;

-- ������ ���ϱ��� �ѹ��� �����ϴ� ��
DROP TABLESPACE user_tablespace INCLUDING CONTENTS AND DATAFILES;

