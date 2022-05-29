truncate table dwh.virus;

INSERT INTO dwh.virus
SELECT 
    @a:=@a + 1 v_id,
    variant AS name,
    NULL AS family,
    NULL AS indicator_rate,
    percent_variant AS type
FROM
    staging.source_variant,
    (SELECT @a:=0) AS a;

truncate table dwh.location;

INSERT INTO dwh.location
SELECT 
    @a:=@a + 1 l_id,
    countriesAndTerritories AS country,
    countryterritoryCode AS region,
    popData2020 AS population
FROM
    staging.source_pandemic,
    (SELECT @a:=0) AS a;

truncate table dwh.time;

INSERT INTO dwh.time
SELECT 
    @a:=@a + 1 t_id,
    year AS year,
    month AS month,
    day AS date,
    dateRep AS start_date
FROM
    staging.source_pandemic,
    (SELECT @a:=0) AS a;

truncate table dwh.vaccination;
INSERT into dwh.vaccination
SELECT 
    vac_id,
    t_id,
    l_id,
    trg_id,
    NumberDosesReceived AS doses_received,
    FirstDose AS first_dose,
    SecondDose AS second_dose,
    DoseAdditional1 AS third_dose
FROM
    staging.source_vaccination AS sv,
    dwh.vaccine AS dv,
    staging.source_location AS l,
    dwh.time t,
    dwh.location dl,
    staging.source_pandemic AS p,
    dwh.target_group as g
WHERE
    sv.Vaccine = dv.name
        AND sv.YearWeekISO = l.year_week
        AND p.dateRep = t.start_date
        AND CONCAT(p.year, '-', p.month, '-', p.day) = l.date
        AND dl.country = p.countriesAndTerritories
        AND dl.region = p.countryterritoryCode
        AND g.age_range = sv.TargetGroup
        AND l_id = 1 limit 10000;

truncate table dwh.pandemic;
INSERT into dwh.pandemic
SELECT distinct
   cases AS current_cases,
   cases AS new_cases,
   cases-deaths AS recovered,
   deaths AS deaths,
   l_id,
   t_id,
   v_id
FROM
    staging.source_pandemic AS sp,
    dwh.virus AS v ,
    dwh.time AS t,
    dwh.location AS dl,
    staging.source_variant as sv
WHERE
      sp.dateRep = t.start_date
     AND CONCAT(sp.year, '-', sp.month, '-', sp.day) = CONCAT(t.year, '-', t.month, '-', t.date)
	 AND dl.country = sp.countriesAndTerritories
         AND dl.region = sp.countryterritoryCode
         AND sv.variant = v.name
         AND sp.geoId = sv.country_code
         AND l_id = 1 limit 10000
;

CREATE INDEX idx_pandemic_l_t_id
ON dwh.pandemic (l_id,t_id);

CREATE INDEX idx_vaccination_l_t_id
ON dwh.vaccination (l_id,t_id);