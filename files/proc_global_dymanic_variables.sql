DROP PROCEDURE IF EXISTS set_global_dynamic;
DELIMITER //
CREATE PROCEDURE set_global_dynamic(IN pvar CHAR(64), IN pval CHAR(255))
BEGIN
   CREATE TABLE IF NOT EXISTS mysql.dynamics 
      (variable CHAR(64), value CHAR(255), PRIMARY KEY (variable));
   SET @cmd = CONCAT("SET GLOBAL ", pvar, " = '", pval, "'");
   PREPARE stmt FROM @cmd;
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
   SET @cmd = '';
   REPLACE INTO mysql.dynamics VALUES (pvar, pval);
 END;
 //
 DELIMITER ;

 DROP PROCEDURE IF EXISTS load_global_dynamic;
 DELIMITER //
 CREATE PROCEDURE load_global_dynamic ()
 BEGIN
   DECLARE done INT DEFAULT 0;
   DECLARE pvar CHAR(64);
   DECLARE pval CHAR(255);
   DECLARE cur CURSOR FOR SELECT variable, value FROM mysql.dynamics;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
   DECLARE EXIT HANDLER FOR SQLSTATE '42S02' BEGIN END;

   OPEN cur;
   REPEAT
     FETCH cur INTO pvar, pval;
     SET @cmd = CONCAT("SET GLOBAL ", pvar, " = '", pval, "'");
     PREPARE stmt FROM @cmd;
     EXECUTE stmt;
     DEALLOCATE PREPARE stmt;
   UNTIL done END REPEAT;
   CLOSE cur;
 END;
//
DELIMITER ;