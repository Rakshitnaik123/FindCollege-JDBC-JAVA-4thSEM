use find_college_db;
DELETE  FROM LOGIN_COLLEGES;
ALTER TABLE LOGIN_COLLEGES AUTO_INCREMENT = 1;
INSERT INTO LOGIN_COLLEGES(EMAIL,PASSWRD) VALUES("atria@atria.edu","password");
INSERT INTO LOGIN_COLLEGES(EMAIL,PASSWRD) VALUES("ramaiah@ramaiah.edu","password");
INSERT INTO LOGIN_COLLEGES(EMAIL,PASSWRD) VALUES("bms@bms.edu","password");
INSERT INTO LOGIN_COLLEGES(EMAIL,PASSWRD) VALUES("rns@rns.edu","password");
INSERT INTO LOGIN_COLLEGES(EMAIL,PASSWRD) VALUES("bangalore@bangalore.edu","password");
#SELECT * from LOGIN_COLLEGES;
#'atria@atria.edu'