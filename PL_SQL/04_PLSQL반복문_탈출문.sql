
-- WHILE��

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        v_num := v_num + v_count;
        v_count := v_count + 1; -- step
    END LOOP;
         dbms_output.put_line(v_num);
END;



-- Ż�⹮

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        EXIT WHEN v_count = 5;
        
        v_num := v_num + v_count;
        v_count := v_count + 1; -- step
    END LOOP;
         dbms_output.put_line(v_num);
END;

-- FOR��

DECLARE
    v_num NUMBER := 4;
BEGIN
    
    FOR i IN 1..9    -- .�� �ΰ� �ۼ��ؼ� ������ ǥ��
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;
    
END;



-- CONTINUE�� ( �ǳ� �� )

DECLARE
    v_num NUMBER := 3;
BEGIN
    
    FOR i IN 1..9    -- .�� �ΰ� �ۼ��ؼ� ������ ǥ��
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;
    
END;


-- 1. ��� �������� ����ϴ� �͸� ����� ���弼�� ( 2 ~ 9 �� )
-- ¦���ܸ� ����� �ּ��� (2,4,6,8)
-- ����Ŭ ���꿡�� �������� �˾Ƴ��� �����ڰ� ����
DECLARE
    
BEGIN
FOR i in 2..8
LOOP 
    CONTINUE WHEN MOD(i,2) !=0;
    dbms_output.put_line(i || ' �� ');
    FOR j in 1..9
    LOOP
    dbms_output.put_line(i || ' x ' || j || ' = ' || i * j);
    END LOOP;
END LOOP;
END;


-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....
CREATE TABLE board(
bno NUMBER(5) PRIMARY KEY,
writer VARCHAR2(30),
title VARCHAR2(30)
);

CREATE SEQUENCE bno_up2
    START WITH 1 -- ���۰� (�⺻���� �����Ҷ� �ּҰ�, ������ �� �ִ밪��)
    INCREMENT BY 1 -- ������ (����� ����, ������ ����, �⺻�� 1)
    MAXVALUE 1000 -- �ִ밪 (�⺻���� ������ �� 1027 , �����϶��� -1)
    MINVALUE 1 -- �ּҰ� (������ ���� 1, �����϶��� -1027)
    NOCACHE -- ĳ�� �޸� ��� ���� ( CACHE )
    NOCYCLE; -- ��ȯ���� ( NOCYCLE�� �⺻���̱� �� ) , ��ȯ��Ű���� CYCLE �ۼ�
    

DECLARE
    v_num NUMBER := 1;
BEGIN
    WHILE v_num <= 300
    LOOP
        INSERT INTO board
        VALUES(bno_up2.NEXTVAL, 'test'||v_num , 'title'||v_num);
        v_num := v_num + 1;
    END LOOP;
    COMMIT;
END;

SELECT *
FROM board;