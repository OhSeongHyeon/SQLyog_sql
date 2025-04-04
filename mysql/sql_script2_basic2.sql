DROP DATABASE IF EXISTS AM_DB_25_03;
CREATE DATABASE AM_DB_25_03;
USE AM_DB_25_03;

DROP TABLE IF EXISTS article;

CREATE TABLE article (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
,   regDate DATETIME NOT NULL
,   updateDate DATETIME NOT NULL
,   title VARCHAR(255) NOT NULL
,   `body` TEXT NOT NULL
);

SHOW TABLES;
DESC article;
SELECT * FROM article;

INSERT INTO article
SET
    title = "제목"
,   `body` = "내용";

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = CONCAT('제목',SUBSTRING(RAND() * 1000 FROM 1 FOR 2)),
`body` = CONCAT('내용',SUBSTRING(RAND() * 1000 FROM 1 FOR 2));

##################################################################################
##################################################################################

# a5 데이터베이스 삭제/생성/선택
DROP DATABASE IF EXISTS `a5`;
CREATE DATABASE `a5`;
USE `a5`;
# 부서(dept) 테이블 생성 및 홍보부서 기획부서 추가
CREATE TABLE dept (
    id INT UNSIGNED AUTO_INCREMENT
,   `name` VARCHAR(100)
,   regDate DATETIME NOT NULL
,   PRIMARY KEY (id)
);
INSERT INTO dept SET regDate = NOW(), `name` = '홍보';
INSERT INTO dept SET regDate = NOW(), `name` = '기획';
# 사원(emp) 테이블 생성 및 홍길동사원(홍보부서), 홍길순사원(홍보부서), 임꺽정사원(기획부서) 추가
CREATE TABLE emp (
    id INT UNSIGNED AUTO_INCREMENT
,   `name` VARCHAR(255)
,   regDate DATETIME NOT NULL
,   deptId INT UNSIGNED
,   PRIMARY KEY (id)
,   FOREIGN KEY (deptId) REFERENCES `dept`(id)
);
INSERT INTO emp
    (`name`, regDate, deptId)
VALUES
    ('홍길동', NOW(), 1)
,   ('홍길순', NOW(), 1)
,   ('임꺽정', NOW(), 2);
# 홍보를 마케팅으로 변경
UPDATE dept
SET `name` = '마케팅'
WHERE `name` = '홍보';
# 마케팅을 홍보로 변경
#UPDATE dept SET `name` = '홍보' WHERE `name` = '마케팅';
# 홍보를 마케팅으로 변경
#UPDATE dept SET `name` = '마케팅' WHERE `name` = '홍보';
# 구조를 변경하기로 결정(사원 테이블에서, 이제는 부서를 이름이 아닌 번호로 기억)

# 사장님께 드릴 인명록을 생성

# 사장님께서 부서번호가 아니라 부서명을 알고 싶어하신다.
# 그래서 dept 테이블 조회법을 알려드리고 혼이 났다.

# 사장님께 드릴 인명록을 생성(v2, 부서명 포함, ON 없이)
# 이상한 데이터가 생성되어서 혼남

# 사장님께 드릴 인명록을 생성(v3, 부서명 포함, 올바른 조인 룰(ON) 적용)
# 보고용으로 좀 더 편하게 보여지도록 고쳐야 한다고 지적받음

# 사장님께 드릴 인명록을 생성(v4, 사장님께서 보시기에 편한 칼럼명(AS))
SELECT
    a.id '사번'
,   a.name '이름'
,   b.name '부서명'
,   DATE(a.regDate) '입사일'
FROM
    emp a
,   dept b
WHERE
    a.deptId = b.id;































