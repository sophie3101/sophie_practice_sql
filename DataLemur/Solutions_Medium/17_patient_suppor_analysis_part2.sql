SELECT 

ROUND(100.0*COUNT(*)FILTER(WHERE call_category='n/a' OR call_category IS NULL)/COUNT(*),1)
FROM callers;