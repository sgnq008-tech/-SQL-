-- ==========================================================
-- 0. ?Ёэлкл╓л╕лзлпл╚к╬▐√Ё╢ (Ї°╤в√∙)
-- ==========================================================
DROP TABLE ANIME_REVIEWS CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_REVIEW_BNO;

-- ==========================================================
-- 1. лц?л╢?л╞?л╓лы (USERS) э┬рў
-- ==========================================================
CREATE TABLE USERS (
    USER_ID   VARCHAR2(50)  PRIMARY KEY,          -- лц?л╢?ID (лэл░лдлєID)
    USER_PW   VARCHAR2(100) NOT NULL,             -- л╤л╣ля?л╔
    USER_NAME VARCHAR2(100) NOT NULL              -- лц?л╢?┘г (°·у╞┘г)
);

COMMENT ON TABLE USERS IS 'AniLog ?ъмл▐л╣л┐?л╞?л╓лы';
COMMENT ON COLUMN USERS.USER_ID IS 'лц?л╢?ID (PK)';
COMMENT ON COLUMN USERS.USER_PW IS 'лэл░лдлєл╤л╣ля?л╔';
COMMENT ON COLUMN USERS.USER_NAME IS 'лц?л╢?°·у╞┘г';

-- ==========================================================
-- 2. лвл╦лсльл╙лх?э╗╘╤єї█ул╖?л▒лєл╣ (SEQ_REVIEW_BNO) э┬рў
-- ==========================================================
CREATE SEQUENCE SEQ_REVIEW_BNO 
    START WITH 1 
    INCREMENT BY 1 
    NOCACHE 
    NOCYCLE;

-- ==========================================================
-- 3. лвл╦лсльл╙лх?л╞?л╓лы (ANIME_REVIEWS) э┬рў
-- ==========================================================
CREATE TABLE ANIME_REVIEWS (
    BNO         NUMBER         PRIMARY KEY,          -- ўс═├█у? (PK)
    ANIME_TITLE VARCHAR2(200)  NOT NULL,             -- лвл╦лсэ┬∙б┘г (╓╟: ▄╥к╬л╥?лэ?лвллл╟л▀лв, ё▒т·№▀?)
    TITLE       VARCHAR2(300)  NOT NULL,             -- льл╙лх?╠╕їєк╖ / л┐лдл╚лы
    CONTENT     CLOB           NOT NULL,             -- ╩я▀╠?льл╙лх?▄т┘■
    RATING      NUMBER(1)      DEFAULT 5 NOT NULL,   -- р°°─? (1?5я├)
    WRITER      VARCHAR2(50)   NOT NULL,             -- ўс═├э║ (USERS.USER_ID кЄ?Ё╬)
    REG_DATE    DATE           DEFAULT SYSDATE NOT NULL, -- э┬рўьэу┴
    CONSTRAINT FK_REVIEWS_WRITER FOREIGN KEY (WRITER) REFERENCES USERS(USER_ID) ON DELETE CASCADE,
    CONSTRAINT CK_REVIEWS_RATING CHECK (RATING BETWEEN 1 AND 5)
);

COMMENT ON TABLE ANIME_REVIEWS IS 'лвл╦лс╩я▀╠?°─?ўс═├л╞?л╓лы';
COMMENT ON COLUMN ANIME_REVIEWS.BNO IS 'ўс═├╬╖╫т█у? (SEQ_REVIEW_BNO╫╫щ─)';
COMMENT ON COLUMN ANIME_REVIEWS.ANIME_TITLE IS 'лвл╦лсэ┬∙бл┐лдл╚лы';
COMMENT ON COLUMN ANIME_REVIEWS.TITLE IS 'льл╙лх?к╬л┐лдл╚лы';
COMMENT ON COLUMN ANIME_REVIEWS.CONTENT IS '▀┘к╖кд╩я▀╠?═┼є╠▄т┘■';
COMMENT ON COLUMN ANIME_REVIEWS.RATING IS 'р°°─? (1я├?5я├)';
COMMENT ON COLUMN ANIME_REVIEWS.WRITER IS 'ўс═├э║ID (USERSл╞?л╓лык╬USER_ID)';
COMMENT ON COLUMN ANIME_REVIEWS.REG_DATE IS 'ўс═├ьэу┴';

-- ==========================================================
-- 4. л╞л╣л╚щ─л╡лєл╫лыл╟?л┐к╬ўсь¤ (Ї°╤вл╟?л┐)
-- ==========================================================

-- 4-1. л╞л╣л╚лц?л╢?╘Ї? (ID: test1, admin)
INSERT INTO USERS (USER_ID, USER_PW, USER_NAME) 
VALUES ('test1', '1234', '╛╓┤╧╞╥');

