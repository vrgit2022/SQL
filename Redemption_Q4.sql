WITH CTE AS (
  SELECT
    redemptionDate,
    MAX(redemptionCount) as redemptionCount
  FROM `aerobic-name-423202-q3.reporting.tblRedemptions-ByDay`
  WHERE retailerId = (SELECT id FROM `aerobic-name-423202-q3.reporting.tblRetailers` WHERE retailerName = 'ABC Store')
    AND redemptionDate BETWEEN '2023-10-30' AND '2023-11-05'
  GROUP BY redemptionDate
),
CTE_2 AS (
  SELECT
    redemptionDate,
    redemptionCount,
    ROW_NUMBER() OVER (ORDER BY redemptionCount DESC) AS Rank
  FROM CTE
)

SELECT
  redemptionDate,
  redemptionCount
FROM CTE_2
WHERE Rank = (SELECT MIN(Rank) FROM CTE_2) OR Rank = (SELECT MAX(Rank) FROM CTE_2)
ORDER BY redemptionCount ASC;
