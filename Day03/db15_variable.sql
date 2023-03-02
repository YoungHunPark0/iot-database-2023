-- 변수 사용
USE sqldb;

SET @myVar1 = 5; -- set @ = > @는 mysql서버를 나타냄
SELECT @myVar1;
SET @myVar2 = '이름 ==> ';

SELECT @myVar2, name
  FROM usertbl
 WHERE height > 170;
 
SELECT name, height + @myVar1
  FROM usertbl;
  
-- 형 변환
SELECT CAST(birthYear AS CHAR) FROM usertbl; -- AS
SELECT CAST(CONVERT(birthYear, CHAR) AS SIGNED INTEGER) FROM usertbl; -- ,

SELECT CAST(addr AS decimal) FROM usertbl; -- addr은 문자열이라 decimal x
SELECT CONVERT(addr, decimal) FROM usertbl;

SELECT CAST('1000' AS decimal);

-- 암시적 형변환
SELECT 200 + 300;

SELECT CONCAT('Hello ','World'); -- CONCAT()-> 문자열 합치기

SELECT '200' + '300'; -- MySQL 이외에서는 '200300' 문자와문자를 더함(정수변환)
SELECT CONCAT(200,'300'); -- 문자와 문자를 연결(문자로 처리)

SELECT 2 = 1; -- TRUE/FALSE

/* 내장함수 리스트 */
-- 흐름함수
-- python 100>200 ? '참' : '거짓' => 이값이 ? 이면 참/거짓
SELECT IF(100>200, '참', '거짓');

SELECT IFNULL(NULL, '널입니다');

-- NULL은 계산이 오류(결과도 NULL)
SELECT NULL + 100; -- 값이 NULL. NULL이 들어가면 통계나 합산이 안됨
SELECT IFNULL(NULL, 0) + 100; -- NULL을 0으로 바꿔주면 계산됨

-- 쿼리작성할 때 많이 사용(많이 사용함)
SELECT name
	 , birthYear
     , addr
     , CASE addr
	   WHEN '서울' THEN '수도권'
       WHEN '경기' THEN '수도권'
       WHEN '부산' THEN '광역권'
       WHEN '한양' THEN '조선권'
       ELSE '지역권' END AS '권역'
  FROM usertbl;
  
-- 문자열함수
SELECT ASCII('A'), CHAR(65), ASCII('a');
SELECT ASCII('안'), CHAR(236); -- 한글은 사용하면 안됨

-- CHAR_LENGTH(글자길이), LENGTH(byte)
SELECT CHAR_LENGTH('ABC'), LENGTH('ABC'); -- 3, 3bytes
-- UTF-8
SELECT CHAR_LENGTH('가나다'), LENGTH('가나다'); -- 한글은 한글자당 3bytes 3/9
-- (많이 사용함)
SELECT REPLACE('Hello World', 'Hello', 'Byebye');
-- DB는 인덱스를 1부터 시작(많이 사용함)
SELECT INSTR('안녕하세요, 여러분', '여'); -- '안녕하세요, 여러분' 에서 '여'는 8번째
-- LEFT, RIGHT (많이 사용함)
SELECT LEFT('ABCDEFGHIJKLMN', 3), RIGHT('ABCDEFGHIJKLMN', 3); -- ABC / LMN
-- UPPER, LOWER
SELECT UPPER('Hello World'), LOWER('Hello World'); -- 대문자 / 소문자

-- LTRIM, RTRIM, TRIM
SELECT LTRIM('          Hello World!          ') AS 'ltrim' 
	 , RTRIM('          Hello World!          ') AS 'rtrim'
	 , TRIM('          Hello World!          ') AS 'trim';
     
-- 'Hello' * 3
SELECT REPEAT('Hello', 3);

-- substring
SELECT SUBSTRING('대한민국만세', 5, 2);

-- 수학함수
SELECT ABS(-10);  -- 10
-- 올림, 내림, 반올림
SELECT CEILING(4.3), FLOOR(4.9), ROUND(4.4);

SELECT MOD(157, 10);

-- RANDOM
SELECT RAND(), FLOOR(1 + (RAND() * 6)); -- RNAD() 0부터 1사이 소수점이 나옴-> 주사위놀이

-- 날짜 및 시간함수
SELECT NOW();
SELECT ADDDATE('2023-03-02', INTERVAL -10 DAY); -- 23.02.20 

SELECT YEAR(NOW()); -- 2023
SELECT DATE(NOW());
SELECT TIME(NOW());
SELECT DAYOFWEEK(NOW()); # 1(일요일)~7(토)
SELECT LAST_DAY('2023-02-01'); # 해당 달의 마지막 날

-- 시스템 함수
SELECT USER(); -- 유저의 정보 

SELECT DATABASE(); -- 현재 사용되고 있는 데이터베이스

-- ROW_COUNT()
USE sqldb;
UPDATE buytbl SET price = price * 2;
SELECT ROW_COUNT();

SELECT VERSION();