-- Active: 1677474332381@@127.0.0.1@3306@employees
-- 사용 데이터베이스 변경
USE homeplus;
-- SELECT * == all(X)
-- 한문장 끝은 ;으로 마침
SELECT * FROM indextbl; 
SELECT * FROM homeplus.indextbl; /* 윗문장과 동일한 의미 */

SELECT * FROM employees.titles; -- 다른 DB의 테이블에서 데이터를 가져올때

-- 필요한 컬럼만 가져오겠다
SELECT first_name, last_name FROM indextbl;

-- sqldb를 사용
USE sqldb;

-- 조건절로 검색 select * from where name = '김경호'; 모든 컬럼의 값을 보여줘, name의 김경호
SELECT userID
     , name
     , birthYear
     , height 
  FROM usertbl
 WHERE name = '김경호'; -- 가독성, 추가, 삭제 때문에 세로로 맞춤.
 
 
-- 관계 연산자
SELECT *
	FROM usertbl
   WHERE birthYear >= 1970
     AND height >= 182;
     
-- 사이의 값을 조회
SELECT *
	FROM usertbl
   WHERE height >= 180
     AND height <= 183;
     
SELECT *
	FROM usertbl
   WHERE height BETWEEN 180 AND 183;
   
-- IN 연산자
SELECT *
  FROM usertbl
 WHERE addr IN ('경남', '경북', '전남');
 
-- 문자열 검색 - 뉴스 본문안에서 일정단어를 검색 할 때 반드시 필요!
SELECT * 
  FROM usertbl
 WHERE name LIKE '김__';
 
-- Subquery(서브쿼리)
-- 1. 컬럼 위치
-- 2. 테이블 위치
-- 3. 조건절 위치
-- WHERE절에 서브쿼리가 컬럼이 한개이상이거나 결과가 한개이상이면
-- 조건연산자로 조회할 수 없음
SELECT name
     , height
  FROM usertbl
 WHERE height > (SELECT height FROM usertbl WHERE name LIKE '김경호%');

-- 가상 테이블
-- AS 별명
SELECT u.userID
	 , u.name
     , (2023 - u.birthYear) AS 'age' -- 한글은 ' ' 써야함, 영어는 상관없음
     -- 계산해서 만든 새로운 컬럼(이름x)-->> AS = 별명 만듬, 나이만 나옴
  FROM(
		SELECT userID, name, birthYear, addr
		   FROM usertbl
           ) AS u
 WHERE u.birthYear > 1969;
 
-- 컬럼에 쓰는 서브쿼리 (컬럼에 서브쿼리 쓸때는 하나만 씀( * 사용x)
SELECT b.userID AS '아이디'
 	 -- 에러 Operand should contain 1 column(s) - *(all)->name
     , (SELECT name FROM usertbl WHERE userID = b.userID) AS '이름' 
	 , b.prodName 
     , b.price * amount AS '판매액'
  FROM buytbl AS b;

-- 정렬 Order BY : default ASC(ENDING) 안적어도 오름차순
-- 내림차순 DESC(ENDING)
SELECT name
     , birthYear
     , height
  FROM usertbl
 WHERE birthYear > 1969
 ORDER BY birthYear DESC, height ASC;
 
-- 중복제거 / 중복제거할 컬럼만
SELECT DISTINCT addr
  FROM usertbl;
  
-- LIMIT 갯수 제한
USE homeplus;

SELECT * FROM indexTbl
 LIMIT 5;

USE sqlDB;

-- 조회하면서 새로운 테이블 생성하는 쿼리
-- PK/ FK 제약조건은 복사안됨
-- 일부 컬럼(열)만 복사 테이블생성 가능
CREATE TABLE elec_buytbl_new
SELECT num 
     , prodName
     , price
  FROM buytbl
 WHERE groupName = '전자';