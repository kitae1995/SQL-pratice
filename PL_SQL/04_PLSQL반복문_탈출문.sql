
-- WHILE문

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



-- 탈출문

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

-- FOR문

DECLARE
    v_num NUMBER := 4;
BEGIN
    
    FOR i IN 1..9    -- .을 두개 작성해서 범위를 표현
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;
    
END;



-- CONTINUE문 ( 건너 뜀 )

DECLARE
    v_num NUMBER := 3;
BEGIN
    
    FOR i IN 1..9    -- .을 두개 작성해서 범위를 표현
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || ' x ' || i || ' = ' || v_num * i);
    END LOOP;
    
END;


-- 1. 모든 구구단을 출력하는 익명 블록을 만드세요 ( 2 ~ 9 단 )
-- 짝수단만 출력해 주세요 (2,4,6,8)
-- 오라클 연산에는 나머지를 알아내는 연산자가 없음
DECLARE
    
BEGIN
FOR i in 2..8
LOOP 
    CONTINUE WHEN MOD(i,2) !=0;
    dbms_output.put_line(i || ' 단 ');
    FOR j in 1..9
    LOOP
    dbms_output.put_line(i || ' x ' || j || ' = ' || i * j);
    END LOOP;
END LOOP;
END;


-- 2. INSERT를 300번 실행하는 익명 블록을 처리하세요.
-- board라는 이름의 테이블을 만드세요. (bno, writer, title 컬럼이 존재합니다.)
-- bno는 SEQUENCE로 올려 주시고, writer와 title에 번호를 붙여서 INSERT 진행해 주세요.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....
CREATE TABLE board(
bno NUMBER(5) PRIMARY KEY,
writer VARCHAR2(30),
title VARCHAR2(30)
);

CREATE SEQUENCE bno_up2
    START WITH 1 -- 시작값 (기본값은 증가할때 최소값, 감소할 때 최대값임)
    INCREMENT BY 1 -- 증가값 (양수면 증가, 음수면 감소, 기본값 1)
    MAXVALUE 1000 -- 최대값 (기본값은 증가일 때 1027 , 감소일때는 -1)
    MINVALUE 1 -- 최소값 (증가일 때는 1, 감소일때는 -1027)
    NOCACHE -- 캐시 메모리 사용 여부 ( CACHE )
    NOCYCLE; -- 순환여부 ( NOCYCLE이 기본값이긴 함 ) , 순환시키려면 CYCLE 작성
    

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