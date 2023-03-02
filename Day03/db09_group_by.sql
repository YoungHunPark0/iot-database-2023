-- 집계함수를 사용하기 위해서 / 그룹핑
USE sqldb;

-- GROUP BY에 작성된 컬럼명만 SELECT에 쓸 수 있음
SELECT userID AS '아이디'
	 , SUM(amount) AS '구매갯수'
  FROM buytbl
 GROUP BY userID; 
 
 SELECT userID AS '아이디'
	 , AVG(amount) AS '평균구매갯수'
  FROM buytbl
 GROUP BY userID;

-- HAVING은 집계함수등의 결과값을 필터링하기 위해서 사용(집계함수, 통계 등)
SELECT userID
	 , SUM(price * amount) AS '합산'
  FROM buytbl
 GROUP BY userID
HAVING SUM(price * amount) >= 1000; 
-- WHERE '합산' > 1000 이렇게 쓰면 될까???  
-- WHERE절은 EX 키가 175이상인사람들 등 컬럼이면 가능, 
-- SUM(price* amount)--> 이건 집계함수, 컬럼이 아님! WHERE절은 집계함수에 사용X

-- ROLLUP 전체합계 자동계산
SELECT userID
	 , SUM(price * amount) AS '합산'
  FROM buytbl
 GROUP BY userID
  WITH ROLLUP; 