use staging;

DROP TABLE source_location;
CREATE TABLE source_location(
country VARCHAR(50),
indicator VARCHAR(50),
date VARCHAR(50),
year_week VARCHAR(50),
value VARCHAR(50),
source VARCHAR(50),
url VARCHAR(4000));

DROP TABLE source_vaccination;
CREATE TABLE source_vaccination(
YearWeekISO VARCHAR(50),
FirstDose VARCHAR(50),
FirstDoseRefused VARCHAR(50),
SecondDose VARCHAR(50),
DoseAdditional1 VARCHAR(50),
UnknownDose VARCHAR(50),
NumberDosesReceived VARCHAR(50),
NumberDosesExported VARCHAR(50),
Region VARCHAR(50),
Population VARCHAR(50),
ReportingCountry VARCHAR(50),
TargetGroup VARCHAR(50),
Vaccine VARCHAR(50),
Denominator VARCHAR(50));

DROP TABLE source_pandemic;
CREATE TABLE source_pandemic(
dateRep VARCHAR(50),
day VARCHAR(50),
month VARCHAR(50),
year VARCHAR(50),
cases VARCHAR(50),
deaths VARCHAR(50),
countriesAndTerritories VARCHAR(50),
geoId VARCHAR(50),
countryterritoryCode VARCHAR(50),
popData2020 VARCHAR(50),
continentExp VARCHAR(50));

DROP TABLE source_variant;
CREATE TABLE source_variant(
country VARCHAR(50),
country_code VARCHAR(50),
year_week VARCHAR(50),
source VARCHAR(50),
new_cases VARCHAR(50),
number_sequenced VARCHAR(50),
percent_cases_sequenced VARCHAR(50),
valid_denominator  VARCHAR(50),
variant VARCHAR(50),
number_detections_variant VARCHAR(50),
number_sequenced_known_variant VARCHAR(50),
percent_variant VARCHAR(50),
url VARCHAR(4000));


LOAD DATA INFILE 'C:\Users\LENOVO\pandemic.csv' 
INTO TABLE source_pandemic
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';