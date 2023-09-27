
-- ���̺� ������ ��������
-- : ���̺� �������� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���� ��Ģ�� �����ϴ� ��.

-- ���̺� ������ �������� (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: ���̺��� ���� �ĺ� �÷��Դϴ�. (�ֿ� Ű)
-- UNIQUE: ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL: null�� ������� ����. (�ʼ����� �־����)
-- FOREIGN KEY: �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�
-- CHECK: ���ǵ� ���ĸ� ����ǵ��� ���.


-- �÷� ���� ���� ���� (�÷� ���𸶴� �������� ����)
-- CONSTRAINT �̸� -> �������ǿ� �̸��� �������ִ°�
CREATE TABLE dept2(
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    -- dept2_detpno_pk -> ���������� �̸�, �˾ƺ��� ���� ���°� ���� (�������ҰŸ� ���� ����)
    -- dept_no �÷��� PRIMARY KEY�� ��������
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    -- detp2�� loca�÷��� location ���̺��� location_id �÷��� �����ϴ°� , �ܷ�Ű ����
    -- JOIN�� �Ϸ��� �����������
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M','F'))
); 

DROP TABLE dept2;

-- ���̺� ���� ���� ���� (��� �÷��� �����Ŀ� ���� ���� ������ �ɾ��ִ� ��� )
-- ������ �÷� �����Ҷ� ���� ������ �ɾ���
CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) CONSTRAINT dept_name_notnull NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1),
    
    CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
    CONSTRAINT dept2_deptname_uk UNIQUE(dept_name),
    CONSTRAINT dept2_loca_locid_fk FOREIGN KEY(loca) REFERENCES locations(location_id),
    CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

-- �ܷ� Ű(foreing key)�� �θ����̺�(�������̺�)�� ���ٸ� INSERT �Ұ���
INSERT INTO dept2
VALUES(10,'gg',4000,100000,'M'); -- 4000�� locations�� ��� �Ұ���

INSERT INTO dept2
VALUES(10,'gg',3000,100000,'M');  

INSERT INTO dept2
VALUES(10,'hh',1900,100000,'M'); -- �̹� 10�� ������ ������ �ִ� PRIMARY KEY�� �־

INSERT INTO dept2
VALUES(20,'mm',3000,100000,'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; -- 4000�� locations�� ��� �Ұ��� ( UPDATE�� �翬�� �ȵ� )



-- ���������� �����ϴ¹�
-- ���������� �߰�,������ ������ . ������ X
-- �����Ϸ��� �ᱹ , �����ϰ� �ٽ� ���ο� �������� �߰��ؾ���
-- �����̳� ���̺� ���������� ALTER , �ܼ� �÷��� ���� ������ UPDATE

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- PK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);

-- FK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

-- CHECK �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0);

-- UNIQUE �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

-- NOT NULL�� �� �������·� ����
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- ���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

-- ���� ���� ���� ( ���� ���� �̸����� �����ϸ� �� )
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;


--------------------------------------------------------------------------------
-------------------------------------����---------------------------------------

CREATE TABLE members (
 M_NAME VARCHAR2(10) NOT NULL,
 M_NUM NUMBER(2) CONSTRAINT mem_memnum_pk PRIMARY KEY,
 REG_DATE DATE NOT NULL CONSTRAINT mem_regdate_uk UNIQUE, 
 GENDER VARCHAR2(1) CONSTRAINT mem_gender_ck CHECK(GENDER IN('M','F')),
 LOCA NUMBER(6) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id));
 
 INSERT INTO members
 VALUES('DDD',4,sysdate,'M',2000);
 
 SELECT * FROM members;
 
 SELECT
 m.m_name,
 m.m_num,
 loc.street_address,
 loc.location_id
 FROM members m INNER JOIN locations loc
 ON m.loca = loc.location_id
 ORDER BY m_num ASC;
 
 COMMIT;
 