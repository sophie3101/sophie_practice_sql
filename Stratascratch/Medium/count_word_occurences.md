Find the number of times each word appears in the contents column across all rows in the google_file_store dataset. Output two columns: word and occurrences.
https://platform.stratascratch.com/coding/9817-find-the-number-of-times-each-word-appears-in-drafts?code_type=1

solution

```
WITH cte AS 
(
select unnest(string_to_array(REGEXP_REPLACE(lower(contents), '[.,]','', 'g'), ' ')) AS word
from google_file_store
)

SELECT word, COUNT(word) as occurrences
FROM cte
GROUP BY word
ORDER BY occurrences DESC


```