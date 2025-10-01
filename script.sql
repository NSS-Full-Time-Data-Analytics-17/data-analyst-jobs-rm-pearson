-- 1. How many rows are in the data_analyst_jobs table?
SELECT 
	COUNT(*) AS count_rows
FROM data_analyst_jobs
; --1,793

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10
; -- Exxon Mobil

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT 
	location,
	COUNT(*) AS count_postings
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY')
GROUP BY location
; -- 21 in Tennessee; 27 in TN or KY

/* Alternately:
3.a.
SELECT
	COUNT(*) AS TN_postings
FROM data_analyst_jobs
WHERE location = 'TN'
;
3.b.
SELECT
	COUNT(*) AS TN_KY_postings
FROM data_analyst_jobs
WHERE location IN ('TN', 'KY')
;
*/

-- 4. How many postings in Tennessee have a star rating above 4?
SELECT 
	COUNT(*) AS TN_high_rating
FROM data_analyst_jobs
WHERE 
	star_rating > 4
	AND location = 'TN'
; --3

-- 5. How many postings in the dataset have a review count between 500 and 1000?
SELECT
	COUNT(*) AS postings_med_reviews
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000
; -- 151

-- 6. Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
SELECT
	location AS state,
	ROUND(AVG(star_rating), 2) AS avg_rating
FROM data_analyst_jobs
WHERE location IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC
; -- Nebraska has the highest average rating

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT
	COUNT(DISTINCT title) AS unique_titles
FROM data_analyst_jobs
; -- 881

-- 8. How many unique job titles are there for California companies?
SELECT
	COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location = 'CA'
; --230

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across. How many companies are there with more that 5000 reviews?
SELECT
	company,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC
;

SELECT
	COUNT(DISTINCT company) AS companies_many_reviews
FROM data_analyst_jobs
WHERE review_count > 5000
; --40 companies

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT
	company,
	AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
	AND company IS NOT NULL
GROUP BY company
ORDER BY avg_rating DESC
; -- There are several companies tied for highest rating at 4.2, including Unilever, GM, Nike, American Express, Microsoft, and Kaiser Permanente


-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
SELECT
	COUNT(DISTINCT title) AS unique_analyst_titles
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%'
; --774

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT
	title
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%' AND title NOT ILIKE '%Analytics%'
; -- 4 distinct job titles that do not contain Analyst or Analytics - they all mention Tableau specifically instead


/* **BONUS:**
You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
 - Disregard any postings where the domain is NULL.
 - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top.
 - Which industries are in the top 4?
 */

SELECT
	domain, 
	COUNT(*) AS old_postings
FROM data_analyst_jobs
WHERE 
	skill ILIKE '%SQL%'
	AND days_since_posting > 21
	AND days_since_posting IS NOT NULL
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY old_postings DESC
; -- "Internet and Software", "Banks and Financial Services", "Consulting and Business Services", and "Health Care" (Although "InsuranceHealth Care" and "Insurance" are listed separately also in the top 10)
