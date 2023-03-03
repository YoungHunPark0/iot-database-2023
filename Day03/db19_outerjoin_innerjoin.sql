-- INNER JOIN. stdtbl, stdclubtbl에서 컬럼 stdName이름이 같기때문 j,s로 구분
SELECT s.stdName, s.addr, c.clubName, c.roomNo
  FROM stdtbl AS s
 INNER JOIN stdclubtbl AS j
    ON s.stdName = j.stdName
 INNER JOIN clubtbl AS c
    ON c.clubName = j.clubName;