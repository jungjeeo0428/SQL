DROP DATABASE IF EXISTS practice_med;
CREATE DATABASE practice_med DEFAULT CHARACTER SET utf8mb4;
USE practice_med;

DROP TABLE IF EXISTS patients;
CREATE TABLE patients (
    patient_id  VARCHAR(10) PRIMARY KEY,
    `name`        VARCHAR(50),
    gender      VARCHAR(10),
    birth_date  DATE,
    phone       VARCHAR(20)
);

INSERT INTO patients (patient_id, `name` , gender, birth_date, phone) VALUES
('P001', '환자1',   'M',      '1978-03-12', '010-1111-0001'),
('P002', '환자2',   'female', '1990-07-25', '010-1111-0002'),
('P003', '환자3 ',  'm',      NULL,         '010-1111-0003'),
('P004', '환자4',   'F',      '1965-11-02', '010-1111-0004'),
('P005', '환자5',   'Male',   '2001-05-19', NULL),
('P006', '환자6',   NULL,     '1988-09-30', '010-1111-0006'),
('P007', '환자7',   'M',      '1955-01-15', '010-1111-0007'),
('P008', '환자8',   'f',      '1995-12-08', '010-1111-0008'),
('P009', '환자9',   'M',      NULL,         '010-1111-0009'),
('P010', '환자10',   'F',      '1972-06-21', '010-1111-0010'),
('P011', '환자11',   'male',   '1983-04-17', '010-1111-0011'),
('P012', '환자12',   'F',      '2008-02-14', '010-1111-0012');

DROP TABLE IF EXISTS admissions;
CREATE TABLE admissions (
    admission_id   VARCHAR(10) PRIMARY KEY,
    patient_id     VARCHAR(10),
    admit_date     DATE,
    discharge_date DATE,
    department     VARCHAR(30)
);

INSERT INTO admissions (admission_id, patient_id, admit_date, discharge_date, department) VALUES
('A001', 'P001', '2026-05-01', '2026-05-07', '내과'),
('A002', 'P002', '2026-05-03', NULL,         '외과'),
('A003', 'P003', '2026-04-20', '2026-04-18', '정형외과'),
('A004', 'P004', '2026-05-10', '2026-05-25', '내과'),
('A005', 'P001', '2026-06-01', '2026-06-03', '내과'),
('A006', 'P007', '2026-05-15', '2026-06-20', '신경과'),
('A007', 'P008', '2026-05-22', '2026-05-24', '외과'),
('A008', 'P011', '2026-06-05', NULL,         '내과'),
('A009', 'P004', '2026-06-10', '2026-06-12', '내과'),
('A010', 'P012', '2026-05-30', '2026-06-01', '소아과');

DROP TABLE IF EXISTS labs;
CREATE TABLE labs (
    lab_id      VARCHAR(10) PRIMARY KEY,
    patient_id  VARCHAR(10),
    test_name   VARCHAR(30),
    `value`       DECIMAL(10,2),
    unit        VARCHAR(10),
    measured_at DATETIME
);

INSERT INTO labs (lab_id, patient_id, test_name, `value`, unit, measured_at) VALUES
('L001', 'P001', 'glucose',      95,   'mg/dL', '2026-05-01 08:00:00'),
('L002', 'P001', 'Glucose',      140,  'mg/dL', '2026-05-02 08:00:00'),
('L003', 'P002', 'glucose',      210,  'mg/dL', '2026-05-03 08:00:00'),
('L004', 'P002', 'glucose',      210,  'mg/dL', '2026-05-03 08:00:00'),
('L005', 'P004', 'glucose',      65,   'mg/dL', '2026-05-11 08:00:00'),
('L006', 'P007', 'glucose',      -5,   'mg/dL', '2026-05-16 08:00:00'),
('L007', 'P007', 'glucose',      9999, 'mg/dL', '2026-05-17 08:00:00'),
('L008', 'P001', 'hemoglobin',   14.2, 'g/dL',  '2026-05-01 08:00:00'),
('L009', 'P004', 'Hemoglobin',   11.0, 'g/dL',  '2026-05-11 08:00:00'),
('L010', 'P008', 'hemoglobin ',  13.5, 'g/dL',  '2026-05-22 08:00:00'),
('L011', 'P011', 'glucose',      NULL, 'mg/dL', '2026-06-05 08:00:00'),
('L012', 'P012', 'glucose',      88,   'mg/dL', '2026-05-30 08:00:00'),
('L013', 'P004', 'GLUCOSE ',     130,  NULL,    '2026-06-10 08:00:00'),
('L014', 'P002', 'hemoglobin',   12.8, 'g/dL',  '2026-05-03 08:00:00');

SELECT COUNT(*) AS patients_cnt   FROM patients;    -- 12
SELECT COUNT(*) AS admissions_cnt FROM admissions;  -- 10
SELECT COUNT(*) AS labs_cnt       FROM labs;        -- 14

SELECT * 
FROM patients;  
 
SELECT * 
FROM admissions; 

SELECT * 
FROM labs; 


#=========================
#모두보기
SELECT *
FROM labs;

#null 제외, 이상치 제외
SELECT patient_id, LOWER(TRIM(test_name)), 
	`value`,
	unit, 
	meausred_at
FROM labs
WHERE `value` IS NOT NULL
	AND `value` BETWEEN 0 AND 1000;

