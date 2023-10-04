
-- 프로시저(procedure) -> void 메서드 유사
-- 특정한 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 (쿼리)
-- 하지만 프로시저를 통해서 값을 리턴하는 방법도 있습니다.

CREATE procedure GUGUDAN
    (p_dan IN NUMBER)
IS

BEGIN
    dbms_output.put_line(p_dan || '단');
    FOR I in 1..9
    LOOP
        dbms_output.put_line(p_dan || 'x' || i || '=' || p_dan * i);
    END LOOP;
END;

-- 프로시저 실행
EXEC GUGUDAN(5);



-- 매개값(인수) 없는 프로시저
CREATE procedure p_test
IS -- 선언부
    v_msg VARCHAR2(30) := 'hello procedure!';
BEGIN -- 실행부
    dbms_output.put_line(v_msg);
END; -- 종료부

EXEC p_test;



-- IN 입력값을 여러개 전달받는 프로시저
CREATE procedure my_new_job_proc
    (
     p_job_id IN jobs.job_id%TYPE,
     p_job_title IN jobs.job_title%TYPE,
     p_min_sal IN jobs.min_salary%TYPE,
     p_max_sal IN jobs.max_salary%TYPE
    )
IS

BEGIN
    INSERT INTO jobs
    VALUES(p_job_id , p_job_title , p_min_sal , p_max_sal);
    COMMIT;
END;

EXEC my_new_job_proc('JOB2','test job2',20000,30000);

SELECT *
FROM jobs;

----------------------------------------------------------------------------


