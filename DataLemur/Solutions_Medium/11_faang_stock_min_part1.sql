/*
Task:
Analyze historical stock data for FAANG stocks to find:
- The month-year ('Mon-YYYY') with the highest opening price and the highest open price for each ticker.
- The month-year with the lowest opening price and the lowest open price for each ticker.

Input:
- stock_prices table containing:
  - date (datetime): date of stock data
  - ticker (varchar): stock ticker symbol (e.g., AAPL)
  - open (decimal): opening price of the stock
  - high, low, close (decimal): daily high, low, and closing prices

Details:
- Consider only FAANG stocks: Facebook (META), Apple (AAPL), Amazon (AMZN), Netflix (NFLX), Google (GOOGL).
- Format month-year output as 'Mon-YYYY' (e.g., Jan-2023).
- Return one row per ticker with columns: ticker, highest_mth, highest_open, lowest_mth, lowest_open.
- Sort results by ticker ascending.

Example Input:
Sample data includes AAPL with various dates and prices.

Example Output:
ticker | highest_mth | highest_open | lowest_mth | lowest_open
AAPL   | May-2023    | 176.76       | Jan-2023   | 142.28
*/

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


