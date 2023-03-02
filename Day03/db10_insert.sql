-- INSERT 삽입하는 명령어
INSERT INTO usertbl -- 테이블이름적기
(userID, name, birthYear, addr, mobile1, mobile2, height, mDate) -- 컬럼
VALUES -- mobile1은 ch(3), date도 '' 사용 
('PYH', '박영훈', 1995, '부산', '010', '11112222', 175, '2023-03-02');

-- 컬럼을 다 적을 때 입력안할 컬럼은 NULL로 지정(많이씀)
INSERT INTO usertbl
(userID, name, birthYear, addr, mobile1, mobile2, height, mDate)
VALUES 
('SHM', '손흥민', 1991, '서울', NULL, NULL, NULL, NULL); 
-- NULL도 정확히는 값(아무값도없음) 입력해야됨. 모바일1부터 null가능.

-- NULL컬럼은 생략가능
INSERT INTO usertbl 
(userID, name, birthYear, addr) 
VALUES  
('SHM', '손흥민', 1991, '서울'); 
-- NULL을 사용안할 때 컬럼을 없애면됨.(실무에선 안씀)

-- 컬럼 지정을 생략가능(단, 입력할 값의 순서가 컬럼순서와 일치해야됨)
INSERT INTO usertbl VALUES 
('SJW', '손정웅', 1969, '서울', '010', '55556666', 176, NULL); 

-- AUTO_INCREMENT 의 경우 필드값을 입력하지 않아도 됨
INSERT INTO buytbl 
(userID, prodName, groupName, price, amount)
VALUES 
('PYH', '노트북', '전자', 5000000, 1);
-- num컬럼은 AI(AUTO_INCREMENT)여서 자동증가->입력 안해도됨
-- 단, 입력할때마다 같은값이 증가하기 때문에 주의해야됨!(중복안되고 같은값증가)
-- 한번 들어간 값은 지워도 증가값은 지워지지않음
-- num 14~16지우고 추가하면 14가 아니라 17됨
