
DELIMITER //
 
CREATE PROCEDURE GetAvgPer()
BEGIN
	UPDATE MARKS set TOTAL_MARKS = (ENGLISH + HINDI_KANNADA + MATHS+ PHYSICS + CHEMISTRY + COMPUTER_BIOLOGY);
	UPDATE MARKS set PERCENTAGE = (ENGLISH + HINDI_KANNADA + MATHS+ PHYSICS + CHEMISTRY + COMPUTER_BIOLOGY) /6 ;
END //
 
DELIMITER ;







