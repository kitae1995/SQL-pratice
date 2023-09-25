SELECT * 
FROM info;

SELECT *
FROM AUTH;

-- 이너(내부) 조인
SELECT 
    *
FROM info i INNER JOIN AUTH A
ON i.auth_id = A.auth_id;

-- 오라클 문법 ( 잘 사용 안하긴 함 )
SELECT
    *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;



-- auth_id 컬럼을 그냥 쓰면 모호하다 라고 뜹니다.
-- 그 이유는 양쪽 테이블에 모두 존재하기 때문입니다.
-- 이럴 때는, 컬럼에 테이블 이름을 붙이던지, 별칭을 쓰셔서
-- 확실하게 지목을 해주세요.

SELECT
    auth.auth_id,title,content,name
FROM info INNER JOIN auth -- INNER JOIN은 디폴트라 INNER 빼고 join만 써도 됨
on info.auth_id = auth.auth_id;

-- 필요한 데이터만 조회하겠다! 라고 한다면
-- WHERE 구문을 통해 일반 조건을 걸어 주시면 됩니다.

SELECT
    a.auth_id,title,content,name
FROM info i
JOIN auth a
on i.auth_id = a.auth_id
WHERE a.name = '이순신';

-- 아우터 (외부) 조인 /안시/
SELECT 
*
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT 
*
FROM info i RIGHT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT
*
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+); // 위에 아우터(외부)조인을 오라클 문법으로

-- 좌측 테이블과 우측 테이블 데이터를 모두 읽어 중복된 데이터는 삭제되는 외부 조인 (FULL JOIN)
SELECT
    *
FROM info i FULL JOIN auth a
ON i.auth_id = a.auth_id;

--CROOS join 모든 컬럼에 조인을 진행 (조건이 안들어감)

SELECT
    *
FROM info i CROSS JOIN auth a
ORDER BY id asc;

SELECT
    *
FROM employees CROSS JOIN departments;

-- 여러개 테이블 조인 -> 키 값을 찾아서 구문을 연결해서 쓰면 됩니다.
SELECT
    *
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN locations loc on d.location_id = loc.location_id;



/*
- 테이블 별칭 a, i를 이용하여 LEFT OUTER JOIN 사용.
- info, auth 테이블 사용
- job 컬럼이 scientist인 사람의 id, title, content, job을 출력.
*/

SELECT 
i.id,i.title,i.content,a.job
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.job = 'scientist';

-- 셀프조인이란 동일 테이블 사이의 조인을 말한다
-- 동일 테이블 컬럼을 통해 기존에 존재하는 값을 매칭시켜 가져올 때 사용합니다.
SELECT
    e1.employee_id,e1.first_name,e1.manager_id,
    e2.first_name,e2.employee_id
FROM employees e1 JOIN employees e2
on e1.manager_id = e2.employee_id
ORDER BY e1.employee_id ASC;



