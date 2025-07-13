USE weatherpredictionsource;

CREATE TABLE govoffice (
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

-- Insert Query 1
INSERT INTO govoffice (Name, Address, contact_number, email, headOffice, established_date, workersCount, annualBudget, website, last_audit_date)
VALUES ('Tax Department', '123 Main St, Anytown', '0112345678', 'info@taxdept.gov', 'Colombo', '1950-01-15', 500, 150000000.00, 'www.taxdept.gov', '2024-03-10');
-- Insert Query 2
INSERT INTO govoffice (Name, Address, contact_number, email, headOffice, established_date, workersCount, annualBudget, website, last_audit_date)
VALUES ('Education Ministry', '456 School Rd, Cityville', '0118765432', 'contact@moe.gov', 'Kandy', '1948-07-20', 1200, 300000000.00, 'www.moe.gov', '2023-11-25');

-- Insert Query 3
INSERT INTO govoffice (Name, Address, contact_number, email, headOffice, established_date, workersCount, annualBudget, website, last_audit_date)
VALUES ('Health Services', '789 Hospital Ave, Villageton', '0115551234', 'admin@health.gov', 'Galle', '1960-03-01', 800, 200000000.00, 'www.health.gov', '2024-01-05');

-- Insert Query 4
INSERT INTO govoffice (Name, Address, contact_number, email, headOffice, established_date, workersCount, annualBudget, website, last_audit_date)
VALUES ('Public Works Dept', '101 Bridge St, Townsville', '0117778899', 'pwc@publicworks.gov', 'Jaffna', '1975-09-10', 350, 80000000.00, 'www.publicworks.gov', '2023-09-18');

-- Insert Query 5
INSERT INTO govoffice (Name, Address, contact_number, email, headOffice, established_date, workersCount, annualBudget, website, last_audit_date)
VALUES ('Social Welfare', '202 Charity Ln, Metroburg', '0119990000', 'support@socialwelfare.gov', 'Colombo', '1982-06-05', 600, 100000000.00, 'www.socialwelfare.gov', '2024-02-29');

select user();




INSERT INTO ContributedEmployee (Fname, Lname, Address, ContactNo, Email, JoinedDate, OfficeID) VALUES
('Kamal', 'Perera', '10 Galle Rd, Colombo 03', '0771234567', 'kamal.p@healthmin.gov.lk', '2010-05-20', 1),
('Nimali', 'Silva', '25 Temple St, Kandy', '0719876543', 'nimali.s@uda.gov.lk', '2015-08-12', 2),
('Sunil', 'Fernando', '30 Beach Rd, Galle', '0765432109', 'sunil.f@meteo.gov.lk', '2018-01-01', 3),
('Priya', 'Bandara', '50 Hill St, Colombo 07', '0701122334', 'priya.b@healthmin.gov.lk', '2020-03-15', 1);

--
-- Data for table `Area`
-- (Using ST_GeomFromText for POINT data type)
--

INSERT INTO Area (Name, Measurements, Coordinates) VALUES
('Colombo City', 37.3, ST_GeomFromText('POINT(6.9271 79.8612)')),
('Kandy Lake Area', 15.5, ST_GeomFromText('POINT(7.2906 80.6337)')),
('Galle Fort', 5.2, ST_GeomFromText('POINT(6.0329 80.2168)')),
('Mount Lavinia Beach', 10.1, ST_GeomFromText('POINT(6.8333 79.8667)'));

--
-- Data for table `Districts`
-- (Assuming AreaIDs 1, 2, 3, 4 exist from Area inserts)
--

INSERT INTO Districts (Name, AreaID) VALUES
('Colombo', 1),
('Kandy', 2),
('Galle', 3),
('Kalutara', 4);

--
-- Data for table `Hospital`
-- (Assuming DistrictIDs 1, 2, 3 and AreaIDs 1, 2, 3, 4 exist)
--

INSERT INTO Hospital (Name, Address, hospital_type, postal_code, contact_number, email, website_url, number_of_doctors, number_of_nurses, number_of_icu_beds, number_of_beds, status, last_inspection_date, DistrictID, AreaID) VALUES
('National Hospital Colombo', 'Ward Place, Colombo 07', 'General', '00700', '0112691111', 'info@nhcolombo.lk', 'www.nhcolombo.lk', 500, 1200, 50, 2000, 'Operational', '2024-04-01', 1, 1),
('Peradeniya Teaching Hospital', 'Peradeniya, Kandy', 'Teaching', '20400', '0812388000', 'info@pth.lk', 'www.pth.lk', 300, 800, 30, 1500, 'Operational', '2023-10-25', 2, 2),
('Karapitiya Teaching Hospital', 'Karapitiya, Galle', 'Teaching', '80000', '0912232232', 'info@kth.lk', 'www.kth.lk', 250, 700, 25, 1200, 'Operational', '2024-03-10', 3, 3),
('Kalubowila Teaching Hospital', 'Kalubowila, Dehiwala', 'Teaching', '10350', '0112765432', 'info@kthospital.lk', 'www.kthospital.lk', 180, 500, 15, 800, 'Operational', '2024-02-05', 1, 4);

--
-- Data for table `AccidentPatient`
-- (Assuming DistrictIDs 1, 2, 3, AreaIDs 1, 2, 3, 4 and HospitalIDs 1, 2, 3, 4 exist)
--

INSERT INTO AccidentPatient (Fname, Lname, ContactName, Address, Email, Gender, ConditionOfPatient, Age, admittedDate, DistrictID, AreaID, HospitalID) VALUES
('Amara', 'Kumari', 'Sunil Perera', '15 Flower Rd, Colombo 07', 'amara.k@example.com', 'Female', 'Stable', 35, '2024-06-01', 1, 1, 1),
('Bimal', 'Rajapaksha', 'Nimal Fernando', '20 Palm Ave, Kandy', 'bimal.r@example.com', 'Male', 'Critical', 50, '2024-06-05', 2, 2, 2),
('Chathuri', 'De Silva', 'Kamal Siriwardena', '5 Galle Rd, Galle', 'chathuri.ds@example.com', 'Female', 'Serious', 28, '2024-06-10', 3, 3, 3),
('Dinesh', 'Gunawardana', 'Priya Somapala', '10 School Ave, Mount Lavinia', 'dinesh.g@example.com', 'Male', 'Stable', 42, '2024-06-12', 1, 4, 4);

--
-- Data for table `Urbanization`
-- (Assuming OfficeIDs 1, 2, EmployeeIDs 1, 2, 4 and AreaIDs 1, 2, 4 exist)
--

INSERT INTO Urbanization (WasteGeneration, LandUse, AffordableHousingUnits, PredictedHousing, MonthlyCommunityPopulation, ConductedDate, OfficeID, EmployeeID, AreaID) VALUES
(1500.50, 250.75, 100, 120, 50000.00, '2024-05-10', 2, 2, 1),
(800.20, 150.30, 50, 60, 25000.00, '2024-04-20', 2, 2, 2),
(1200.00, 200.00, 80, 90, 40000.00, '2024-05-01', 1, 4, 4);

--
-- Data for table `MetrologicalConditions`
-- (Assuming EmployeeIDs 1, 3, 4, DistrictIDs 1, 2, 3, AreaIDs 1, 2, 3, 4 exist)
--

INSERT INTO MetrologicalConditions (Temperature, Humidity, Pressure, Precipitation, WindSpeed, DateRecorded, EmployeeID, DistrictID, AreaID) VALUES
(28.5, 85.2, 1012.5, 5.3, 15.0, '2024-06-15', 3, 1, 1),
(25.0, 90.0, 1010.0, 10.0, 10.5, '2024-06-16', 3, 2, 2),
(30.1, 78.5, 1015.2, 0.0, 20.1, '2024-06-17', 3, 3, 3),
(27.0, 88.0, 1013.0, 2.5, 12.0, '2024-06-18', 3, 1, 4);

--
-- Data for table `PollutantData`
-- (Assuming EmployeeIDs 1, 3, 4, DistrictIDs 1, 2, 3, AreaIDs 1, 2, 3, 4 exist)
--

INSERT INTO PollutantData (GroundLevelOzone, PM_Value, CarbonMonoxide, SulfurDioxide, NitrogenDioxide, DateMeasured, HealthyStatus, EmployeeID, DistrictID, AreaID) VALUES
(45.2, 25.1, 1.2, 0.5, 10.3, '2024-06-15', 'Good', 1, 1, 1),
(60.1, 40.5, 2.5, 1.0, 15.0, '2024-06-16', 'Moderate', 1, 2, 2),
(30.0, 15.0, 0.8, 0.2, 5.5, '2024-06-17', 'Good', 1, 3, 3),
(75.5, 55.0, 3.0, 1.5, 20.0, '2024-06-18', 'Unhealthy', 1, 1, 4);

--
-- Data for table `HospitalAccidentReport`
-- (Assuming HospitalIDs 1, 2, 3, 4 exist)
--

INSERT INTO HospitalAccidentReport (PrimaryCause, ViolationType, RoadFlaw, VehicleProblem, PatientCondition, DateRecorded, HospitalID) VALUES
('Driver Negligence', 'Speeding', 'NO', 'NO', 'YES', '2024-06-01', 1),
('Road Condition', 'Pothole', 'YES', 'NO', 'YES', '2024-06-05', 2),
('Vehicle Malfunction', 'Brake Failure', 'NO', 'YES', 'YES', '2024-06-10', 3),
('Pedestrian Error', 'Jaywalking', 'NO', 'NO', 'YES', '2024-06-12', 4);

--
-- Data for table `PatientDetails`
-- (Assuming HospitalAccidentReport IDs 1, 2, 3, 4 and AccidentPatient IDs 1, 2, 3, 4 exist)
--

INSERT INTO PatientDetails (Id, PatientID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

--
-- Data for table `Victims`
-- (Assuming AccidentPatient IDs 1, 2, 3, 4 exist)
--

INSERT INTO Victims (AgeGroup, Gender, Role, PatientID) VALUES
('30-40', 'Female', 'Driver', 1),
('50-60', 'Male', 'Passenger', 2),
('20-30', 'Female', 'Pedestrian', 3),
('40-50', 'Male', 'Cyclist', 4);

--
-- Data for table `AccidentEnv`
-- (Assuming AccidentPatient IDs 1, 2, 3, 4 exist)
--

INSERT INTO AccidentEnv (Location, Environment, Lighting, Obstacles, Hazards, Terrain, DateRecorded, DescriptionContent, PatientID) VALUES
('Galle Road, Colombo', 'Urban', 'Daylight', 'None', 'Heavy Traffic', 'Flat', '2024-06-01 10:30:00', 'Accident occurred near a busy intersection during peak hours.', 1),
('Kandy-Colombo Road', 'Rural', 'Daylight', 'Pothole', 'Slippery Road', 'Hilly', '2024-06-05 14:00:00', 'Vehicle lost control due to a large pothole on a winding road.', 2),
('Main Street, Galle', 'Urban', 'Night', 'Parked Cars', 'Poor Visibility', 'Flat', '2024-06-10 20:15:00', 'Pedestrian hit by a car in low visibility conditions.', 3),
('Marine Drive, Mount Lavinia', 'Coastal', 'Daylight', 'None', 'Strong Winds', 'Flat', '2024-06-12 11:45:00', 'Cyclist fell due to a sudden gust of wind near the beach.', 4);
