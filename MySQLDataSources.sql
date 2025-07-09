USE weatherpredictionsource;

CREATE TABLE GovOffice (
    OfficeID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(20),
    Address VARCHAR(60),
    contact_number VARCHAR(20),  -- Changed to VARCHAR
    email VARCHAR(60),           -- Increased length
    headOffice VARCHAR(20),
    established_date DATE,
    workersCount INT,            -- Fixed spelling
    annualBudget DOUBLE,
    website VARCHAR(60),
    last_audit_date DATE
);

CREATE TABLE ContributedEmployee (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    Fname VARCHAR(20),
    Lname VARCHAR(20),
    Address VARCHAR(60),
    ContactNo VARCHAR(20),       -- Changed to VARCHAR
    Email VARCHAR(60),
    JoinedDate DATE,
    OfficeID INT,
    FOREIGN KEY (OfficeID) REFERENCES GovOffice(OfficeID)
);

CREATE TABLE Area (
    AreaID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(20),
    Measurements DOUBLE,
    Coordinates POINT NOT NULL,
    SPATIAL INDEX (Coordinates)  -- Corrected keyword
);

CREATE TABLE Districts (
    DistrictID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(20),
    AreaID INT,
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

CREATE TABLE Hospital (
    HospitalID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Address TEXT,
    hospital_type VARCHAR(100),  -- Renamed from 'type' (reserved word)
    postal_code VARCHAR(20),
    contact_number VARCHAR(20),
    email VARCHAR(255),
    website_url VARCHAR(255),
    number_of_doctors INT,
    number_of_nurses INT,
    number_of_icu_beds INT,
    number_of_beds INT,
    status VARCHAR(50),
    last_inspection_date DATE,
    DistrictID INT,
    AreaID INT,
    FOREIGN KEY (DistrictID) REFERENCES Districts(DistrictID),
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

CREATE TABLE AccidentPatient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    Fname VARCHAR(20),
    Lname VARCHAR(20),
    ContactName VARCHAR(20),    -- Changed to VARCHAR
    Address VARCHAR(60),
    Email VARCHAR(60),          -- Increased length
    Gender VARCHAR(20),
    ConditionOfPatient VARCHAR(20),
    Age INT,
    admittedDate DATE,          -- Fixed spelling
    DistrictID INT,
    AreaID INT,
    HospitalID INT,             -- Fixed spelling
    FOREIGN KEY (DistrictID) REFERENCES Districts(DistrictID),
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID),
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
);

CREATE TABLE Urbanization (
    UrbanizationID INT PRIMARY KEY AUTO_INCREMENT,
    WasteGeneration DOUBLE,
    LandUse DOUBLE,
    AffordableHousingUnits INT,
    PredictedHousing INT,
    MonthlyCommunityPopulation DOUBLE,
    ConductedDate DATE,
    OfficeID INT,
    EmployeeID INT,
    AreaID INT,
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID),
    FOREIGN KEY (EmployeeID) REFERENCES ContributedEmployee(EmployeeID),
    FOREIGN KEY (OfficeID) REFERENCES GovOffice(OfficeID)
);

CREATE TABLE MetrologicalConditions (
    MetrologicalID INT PRIMARY KEY AUTO_INCREMENT,
    Temperature DOUBLE,
    Humidity DOUBLE,
    Pressure DOUBLE,
    Precipitation DOUBLE,
    WindSpeed DOUBLE,
    DateRecorded DATE,
    EmployeeID INT,
    DistrictID INT,
    AreaID INT,
    FOREIGN KEY (EmployeeID) REFERENCES ContributedEmployee(EmployeeID),
    FOREIGN KEY (DistrictID) REFERENCES Districts(DistrictID),
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

CREATE TABLE PollutantData (
    PollutantID INT PRIMARY KEY AUTO_INCREMENT,
    GroundLevelOzone DOUBLE,
    PM_Value DOUBLE,
    CarbonMonoxide DOUBLE,
    SulfurDioxide DOUBLE,
    NitrogenDioxide DOUBLE,
    DateMeasured DATE,
    HealthyStatus VARCHAR(20),
    EmployeeID INT,
    DistrictID INT,
    AreaID INT,
    FOREIGN KEY (EmployeeID) REFERENCES ContributedEmployee(EmployeeID),
    FOREIGN KEY (DistrictID) REFERENCES Districts(DistrictID),
    FOREIGN KEY (AreaID) REFERENCES Area(AreaID)
);

CREATE TABLE HospitalAccidentReport (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    PrimaryCause VARCHAR(255),
    ViolationType VARCHAR(100),
    RoadFlaw VARCHAR(3) CHECK (RoadFlaw IN ('YES', 'NO')),
    VehicleProblem VARCHAR(3) CHECK (VehicleProblem IN ('YES', 'NO')),
    PatientCondition VARCHAR(3) CHECK (PatientCondition IN ('YES', 'NO')),
    DateRecorded DATE,
    HospitalID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID)
);

CREATE TABLE PatientDetails (
    IdPatientDetails INT PRIMARY KEY AUTO_INCREMENT,
    Id INT,
    PatientID INT,
    FOREIGN KEY (Id) REFERENCES HospitalAccidentReport(Id),
    FOREIGN KEY (PatientID) REFERENCES AccidentPatient(PatientID)
);

CREATE TABLE Victims (
    VictimsID INT PRIMARY KEY AUTO_INCREMENT,
    AgeGroup VARCHAR(50),
    Gender VARCHAR(50),
    Role VARCHAR(100),
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES AccidentPatient(PatientID)
);

CREATE TABLE AccidentEnv (
    EnvironmentID INT PRIMARY KEY AUTO_INCREMENT,
    Location VARCHAR(255),
    Environment VARCHAR(100),
    Lighting VARCHAR(50),
    Obstacles VARCHAR(255),
    Hazards VARCHAR(255),
    Terrain VARCHAR(100),
    DateRecorded DATETIME,
    DescriptionContent TEXT,
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES AccidentPatient(PatientID)
);
ROLLBACK;