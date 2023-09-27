
-- 테이블 생성과 제약조건
-- : 테이블에 부적절한 데이터가 입력되는 것을 방지하기 위해 규칙을 설정하는 것.

-- 테이블 열레벨 제약조건 (PRIMARY KEY, UNIQUE, NOT NULL, FOREIGN KEY, CHECK)
-- PRIMARY KEY: 테이블의 고유 식별 컬럼입니다. (주요 키)
-- UNIQUE: 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL: null을 허용하지 않음. (필수값이 있어야함)
-- FOREIGN KEY: 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼
-- CHECK: 정의된 형식만 저장되도록 허용.


-- 컬럼 레벨 제약 조건 (컬럼 선언마다 제약조건 지정)
-- CONSTRAINT 이름 -> 제약조건에 이름을 설정해주는것
CREATE TABLE dept2(
    dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
    -- dept2_detpno_pk -> 제약조건의 이름, 알아보기 쉽게 짓는게 좋음 (수정안할거면 생략 가능)
    -- dept_no 컬럼을 PRIMARY KEY로 지정해줌
    dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
    loca NUMBER(4) CONSTRAINT dept2_loca_locid_fk REFERENCES locations(location_id),
    -- detp2의 loca컬럼은 location 테이블의 location_id 컬럼을 참조하는것 , 외래키 설정
    -- JOIN을 하려면 설정해줘야함
    dept_bonus NUMBER(10) CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0),
    dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M','F'))
); 

DROP TABLE dept2;

-- 테이블 레벨 제약 조건 (모든 컬럼을 선언후에 따로 제약 조건을 걸어주는 방식 )
-- 위에는 컬럼 선언할때 같이 제약을 걸었음
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

-- 외래 키(foreing key)가 부모테이블(참조테이블)에 없다면 INSERT 불가능
INSERT INTO dept2
VALUES(10,'gg',4000,100000,'M'); -- 4000은 locations에 없어서 불가능

INSERT INTO dept2
VALUES(10,'gg',3000,100000,'M');  

INSERT INTO dept2
VALUES(10,'hh',1900,100000,'M'); -- 이미 10을 값으로 가지고 있는 PRIMARY KEY가 있어서

INSERT INTO dept2
VALUES(20,'mm',3000,100000,'M');

UPDATE dept2
SET loca = 4000
WHERE dept_no = 10; -- 4000은 locations에 없어서 불가능 ( UPDATE도 당연히 안됨 )



-- 제약조건을 변경하는법
-- 제약조건은 추가,삭제만 가능함 . 변경은 X
-- 변경하려면 결국 , 삭제하고 다시 새로운 내용으로 추가해야함
-- 조건이나 테이블 구조같은건 ALTER , 단순 컬럼의 내용 변경은 UPDATE

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14) NOT NULL,
    loca NUMBER(4),
    dept_bonus NUMBER(10),
    dept_gender VARCHAR2(1)
);

-- PK 추가
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);

-- FK 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_loca_locid_fk
FOREIGN KEY(loca) REFERENCES locations(location_id);

-- CHECK 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_bonus_ck CHECK(dept_bonus > 0);

-- UNIQUE 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptname_uk UNIQUE(dept_name);

-- NOT NULL은 열 수정형태로 변경
ALTER TABLE dept2 MODIFY dept_bonus NUMBER(10) NOT NULL;

-- 제약 조건 확인
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';

-- 제약 조건 삭제 ( 제약 조건 이름으로 삭제하면 됨 )
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk;


--------------------------------------------------------------------------------
-------------------------------------문제---------------------------------------

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
 