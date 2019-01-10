-----------------------------------------------------------------------------------------------------------------------
----------------------------------------------    MySQL       -----------------------------------------
-----------------------------------------------------------------------------------------------------------------------
-- 表改名 -下面最好都要走一遍
RENAME TABLE `user_detail_1` TO `user_detail`;
SET NAMES 'utf8';
SHOW TABLE STATUS LIKE 'user_detail';
SHOW CREATE TABLE `user_detail`;
SET NAMES 'utf8mb4';
SELECT COUNT(1) FROM `user_detail`;

--修改表字段类型
ALTER TABLE `date_sync_produce_qc_record` CHANGE `qc_task_code` `qc_task_code` BIGINT(10) UNSIGNED ZEROFILL NOT NULL COMMENT '质检任务编号';
SET NAMES 'utf8';
SHOW CREATE TABLE `date_sync_produce_qc_record`;
SET NAMES 'utf8mb4';
SHOW INDEX FROM `date_sync_produce_qc_record`;
SET NAMES 'utf8';
SHOW TABLE STATUS LIKE 'date_sync_produce_qc_record';
SET NAMES 'utf8mb4';
ALTER TABLE `date_sync_produce_qc_record` CHANGE `qc_task_code` `qc_task_code` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '质检任务编号';
SET NAMES 'utf8';
SHOW CREATE TABLE `date_sync_produce_qc_record`;
SET NAMES 'utf8mb4';
SHOW INDEX FROM `date_sync_produce_qc_record`;
SET NAMES 'utf8';
SHOW TABLE STATUS LIKE 'date_sync_produce_qc_record';
SET NAMES 'utf8mb4';

--
ALTER TABLE table_name MODIFY col1 VARCHAR(50) CHARACTER SET utf8mb4;



