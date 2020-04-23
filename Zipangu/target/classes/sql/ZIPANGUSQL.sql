DROP SEQUENCE RESUME_SEQ;
DROP SEQUENCE INTERVIEW_SEQ;
DROP SEQUENCE QUESTION_SEQ;
DROP SEQUENCE COMPANY_SEQ;
DROP SEQUENCE TIMELINE_SEQ;

DROP TABLE REPLY;
DROP TABLE BOARD;
DROP TABLE GUESTBOOK;

DROP TABLE ENTRYSHEET;
DROP TABLE COMPANY_RESULT;
DROP TABLE COMPANY;
DROP TABLE PERSONALITY;
DROP TABLE SENDER_MSG;
DROP TABLE RECEIVED_MSG;
DROP TABLE SCHEDULE;
DROP TABLE INTERVIEW_RESULT;
DROP TABLE QUESTION;
DROP TABLE INTERVIEW;
DROP TABLE CAREER;
DROP TABLE QUALIFIED;
DROP TABLE RESUME_MEMBER;
DROP TABLE RESUME;
DROP TABLE TIMELINE;
DROP TABLE LIST_MSG;
DROP TABLE LIST_MSG_USER_ADMIN;
DROP TABLE MEMBER;

CREATE SEQUENCE RESUME_SEQ;
CREATE SEQUENCE INTERVIEW_SEQ;
CREATE SEQUENCE QUESTION_SEQ;
CREATE SEQUENCE COMPANY_SEQ;
CREATE SEQUENCE TIMELINE_SEQ;

