/* OUTER JOIN*/
-- stdtbl 테이블
CREATE TABLE stdtbl (
	stdName NVARCHAR(10) NOT NULL PRIMARY KEY,
    addr	NCHAR(4) NOT NULL
); 
-- clubtbl 테이블 - 클럽정보, 방번호
CREATE TABLE clubtbl (
	clubName NVARCHAR(10) NOT NULL PRIMARY KEY,
    roomNo NCHAR(4) NOT NULL
);
-- 학생 중 클럽에 가입한 정보
CREATE TABLE stdclubtbl( 
	num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- AUTO_INCREMENT 자동증가. PRIMARY KEY 반드시 not null 들어가야함
    stdName NVARCHAR(10) NOT NULL,
    clubName NVARCHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdName), -- references 참조하다
    FOREIGN KEY(clubName) REFERENCES clubtbl(clubName) 
);