INSERT INTO USERS (USER_ID, USER_PW, USER_NAME) 
VALUES ('admin', '1234', '╬╖╫тэ║');

INSERT INTO USERS (USER_ID, USER_PW, USER_NAME) 
VALUES ('kenji', '1234', 'л▒лєл╕');

-- 4-2. лвл╦лсльл╙лх?л╡лєл╫лы╘Ї? (р°°─?▄їкн)
-- льл╙лх? 1: ▄╥к╬л╥?лэ?лвллл╟л▀лв (My Hero Academia)
INSERT INTO ANIME_REVIEWS (BNO, ANIME_TITLE, TITLE, CONTENT, RATING, WRITER, REG_DATE) 
VALUES (
    SEQ_REVIEW_BNO.NEXTVAL, 
    '▄╥к╬л╥?лэ?лвллл╟л▀лв', 
    'лплщлдл▐л├лпл╣к╬э┬?к╚??┘┌?км??к╟к╖к┐гб', 
    'лнлулщлпл┐?ьщь╤к╥к╚кък╬рўэ■кмя╦╥╗к╦┘┌клкьк╞кдк╞бв∙╝╙°╠╕к╞ктцЁкд?Єек┴к╦к╩кьк▐к╣бг╨╝┌сых?ктш╟█¤к╟к╖к┐бг┘■╧гк╩к╖к╬5к─р°к╟к╣гб', 
    5, 
    'kenji', 
    SYSDATE - 2
);

-- льл╙лх? 2: ё▒т·№▀? (Jujutsu Kaisen)
INSERT INTO ANIME_REVIEWS (BNO, ANIME_TITLE, TITLE, CONTENT, RATING, WRITER, REG_DATE) 
VALUES (
    SEQ_REVIEW_BNO.NEXTVAL, 
    '┴╓╝·╚╕└№ (ё▒т·№▀?)', 
    '╜├║╬╛▀ ╗ч║п ┐м├т ╣╠├╞│╫┐ф, ▓└ ║┴╛▀ ╟╒┤╧┤┘', 
    '┐°└█└╟ ╛ю╡╬┐ю ║╨└з▒т╕ж ╛╓┤╧╕▐└╠╝╟ ┐м├т░· ╢┘╛ю│н ─л╕▐╢є ┐Ў┼й╖╬ ┐╧║о╟╧░╘ ╗ь╖╚╜└┤╧┤┘. ┼█╞ў░б ╗б╢є╝н ┴Ў╖ч╟╥ ╞┤└╠ ╛°╛·╜└┤╧┤┘.', 
    5, 
    'test1', 
    SYSDATE - 1
);

-- льл╙лх? 3: ╤ж╘╤?▐═лмлєл└лр (Mobile Suit Gundam)
INSERT INTO ANIME_REVIEWS (BNO, ANIME_TITLE, TITLE, CONTENT, RATING, WRITER, REG_DATE) 
VALUES (
    SEQ_REVIEW_BNO.NEXTVAL, 
    'Mobile Suit Gundam', 
    'Great classic story and deep mechanical lore', 
    'The philosophical depth and political conflicts still hold up amazingly well today. Recommended for any true mecha fan.', 
    4, 
    'admin', 
    SYSDATE - 0.5
);

-- льл╙лх? 4: ╨б╪■к╬ь╙ (Demon Slayer)
INSERT INTO ANIME_REVIEWS (BNO, ANIME_TITLE, TITLE, CONTENT, RATING, WRITER, REG_DATE) 
VALUES (
    SEQ_REVIEW_BNO.NEXTVAL, 
    '▒═╕ъ└╟ ─о│п (╨б╪■к╬ь╙)', 
    '└█╚н┤┬ ┤ы┤▄╟╤╡е ╜║┼ф╕о░б ┴╢▒▌ ┬к╛╞╝н ╛╞╜м┐Ў┐ф', 
    '└п╞ў┼═║э ╞п└п└╟ 3D CG┐═ └╠╞х╞о ░с╟╒└║ ┐й└№╚ў ░и┼║╜║╖┤╜└┤╧┤┘╕╕, └╠╣° ▒╪└х╞╟/┐б╟╟╝╥╡х┤┬ ║╨╖о└╠ ╛р░г ┬к░╘ ┤└▓╕┴│╜└┤╧┤┘.', 
    3, 
    'test1', 
    SYSDATE
);

-- ==========================================================
-- 5. ?╠┌?щ╗к╬№мя╥ (COMMIT)
-- ==========================================================
COMMIT;

SELECT * FROM USERS;
SELECT BNO, ANIME_TITLE, TITLE, RATING, WRITER FROM ANIME_REVIEWS;