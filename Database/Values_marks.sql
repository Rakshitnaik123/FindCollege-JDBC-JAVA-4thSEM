use find_college_db;
DELETE  FROM MARKS;
ALTER TABLE MARKS AUTO_INCREMENT = 1;
INSERT INTO MARKS(ENGLISH,HINDI_KANNADA,MATHS,PHYSICS,CHEMISTRY,COMPUTER_BIOLOGY) VALUES(60,40,60,80,75,66);
INSERT INTO MARKS(ENGLISH,HINDI_KANNADA,MATHS,PHYSICS,CHEMISTRY,COMPUTER_BIOLOGY) VALUES(67,47,80,89,55,86);
INSERT INTO MARKS(ENGLISH,HINDI_KANNADA,MATHS,PHYSICS,CHEMISTRY,COMPUTER_BIOLOGY) VALUES(45,76,90,68,86,66);
#SELECT (ENGLISH + HINDI_KANNADA + MATHS+ PHYSICS + CHEMISTRY + COMPUTER_BIOLOGY) /6 FROM MARKS;
#UPDATE MARKS set TOTAL_MARKS = (ENGLISH + HINDI_KANNADA + MATHS+ PHYSICS + CHEMISTRY + COMPUTER_BIOLOGY) ;
#UPDATE MARKS set PERCENTAGE = (ENGLISH + HINDI_KANNADA + MATHS+ PHYSICS + CHEMISTRY + COMPUTER_BIOLOGY) /6 ;
#SELECT * FROM MARKS;

#SELECT m.PERCENTAGE
#FROM students s, MARKS m
#WHERE s.STUDENT_ID = m.STUDENT_ID AND
#	s.EMAIL ="rakshitnaik79@gmail.com";
    
#SELECT c.COLLEGE_ID
#FROM colleges c, students s, MARKS m
#WHERE s.STUDENT_ID = m.STUDENT_ID AND
#	s.EMAIL ="rakshitnaik79@gmail.com" AND
#    m.PERCENTAGE >= c.MIN_PERCENTAGE;

#SELECT c.COLLEGE_ID, c.CNAME, c.MIN_PERCENTAGE, c.FEES, c.LOCATION, c.CONTACT, c.EMAIL, c.WEBSITE, l.PASSWRD FROM colleges c, students s, MARKS m, LOGIN_COLLEGES l WHERE s.STUDENT_ID = m.STUDENT_ID AND s.EMAIL ="rakshitnaik79@gmail.com" AND m.PERCENTAGE >= c.MIN_PERCENTAGE GROUP BY c.COLLEGE_ID;

#SELECT c.COLLEGE_ID, c.CNAME, c.MIN_PERCENTAGE, c.FEES, c.LOCATION, c.CONTACT, c.EMAIL, c.WEBSITE FROM colleges c, students s, MARKS m WHERE s.STUDENT_ID = m.STUDENT_ID AND s.EMAIL ="rakshitnaik79@gmail.com" AND m.PERCENTAGE >= c.MIN_PERCENTAGE;

#SELECT c.COLLEGE_ID, c.CNAME, c.MIN_PERCENTAGE, c.FEES, c.LOCATION, c.CONTACT, c.EMAIL, c.WEBSITE  FROM colleges c, students s, MARKS m WHERE s.STUDENT_ID = m.STUDENT_ID AND s.EMAIL ="rakshitnaik79@gmail.com" AND m.PERCENTAGE >= c.MIN_PERCENTAGE;
