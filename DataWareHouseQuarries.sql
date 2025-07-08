ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER weatherAdmin IDENTIFIED BY 123;
GRANT CONNECT, RESOURCE, CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE TO weatherAdmin;
ALTER USER weatherAdmin QUOTA UNLIMITED ON USERS;
CREATE TABLE Dim_Urbanization (
    UrbanizationKey NUMBER PRIMARY KEY,
    WasteGeneration VARCHAR2(100),
    LandUse VARCHAR2(100),
    HousingDetails VARCHAR2(100),
    PredictedHousing VARCHAR2(100),
    DailyCommunityPopulation NUMBER
);

CREATE TABLE Dim_metrologicalConditions (
    MetrologicalKey NUMBER PRIMARY KEY,
    Temperature NUMBER,
    Humidity NUMBER,
    Pressure NUMBER,
    Precipitation NUMBER,
    WindSpeed NUMBER
);

CREATE TABLE Dim_pollutant (
    ConcentrationKey NUMBER PRIMARY KEY,
    GroundLevelOzone NUMBER,
    PM_Value NUMBER,
    CarbonMonoxide NUMBER,
    SulfurDioxide NUMBER,
    NitrogenDioxide NUMBER
);

CREATE TABLE Dim_date (
    DateKey NUMBER PRIMARY KEY,  -- YYYYMMDD
    Year NUMBER,
    Month NUMBER,
    FullDate DATE
);

CREATE TABLE Dim_PatientDimension (
    PatientID NUMBER PRIMARY KEY,
    AccidentID NUMBER,  -- FK to Fact_roadAccidentsIn2025
    Name VARCHAR2(100),
    Age NUMBER,
    Gender VARCHAR2(10),
    Condition VARCHAR2(50),
    LocationID NUMBER
);

CREATE TABLE Dim_CauseDimension (
    CauseID NUMBER PRIMARY KEY,
    AccidentID NUMBER,  -- FK to Fact_roadAccidentsIn2025
    PrimaryCause VARCHAR2(100),
    ViolationType VARCHAR2(100),
    RoadFlaw VARCHAR2(3),  -- YES/NO
    VehicleProblem VARCHAR2(3)  -- YES/NO
);

CREATE TABLE Dim_environment (
    EnvironmentID NUMBER PRIMARY KEY,
    AccidentID NUMBER,  -- FK to Fact_roadAccidentsIn2025
    RoadLighting VARCHAR2(3),  -- YES/NO
    Obstacles VARCHAR2(100),
    SurroundingObstacles VARCHAR2(100)
);

CREATE TABLE Dim_Victims (
    VictimID NUMBER PRIMARY KEY,
    AccidentID NUMBER,  -- FK to Fact_roadAccidentsIn2025
    AgeGroup VARCHAR2(50),
    Gender VARCHAR2(10),
    Role VARCHAR2(50)
);

CREATE TABLE Dim_Location (
    LocationID NUMBER PRIMARY KEY,
    AccidentID NUMBER,  -- FK to Fact_roadAccidentsIn2025
    Area VARCHAR2(100),
    Hospital VARCHAR2(100),
    RoadName VARCHAR2(100),
    Coordinates VARCHAR2(100)
);

ROLLBACK;
-- FACT TABLES (drop these first to avoid FK constraint errors)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Fact_roadAccidentsIn2025 CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Fact_AirQuality_in_next_12_months CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- DIMENSION TABLES
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_Urbanization CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_metrologicalConditions CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_pollutant CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_date CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_PatientDimension CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_CauseDimension CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_environment CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_Victims CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Dim_Location CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/
