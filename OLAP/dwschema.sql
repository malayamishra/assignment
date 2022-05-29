DROP TABLE virus;
CREATE TABLE virus(
v_id VARCHAR(50) NOT NULL,
name VARCHAR(50),
family VARCHAR(50),
type VARCHAR(50),
indicator_rate VARCHAR(50),
PRIMARY KEY (v_id));

DROP TABLE location;
CREATE TABLE location(
l_id VARCHAR(50) NOT NULL,
country VARCHAR(50) NOT NULL,
region VARCHAR(50),
population VARCHAR(50),
PRIMARY KEY (l_id));

DROP TABLE time;
CREATE TABLE time(
t_id VARCHAR(50) NOT NULL,
year VARCHAR(50) NOT NULL,
month VARCHAR(50),
date VARCHAR(50),
start_date VARCHAR(50),
PRIMARY KEY (t_id));


DROP TABLE vaccine;
CREATE TABLE vaccine(
vac_id VARCHAR(50) NOT NULL,
name VARCHAR(50) NOT NULL,
PRIMARY KEY (vac_id));

DROP TABLE target_group;
CREATE TABLE target_group(
trg_id VARCHAR(50) NOT NULL,
age_range VARCHAR(50) NOT NULL,
PRIMARY KEY (trg_id));

DROP TABLE pandemic;
CREATE TABLE pandemic(
current_cases VARCHAR(50) NOT NULL,
new_cases VARCHAR(50),
recovered VARCHAR(50),
deaths VARCHAR(50),
l_id VARCHAR(50)  REFERENCES location(l_id),
t_id VARCHAR(50)  REFERENCES time(t_id),
v_id VARCHAR(50)  REFERENCES vaccine(v_id));


DROP TABLE vaccination;
CREATE TABLE vaccination(
doses_received VARCHAR(50) NOT NULL,
first_dose VARCHAR(50),
second_dose VARCHAR(50),
third_dose VARCHAR(50),
vac_id VARCHAR(50)  REFERENCES vaccine(vac_id),
t_id VARCHAR(50)  REFERENCES time (t_id),
l_id VARCHAR(50)  REFERENCES location(l_id),
trg_id VARCHAR(50)  REFERENCES target_group(trg_id));

DROP TABLE icu;
CREATE TABLE icu(
indicator VARCHAR(50) NOT NULL,
source VARCHAR(50),
icu_cases VARCHAR(50),
third_dose VARCHAR(50),
t_id VARCHAR(50)  REFERENCES time (t_id),
l_id VARCHAR(50)  REFERENCES location (l_id));
