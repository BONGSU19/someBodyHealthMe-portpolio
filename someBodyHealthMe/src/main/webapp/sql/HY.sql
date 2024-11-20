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


    
CREATE TABLE InBody (
  InBodyID         NUMBER NOT NULL,               -- 인바디 기록 고유 코드
  MeasurementDate   DATE NOT NULL,                 -- 측정 날짜 (날짜와 시간을 저장)
  MuscleMass        NUMBER NOT NULL,               -- 근육량
  BodyFatPercentage NUMBER NOT NULL,               -- 체지방률
  CreatedAt         DATE NOT NULL,                 -- 데이터 생성 시간
  modify_date       DATE NOT NULL,                 -- 수정일
  user_num          NUMBER NOT NULL,               -- 각 사용자를 구별하는 고유 ID
  CONSTRAINT InBody_PK PRIMARY KEY (InBodyID)     -- 기본 키 제약 조건 추가
);

CREATE SEQUENCE InBodyID_seq;

ALTER TABLE InBody MODIFY MODIFY_DATE DATE NULL;


