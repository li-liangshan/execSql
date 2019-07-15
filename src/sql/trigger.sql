-- trigger schema definition:
CREATE
    [DEFINER = user]
    TRIGGER trigger_name
    trigger_time trigger_event
    ON tbl_name FOR EACH ROW
    [trigger_order]
    trigger_body

trigger_time: { BEFORE | AFTER }

trigger_event: { INSERT | UPDATE | DELETE }

trigger_order: { FOLLOWS | PRECEDES } other_trigger_name

-- A potentially confusing example of this is the INSERT INTO ... ON DUPLICATE KEY UPDATE ... syntax: a BEFORE INSERT trigger
-- activates for every row, followed by either an AFTER INSERT trigger or both the BEFORE UPDATE and AFTER UPDATE triggers,
-- depending on whether there was a duplicate key for the row.

-- To affect trigger order, specify a trigger_order clause that indicates FOLLOWS or PRECEDES and the name of an existing
-- trigger that also has the same trigger event and action time. With FOLLOWS, the new trigger activates after the
-- existing trigger. With PRECEDES, the new trigger activates before the existing trigger.

-- example:
CREATE TABLE `account` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
	`acct_num` int(11) DEFAULT NULL COMMENT '实际acct数',
	`amount` DECIMAL(20, 6) DEFAULT NULL COMMENT '数量',
	`created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	`updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	PRIMARY KEY(`id`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TRIGGER ins_sum BEFORE INSERT ON account FOR EACH ROW SET @sum=@sum + NEW.amount;

SET @sum = 0;
INSERT INTO account VALUES(137,14.98),(141,1937.50),(97,-100.00);
SELECT @sum AS 'Total amount inserted';

DROP TRIGGER test.ins_sum;

CREATE TRIGGER ins_transaction BEFORE INSERT ON account
  FOR EACH ROW PRECEDES ins_sum
  SET @deposits = @deposits + IF(NEW.amount>0,NEW.amount,0), @withdrawals = @withdrawals + IF(NEW.amount<0,-NEW.amount,0);

-- trigger update OLD | NEW:
-- Within the trigger body, you can refer to columns in the subject table (the table associated with the trigger) by
-- using the aliases OLD and NEW. OLD.col_name refers to a column of an existing row before it is updated or deleted.
-- NEW.col_name refers to the column of a new row to be inserted or an existing row after it is updated.
delimiter //
CREATE TRIGGER upd_check BEFORE UPDATE ON account
FOR EACH ROW
BEGIN
     IF NEW.amount < 0 THEN SET NEW.amount = 0;
     ELSEIF NEW.amount > 100 THEN SET NEW.amount = 100;
     END IF;
END;//
delimiter ;

--
CREATE TABLE test1(a1 INT);
CREATE TABLE test2(a2 INT);
CREATE TABLE test3(a3 INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
CREATE TABLE test4(a4 INT NOT NULL AUTO_INCREMENT PRIMARY KEY, b4 INT DEFAULT 0);

delimiter |

CREATE TRIGGER test_ref BEFORE INSERT ON test1
  FOR EACH ROW
  BEGIN
    INSERT INTO test2 SET a2 = NEW.a1;
    DELETE FROM test3 WHERE a3 = NEW.a1;
    UPDATE test4 SET b4 = b4 + 1 WHERE a4 = NEW.a1;
  END;
|

delimiter ;

INSERT INTO test3 (a3) VALUES
  (NULL), (NULL), (NULL), (NULL), (NULL),
  (NULL), (NULL), (NULL), (NULL), (NULL);

INSERT INTO test4 (a4) VALUES (0), (0), (0), (0), (0), (0), (0), (0), (0), (0);
