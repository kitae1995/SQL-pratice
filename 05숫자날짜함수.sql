
-- 숫자함수
-- ROUND(반올림)
-- 원하는 반올림 위치를 매개값으로 지정, 음수를 주는 것도 가능

SELECT
    ROUND(3.1415,3),ROUND(45.923,0),ROUND(45.923,-1)
FROM dual;

-- TRUNC(절사)
-- 정해진 소수점 자리수까지 잘라냅니다.

SELECT
    TRUNC(3.1415,3),TRUNC(45.923,0),TRUNC(45.923,-1)
FROM dual;

-- ABS(절대값)
SELECT 
    ABS(-34)
FROM dual;

-- CEIL(올림) , FLOOR(내림)

SELECT
    CEIL(3.14), FLOOR(3.14)
FROM dual;

-- MOD(나머지 값)
SELECT
10/4,MOD(10,4)
FROM dual;

-- 날짜 함수
-- sysdate: 날짜를 알려줌
-- systimestamp : 날짜+시간까지 알려줌
SELECT
sysdate,systimestamp
FROM dual;

-- 날짜도 연산이 가능합니다.
SELECT
sysdate + 1
FROM dual;


--날짜와 날짜는 뺼셈 연산을 지원해줌
--단순 숫자를 더하는것은 되지만 날짜와 날짜 연산은 뺼셈만 가능함
SELECT
first_name,sysdate - hire_date
FROM employees; -- 일

SELECT first_name , hire_date,(sysdate - hire_date)/7 AS week
FROM employees; -- 주 

SELECT first_name , hire_date,(sysdate - hire_date)/365 AS year
FROM employees; -- 년수

-- 날짜 반올림, 절사
SELECT
ROUND(sysdate) -- 정오 기준으로 됨
FROM dual;


SELECT
ROUND(sysdate,'day') -- 일 기준으로 반올림해줌 (한 주를 기준으로 반이 넘어갔으면 다음주)
FROM dual;

SELECT
ROUND(sysdate,'month') -- 월 기준으로 반올림해줌
FROM dual;

SELECT
ROUND(sysdate,'year') -- 연 기준으로 반올림해줌
FROM dual;

-- 절사
SELECT
TRUNC(sysdate,'day') -- 일 기준으로 반올림해줌 (한 주를 기준으로 반이 넘어갔으면 다음주)
FROM dual;

SELECT
TRUNC(sysdate,'month') -- 월 기준으로 반올림해줌
FROM dual;

SELECT
TRUNC(sysdate,'year') -- 연 기준으로 반올림해줌
FROM dual;