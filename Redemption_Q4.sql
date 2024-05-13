WITH CTE AS (
SELECT [redemptionDate], MAX([redemptionCount]) as 'Count'
FROM [learning].[dbo].[tblRedemptions-ByDay]
WHERE [retailerId] = ( SELECT id FROM [dbo].[tblRetailers] WHERE [retailerName] = 'ABC Store')
AND [redemptionDate] BETWEEN '2023-10-30' AND '2023-11-05'
GROUP BY [retailerId],[redemptionDate]),

CTE_2 AS (
SELECT [redemptionDate], Count, ROW_NUMBER() OVER (ORDER BY [redemptionDate] DESC ) AS 'Rank' FROM CTE
)

SELECT * FROM CTE_2
WHERE [Rank] = ( SELECT MIN([Rank]) FROM CTE_2) OR
[Rank] = ( SELECT MAX([Rank]) FROM CTE_2)
