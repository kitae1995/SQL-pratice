
/*
# 조인이란?
- 서로 다른 테이블간에 설정된 관계가 결합하여
 1개 이상의 테이블에서 데이터를 조회하기 위해서 사용합니다.
- SELECT 컬럼리스트 FROM 조인대상이 되는 테이블 (1개 이상)
  WHERE 조인 조건 (오라클 조인 문법)
*/

-- employees 테이블에 부서 id와 일치하는 departments 테이블의 부서 id를
-- 찾아서 SELECT 이하에 있는 컬럼들을 출력하는 쿼리문.
SELECT 
 e.first_name,
 d.department_name  

FROM employees e, departments d --테이블 이름 테이블은 AS없이 그냥 뒤에 바로 별칭 붙일수있음
WHERE e.department_id = d.department_id; 



-- 안시 조인 ( INNER JOIN(연결할 테이블) , ON(그 테이블의 조건)
SELECT
    e.first_name,e.last_name,e.hire_date,
    e.salary,e.job_id,d.department_name
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id;

/*
각각의 테이블에 독립적으로 존재하는 컬럼의 경우에는
테이블 이름을 생략해도 무방합니다. 그러나, 해석의 명확성을 위해
테이블 이름을 작성하셔서 소속을 표현해 주는 것이 바람직합니다.
테이블 이름이 너무 길 시에는 ALIAS를 작성하여 칭합니다.
두 테이블 모두 가지고 있는 컬럼의 경우 반드시 명시해 주셔야 합니다.
*/

-- 3개의 테이블을 이용한 내부 조인(INNER JOIN)
-- 내부 조인이란 ? 조인 조건이 일치하는 행만 반환하는 조인.
-- (조인 조건과 일치하지 않는 데이터는 조회 대상에서 제외)

SELECT
    e.first_name,e.last_name,e.department_id,e.job_id,
    d.department_name,
    j.job_title
FROM employees e , departments d , jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id;

---------

SELECT 
    e.first_name,e.last_name,e.department_id,
    d.department_name,e.job_id,j.job_title,loc.city
FROM employees e , departments d , jobs j , locations loc
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id -- 순서 3,4
AND d.location_id = loc.location_id -- 순서 2
AND loc.state_province = 'California'; --순서 1 , (일반조건인데 오라클문법이면 구별이 잘안됨 )

/* 
1. loc 테이블의 state_province = 'California' 조건에 맞는 값을 대상으로
2. location_id값과 같은 값을 가진 데이터를 d.location_id에서 찾아서 조인
3. 위의 조인한 결과와 동일한 department_id를 가진 employees 테이블의 데이터를 찾아서 조인
4. 위에 결과와 jobs 테이블을 비교하여 조인하고 최종 결과를 출력.
*/

------ 외부 조인 ---------
/*
    상호 테이블 간에 일치하는 값으로 연결되는 내부 조인과는 다르게
    어느 한 테이블에 공통 값이 없더라도 해당 row들이 조회 결과에
    모두 포함되는 조인을 말합니다.
*/


SELECT 
 e.first_name,
 d.department_name,
 loc.location_id
FROM employees e, departments d, locations loc
WHERE e.department_id = d.department_id(+)
AND d.location_id = loc.location_id;

/*
employees 테이블에는 존재하고, departments 테이블에는 존재하지 않아도
(+)가 붙지않은 테이블을 기준으로 하여 departments 테이블이 조인에
참여하라는 의미를 부여하기 위해 기호를 붙입니다.
쉽게 얘기하면 앞에 있는 e.department는 전부다 보여주고
(+)가 붙었으니까 id가 없어도 그냥 null로라도 전부 출력하라는 말임
원래 일반적인 내부조인은 kimberely는 department_id가 없어서 출력이 안됨

%% 외부조인을 사용했더라도 , 뒤에 내부조인을 사용한다면
내부조인을 우선적으로 인식함(외부조인 무시됨).
*/

SELECT
    e.employee_id, e.first_name,
    e.department_id,
    j.start_date, j.end_date , j.job_id
FROM employees e, job_history j
WHERE e.employee_id = j.employee_id(+)
AND j.department_id = 80; -- 이렇게하면 80인 데이터를 2개를 가져오는데
                          -- 그건 내부조인이고 분명 외부조인을 걸었는데 2개밖에 안가져오는게 말이안됨
                          -- 외부조인이면 일단 80이면 전부 가져와야하는데 왜 2개인가?
                          -- 이런 경우에는 조건에도 (+)를 걸어서 외부조인으로 만들어줘야함
                          -- j.department_id(+) = 80; <- 이렇게 써줘야함
                          
                          
--조인 종류 , left join , right join , full join , CROSS join ,Self join

--Cross join - 조인 대상이 되는 테이블 한 행마다 모든 데이터가 조회됨 ( 다중 for문마냥)
--A 라는 테이블 6행 , B라는 테이블 5행이면 6*5 = 30행이 나옴
-- 카티션 프로덕트라고 보편적으로 많이 말함 ( 잘 안쓰는 조인임 ) 

-- 좌측 테이블과 우측 테이블 데이터를 모두 읽어 중복된 데이터는 삭제되는 외부 조인 (FULL JOIN)

--Self join
-- 테이블 자기 자신에서 조인을 거는것 manager id가 employee아이디와 동일한것을 가져와라 등
-- 한 테이블 내에서 두가지 이상의 정보를 가져오고 싶을때
--SELECT * FROM employees e1 Inner Join employees2 e2 ON e1.manager_id = e2.employee_id