#빈칸 없애기

SELECT patient_id, LOWER(TRIM(test_name)), 
	`value`
	COALESCE(unit, UNKNOWN) AS unit, # 빈칸 없애기
	meausred_at
FROM labs
WHERE `value` IS NOT NULL
	AND `value` BETWEEN 0 AND 1000;

# 중복제거


SELECT DISTINCT patient_id, 
LOWER(TRIM(test_name)), 
	`value`,
	COALESCE(unit, 'UNKNOWN') AS unit, 
	measured_at
FROM labs
WHERE `value` IS NOT NULL
	AND `value` BETWEEN 0 AND 1000; #이상치 제외

# 이름 붙여서 저장
CREATE TABLE labs_clean AS # 여기에다 붙여 만들기
SELECT DISTINCT patient_id, 
LOWER(TRIM(test_name)), 
	`value`,
	COALESCE(unit, 'UNKNOWN') AS unit, # 빈칸 없애기 
	measured_at
FROM labs
WHERE `value` IS NOT NULL
	AND `value` BETWEEN 0 AND 1000;
	
SELECT * FROM labs_clean;
	







# 1. 결측
# 1-1 결측 몇 개?
SELECT 
COUNT(*) AS '전체 환자 수', 
COUNT(birth_date) AS '생일 있음', 
COUNT(*) - COUNT(birth_date) AS '생일 없음'
FROM patients;

# 1-2 누가 없지?
SELECT patient_id, `name`
FROM patients
WHERE birth_date IS NULL;

# 2. 중복 L003, L004 잡아내기
# 2-1 -> 같은 환자이며, 같은 검사이며, 같은 시각이 2번 이상인거
SELECT patient_id, test_name, measured_at ,COUNT(*) AS '입력횟수'
FROM labs
GROUP BY patient_id, test_name, measured_at
HAVING COUNT(*) > 1; 

# 2-2 -> 이거는 중복인가?
SELECT patient_id, COUNT(*) AS '입원횟수'
FROM admissions
GROUP BY patient_id
HAVING COUNT(*) > 1;
# -> 이거는 재입원 같은데? 정상 아님???
# --> 도구는 잡아주기는 가능, 중복 여부는 사람이 해당 도메인지식을 바탕으로 판단

# 3. 표기 불일치 -> 한 번에 못세
SELECT gender, COUNT(*) AS '인원'
FROM patients
GROUP BY gender;
# 남자는 몇명? 6명일까?

# 3-1 통일을 해주자
SELECT patient_id, `name`, gender AS '원본',
	CASE
		WHEN LOWER(gender) IN ('m','male') THEN 'M'
		WHEN LOWER(gender) IN ('f','female') THEN 'F'
		ELSE 'U'	
	END AS gender_norm	
FROM patients;

# 3-2 통일 버전으로 다시 세면?
SELECT patient_id, `name`, gender AS '원본',
	CASE
		WHEN LOWER(gender) IN ('m','male') THEN 'M'
		WHEN LOWER(gender) IN ('f','female') THEN 'F'
		ELSE 'U'	
	END AS gender_norm, COUNT(*) AS '인원'
FROM patients
GROUP BY gender_norm;

# 3-3 
SELECT test_name FROM labs;
SELECT test_name, COUNT(*) FROM labs GROUP BY test_name; o
SELECT DISTINCT test_name, COUNT(*) FROM labs; X
SELECT DISTINCT LOWER(TRIM(test_name)) AS clean FROM labs; o

#4. 이상치
# 4-1 이상치를 그냥 방치하면?
SELECT AVG(`value`) AS '평균혈당'
FROM labs
WHERE LOWER(TRIM(test_name)) = 'glucose';

# 4-2 이상치를 잡자!
SELECT lab_id, patient_id, `value`
FROM labs
WHERE LOWER(TRIM(test_name)) = 'glucose' AND (`value` < 0 OR `value` > 1000);

# 4-3 4-2 빼고 평균
SELECT AVG(`value`) AS '평균혈당'
FROM labs
WHERE LOWER(TRIM(test_name)) = 'glucose' AND `value` BETWEEN 0 AND 1000;

# 5. 논리오류 - 퇴원이 입원보다 빠르다?
# 이상, 결측치가 아니므로 직접 잡아야함

# 5-1. 컬럼간의 관계로 잡는다
SELECT admission_id, patient_id, admit_date, discharge_date
FROM admissions
WHERE discharge_date < admit_date;

# 5-2 안치우고 재원일수를 구하면?
SELECT admission_id, DATEDIFF(discharge_date, admit_date) AS los_Days
FROM admissions
WHERE discharge_date IS NOT NULL;


# 구조적 문제
CREATE TABLE patients (
    patient_id  INT PRIMARY KEY AUTO_INCREMENT,
    patient_code VARCHAR(10) NOT NULL UNIQUE, -- 사람용 코드(P001) 는 따로 저장
    `name`        VARCHAR(50),
    gender      CHAR(1) NOT NULL, -- M/F/U 만 넣을 수 있도록 사이즈를 줄여
    birth_date  DATE,
    phone       VARCHAR(20)
);

# 현실이랑은 거리가 멀다. 이미 데이터는 이상한 모양으로 쌓여있고 나는 이걸 정제해야해