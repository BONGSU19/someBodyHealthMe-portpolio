-- 테이블 생성
CREATE TABLE Healthinfo (
    HealthInfoID NUMBER NOT NULL,
    Height NUMBER(5, 2) NOT NULL,
    Weight NUMBER(5, 2) NOT NULL,
    Age NUMBER(3) NOT NULL,
    BMI NUMBER(5, 2) NOT NULL,
    Goal VARCHAR2(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    CreatedAt DATE NOT NULL,
    ModifyDate DATE NULL,
    user_num NUMBER NOT NULL,
    CONSTRAINT Healthinfo_PK PRIMARY KEY (HealthInfoID)
);

-- 시퀀스 생성 (HealthInfoID 자동 증가)
CREATE SEQUENCE Healthinfo_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;