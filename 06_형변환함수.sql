
-- 형 변환 함수 TO_CHAR , TO_NUMBER , TO_DATE

-- 날짜를 문자로 TO_CHAR(값,형식)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate,'YYYY-MM-DD DY PM HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate,'YY-MM-DD PM HH24:MI:SS') FROM dual;

SELECT
    first_name, TO_CHAR(hire_date,'YYYY"년" MM"월" DD"일" HH:MI:SS')
FROM employees; -- 서식 문자가 아닌 (대표적으로 한글)은 ""안에 넣어서 전달해야함 

-- 숫자를 문자로 TO_CHAR(값,형식)
-- 형식에서 사용하는 '9'는 실제 숫자 9가 아니라 자리수를 표현하기 위한 기호입니다.
SELECT TO_CHAR(20000,'99999') FROM dual;

-- 주어진 자릿수에 숫자를 모두 표기할수 없어서 이럴 경우엔 #으로 표기됨
SELECT TO_CHAR(20000,'9999') FROM dual;
SELECT TO_CHAR(20000.29,'99999.9') FROM dual;

SELECT TO_CHAR(salary,'L99,999') AS salary   -- L을 붙이면 원단위 표시가 됨
FROM employees;

-- 문자를 숫자로 TO_NUMBER(값, 형식)
SELECT '2000' + 2000 FROM dual; -- 자동 형 변환 (문자 -> 숫자)
SELECT TO_NUMBER('2000') + 2000 FROM dual; -- 명시적 형 변환
SELECT '$3,300' + 2000 FROM dual; 
-- 달러표시와 콤마 때문에 자동 형변환 안됨 에러남
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;

-- 문자를 날짜로 변환하는 함수 TO_DATE(값, 형식)
SELECT TO_DATE('2023-04-13') FROM dual;
SELECT sysdate - '2021-03-26' FROM dual; -- 연산안됨 에러남
SELECT sysdate - TO_DATE('2021-03-26') FROM dual;
SELECT TO_DATE('2020/12/25', 'YY-MM-DD') FROM dual;
SELECT TO_DATE('2021-03-31 12:23:50', 'YY-MM-DD') FROM dual; 
--이건 오류남 원래 시간까지 있는 값이라 YY-MM-DD로는 표현이 안됨. 원래 값 전부 표현해야 함
SELECT TO_DATE('2021-03-31 12:23:50', 'YY-MM-DD HH:MI:SS') FROM dual;

--XXXX년 xx월 xx일 문자열 형식으로 변경해보세요
-- 조회 컬럼명은 dateInfo라고 하겠습니다
SELECT TO_CHAR(TO_DATE('20050102'),'YYYY"년" MM"월" DD"일"') AS dateInfo
FROM dual;
-- TO_CHAR 함수는 날짜를 문자로 바꿔주는거지 숫자를 문자로 바꿔주는게 아님
-- 20050102는 날짜처럼보이지만 숫자이기 때문에
-- TO_DATE로 20050102를 날짜로 바꿔줘야함 ( 값은 똑같음 )

-- NULL 형태를 변환하는 함수 NVL(컬럼, 변환할 타겟값)
SELECT NULL FROM dual;
SELECT NVL(NULL,0) FROM dual;

-- NVL의 예시
SELECT
first_name,
NVL(commission_pct,0) -- commission_pct에 있는 NULL값을 전부 0으로 바꿔줌
FROM employees;

-- NULL 변환 함수 NVL2(컬럼,null이 아닐경우의 값 , null일 경우의 값)
SELECT
    NVL2(NULL,'널아님','널임')
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

-- DECOCE(컬럼 혹은 표현식,항목1,결과1,항목2,결과2 .... default)
-- IF문, 특히 Switch case문과 유사함 
SELECT
    DECODE('C','A','A입니다','B','B입니다','C','C입니다','모름')
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

--CASE WHEN THEN END ( DECODE 문과 기능은 유사함 )
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
문제 1.
현재일자를 기준으로 employees테이블의 입사일자(hire_date)를 참조해서 근속년수가 17년 이상인
사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
*/
SELECT 
employee_id AS 사원번호,
CONCAT(first_name,last_name) AS 사원명,
hire_date AS 입사일자,
TRUNC((sysdate - hire_date)/365) AS 근속년수
FROM employees
WHERE (sysdate - hire_date)/365 > 17 -- ORDER BY엔 근속년수로 치환해서 썼는데
                                     -- 왜 WHERE절엔 근속년수를 안쓰고 (sysdate ...) 직접 입력했나?
                                     -- 매우 중요함. SQL문의 핵심개념
                                     -- SQL문의 실행순서가 WHERE문이 SELECT문보다 빠르기 때문에
                                     -- FROM -> WHERE -> SELECT 순
                                     -- SELECT문에서 만들어놨던 근속년수를 가져다가 쓸수없음
                                     -- 자바같은곳에서도 지정을 하고 sysout을 하면 되지만
                                     -- sysout을 먼저쓰고 지정을하면 출력이 안되는것처럼
ORDER BY 근속년수 DESC;



/*
문제 2.
EMPLOYEES 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’, 
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) department_id가 50인 사람들을 대상으로만 조회합니다
*/
SELECT -- CASE 문으로
first_name,manager_id,(CASE manager_id WHEN 100 THEN '사원'
WHEN 120 THEN '주임'
WHEN 121 THEN '대리'
WHEN 122 THEN '과장'
ELSE '임원' END)
AS 직급
FROM employees
WHERE department_id = 50;

SELECT -- DECODE 문으로
first_name,manager_id,DECODE(manager_id,120,'주임',121,'대리',122,'과장','임원') AS 직급
FROM employees
WHERE department_id = 50;

-- DECODE문이 좀 더 간략하지만 세세한 설정은 CASE문이 더 나을듯
