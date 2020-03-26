SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor)
FROM
(
    SELECT 
        ROW_NUMBER() OVER(PARTITION BY Occupation ORDER BY Name ASC) AS "rowNo",
        CASE WHEN Occupation = 'Doctor' THEN ISNULL(Name, 'NULL') END Doctor,
        CASE WHEN Occupation = 'Professor' THEN ISNULL(Name, 'NULL') END Professor,
        CASE WHEN Occupation = 'Singer' THEN ISNULL(Name, 'NULL') END Singer,
        CASE WHEN Occupation = 'Actor' THEN ISNULL(Name, 'NULL') END Actor
    FROM OCCUPATIONS
) t
GROUP BY rowNo;