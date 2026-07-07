DROP DATABASE mall;

CREATE DATABASE mall;

USE mall;

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

SHOW TABLES;
DESC t_shopping;
SELECT* FROM t_shopping;

# 1. 손흥민의 주문 개수는? ???
SELECT COUNT(*)
FROM t_shopping
WHERE userName = "손흥민";

#3개

# 2. 손흥민이 산 상품은? ???

SELECT DISTINCT pname
FROM t_shopping
WHERE userName = "손흥민";

#운동화, 코트

# 3. 스커트를 산 사람은? ???

SELECT DISTINCT userName
FROM t_shopping
WHERE pname = "스커트"

#대구에 사는 송혜교씨
#울산에 사는 송혜교씨

# 4. 가장 많이 주문한 사람의 아이디와 이름, 주문개수는? ???
SELECT userId, UserName, COUNT(*)
FROM t_shopping
GROUP BY userName
ORDER BY COUNT(*)DESC
LIMIT 1;

# 5. 소지섭이 사용한 총 금액은? ???

SELECT SUM(price) AS "소지섭이 사용한 총 금액"
FROM t_shopping
WHERE userName = "소지섭";

#100000+30000 = 130000