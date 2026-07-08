
# a6 DB 삭제/생성/선택
DROP DATABASE a6;

CREATE DATABASE a6;

USE a6;
# 부서(홍보, 기획)
CREATE TABLE dept(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	deptName TEXT
);

INSERT INTO dept
SET deptName = "홍보";

INSERT INTO dept
SET deptName = "기획";

SELECT *
FROM dept;
# 사원(홍길동/홍보/5000만원, 홍길순/홍보/6000만원, 임꺽정/기획/4000만원)

CREATE TABLE emp(
	id INT PRIMARY KEY AUTO_INCREMENT, 
	`name` TEXT,
	deptId INT,
	salary INT
);

INSERT INTO emp
SET `name` = "홍길동",
deptId = 1,
salary = 5000;

INSERT INTO emp
SET `name` = "홍길순",
deptId = 1,
salary = 6000;

INSERT INTO emp
SET `name` = "임꺽정",
deptId = 2,
salary = 4000;

SELECT *
FROM emp;
#여기까지 테스터 환경 만들기 중요!

# 사원 수 출력
SELECT COUNT(emp.name) AS "사원수" FROM emp;

# 가장 큰 사원 번호 출력
SELECT MAX(emp.id)
FROM emp;


# 가장 고액 연봉
SELECT MAX(emp.salary) AS "가장 고액 연봉"
FROM emp;

# 가장 저액 연봉
SELECT MIN(emp.salary) AS "가장 저액 연봉"
FROM emp;

# 회사에서 1년 고정 지출(인건비)
SELECT SUM(emp.salary) AS "인건비"
FROM emp;

# 부서별, 1년 고정 지출(인건비) 
SELECT emp.deptId, SUM(emp.salary) AS "인건비"
FROM emp
GROUP BY deptId;

# 부서별, 최고연봉
SELECT emp.deptId, MAX(emp.salary)
FROM emp
GROUP BY deptId;

# 부서별, 최저연봉
SELECT emp.deptId, MIN(emp.salary)
FROM emp
GROUP BY deptId;

# 부서별, 평균연봉
SELECT emp.deptId, TRUNCATE(AVG(emp.salary), 0)
FROM emp
GROUP BY deptId;


# 부서별, 부서명, 사원리스트, 평균연봉, 최고연봉, 최소연봉, 사원수 
## V1(조인 안한 버전)
SELECT emp.deptId, GROUP_CONCAT(emp.Name), TRUNCATE(AVG(emp.salary), 0), MAX(emp.salary), MIN(emp.salary), COUNT(emp.name)
FROM emp
GROUP BY deptId;

SELECT * FROM dept WHERE id =1;#조인을 안할때는 이렇게 한번에 묶어서 보여줄수 밖에 없다.
SELECT * FROM dept WHERE id =2;
## V2(조인해서 부서명까지 나오는 버전)
SELECT dept.deptName, GROUP_CONCAT(emp.Name), TRUNCATE(AVG(emp.salary), 0), MAX(emp.salary), MIN(emp.salary), COUNT(emp.name) AS "사원수"
FROM dept
INNER JOIN emp
ON dept.id = emp.deptId
GROUP BY dept.deptName;

## V3(V2에서 평균연봉이 5000이상인 부서로 추리기)

SELECT dept.deptName, TRUNCATE(AVG(emp.salary),0)
FROM dept
INNER JOIN emp
ON dept.id = emp.deptId
GROUP BY dept.deptName
HAVING TRUNCATE(AVG(emp.salary), 0) >= 5000;
