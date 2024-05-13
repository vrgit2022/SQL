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
    redemptionDate,
    mostRecentRedemptionCount
FROM
    redemptioncte
WHERE
    mostRecentRedemptionCount = (
        SELECT
            MAX(mostRecentRedemptionCount)
        FROM
            redemptioncte
    );
