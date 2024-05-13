WITH redemptioncte AS (
    SELECT 
        redemptionDate,
        MAX(redemptionCount) AS mostRecentRedemptionCount
    FROM 
        `aerobic-name-423202-q3.reporting.tblRetailers` AS r
    JOIN 
        `aerobic-name-423202-q3.reporting.tblRedemptions-ByDay` AS rd
    ON 
        r.id = rd.retailerId
    WHERE 
        r.retailerName = 'ABC Store'
        AND rd.redemptionDate BETWEEN '2023-10-30' AND '2023-11-05'
    GROUP BY 
        redemptionDate
)

SELECT 
    rbd.redemptionDate,
    rbd.redemptionCount AS mostRecentRedemptionCount,
    rbd.createDateTime
FROM 
    redemptioncte AS rc
JOIN 
    `aerobic-name-423202-q3.reporting.tblRedemptions-ByDay` AS rbd
ON 
    rc.redemptionDate = rbd.redemptionDate
    AND rc.mostRecentRedemptionCount = rbd.redemptionCount
WHERE 
    rbd.redemptionCount IN (
        SELECT 
            MIN(mostRecentRedemptionCount) AS minCount
        FROM 
            redemptioncte
        UNION ALL
        SELECT 
            MAX(mostRecentRedemptionCount) AS maxCount
        FROM 
            redemptioncte
    );
