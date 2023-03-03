USE tabledb;

CREATE TABLE TBL1(
	ID INT NOT NULL PRIMARY KEY,
    bridge INT NULL,
    contents VARCHAR(5000)
);

-- sqldb DB의 usertbl 데이터 중에서
-- userID, name, birthYear, addr만 가져와서
-- tabledb.usertbl에 부어 넣은것
INSERT INTO tabledb.usertbl
SELECT userID, name, birthYear, addr
  FROM sqldb.usertbl; -- sqldb에 있는 usertbl에 있는 데이터를 들고오겠다
  
SELECT * FROM usertbl WHERE name = '김범수';