SHOW DATABASES;

#create database `a1`;

SHOW VARIABLES LIKE "%char%";

###################################
# 전체 데이터베이스 리스팅
SHOW DATABASES;
# `mysql` 데이터 베이스 선택
USE `mysql`;
# 테이블 리스팅
SHOW TABLES;
# 특정 테이블의 구조
DESC func;
# `test` 데이터 베이스 선택
USE `test`;
# 테이블 리스팅
SHOW TABLES;
# 기존에 a1 데이터베이스가 존재 한다면 삭제
DROP DATABASE `a1`;
DROP DATABASE IF EXISTS `a1`;
# 새 데이터베이스(`a1`) 생성
CREATE DATABASE `a1`;
# 데이터베이스(`a1`) 선택
USE `a1`;
# 데이터베이스 추가 되었는지 확인
SHOW DATABASES;
# 테이블 확인
SHOW TABLES;
# 게시물 테이블 article(title, body)을 만듭니다.
# VARCHAR(100) => 문자 100개 저장가능
# text => 문자 많이 저장가능
CREATE TABLE article (
    title VARCHAR(100)
,   `body` TEXT
);
# 잘 추가되었는지 확인, 리스팅과 구조까지 확인
SELECT * FROM article;
# 데이터 하나 추가(title = 제목, body = 내용)
INSERT INTO article (
    title
,   `body`
) VALUES (
    '제목'
,   '내용'
);
# 데이터 조회(title 만)
SELECT title FROM article;
# 데이터 조회(title, body)
SELECT title, `body` AS 'content' FROM article;
# 데이터 조회(body, title)
SELECT `body`, title FROM article;
# 데이터 조회(*)
SELECT * FROM article;
# 데이터 또 하나 추가(title = 제목, body = 내용)
INSERT INTO article
VALUES (
    '제목2'
,   '내용2'
);
# 데이터 조회(*, 어떤게 2번 게시물인지 알 수 없음)
SELECT * FROM article;
# 테이블 구조 수정(id 칼럼 추가, first)
ALTER TABLE article ADD COLUMN id INT FIRST;
# 데이터 조회(*, id 칼럼의 값은 NULL)
SELECT * FROM article;
# 기존 데이터에 id값 추가(id = 1, id IS NULL)
UPDATE article
SET id = 1
WHERE id IS NULL;
# 데이터 조회(*, 둘다 수정되어 버림..)
SELECT * FROM article;
# 기존 데이터 중 1개만 id를 2로 변경(LIMIT 1)
UPDATE article
SET id = 2
WHERE id = 1
LIMIT 1;
# 데이터 조회(*)
SELECT * FROM article;
# 데이터 1개 추가(id = 3, title = 제목3, body = 내용3)
INSERT INTO article VALUES (3, '제목3', '내용3');
# 데이터 조회(*)
SELECT * FROM article;
# 2번 게시물, 데이터 삭제 => DELETE
DELETE FROM article WHERE id = 2;
#DELETE FROM article WHERE id = 1 and (title is null or `body` is null);
# 데이터 조회(*)
SELECT * FROM article;
# 날짜 칼럼 추가 => regDate DATETIME
ALTER TABLE article ADD COLUMN regDate DATETIME;
# 테이블 구조 확인
DESC article;
# 데이터 조회(*, 날짜 정보가 비어있음)
SELECT * FROM article;
# 1번 게시물의 비어있는 날짜정보 채움(regDate = 2018-08-10 15:00:00)
UPDATE article SET regDate = '2018-08-10 15:00:00' WHERE id = 1;
# 데이터 조회(*, 이제 2번 게시물의 날짜 정보만 넣으면 됩니다.)
SELECT * FROM article;
INSERT INTO article (id, title, `body`) VALUES (2, '제목22', '내용2222');
# NOW() 함수 실행해보기
SELECT NOW();
SELECT NOW() FROM DUAL;
# 3번 게시물의 비어있는 날짜정보 채움(NOW())
UPDATE article SET regDate = NOW() WHERE id = 3;
# 데이터 조회(*)
SELECT * FROM article;
###################################
###################################
# 기존에 a2 데이터베이스가 존재 한다면 삭제
DROP DATABASE IF EXISTS `a2`;
# 새 데이터베이스(`a2`) 생성
CREATE DATABASE `a2`;
# 새 데이터베이스(`a2`) 선택
USE `a2`;
# article 테이블 생성(id, regDate, title, body)
CREATE TABLE article(
    id INT #unsigned not null auto_increment
,   regDate DATETIME
,   title CHAR(255)
,   `body` TEXT
);
SHOW TABLES;
# article 테이블 조회(*)
SELECT * FROM article;
# article 테이블에 data insert (regDate = NOW(), title = '제목', body = '내용')
INSERT INTO article SET regDate = NOW(), title = '제목', BODY = '내용';
# article 테이블에 data insert (regDate = NOW(), title = '제목', body = '내용')
INSERT INTO article SET regDate = NOW(), title = '제목', BODY = '내용';
# article 테이블 조회(*)
## id가 NULL인 데이터 생성이 가능하네?
SELECT * FROM article;
# id 데이터는 꼭 필수 이기 때문에 NULL을 허용하지 않게 바꾼다.(alter table, not null)
## 기존의 NULL값 때문에 경고가 뜬다.
## 기존의 NULL값이 0으로 바뀐다.
ALTER TABLE article MODIFY COLUMN id INT PRIMARY KEY;
# article 테이블 조회(*)
SELECT * FROM article;
# 생각해 보니 모든 행(row)의 id 값은 유니크 해야한다.(ADD PRIMARY KEY(id))
## 오류가 난다. 왜냐하면 기존의 데이터 중에서 중복되는게 있기 때문에
UPDATE article SET id = 0;
# id가 0인 것 중에서 1개를 id 1로 바꾼다.
UPDATE article SET id = 1 WHERE id = 0 LIMIT 1;
# article 테이블 조회(*)
SELECT * FROM article;
# id가 0인것을 id 2로 바꾼다.
UPDATE article SET id = 2 WHERE id = 0 LIMIT 1;
# 생각해 보니 모든 행(row)의 id 값은 유니크 해야한다.(ADD PRIMARY KEY(id))
## 이제 적용이 잘 된다.
ALTER TABLE article MODIFY COLUMN id INT PRIMARY KEY;
# id 칼럼에 auto_increment 를 건다.
## auto_increment 를 걸기전에 해당 칼럼은 무조건 key 여야 한다.
ALTER TABLE article MODIFY COLUMN id INT AUTO_INCREMENT;
# article 테이블 구조확인(desc)
DESC article;
# 나머지 칼럼 모두에도 not null을 적용해주세요.
ALTER TABLE article MODIFY COLUMN id INT NOT NULL;
ALTER TABLE article MODIFY COLUMN regDate DATETIME NOT NULL;
ALTER TABLE article MODIFY COLUMN title CHAR(255) NOT NULL;
ALTER TABLE article MODIFY COLUMN `body` TEXT NOT NULL;
# id 칼럼에 UNSIGNED 속성을 추가하세요.
ALTER TABLE article MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
# 작성자(writer) 칼럼을 title 칼럼 다음에 추가해주세요.
ALTER TABLE article ADD COLUMN writer VARCHAR(255) AFTER title;
SELECT * FROM article;
# 작성자(writer) 칼럼의 이름을 nickname 으로 변경해주세요.(ALTER TABLE article CHANGE oldName newName TYPE 조건)
ALTER TABLE article CHANGE `writer` `nickname` VARCHAR(255) NOT NULL;
DESC article; #위에서 낫널 명시안해줬네?
ALTER TABLE article MODIFY COLUMN nickname VARCHAR(255) NOT NULL;
# nickname 칼럼의 위치를 body 밑으로 보내주세요.(MODIFY COLUMN nickname)
ALTER TABLE article MODIFY COLUMN nickname VARCHAR(255) AFTER `body`;
# hit 조회수 칼럼 추가 한 후 삭제해주세요.
ALTER TABLE article ADD COLUMN hit INT UNSIGNED NOT NULL;
ALTER TABLE article DROP COLUMN hit;
# hit 조회수 칼럼을 다시 추가
ALTER TABLE article ADD COLUMN hit INT UNSIGNED NOT NULL;
# 기존의 비어있는 닉네임 채워넣기(무명)
UPDATE article SET nickname = '무명';
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목3', body = '내용3', nickname = '홍길순', hit = 10)
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목4', body = '내용4', nickname = '홍길동', hit = 55)
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목5', body = '내용5', nickname = '홍길동', hit = 10)
# article 테이블에 데이터 추가(regDate = NOW(), title = '제목6', body = '내용6', nickname = '임꺽정', hit = 100)
INSERT INTO article (regDate, title, `body`, nickname, hit)
VALUES
    (NOW(), '제목3', '내용3', '홍길순', 10)
