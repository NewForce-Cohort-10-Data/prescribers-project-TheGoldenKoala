--BONUS
-- 1.How many npi numbers appear in the prescriber table but not in the prescription table?
SELECT npi
FROM prescriber
EXCEPT
SELECT npi
FROM prescription;

-- 2. a. Find the top five drugs (generic_name) prescribed by prescribers with the specialty of Family Practice.
SELECT generic_name, SUM(total_claim_count) AS prescribed_total
FROM prescriber
INNER JOIN prescription
USING(npi)
INNER JOIN drug
USING(drug_name)
WHERE specialty_description = 'Family Practice'
GROUP BY generic_name
ORDER BY prescribed_total DESC
LIMIT 5;
-- b. Find the top five drugs (generic_name) prescribed by prescribers with the specialty of Cardiology.
SELECT generic_name, SUM(total_claim_count) AS prescribed_total
FROM prescriber
INNER JOIN prescription
USING(npi)
INNER JOIN drug
USING(drug_name)
WHERE specialty_description = 'Cardiology'
GROUP BY generic_name
ORDER BY prescribed_total DESC
LIMIT 5;
-- c. Which drugs are in the top five prescribed by Family Practice prescribers and Cardiologists? Combine 
-- what you did for parts a and b into a single query to answer this question.

SELECT generic_name, SUM(total_claim_count) AS prescribed_total
FROM prescriber
INNER JOIN prescription
USING(npi)
INNER JOIN drug
USING(drug_name)
WHERE specialty_description = 'Family Practice'
GROUP BY generic_name
UNION ALL
SELECT generic_name, SUM(total_claim_count) AS prescribed_total
FROM prescriber
INNER JOIN prescription
USING(npi)
INNER JOIN drug
USING(drug_name)
WHERE specialty_description = 'Cardiology'
GROUP BY generic_name
ORDER BY prescribed_total DESC
LIMIT 5;
-- 3.Your goal in this question is to generate a list of the top prescribers in each of the major 
-- metropolitan areas of Tennessee. 
-- a. First, write a query that finds the top 5 prescribers in 
-- Nashville in terms of the total number of claims (total_claim_count) across all drugs. Report 
-- the npi, the total number of claims, and include a column showing the city.

SELECT npi, SUM(total_claim_count), nppes_provider_city
FROM prescription
INNER JOIN prescriber
USING (npi)
WHERE nppes_provider_city = 'NASHVILLE'
GROUP BY npi, nppes_provider_city
ORDER BY SUM(total_claim_count) DESC
LIMIT 5;

-- b. Now, report the same for Memphis.
SELECT npi, SUM(total_claim_count), nppes_provider_city
FROM prescription
INNER JOIN prescriber
USING (npi)
WHERE nppes_provider_city = 'MEMPHIS'
GROUP BY npi, nppes_provider_city
ORDER BY SUM(total_claim_count) DESC
LIMIT 5;
-- c. Combine your results from a and b, along with the results for Knoxville and Chattanooga.

SELECT npi, SUM(total_claim_count), nppes_provider_city
FROM prescription
INNER JOIN prescriber
USING (npi)
WHERE nppes_provider_city = 'NASHVILLE'
GROUP BY npi, nppes_provider_city
ORDER BY SUM(total_claim_count) DESC
LIMIT 5;

SELECT npi, SUM(total_claim_count), nppes_provider_city
FROM prescription
INNER JOIN prescriber
USING (npi)
WHERE nppes_provider_city = 'MEMPHIS'
GROUP BY npi, nppes_provider_city
ORDER BY SUM(total_claim_count) DESC
LIMIT 5;
-- 4.Find all counties which had an above-average number of overdose deaths. Report the county 
-- name and number of overdose deaths.

-- 5.a. Write a query that finds the total population of Tennessee.

-- b. Build off of the query that you wrote in part a to write a query 
-- that returns for each county that county's name, its population, and the 
-- percentage of the total population of Tennessee that is contained in that county.