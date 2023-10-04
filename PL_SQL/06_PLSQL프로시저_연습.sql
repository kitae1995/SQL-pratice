/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
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
    dbms_output.put_line('����� ���� : ' || c);
    
END;

EXEC divisor_proc(4);


/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
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
        dbms_output.put_line('�μ��� �����ϴ�');
        RETURN;
        END IF;
        DELETE FROM depts
        WHERE department_id = p_dep_id;
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('�������� ���� ��Ȳ �߻�');
END;

EXEC depts_proc(350,'��ī��','I');

SELECT * FROM depts;

/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/


/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/