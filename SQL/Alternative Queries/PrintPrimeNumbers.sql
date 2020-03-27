-- modified from Kenneth Fisher's solution
--DROP TABLE #Numbers
CREATE TABLE #Numbers (primeNo BIGINT)

DECLARE @result VARCHAR(MAX)

DECLARE @counter BIGINT
SET @counter = 2

DECLARE @limit BIGINT
SET @limit = 1000

-- insert the numbers first
WHILE (@counter <= @limit)
BEGIN
    INSERT INTO #Numbers
    VALUES(@counter);

    SET @counter = @counter + 1
END

SELECT @result = REPLACE(STUFF((
	SELECT '&' + 
	CAST(primeNo AS VARCHAR(10))
	FROM #Numbers
	WHERE #Numbers.primeNo > 1 -- We only want numbers > 1
	  AND NOT EXISTS (
		SELECT 1 FROM #Numbers N2
		WHERE N2.primeNo > 1 -- We only want numbers > 1
		  -- We only need to test numbers less than the current number
		  AND #Numbers.primeNo > N2.primeNo
		  -- Check to see if there are any numbers that evenly divide in.
		  AND #Numbers.primeNo % N2.primeNo = 0
		)
	ORDER BY primeNo
	FOR XML PATH('')), 1, 5, ''), 'amp;', '');

PRINT @result