-- job_id를 확인해서
-- 이미 존재하는 데이터라면 수정 , 없다면 새롭게 추가
-- (job_id가 PRIMARY KEY라서 중복되면 원래 오류나는데 , 이렇게하면 오류나지않고 수정됨 )
CREATE OR REPLACE PROCEDURE my_new_job_proc -- VIEW에 나옴 CREATE OR REPLACE
    -- CREATE OR REPLACE 기존 프로시저 구조를 수정
    (
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE :=0,
    p_max_sal IN jobs.max_salary%TYPE :=1000
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0 -> v_cnt에 저장.
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- 조회결과가 없었다면 INSERT
         INSERT INTO jobs
         VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- 0이 아니다 = 조회결과 있다 UPDATE 한다
        UPDATE jobs
        SET job_title = p_job_title,
        min_salary = p_min_sal,
        max_salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;

EXEC my_new_job_proc('JOB2', 'test job3', 2000, 3000);
SELECT * FROM jobs;

-------------------------------------------------------------------------------

-- OUT,IN OUT 매개변수 사용
-- OUT 변수를 사용하면 프로시저 바깥쪽으로 값을 보냅니다.
-- OUT을 이용해서 보낸 값은 익명 블록에서 실행해야 합니다.

CREATE OR REPLACE PROCEDURE my_new_job_proc
    -- CREATE OR REPLACE 기존 프로시저 구조를 수정
    (
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE :=0,
    p_max_sal IN jobs.max_salary%TYPE :=1000,
    p_result OUT VARCHAR2 := '안녕하세요' -- 바깥쪽에서 출력을 하기 위한 변수
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT 처리 되었습니다';
BEGIN

    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0 -> v_cnt에 저장.
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- 조회결과가 없었다면 INSERT
         INSERT INTO jobs
         VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- 기존에 존재하는 데이터라면 이번엔 조회된 결과를 추출해봄(수정 X) 
        SELECT
            p_job_id || '의 최대 연봉 : ' || max_salary || ', 최소 연봉' || min_salary
        INTO
            p_result -- 조회 결과
        FROM jobs
        WHERE job_id = p_job_id;
    END IF;
    
    dbms_output.put_line('p_result: ' || p_result);
    
    -- OUT 매개변수에 조회 결과를 할당.
    p_result := v_result;
    
    COMMIT;
END;

------------------------------------------------------------------------------
-- msg라는 익명블럭을 만들어줌
DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('JOB2','test_job2',2000,8000,msg);
    dbms_output.put_line(msg);
    
    my_new_job_proc('CEO2','test_CEO2',30000,45000,msg);
    dbms_output.put_line(msg);
END;

--------------------------------------------------------------------------------

-- IN,OUT 동시에 처리
CREATE OR REPLACE procedure my_parameter_test_proc
    (
    -- IN : 반환 불가 . 받는 용도로만 활용
    p_var1 IN VARCHAR2,
    -- OUT : 받는 용도로는 아예 활용 불가능.
    -- OUT이 되는 시점은 프로시저가 끝날 때. 그전까지는 할당이 안됨.
    p_var2 OUT VARCHAR2,
    -- IN OUT : 둘 다 가능함
    p_var3 IN OUT VARCHAR2
    )
    
IS

BEGIN
    dbms_output.put_line('p_var1 : ' || p_var1);
    dbms_output.put_line('p_var2 : ' || p_var2);
    dbms_output.put_line('p_var3 : ' || p_var3);
    
    -- p_var1 := '결과1'; -> IN 변수는 값 할당 자체가 불가능.
    p_var2 := '결과2';
    p_var3 := '결과3';

    dbms_output.put_line('END 전 p_var2 : ' || p_var2);
END;

--

DECLARE
    v_var1 VARCHAR2(10) := 'value1'; -- IN : 값이 출력됨
    v_var2 VARCHAR2(10) := 'value2'; -- OUT : 값이 전달되지 않음
    v_var3 VARCHAR2(10) := 'value3'; -- IN OUT : IN의 성질을 가지고 있구나~
BEGIN
    my_parameter_test_proc(v_var1,v_var2,v_var3);
    
    dbms_output.put_line('v_var1 : ' || v_var1);
    dbms_output.put_line('v_var2 : ' || v_var2);
    dbms_output.put_line('v_var3 : ' || v_var3);
END;

-- v_var2는 안나올거임 , OUT 변수이기 때문에 익명블럭을 따로 만들어서 출력해야함

CREATE OR REPLACE PROCEDURE my_new_job_proc
    -- CREATE OR REPLACE 기존 프로시저 구조를 수정
    (
    p_job_id IN jobs.job_id%TYPE,
    p_result OUT VARCHAR2 := '안녕하세요' -- 바깥쪽에서 출력을 하기 위한 변수
    )
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '존재하지 않는 값이라 INSERT 처리 되었습니다';
BEGIN
    SELECT
        COUNT(*)
    INTO
        v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        dbms_output.put_line(p_job_id || '는 테이블에 존재하지 않습니다.');
        return; -- ! 프로시저 강제 종료 !
    END IF;
   
        SELECT
            p_job_id || '의 최대 연봉 : ' || max_salary || ', 최소 연봉' || min_salary
        INTO
            v_result -- 조회 결과
        FROM jobs
        WHERE job_id = p_job_id;
 
    
 
    
    -- OUT 매개변수에 조회 결과를 할당.
    p_result := v_result;
    
    COMMIT;
END;


DECLARE
    msg VARCHAR2(100);
BEGIN
    my_new_job_proc('Iasd',msg);
    dbms_output.put_line(msg);
END;

------------------------------------------------------------------------------

-- 예외 처리 (java의 try catch와 유사)
DECLARE 
    v_num NUMBER := 0;
BEGIN

    v_num := 10/0; -- 오류남 0으로 나눌수 없음
    
    /*
    OTHERS 자리에 예외의 타입을 작성해 줍니다.
    ACCESS_INTO_NULL -> 객체 초기화가 되어 있지 않은 상태에서 사용.
    NO_DATA_FOUND -> SELECT INTO 시 데이터가 한 건도 없을 때
    ZERO_DIVIDE -> 0으로 나눌 때
    VALUE_ERROR -> 수치 또는 값 오류
    INVALID_NUMBER -> 문자를 숫자로 변환할 때 실패한 경우
    */
    
    EXCEPTION
        WHEN ZERO_DIVIDE THEN
            dbms_output.put_line('0으로 나눌수 없습니다');
            dbms_output.put_line('SQL ERROR CODE : ' || SQLCODE); -- 에러 코드
            dbms_output.put_line('SQL ERROR MSG : ' || SQLERRM); -- 에러 메세지
        WHEN OTHERS THEN -- 보통 마지막에 작성하는 코드로써 설정한 오류들이 아닐때 최종적으로 실행
            dbms_output.put_line('알수 없는 예외 발생');
    
END;