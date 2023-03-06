USE bookrentalshop;

-- 1번 문제
SELECT CONCAT(LEFT(m.Names, 1),',', SUBSTRING(m.Names, 2, 3)) AS '회원명'
	 , m.Addr AS '주소'
     , m.Mobile AS '폰번호'
     , m.Email AS '이메일'
  FROM membertbl AS m;

-- 2번 문제
SELECT d.Names AS '장르'
     , b.Author AS '작가'
     , b.Names AS '책제목'
  FROM bookstbl AS b
 INNER JOIN divtbl AS d
	ON b.Division = d.Division
 ORDER BY d.Names ASC;

-- 3번 문제
START TRANSACTION;
INSERT INTO bookrentalshop.divtbl (Division, Names) VALUES ('I002', '네트워크');

-- 4번 문제
START TRANSACTION;
UPDATE membertbl
   SET Levels = 'D'
     , Mobile = '010-9839-9999'  
 WHERE Names = '성명건';

-- 5번 문제
SELECT bb.Names AS '장르', FORMAT(bb.tot,0) AS '장르별 총합계'
  FROM (
	    SELECT IFNULL(d.Names,'--합계--') AS Names
			 , SUM(b.Price) AS tot
		  FROM bookstbl AS b
		 INNER JOIN divtbl AS d
			ON b.Division = d.Division 
		GROUP BY d.Names
        WITH ROLLUP
		) AS bb
 
  