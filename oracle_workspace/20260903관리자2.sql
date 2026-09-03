-- 사용자 생성
-- CREATE USER 유저명 identified by 비밀번호
CREATE USER backupuser IDENTIFIED BY back1234;
GRANT CREATE SESSION, RESOURCE TO backupuser;