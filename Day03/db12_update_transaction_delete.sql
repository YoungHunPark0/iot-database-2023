-- UPDATE & TRANSACTION 
START TRANSACTION;
-- 트랜잭션을 안하면 UPDATE, DELETE 쓸 때 뭔가 잘못되었을 때 되돌릴 수 없음.

-- 경고! UPDATE 구문에는 WHERE절 빼면 안됨!!
-- WHERE절 생략하면 테이블 전체행의 내용이 변경됨
UPDATE usertbl_bak
   SET mobile1 = '100'
     , mobile2 = '66667788'
     , addr = '부산' -- UPDATD 문에 WHERE절 안쓰면 14개 행이 전부 부산,010,667788이됨
 WHERE userID = 'PYH';
 -- INSERT문은 잘못된건 지우면 됨. 하지만 UPDATE는 큰일남 조심!
-- -------------------
COMMIT;
ROLLBACK;

-- DELETE
-- WHERE절이 빠지면 
DELETE FROM usertbl_bak
WHERE userID = 'HGS';