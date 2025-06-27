-- Problem:
-- Given two tables: `pages` and `page_likes`, find the Facebook pages that have zero likes.

-- Requirements:
-- - Output should contain only the page IDs of pages with zero likes.
-- - The result should be sorted in ascending order by page ID.

-- Tables:
-- 1. pages
--    - page_id: INTEGER
--    - page_name: VARCHAR
-- 
-- 2. page_likes
--    - user_id: INTEGER
--    - page_id: INTEGER
--    - liked_date: DATETIME
--Solution 1
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT distinct page_id FROM page_likes)
ORDER BY page_id DESC

--Solution 2

SELECT page_id
FROM pages
WHERE NOT EXISTS (
  SELECT page_id
  FROM page_likes AS likes
  WHERE likes.page_id = pages.page_id
)
order by page_id;