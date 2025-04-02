
# 데이터베이스 a4가 존재하면 삭제
DROP DATABASE IF EXISTS `a4`;
# 데이터베이스 a4 생성
CREATE DATABASE `a4`;
# 데이터베이스 a4 선택
USE `a4`;

# 회원 테이블 생성, loginId, loginPw, `name`
## 조건 : loginId 칼럼에 UNIQUE INDEX 없이
CREATE TABLE `member` (
    loginId VARCHAR(255) NOT NULL
,   loginPw VARCHAR(255) NOT NULL
,   `name` VARCHAR(255) NOT NULL
,   CONSTRAINT member_PK PRIMARY KEY (loginId)
);
# 회원 2명 생성
## 조건 : (loginId = 'user1', loginPw = 'user1', `name` = '홍길동')
## 조건 : (loginId = 'user2', loginPw = 'user2', `name` = '홍길순')
INSERT INTO `member` (loginId, loginPw, `name`)
VALUES
    ('user1', 'user1', '홍길동')
,   ('user2', 'user2', '홍길순');

# 회원 2배 증가 쿼리만들고 회원이 만명 넘을 때 까지 반복 실행
## 힌트1 : INSERT INTO `tableName` (col1, col2, col3, col4)
## 힌트2 : SELECT NOW(), UUID(), 'pw', '아무개'


# 회원수 확인

# 검색속도 확인
## 힌트 : SQL_NO_CACHE

# 유니크 인덱스를 loginID 칼럼에 걸기
## 설명 : mysql이 loginId의 고속검색을 위한 부가데이터를 자동으로 관리(생성/수정/삭제) 한다.
## 설명 : 이게 있고 없고가, 특정 상황에서 어마어마한 성능차이를 가져온다.
## 설명 : 생성된 인덱스의 이름은 기본적으로 칼럼명과 같다.

# 검색속도 확인, loginId 가 'user1' 인 회원 검색

# 인덱스 삭제, `loginId` 이라는 이름의 인덱스 삭제

# 회원 테이블 삭제

# 회원 테이블을 생성하는데, loginId에 uniqueIndex 까지 걸어주세요.

# 회원 2명 생성
## 조건 : (loginId = 'user1', loginPw = 'user1', `name` = '홍길동')
## 조건 : (loginId = 'user2', loginPw = 'user2', `name` = '홍길순')

# 회원수 확인

# 인덱스 쓰는지 확인
## 힌트 : EXPLAIN SELECT SQL_NO_CACHE * ~

# 게시물 테이블 생성(title, body, writerName, memberId)

# 1번 회원이 글 1 작성(title = '글 1 제목', `body` = '글 1 내용')

# 2번 회원이 글 2 작성(title = '글 2 제목', `body` = '글 2 내용')

# 1번 회원이 글 3 작성(title = '글 3 제목', `body` = '글 3 내용')

# 전체글 조회

# 1번회원의 이름변경 홍길동 => 홍길동2

# 전체글 조회, 여전히 게시물 테이블에는 이전 이름이 남아 있음

# 게시물 테이블에서 writerName 삭제

# INNER JOIN 을 통해서 두 테이블을 조회한 결과를 합침, ON 없이

# INNER JOIN 을 통해서 두 테이블을 조회한 결과를 합침, 올바른 조인 조건

## 힌트 : 이걸로 조인조건을 걸 칼럼 조사
## SELECT article.id, article.memberId, member.id AS "회원테이블_번호"
## FROM article
## INNER JOIN `member`;

# 조인 완성, ON 까지 추가

































