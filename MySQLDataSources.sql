USE weatherpredictionsource;
-- DIMENSION TABLES

CREATE TABLE Urbanization (
    UrbanizationID VARCHAR(50) PRIMARY KEY,
    WasteGeneration VARCHAR(100),
    Landuse VARCHAR(100),
    HousingDetails VARCHAR(100),
    PredictedHousing VARCHAR(100),
    DailyCommunityPopulation INT
);

CREATE TABLE Pollutant (
    PollutantID VARCHAR(50) PRIMARY KEY,
    GroundLevelOzone FLOAT,
    PM_Value FLOAT,
    CarbonMonoxide FLOAT,
    SulfurDioxide FLOAT,
    NitrogenDioxide FLOAT
);

CREATE TABLE MeteorologicalConditions (
    MetrologicalID VARCHAR(50) PRIMARY KEY,
    Temperature FLOAT,
    Humidity FLOAT,
    Pressure FLOAT,
    Precipitation FLOAT,
    WindSpeed FLOAT
);

CREATE TABLE Date (
    DateID VARCHAR(50) PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT
);

CREATE TABLE Location (
    LocationID VARCHAR(50) PRIMARY KEY,
    Area VARCHAR(100),
    Hospital VARCHAR(100),
    RoadName VARCHAR(100),
    Coordinates VARCHAR(100)
);

-- FACT TABLES

CREATE TABLE AirQualityMeasurement (
    MeasurementID VARCHAR(50) PRIMARY KEY,
    UrbanizationID VARCHAR(50),
    MetrologicalID VARCHAR(50),
    PollutantID VARCHAR(50),
    DateID VARCHAR(50),
    AQILevel FLOAT,
    RainPrediction VARCHAR(50),
    FOREIGN KEY (UrbanizationID) REFERENCES Urbanization(UrbanizationID),
    FOREIGN KEY (MetrologicalID) REFERENCES MeteorologicalConditions(MetrologicalID),
    FOREIGN KEY (PollutantID) REFERENCES Pollutant(PollutantID),
    FOREIGN KEY (DateID) REFERENCES Date(DateID)
);

CREATE TABLE WeatherConditions (
    WeatherID VARCHAR(50) PRIMARY KEY,
    MetrologicalID VARCHAR(50),
    DateID VARCHAR(50),
    Temperature FLOAT,
    Humidity FLOAT,
    Pressure FLOAT,
    Precipitation FLOAT,
    WeatherDescription VARCHAR(100),
    FOREIGN KEY (MetrologicalID) REFERENCES MeteorologicalConditions(MetrologicalID),
    FOREIGN KEY (DateID) REFERENCES Date(DateID)
);

-- ACCIDENT RELATED TABLES

CREATE TABLE Accident (
    AccidentID VARCHAR(50) PRIMARY KEY,
    AccidentType VARCHAR(50),
    AccidentTime DATETIME,
    LocationID VARCHAR(50),
    CauseID VARCHAR(50),
    EnvironmentID VARCHAR(50),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID),
    FOREIGN KEY (CauseID) REFERENCES Cause(CauseID),
    FOREIGN KEY (EnvironmentID) REFERENCES Environment(EnvironmentID)
);

CREATE TABLE AccidentDetails (
    DetailID VARCHAR(50) PRIMARY KEY,
    AccidentID VARCHAR(50),
    TotalVehiclesInvolved INT,
    Fatalities INT,
    Injuries INT,
    FOREIGN KEY (AccidentID) REFERENCES Accident(AccidentID)
);

CREATE TABLE Cause (
    CauseID VARCHAR(50) PRIMARY KEY,
    PrimaryCause VARCHAR(100),
    ViolationType VARCHAR(100),
    RoadFlaw BOOLEAN,
    VehicleProblem BOOLEAN
);

CREATE TABLE Environment (
    EnvironmentID VARCHAR(50) PRIMARY KEY,
    RoadLighting BOOLEAN,
    Obstacles VARCHAR(100),
    SurroundingObstacles VARCHAR(100)
);

CREATE TABLE Victim (
    VictimID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Role VARCHAR(50),
    AccidentID VARCHAR(50),
    FOREIGN KEY (AccidentID) REFERENCES Accident(AccidentID)
);

CREATE TABLE Vehicle (
    VehicleID VARCHAR(50) PRIMARY KEY,
    VehicleType VARCHAR(50),
    LicensePlate VARCHAR(20),
    AccidentID VARCHAR(50),
    FOREIGN KEY (AccidentID) REFERENCES Accident(AccidentID)
);

CREATE TABLE Patient (
    PatientID VARCHAR(50) PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    PatientCondition VARCHAR(50),
    AccidentID VARCHAR(50),
    FOREIGN KEY (AccidentID) REFERENCES Accident(AccidentID)
);
