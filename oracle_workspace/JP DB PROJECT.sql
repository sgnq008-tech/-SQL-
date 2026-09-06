-- ===================================================
-- 1. ?員テ?ブル作成 / 회원 테이블 생성 (USERS)
-- ===================================================
CREATE TABLE USERS (
    USER_ID   VARCHAR2(50) PRIMARY KEY,     -- ユ?ザ?ID / 사용자 아이디
    USER_PW   VARCHAR2(100) NOT NULL,       -- パスワ?ド / 비밀번호
    USER_NAME VARCHAR2(50) NOT NULL         -- お名前 / 사용자 이름
);

-- ===================================================
-- 2. ?示板テ?ブル作成 / 게시판 테이블 생성 (BOARD)
-- ===================================================
CREATE TABLE BOARD (
    BNO       NUMBER PRIMARY KEY,           -- 投稿番? / 글 번호
    TITLE     VARCHAR2(200) NOT NULL,       -- タイトル / 제목
    CONTENT   CLOB NOT NULL,                -- ?容 / 내용
    WRITER    VARCHAR2(50) NOT NULL,        -- 作成者ID / 작성자 아이디
    REG_DATE  DATE DEFAULT SYSDATE,         -- 作成日時 / 등록일시
    CONSTRAINT FK_BOARD_WRITER FOREIGN KEY (WRITER) 
        REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

-- ===================================================
-- 3. ?示板用シ?ケンス作成 / 게시판 번호 자동 증가 시퀀스 생성
-- ===================================================
CREATE SEQUENCE SEQ_BOARD_BNO
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- ===================================================
-- 4. テスト用初期デ?タ / 테스트용 초기 데이터 삽입
-- ===================================================
-- テストユ?ザ?登? / 테스트 유저 등록
INSERT INTO USERS (USER_ID, USER_PW, USER_NAME) 
VALUES ('admin', '1234', '管理者');

-- テスト投稿登? / 테스트 게시글 등록
INSERT INTO BOARD (BNO, TITLE, CONTENT, WRITER, REG_DATE) 
VALUES (SEQ_BOARD_BNO.NEXTVAL, '첫 번째 공지사항', '다국어 게시판 오픈 테스트입니다.', 'admin', SYSDATE);

COMMIT;