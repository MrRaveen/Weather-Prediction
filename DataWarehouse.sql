CREATE DATABASE weatherPredictionDataWarehouse;
USE weatherPredictionDataWarehouse;
CREATE TABLE Dim_Urbanization (
    UrbanizationKey INT PRIMARY KEY,
    LandUse INT,
    Date DATE,
    HousingUnits INT,
    PredictedHousing INT,
    MonthlyCommunityPopulation INT,
    newRoadDensity FLOAT
);
GO
CREATE TABLE Dim_metrologicalConditions (
    MetrologicallKey INT PRIMARY KEY,
    Temperature DECIMAL(5,2),
    Humidity DECIMAL(5,2),
    Pressure DECIMAL(7,2),
    Precipitation DECIMAL(5,2),
    WindSpeed DECIMAL(5,2)
);
GO
CREATE TABLE Dim_pollutant (
    ConcentrationKey INT PRIMARY KEY,
    GroundLevelOzone DECIMAL(8,4),
    PM_Value DECIMAL(8,4),
    CarbonMonoxide DECIMAL(8,4),
    SulfurDioxide DECIMAL(8,4),
    NitrogenDioxide DECIMAL(8,4)
);
GO
CREATE TABLE Dim_date (
    DateKey INT PRIMARY KEY,
    [Date] DATE NOT NULL,
    [Month] TINYINT NOT NULL CHECK ([Month] BETWEEN 1 AND 12),
    [Year] SMALLINT NOT NULL
);
GO
CREATE TABLE Fact_AirQuality_in_next_12_months (
    AirQualitySK BIGINT IDENTITY(1,1) PRIMARY KEY,
    ConcentrationKey INT NOT NULL REFERENCES Dim_pollutant(ConcentrationKey),
    DateKey INT NOT NULL REFERENCES Dim_date(DateKey),
    UrbanizationKey INT NOT NULL REFERENCES Dim_urbanization(UrbanizationKey),
    MethodologyKey INT,
    RainPrediction VARCHAR(20),
    MetrologicalKey INT REFERENCES Dim_metrologicalConditions(MetrologicallKey)
);