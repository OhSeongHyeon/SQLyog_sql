# a6 DB 삭제/생성/선택
DROP DATABASE IF EXISTS `a6`;
CREATE DATABASE `a6`;
USE `a6`;
# 부서(홍보, 기획)
CREATE TABLE dept (
    id INT UNSIGNED AUTO_INCREMENT
,   `name` VARCHAR(255) NOT NULL
,   regDate DATETIME NOT NULL
,   PRIMARY KEY (id)
);

INSERT INTO dept (id, `name`, regDate)
VALUES
    (NULL, '홍보', NOW())
,   (NULL, '기획', NOW());
-- select * from dept;
    
# 사원(홍길동/홍보/5000만원, 홍길순/홍보/6000만원, 임꺽정/기획/4000만원)
CREATE TABLE emp (
    id INT UNSIGNED AUTO_INCREMENT
,   `name` VARCHAR(255) NOT NULL
,   deptId INT UNSIGNED NOT NULL
,   salary INT
,   regDate DATETIME NOT NULL
,   PRIMARY KEY (id)
,   FOREIGN KEY (deptId) REFERENCES `dept`(id)
);

INSERT INTO emp SET `name` = '홍길동', deptId = 1, salary = 50000000, regDate = NOW();
INSERT INTO emp SET `name` = '홍길순', deptId = 1, salary = 60000000, regDate = NOW();
INSERT INTO emp SET `name` = '임꺽정', deptId = 2, salary = 40000000, regDate = NOW();
-- select * from emp;

# 사원 수 출력
SELECT COUNT(id) AS 사원수 FROM emp;

# 가장 큰 사원 번호 출력
SELECT MAX(id) AS 사번최댓값 FROM emp;

# 가장 고액 연봉
SELECT MAX(salary) AS '가장큰 고액 연봉' FROM emp;

# 가장 저액 연봉
SELECT MIN(salary) AS '가장 저액 연봉' FROM emp;

# 회사에서 1년 고정 지출(인건비)
SELECT SUM(salary) AS '연간 인건비' FROM emp;

# 부서별, 1년 고정 지출(인건비)
SELECT
    dept.name AS '부서명'
,   SUM(salary) AS '연간 인건비'
FROM emp
INNER JOIN dept
ON emp.deptId = dept.id
GROUP BY dept.id;

# 부서별, 최고연봉
SELECT
    dept.name AS '부서명'
,   MAX(salary) AS '가장 고액 연봉'
FROM emp
INNER JOIN dept
ON emp.deptId = dept.id
GROUP BY dept.id;

# 부서별, 최저연봉
SELECT
    dept.name AS '부서명'
,   MIN(salary) AS '최저연봉'
FROM emp
INNER JOIN dept
ON emp.deptId = dept.id
GROUP BY dept.id;

# 부서별, 평균연봉
SELECT
    dept.name AS '부서명'
,   ROUND(AVG(salary), 0) AS '평균연봉'
FROM emp
INNER JOIN dept
ON emp.deptId = dept.id
GROUP BY dept.id;

# 부서별, 부서명, 사원리스트, 평균연봉, 최고연봉, 최소연봉, 사원수 
## V1(조인 안한 버전)

## V2(조인해서 부서명까지 나오는 버전)
SELECT
    e.deptId AS '부서번호'
,   d.name AS '부서명'
,   GROUP_CONCAT(e.name) AS '사원명'
,   TRUNCATE(AVG(e.salary), 0) AS '평균연봉'
,   MAX(e.salary) AS '최고연봉'
,   MIN(e.salary) AS '최소연봉'
,   COUNT(e.salary) AS '사원수'
FROM emp AS e
INNER JOIN dept AS d
ON e.deptId = d.id
GROUP BY e.deptId;

## V3(V2에서 평균연봉이 5000이상인 부서로 추리기)
SELECT
    d.id AS deptId
,   d.name AS deptName
,   ROUND(AVG(e.salary), 0) AS 'salAvg'
FROM emp AS e
INNER JOIN dept AS d
ON e.deptId = d.id
GROUP BY d.id
HAVING AVG(e.salary) >= 50000000;

SELECT
    e.deptId AS '부서번호'
,   d.name AS '부서명'
,   GROUP_CONCAT(e.name) AS '사원명'
,   TRUNCATE(AVG(e.salary), 0) AS '평균연봉'
,   MAX(e.salary) AS '최고연봉'
,   MIN(e.salary) AS '최소연봉'
,   COUNT(e.salary) AS '사원수'
FROM emp AS e
INNER JOIN dept AS d
ON e.deptId = d.id
GROUP BY e.deptId
HAVING AVG(e.salary) >= 50000000;

## V4(V3에서 HAVING 없이 서브쿼리로 수행)
### HINT, UNION을 이용한 서브쿼리
# SELECT *
# FROM (
#     select 1 AS id
#     union
#     select 2
#     UNION
#     select 3
# ) AS A



























