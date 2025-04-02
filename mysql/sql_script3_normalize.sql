DROP DATABASE IS EXISTS mall;
CREATE DATABASE mall;
USE mall;

#정규화 안된 테이블
CREATE TABLE t_shopping(
id INT(5) PRIMARY KEY AUTO_INCREMENT,
userId CHAR(30) NOT NULL,
userPw CHAR(30) NOT NULL,
userName CHAR(30) NOT NULL,
address CHAR(50) NOT NULL,
pname CHAR(50) NOT NULL,
price INT(5) NOT NULL
);

INSERT INTO t_shopping 
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping 
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
address = '서울',
pname = '코트',
price = 100000;

INSERT INTO t_shopping 
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
address = '대전',
pname = '반바지',
price = 30000;

INSERT INTO t_shopping 
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '대구',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping 
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '코트',
price = 100000;

INSERT INTO t_shopping 
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '티셔츠',
price = 9000;

INSERT INTO t_shopping 
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
address = '울산',
pname = '운동화',
price = 200000;

INSERT INTO t_shopping 
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '코트',
price = 100000;

INSERT INTO t_shopping 
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
address = '울산',
pname = '스커트',
price = 15000;

INSERT INTO t_shopping 
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
address = '런던',
pname = '운동화',
price = 1000000;

INSERT INTO t_shopping 
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
address = '부산',
pname = '모자',
price = 30000;

#정규화 테이블
CREATE TABLE t_order(
id INT(5) PRIMARY KEY AUTO_INCREMENT,
userNo INT(5) NOT NULL,
productNo INT(5) NOT NULL
);

#정규화 테이블
CREATE TABLE t_user(
id INT(5) PRIMARY KEY AUTO_INCREMENT,
userId CHAR(200) NOT NULL,
userPw CHAR(200) NOT NULL,
userName CHAR(50) NOT NULL,
addr CHAR(200) NOT NULL
);

#정규화 테이블
CREATE TABLE t_product(
id INT(5) PRIMARY KEY AUTO_INCREMENT,
pname CHAR(100) NOT NULL,
price INT(10) NOT NULL
);

INSERT INTO t_product
SET pname = '운동화',
price = 1000000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '반바지',
price = 30000;

INSERT INTO t_product
SET pname = '스커트',
price = 15000;

INSERT INTO t_product
SET pname = '코트',
price = 100000;

INSERT INTO t_product
SET pname = '티셔츠',
price = 9000;

INSERT INTO t_product
SET pname = '운동화',
price = 200000;

INSERT INTO t_product
SET pname = '모자',
price = 30000;


INSERT INTO t_user
SET userId = 'user1',
userPw = 'pass1',
userName = '손흥민',
addr = '런던';

INSERT INTO t_user
SET userId = 'user2',
userPw = 'pass2',
userName = '설현',
addr = '서울';

INSERT INTO t_user
SET userId = 'user3',
userPw = 'pass3',
userName = '원빈',
addr = '대전';

INSERT INTO t_user
SET userId = 'user4',
userPw = 'pass4',
userName = '송혜교',
addr = '대구';

INSERT INTO t_user
SET userId = 'user5',
userPw = 'pass5',
userName = '소지섭',
addr = '부산';

INSERT INTO t_user
SET userId = 'user6',
userPw = 'pass6',
userName = '김지원',
addr = '울산';


INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 2,
productNo = 2;

INSERT INTO t_order
SET userNo = 3,
productNo = 3;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 5,
productNo = 5;

INSERT INTO t_order
SET userNo = 6,
productNo = 6;

INSERT INTO t_order
SET userNo = 6,
productNo = 7;

INSERT INTO t_order
SET userNo = 1,
productNo = 5;

INSERT INTO t_order
SET userNo = 4,
productNo = 4;

INSERT INTO t_order
SET userNo = 1,
productNo = 1;

INSERT INTO t_order
SET userNo = 5,
productNo = 8;

SHOW TABLES;
SELECT * FROM t_shopping;
SELECT * FROM t_order;
SELECT * FROM t_product;
SELECT * FROM t_user;

# 1. 손흥민의 주문 개수는? ???
#1.비정규 테이블 t_shopping
SELECT userName, COUNT(*) FROM t_shopping WHERE userName = '손흥민' GROUP BY userName = '손흥민';
#1.정규화 테이블
SELECT
    userName
,   COUNT(*) 'orderCount'
FROM
    t_order o
,   t_user u
WHERE
    o.userNo = u.id
AND userName = '손흥민';

SELECT
    u.userName
,   COUNT(o.userNo) AS 'orderCount'
FROM t_order AS o
INNER JOIN t_user AS u
ON o.userNo = u.id
WHERE u.userName = '손흥민';
# 2. 손흥민이 산 상품은? ???
#2.비정규 테이블 t_shopping
SELECT * FROM t_shopping WHERE userName = '손흥민';
#2.정규화 테이블
SELECT
    pname
,   price
,   userId
,   userName
FROM
    t_product p
,   (
        SELECT
            u.userId
        ,   u.userName
        ,   o.productNo
        FROM
            t_order o
        ,   t_user u
        WHERE
            o.userNo = u.id
    )ou
WHERE p.id = ou.productNo
AND userName = '손흥민';

SELECT
    DISTINCT pname
FROM t_order AS o
INNER JOIN t_user AS u
ON o.userNo = u.id
INNER JOIN t_product AS p
ON o.productNo = p.id
WHERE u.userName = '손흥민';

SELECT
    p.pname
,   COUNT(*) AS orderCount
FROM t_order AS o
INNER JOIN t_user AS u
ON o.userNo = u.id
INNER JOIN t_product AS p
ON o.productNo = p.id
WHERE u.userName = '손흥민'
GROUP BY p.pname;

# 3. 스커트를 산 사람은? ???
#3.비정규 테이블 t_shopping
SELECT * FROM t_shopping WHERE pname = '스커트';
#3.정규화 테이블
SELECT
    pname
,   price
,   userId
,   userName
FROM
    t_product p
,   (
        SELECT
            u.userId
        ,   u.userName
        ,   o.productNo
        FROM
            t_order o
        ,   t_user u
        WHERE
            o.userNo = u.id
    )ou
WHERE
    p.id = ou.productNo
AND pname = '스커트';

SELECT
    DISTINCT u.userName
FROM t_order AS o
INNER JOIN t_user AS u
ON o.userNo = u.id
INNER JOIN t_product AS p
ON o.productNo = p.id
WHERE p.pname = '스커트';

# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는? ???
#4.비정규 테이블 t_shopping

#4.정규화 테이블
SELECT
    u.userId AS '아이디'
,   u.userName AS '이름'
,   COUNT(*) AS '주문수'
FROM t_order AS o
INNER JOIN t_user AS u
ON o.userNo = u.id
INNER JOIN t_product AS p
ON o.productNo = p.id
GROUP BY u.id
ORDER BY COUNT(*) DESC LIMIT 1;

# 5. 소지섭이 사용한 총 금액은? ???
#5.비정규 테이블 t_shopping

#5.정규화 테이블
SELECT
    SUM(price)
FROM t_order AS o
INNER JOIN t_user AS u
ON o.userNo = u.id
INNER JOIN t_product AS p
ON o.productNo = p.id
WHERE userName = '소지섭';





























