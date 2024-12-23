-- This query shows a list of the daily top Google Search terms.
SELECT
   t1.refresh_date ,
   t1.term,
   t1.country_name,
   t2.refresh_date ,
   t2.term,
   t2.country_name,
   t2.score,
   t1.rank,
   t2.rank
FROM `bigquery-public-data.google_trends.international_top_terms` AS t1
JOIN `bigquery-public-data.google_trends.international_top_rising_terms` AS t2 ON t1.country_name = t2.country_name

WHERE
   t1.rank = 3 
       -- Choose only the top term each day.
   AND t1.refresh_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 4 WEEK)
       -- Filter to the last 2 weeks.
    AND
    t1.country_name="United Kingdom"
GROUP BY t1.refresh_date, t1.term, t1.rank , t1.country_name,t2.rank,t2.country_name , t2.refresh_date , t2.term , t2.score
ORDER BY t1.refresh_date DESC;
   -- Show the days in reverse chronological order.

