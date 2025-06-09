
-- Upload the csv files first. Statedeocdes and Population. It created Population_New and State_Decode tables

CREATE TABLE dataupload.default.POPULATION_NEW_1
AS 
(
SELECT *,
       population1 * (CAST(FLOOR(RAND() * (10000 - 5000 + 1)) + 5000 AS INT)) AS investment
FROM (
    SELECT *,
           try_cast(REPLACE(population, ',', '') AS BIGINT) AS population1
    FROM dataupload.default.population_new
)
)


select * from dataupload.default.population_new_1


CREATE TABLE dataupload.default.population_new_2 AS
(
  SELECT
    a.*,
    state2
  FROM
    dataupload.default.population_new_1 a
      INNER JOIN dataupload.default.state_decode
        ON trim(a.state) = trim(dataupload.default.state_decode.state)
)

create table dataupload.default.final_pop_invest as (
select sum(investment) as Total_Investment, sum(population1) as Total_Population, state2 
from dataupload.default.population_new_2
group by 3
)

select * from
dataupload.default.final_pop_invest


