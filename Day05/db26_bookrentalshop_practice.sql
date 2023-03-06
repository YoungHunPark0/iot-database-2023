/* BookRentalShop 연습 */
SELECT *
  FROM membertbl;
  
-- 서브쿼리 - 성능이 떨어지는 영향(안좋음)
SELECT b.Author AS '저자'  -- 1번
	-- , b.Division AS '장르' -- 2번, B005등 번호는 사용자는 필요없음, 관리자, 개발자만 필요!
     , (SELECT Names 
          FROM divtbl 
		 WHERE Division = b.Division) AS '장르' -- 2번. 테이블 지정하고, 안에서 장르만듬
     , b.Names AS '책제목' -- 3번
     , b.ISBN -- 4번
     , b.price AS '금액' -- 5번
  FROM bookstbl AS b
 ORDER BY b.Names ASC; -- 3번 '책제목' 오름차순, b.Names => 3 대신 쓸 수 있음. names 쓰는걸 추천
                  -- ; 에서 끝났기 때문에 하단 from bookstbl as b랑 상관없음!

-- 조인 - 서브쿼리 쓸바엔 조인으로 변경하기!
SELECT b.Author AS '저자'
  -- , b.Division
     , d.Names AS '장르'
     , b.Names AS '책제목'
     , b.ISBN 
     , b.price AS '금액'
  FROM bookstbl AS b
 INNER JOIN divtbl AS d
    ON b.Division = d.Division
 ORDER BY b.Names;
 -- 조인은 서브쿼리가 할 수 있는건 조인도 할 수 있음(반대도가능)
 -- 단, 조인은 한번 같은걸 비교하고 끝! -> 빠름. 되도록이면 조인쓰기!
 -- 서브쿼리는 한컬럼당, 한줄당 비교하기 때문에 건수가 많아지면 느려짐! 어쩔 수 없을 때 쓰기!
 
-- 서브쿼리 (써야 할 때) - 장르로 그룹핑
SELECT (SELECT Names
		  FROM divtbl 
		 WHERE Division =  bb.Division) AS '장르'
	 , bb.총합
  FROM (
		SELECT b.Division
			 , SUM(b.Price) AS '총합'
		  FROM bookstbl AS b
		 GROUP BY b.Division -- sum 함수 안쓰면 price가 group by에 안들어 있어서 에러
       ) AS bb; -- group by 등 집계함수 쓸 때는 서브쿼리 마음대로 써도 됨!
       
-- 내부조인 - 테이블 4개 조인, 조인관계는 다이어그램에서 확인!
SELECT m.Names AS '이름'
     , m.Addr AS '주소'
     , m.Mobile AS '연락처'
     , r.rentalDate AS '대여일자'-- 빌린날짜
     , r.returnDate AS '반납일자' -- 반납날짜
--  , r.bookIdx 
-- -> r.bookidx만으로는 책목록을 모름-> 맴버테이블 bookidx 참조해야됨 ->이너조인
-- 관리자만 보면 되기에 주석처리
     , b.Names AS '책제목' 
     , d.Names AS '장르' 
-- B004가 뭔지를 모르기에 조인 한번더 해야됨->b.Division->d.Names 하면 b004->'전쟁' 출력
     , b.Price AS '금액'
  FROM membertbl AS m
 INNER JOIN rentaltbl AS r
	ON m.memberIdx = r.memberIdx
 INNER JOIN bookstbl AS b
	ON r.bookIdx = b.bookIdx
 INNER JOIN divtbl AS d
	ON b.Division = d.Division;
    
-- 외부조인 
SELECT m.Names AS '이름'
     , m.Addr AS '주소'
     , m.Mobile AS '연락처'
     , r.rentalIdx -- 키값은 NOT NULL->NULL 안되는데 NULL이면 무조건 OUTER JOIN!!!
     , r.rentalDate AS '대여일자'-- 빌린날짜
     , IFNULL(r.returnDate, '미반납') AS '반납일자' -- 반납날짜
--  , r.bookIdx 
-- -> r.bookidx만으로는 책목록을 모름-> 맴버테이블 bookidx 참조해야됨 ->이너조인
-- 관리자만 보면 되기에 주석처리
     , b.Names AS '책제목' 
     , d.Names AS '장르' 
-- B004가 뭔지를 모르기에 조인 한번더 해야됨->b.Division->d.Names 하면 b004->'전쟁' 출력
     , b.Price AS '금액'
  FROM membertbl AS m
  LEFT OUTER JOIN rentaltbl AS r -- membertbl 기준할거기 때문에 LEFT OUTER 조인!
	ON m.memberIdx = r.memberIdx
  LEFT OUTER JOIN bookstbl AS b
	ON r.bookIdx = b.bookIdx
  LEFT OUTER JOIN divtbl AS d
	ON b.Division = d.Division
 WHERE r.rentalIdx IS NULL; -- 책을 한번도 안빌린 사람
 
-- 책을 두권이상 출판한 저자
SELECT bb.Author, bb.Division
	 , d.Names AS '장르', bb.출판권수, bb.합계금액
  FROM (
		SELECT b.Author
			 , b.Division
			 , COUNT(b.Author) AS '출판권수' -- 함수는 대문자!
			 , SUM(b.Price) AS '합계금액'
-- count, sum은 컬럼이 아님->from으로 서브커리 하면 에러나는데 mysql은 가능
		  FROM bookstbl AS b
		 GROUP BY b.Author, b.Division
		HAVING COUNT(b.Author) >= 2
		) AS bb
 INNER JOIN divtbl AS d
	ON bb.Division = d.Division -- 조인으로 테이블 연결하고 테이블 명 장르로 변경하기!
 ORDER BY bb.출판권수 DESC; -- 내림차순 -> 출판권수 많은사람 순