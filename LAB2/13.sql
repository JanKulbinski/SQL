DELIMITER $$

CREATE TRIGGER after_filmy_delete AFTER DELETE ON filmy
FOR EACH ROW
BEGIN

DELETE 
FROM zagrali 
WHERE OLD.aktor_id = z.aktor_id;

END; $$

DELIMITER ;
