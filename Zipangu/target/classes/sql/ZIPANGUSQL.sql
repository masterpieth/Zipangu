DROP TABLE MEMBER;
DROP TABLE RESUME;
DROP TABLE QUALIFIED;
DROP TABLE CAREER;
DROP TABLE INTERVIEW;
DROP TABLE INTERVIEW_RESULT;
DROP TABLE QUESTION;
DROP TABLE SCHEDULE;
DROP TABLE RECEIVED_MSG;
DROP TABLE SENDER_MSG;
DROP TABLE PERSONALITY;
DROP TABLE COMPANY;

DROP SEQUENCE RESUME_SEQ;
DROP SEQUENCE INTERVIEW_SEQ;
DROP SEQUENCE QUESTION_SEQ;
DROP SEQUENCE COMPANY_SEQ;

CREATE SEQUENCE RESUME_SEQ;
CREATE SEQUENCE INTERVIEW_SEQ;
CREATE SEQUENCE QUESTION_SEQ;
CREATE SEQUENCE COMPANY_SEQ;

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
    WHY VARCHAR2(2000),
    HOBBYNSKILL VARCHAR2(2000),
    INTRODUCE VARCHAR2(2000),
    PICFILENAME VARCHAR2(200),
    TITLE VARCHAR2(1000),
    INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    CORRECTEDDATE TIMESTAMP DEFAULT SYSTIMESTAMP
    );

CREATE TABLE QUALIFIED(
    RESUME_NUM NUMBER REFERENCES RESUME(RESUME_NUM),
    PERIOD DATE,
    CONTENT VARCHAR2(1000));

CREATE TABLE CAREER(
    RESUME_NUM NUMBER REFERENCES RESUME(RESUME_NUM),
    START_PERIOD DATE,
    END_PERIOD DATE,
    CONTENT VARCHAR2(1000));

CREATE TABLE INTERVIEW(
    INTERVIEW_NUM NUMBER PRIMARY KEY,
    USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
    INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP);

CREATE TABLE QUESTION(
    QUESTION_NUM NUMBER PRIMARY KEY,
    QUESTION_TEXT VARCHAR2(200));

CREATE TABLE INTERVIEW_RESULT(
    INTERVIEW_NUM NUMBER REFERENCES INTERVIEW(INTERVIEW_NUM),
    QUESTION_NUM NUMBER REFERENCES QUESTION(QUESTION_NUM),
    VOICEFILENAME VARCHAR2(200),
    RESULT VARCHAR2(100));
    
CREATE TABLE SCHEDULE(
    MENTORID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    MENTEEID VARCHAR2(100) REFERENCES MEMBER(USERID),
    RESERVEDATE DATE NOT NULL);

CREATE TABLE RECEIVED_MSG(
    USERID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    SENDERID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    TITLE VARCHAR2(1000),
    TEXT VARCHAR2(2000));

CREATE TABLE SENDER_MSG(
    USERID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    RECEIVEDID VARCHAR2(100) REFERENCES MEMBER(USERID) NOT NULL,
    INPUTDATE TIMESTAMP DEFAULT SYSTIMESTAMP,
    TITLE VARCHAR2(1000),
    TEXT VARCHAR2(2000));
    
CREATE TABLE PERSONALITY(
    USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
    TRAIT VARCHAR2(50),
    RATE NUMBER);

CREATE TABLE COMPANY(
    COMPANY_NUM NUMBER PRIMARY KEY,
    TYPE VARCHAR2(4000),
    LOCATION VARCHAR2(4000),
    CONTACT VARCHAR2(4000),
    URL VARCHAR2(100),
    TEXT CLOB);

CREATE TABLE COMPANY_RESULT(
    COMPANY_NUM NUMBER REFERENCES COMPANY(COMPANY_NUM),
    USERID VARCHAR2(100) REFERENCES MEMBER(USERID),
    RESULTDATE TIMESTAMP DEFAULT SYSTIMESTAMP
    );

CREATE TABLE WEIGHT_TBL(
    TYPE_NO NUMBER,
    TYPE VARCHAR2(4000),
    KEY VARCHAR2(100),
    VALUE NUMBER);