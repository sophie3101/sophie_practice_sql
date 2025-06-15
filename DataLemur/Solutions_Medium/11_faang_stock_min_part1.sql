with high_cte AS (
SELECT ticker, open,
      TO_CHAR(date, 'Mon-YYYY') AS timeline, 
      RANK() OVER(PARTITION BY ticker ORDER BY open DESC)
FROM stock_prices
),
low_cte AS(
SELECT ticker, open,
      TO_CHAR(date, 'Mon-YYYY') AS timeline, 
      RANK() OVER(PARTITION BY ticker ORDER BY open )
FROM stock_prices
)

SELECT high_cte.ticker, high_cte.timeline AS highest_mth, high_cte.open AS highest_open,
low_cte.timeline AS lowest_mth, low_cte.open AS lowest_open
FROM high_cte 
JOIN low_cte ON low_cte.ticker = high_cte.ticker AND low_cte.rank=1 AND high_cte.rank=1