,   (NOW(), '제목4', '내용4', '홍길동', 55)
,   (NOW(), '제목5', '내용5', '홍길동', 10)
,   (NOW(), '제목6', '내용6', '임꺽정', 100);
SELECT * FROM article;
# 조회수 가장 많은 게시물 3개 만 보여주세요., 힌트 : ORDER BY, LIMIT
SELECT * FROM article
ORDER BY hit DESC
LIMIT 3;
# 작성자명이 '홍길'로 시작하는 게시물만 보여주세요., 힌트 : LIKE '홍길%'
SELECT * FROM article WHERE nickname LIKE '홍길%';
# 조회수가 10 이상 55 이하 인것만 보여주세요., 힌트 : WHERE 조건1 AND 조건2
SELECT * FROM article
WHERE hit >= 10 AND hit <= 55;
# 작성자가 '무명'이 아니고 조회수가 50 이하인 것만 보여주세요., 힌트 : !=
SELECT * FROM article
WHERE nickname <> '무명' AND hit <= 50;
# 작성자가 '무명' 이거나 조회수가 55 이상인 게시물을 보여주세요. 힌트 : OR
SELECT * FROM article
WHERE nickname = '무명' OR hit >= 55;
######################################################################
######################################################################
# 문자열 합치기
SELECT CONCAT('문자열', ' 숫자리터럴 1');
# 테이블 이름 변경
ALTER TABLE `oldName` RENAME `newName`;
# 실수 난수 생성
SELECT RAND();
# 문자열 자르기 SUBSTRING
SELECT SUBSTRING(RAND() * 10 FROM 1 FOR 1); #난수 생성


























