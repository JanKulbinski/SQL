SET @a = '
	SELECT COUNT(DISTINCT AKTOR)
    FROM Kontrakty
    WHERE agent = ?
';

PREPARE stmtAgent FROM @a;
SET @b = 74;
EXECUTE stmtAgent USING @b; 