CREATE TABLE MEMBER(
	USERID VARCHAR2(100) PRIMARY KEY,
	USERPWD VARCHAR2(100) NOT NULL,
	EMAIL VARCHAR2(100) NOT NULL,
	USERNAME VARCHAR2(50) NOT NULL,
	BIRTH DATE NOT NULL,
	ADDRESS VARCHAR2(200) NOT NULL,
	PHONE VARCHAR2(50) NOT NULL,
	SEX VARCHAR2(10) NOT NULL,
	AUTHORITY NUMBER DEFAULT 2,
	TEXTFILENAME VARCHAR2(200),
	SIGNUPDATE TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE RESUME(
	RESUME_NUM NUMBER PRIMARY KEY,
	USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
	HOBBYNSKILL VARCHAR2(2000),
	INTRODUCE VARCHAR2(2000),
	PICFILENAME VARCHAR2(200),
	TITLE VARCHAR2(1000),
	INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	CORRECTEDDATE TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE RESUME_MEMBER(
	RESUME_NUM NUMBER REFERENCES RESUME(RESUME_NUM),
	EMAIL VARCHAR2(100) NOT NULL,
	USERNAME VARCHAR2(50) NOT NULL,
	BIRTH DATE NOT NULL,
	ADDRESS VARCHAR2(200) NOT NULL,
	PHONE VARCHAR2(50) NOT NULL,
	SEX VARCHAR2(10) NOT NULL
);

CREATE TABLE QUALIFIED(
	RESUME_NUM NUMBER REFERENCES RESUME(RESUME_NUM),
	PERIOD DATE,
	CONTENT VARCHAR2(1000)
);

CREATE TABLE CAREER(
	RESUME_NUM NUMBER REFERENCES RESUME(RESUME_NUM),
	START_PERIOD DATE,
	END_PERIOD DATE,
	CONTENT VARCHAR2(1000)
);

CREATE TABLE INTERVIEW(
	INTERVIEW_NUM NUMBER PRIMARY KEY,
	USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
	INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE QUESTION(
	QUESTION_NUM NUMBER PRIMARY KEY,
	QUESTION_TEXT VARCHAR2(200)
);

CREATE TABLE INTERVIEW_RESULT(
	INTERVIEW_NUM NUMBER REFERENCES INTERVIEW(INTERVIEW_NUM),
	QUESTION_NUM NUMBER REFERENCES QUESTION(QUESTION_NUM),
	VOICEFILENAME VARCHAR2(200),
	RESULT VARCHAR2(100)
);
    
CREATE TABLE SCHEDULE(
	MENTORID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
	MENTEEID VARCHAR2(100) REFERENCES MEMBER(USERID),
	RESERVEDATE DATE NOT NULL
);

CREATE TABLE RECEIVED_MSG(
	USERID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
	SENDERID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
	INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	TITLE VARCHAR2(1000),
	TEXT VARCHAR2(2000)
);

CREATE TABLE SENDER_MSG(
	USERID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
	RECEIVEDID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
	INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP,
	TITLE VARCHAR2(1000),
	TEXT VARCHAR2(2000)
);

CREATE TABLE LIST_MSG_USER_ADMIN(
    userID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    admin VARCHAR2(10) DEFAULT 'admin',
    msg_num VARCHAR2(100) NOT NULL,
    PRIMARY KEY (userID)
);

CREATE TABLE LIST_MSG(
    mentor_id  VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    mentee_id  VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    msg_num VARCHAR2(100) NOT NULL,
    PRIMARY KEY (mentor_id, mentee_id)
);

CREATE TABLE PERSONALITY(
	USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
	TRAIT VARCHAR2(50),
	RATE NUMBER
);
CREATE TABLE TIMELINE(
    TIMELINE_NUM NUMBER PRIMARY KEY,
    USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
    TRAITS_SELECTED VARCHAR2(2000),
    EPISODE_TITLE VARCHAR2(200),
    EPISODE_CONTENT VARCHAR2(2000),
    START_DATE DATE,
    FINISH_DATE DATE
);

--PYTHON SERVER COM
CREATE TABLE COMPANY(
    COMPANY_NUM NUMBER PRIMARY KEY,
    TYPE VARCHAR2(4000),
    LOCATION VARCHAR2(4000),
    CONTACT VARCHAR2(4000),
    TEXT CLOB
);

--PYTHON SERVER COM
CREATE TABLE ENTRYSHEET(
    ENTRYSHEET_NUM NUMBER PRIMARY KEY,
    JOBTYPE VARCHAR2(1000),
    COMSIZE VARCHAR2(1000),
    COMLOCATION VARCHAR2(1000),
    QUALIFICATION VARCHAR2(4000),
    HOBBYNSKILL CLOB,
    STUDY CLOB,
    PR CLOB,
    ABSORPTION CLOB,
    ADVICE CLOB
    FEATURES CLOB
);

--CLIENT COM
CREATE TABLE COMPANY_RESULT(
    COMPANY_NUM NUMBER PRIMARY KEY,
    USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
    CONAME VARCHAR2(4000),
    TYPE VARCHAR2(4000),
    LOCATION VARCHAR2(4000),
    CONTACT VARCHAR2(4000)
);

INSERT INTO MEMBER VALUES('Administrator', '12345678', 'zipangu@zipangu', '관리자', '1970-01-01', '서울 모동', '010-1234-5678', '남성', 0, null, DEFAULT);
INSERT INTO MEMBER VALUES('Mentor1', '12345678', 'zipangu@zipangu', '일멘토', '1980-02-02', '서울 모동', '010-1234-5678', '남성', 1, null, DEFAULT);
INSERT INTO MEMBER VALUES('Mentor2', '12345678', 'zipangu@zipangu', '이멘토', '1981-04-10', '서울 모동', '010-1234-5678', '여성', 1, null, DEFAULT);
INSERT INTO MEMBER VALUES('Mentor3', '12345678', 'zipangu@zipangu', '삼멘토', '1982-12-31', '서울 모동', '010-1234-5678', '남성', 1, null, DEFAULT);
INSERT INTO MEMBER VALUES('Mentee1', '12345678', 'zipangu@zipangu', '일멘티', '1990-03-03', '서울 모동', '010-1234-5678', '여성', DEFAULT, null, DEFAULT);
INSERT INTO MEMBER VALUES('Mentee2', '12345678', 'zipangu@zipangu', '이멘티', '1991-05-16', '서울 모동', '010-1234-5678', '남성', DEFAULT, null, DEFAULT);
INSERT INTO MEMBER VALUES('Mentee3', '12345678', 'zipangu@zipangu', '삼멘티', '1992-08-21', '서울 모동', '010-1234-5678', '여성', DEFAULT, null, DEFAULT);

INSERT INTO SCHEDULE VALUES('Mentor1', 'Mentee1', '2020-04-20');
INSERT INTO SCHEDULE VALUES('Mentor1', null, '2020-04-22');
INSERT INTO SCHEDULE VALUES('Mentor1', null, '2020-04-24');
INSERT INTO SCHEDULE VALUES('Mentor1', null, '2020-04-28');
INSERT INTO SCHEDULE VALUES('Mentor1', 'Mentee2', '2020-04-29');
INSERT INTO SCHEDULE VALUES('Mentor1', null, '2020-05-01');
INSERT INTO SCHEDULE VALUES('Mentor1', null, '2020-05-04');
INSERT INTO SCHEDULE VALUES('Mentor1', null, '2020-05-06');
INSERT INTO SCHEDULE VALUES('Mentor1', 'Mentee3', '2020-05-08');
INSERT INTO SCHEDULE VALUES('Mentor2', 'Mentee2', '2020-04-21');
INSERT INTO SCHEDULE VALUES('Mentor2', null, '2020-04-23');
INSERT INTO SCHEDULE VALUES('Mentor2', null, '2020-04-25');
INSERT INTO SCHEDULE VALUES('Mentor2', null, '2020-04-28');
INSERT INTO SCHEDULE VALUES('Mentor2', 'Mentee3', '2020-04-30');
INSERT INTO SCHEDULE VALUES('Mentor2', null, '2020-05-02');
INSERT INTO SCHEDULE VALUES('Mentor2', null, '2020-05-05');
INSERT INTO SCHEDULE VALUES('Mentor2', null, '2020-05-07');
INSERT INTO SCHEDULE VALUES('Mentor2', 'Mentee1', '2020-05-09');
INSERT INTO SCHEDULE VALUES('Mentor3', 'Mentee3', '2020-04-19');
INSERT INTO SCHEDULE VALUES('Mentor3', null, '2020-04-20');
INSERT INTO SCHEDULE VALUES('Mentor3', null, '2020-04-21');
INSERT INTO SCHEDULE VALUES('Mentor3', null, '2020-04-26');
INSERT INTO SCHEDULE VALUES('Mentor3', 'Mentee1', '2020-04-27');
INSERT INTO SCHEDULE VALUES('Mentor3', null, '2020-04-28');
INSERT INTO SCHEDULE VALUES('Mentor3', null, '2020-05-03');
INSERT INTO SCHEDULE VALUES('Mentor3', null, '2020-05-04');
INSERT INTO SCHEDULE VALUES('Mentor3', 'Mentee2', '2020-05-05');

INSERT INTO RESUME VALUES(resume_seq.NEXTVAL, 'Mentee3', '취미, 특기', '자기소개', null, '이력서1', '2020-04-27', DEFAULT);
INSERT INTO RESUME VALUES(resume_seq.NEXTVAL, 'Mentee3', '취미, 특기', '자기소개', null, '이력서2', '2020-04-28', DEFAULT);
INSERT INTO RESUME VALUES(resume_seq.NEXTVAL, 'Mentee3', '취미, 특기', '자기소개', null, '이력서3', '2020-04-29', DEFAULT);

INSERT INTO RESUME_MEMBER VALUES(1, 'zipangu@zipangu', '삼멘티', '1995-08-21', '서울 모동', '010-1234-5678', '여성');
INSERT INTO RESUME_MEMBER VALUES(2, 'zipangu@zipangu', '삼멘티', '1995-08-21', '서울 모동', '010-1234-5678', '여성');
INSERT INTO RESUME_MEMBER VALUES(3, 'zipangu@zipangu', '삼멘티', '1995-08-21', '서울 모동', '010-1234-5678', '여성');

INSERT INTO CAREER VALUES(3, '1998-03-02', '2004-02-13', '학력1');
INSERT INTO CAREER VALUES(3, '2005-04-05', '2008-12-25', '경력1');

INSERT INTO QUALIFIED VALUES(3, '2009-08-15', '면허1');
INSERT INTO QUALIFIED VALUES(3, '2015-10-05', '자격1');

COMMIT;