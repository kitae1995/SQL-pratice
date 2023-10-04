/*
프로시저명 divisor_proc
숫자 하나를 전달받아 해당 값의 약수의 개수를 출력하는 프로시저를 선언합니다.
*/

CREATE OR REPLACE procedure divisor_proc
    (p_number IN NUMBER)
IS
    c NUMBER := 0;
BEGIN
    FOR i IN 1..p_number
    LOOP
    IF MOD(p_number,i) = 0 THEN
    c := c + 1;
    END IF;
    END LOOP;
    dbms_output.put_line('약수의 개수 : ' || c);
    
END;

EXEC divisor_proc(4);


/*
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
CREATE OR REPLACE procedure depts_proc
    (
     p_dep_id IN depts.department_id%type,
     p_dep_name IN depts.department_name%type,
     flag IN VARCHAR2
    )
IS
    p_count NUMBER := 0;
BEGIN
    SELECT
    count(*)
    INTO
    p_count
    FROM depts
    WHERE department_id = p_dep_id;
    
    IF flag = 'I' THEN
        INSERT INTO depts(department_id,department_name)
        VALUES(p_dep_id,p_dep_name);
    ELSIF flag = 'U' THEN
        UPDATE depts
        SET department_name = p_dep_name
        WHERE department_id = p_dep_id;
    ELSIF flag = 'D' THEN
        IF p_count = 0 THEN
        dbms_output.put_line('부서가 없습니다');
        RETURN;
        END IF;
        DELETE FROM depts
        WHERE department_id = p_dep_id;
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('상정하지 않은 상황 발생');
END;

EXEC depts_proc(350,'피카부','I');

SELECT * FROM depts;

/*
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/


/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
프로시저가 전달받아야 할 값: 사번, last_name, email, hire_date, job_id
*/