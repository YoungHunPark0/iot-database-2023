CREATE DATABASE tabledb;

USE tabledb;

CREATE TABLE usertbl (
	userID CHAR(8) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr VARCHAR(10) -- 마지막에 , 하면 에러남 조심!
);

CREATE TABLE buytbl (
	num INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userID CHAR(8) NOT NULL,
	prodName VARCHAR(10) NOT NULL,
    price INT,
    FOREIGN KEY(userID) REFERENCES usertbl(userID)
);