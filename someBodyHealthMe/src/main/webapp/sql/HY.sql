CREATE TABLE Healthinfo (
    HealthInfoID NUMBER NOT NULL COMMENT '건강 정보 고유 코드, PK',
    Height NUMBER(5, 2) NOT NULL COMMENT '키 (단위: cm)',
    Weight NUMBER(5, 2) NOT NULL COMMENT '몸무게 (단위: kg)',
    Age NUMBER(3) NOT NULL COMMENT '사용자 나이 데이터',
    BMI NUMBER(5, 2) NOT NULL COMMENT '사용자 BMI 지수 데이터',
    Goal VARCHAR2(50) NOT NULL COMMENT '운동 목표 (다이어트, 벌크업, 유지 등)',
    Gender CHAR(1) NOT NULL COMMENT '성별 (M: 남성, F: 여성)',
    CreatedAt DATE NOT NULL COMMENT '데이터 생성 시간',
    ModifyDate DATE NULL COMMENT '수정일',
    user_num NUMBER NOT NULL COMMENT '각 사용자를 구별하는 고유 ID',
    CONSTRAINT Healthinfo_PK PRIMARY KEY (HealthInfoID)
) COMMENT '건강 정보 테이블';

