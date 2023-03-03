-- 쇼핑몰에 가입하고 물건을 한번도 
-- 구매하지 않은 회원까지 모두 출력
SELECT u.*
	 , b.userID
     , b.prodName
     , b.groupName
     , b.price
     , b.amount
  FROM usertbl AS u
  LEFT OUTER JOIN buytbl AS b -- LEFT조인은 왼쪽에서 맞지않는 것만 출력
    ON u.userID = b.userID
 WHERE b.userID IS NULL; -- userID에 널인것만 보겠다(널비교할땐 is null)
 
-- 학생중에 동아리에 가입하지 않은 학생
SELECT s.stdName, s.addr
	 , j.num, c.clubName, c.roomNo
  FROM stdtbl AS s
 LEFT OUTER JOIN stdclubtbl AS j
    ON s.stdName = j.stdName
 LEFT OUTER JOIN clubtbl AS c 
    ON c.clubName = j.clubName
 UNION -- 집합(두 쿼리결과를 합쳐줌), UNION ALL - 중복된 열까지 모두 출력(잘안씀)
SELECT s.stdName, s.addr
	 , j.num, c.clubName, c.roomNo
  FROM stdtbl AS s
RIGHT OUTER JOIN stdclubtbl AS j
    ON s.stdName = j.stdName
RIGHT OUTER JOIN clubtbl AS c -- clubtbl을 기준으로 함 
    ON c.clubName = j.clubName;
-- RIGHT조인 -> 가입자없는 동아리, LEFT조인- 동아리에 가입하지 않은 사람

-- INNER JOIN의 약식표현(권하지 않음)
SELECT u.*
	 , b.userID
     , b.prodName
     , b.groupName
     , b.price
     , b.amount
  FROM usertbl AS u, buytbl AS b
 WHERE u.userID = b.userID;
 
-- IN은 조건이 만족하는 것 출력
-- NOT IN은 조건이 만족하지 않는 것만 출력
SELECT name
     , height
  FROM usertbl
 WHERE height NOT IN (SELECT height
					    FROM usertbl 
			 WHERE name LIKE '김경호%'); 