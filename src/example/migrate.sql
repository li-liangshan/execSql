SELECT * FROM `qc_check_item_config` WHERE org_id = 193 AND `qc_config_id` IN (
	SELECT `id` FROM qc_config WHERE `org_id` = 193 AND `ref_id` = -1
);
SELECT * FROM qc_config WHERE `org_id` = 193 AND `ref_id` = -1;

-- 创建质检方案
CREATE TABLE qc_config_bk LIKE `qc_config`;
-- 创建质检项
CREATE TABLE qc_check_item_bk LIKE `qc_check_item`;
-- 创建质检方案标准
CREATE TABLE `qc_check_item_config_bk` LIKE `qc_check_item_config`;
-- 创建质检项分类
CREATE TABLE `qc_check_item_group_bk` LIKE `qc_check_item_group`;

-- 导入质检方案数据
INSERT INTO qc_config_bk( `old_id`, `org_id`, `ref_id`, `parent_id`, `code`, `name`, `check_type`, `check_count_type`, `record_type`, `check_count`,
        `auto_create_qc_task`,`scrap_inspection`, `task_create_type`, `task_create_interval`, `task_create_count`,
        `attachments`, `node_code`,
        `record_check_item_type`, `record_sample_result_type`, `check_entity_type`, `check_entity_unit_count`, `check_entity_unit_unit`)
 SELECT `id`, `org_id`, `ref_id`, `parent_id`, `code`, `name`, `check_type`, `check_count_type`, `record_type`, `check_count`,
        `auto_create_qc_task`,`scrap_inspection`, `task_create_type`, `task_create_interval`, `task_create_count`,
        `attachments`, `node_code`,
        `record_check_item_type`, `record_sample_result_type`, `check_entity_type`, `check_entity_unit_count`, `check_entity_unit_unit`
 FROM qc_config WHERE `org_id` = 193 AND `ref_id` = -1;

-- 更新org_id
UPDATE qc_config_bk SET org_id = 162;

-- 导入质检项
INSERT INTO qc_check_item_bk( `old_id`,`org_id`, `code`, `name`, `desc`, `spell`, `group_id`, `method`, `standard`)
SELECT `id`, `org_id`, `code`, `name`, `desc`, `spell`, `group_id`, `method`, `standard` FROM qc_check_item WHERE `org_id` = 193;
-- 更新org_id
UPDATE qc_check_item_bk SET org_id = 162;

-- 导入质检标准
INSERT INTO qc_check_item_config_bk( `old_id`,`org_id`,`qc_config_id`,`check_item_id`,`logic`,`max`,`min`,`base`,`unit_id`,`desc`,`seq`,`method`,`standard`)
SELECT `id`,`org_id`,`qc_config_id`,`check_item_id`,`logic`,`max`,`min`,`base`,`unit_id`,`desc`,`seq`,`method`,`standard` FROM qc_check_item_config
WHERE `org_id` = 193 AND `qc_config_id` IN (SELECT `id` FROM qc_config WHERE `org_id` = 193 AND `ref_id` = -1);;

-- 更新org_id
UPDATE qc_check_item_config_bk SET org_id = 162;

-- 导入质检项分类
INSERT INTO qc_check_item_group_bk( `old_id`,`org_id`, `name`)
SELECT `id`, `org_id`, `name` FROM qc_check_item_group WHERE `org_id` = 193;

-- 更新org_id
UPDATE qc_check_item_group_bk SET org_id = 162;

-- 更新最大的ID
UPDATE `qc_config_bk` SET id = id + (SELECT MAX(`id`) FROM qc_config);
UPDATE `qc_check_item_bk` SET id = id + (SELECT MAX(`id`) FROM qc_check_item);
UPDATE `qc_check_item_config_bk` SET id = id + (SELECT MAX(`id`) FROM qc_check_item_config);
UPDATE `qc_check_item_group_bk` SET id = id + (SELECT MAX(`id`) FROM qc_check_item_group);


-- 更新现有的关联关系ID
SELECT * FROM `qc_check_item_bk` INNER JOIN `qc_check_item_group_bk` ON `qc_check_item_bk`.`group_id` = `qc_check_item_group_bk`.`old_id`;
UPDATE `qc_check_item_bk` INNER JOIN `qc_check_item_group_bk` ON `qc_check_item_bk`.`group_id` = `qc_check_item_group_bk`.`old_id` SET `group_id` = `qc_check_item_group_bk`.`id`;
SELECT * FROM `qc_check_item_bk` INNER JOIN `qc_check_item_group_bk` ON `qc_check_item_bk`.`group_id` = `qc_check_item_group_bk`.`id`;

-- 更新现有的关联关系ID
SELECT * FROM `qc_check_item_config_bk` INNER JOIN `qc_config_bk` ON `qc_check_item_config_bk`.`qc_config_id` = `qc_config_bk`.`old_id`;
UPDATE `qc_check_item_config_bk` INNER JOIN `qc_config_bk` ON `qc_check_item_config_bk`.`qc_config_id` = `qc_config_bk`.`old_id` SET `qc_config_id` = `qc_config_bk`.`id`;
SELECT * FROM `qc_check_item_config_bk` INNER JOIN `qc_config_bk` ON `qc_check_item_config_bk`.`qc_config_id` = `qc_config_bk`.`id`;

-- 更新现有的关联关系ID
SELECT * FROM `qc_check_item_config_bk` INNER JOIN `qc_check_item_bk` ON `qc_check_item_config_bk`.`check_item_id` = `qc_check_item_bk`.`old_id`;
UPDATE `qc_check_item_config_bk` INNER JOIN `qc_check_item_bk` ON `qc_check_item_config_bk`.`check_item_id` = `qc_check_item_bk`.`old_id` SET `check_item_id` = `qc_check_item_bk`.`id`;
SELECT * FROM `qc_check_item_config_bk` INNER JOIN `qc_check_item_bk` ON `qc_check_item_config_bk`.`check_item_id` = `qc_check_item_bk`.`id`;

-- 更新现有的关联关系
UPDATE qc_check_item_config_bk SET unit_id = null;

-------------------------------------------------------------------------------------------------
-- 导入前备份
-- 创建质检方案
CREATE TABLE qc_config_bk_1 LIKE `qc_config`;
INSERT INTO qc_config_bk_1 SELECT * FROM `qc_config`;
-- 创建质检项
CREATE TABLE qc_check_item_bk_1 LIKE `qc_check_item`;
INSERT INTO qc_check_item_bk_1 SELECT * FROM  `qc_check_item`;
-- 创建质检方案标准
CREATE TABLE qc_check_item_config_bk_1 LIKE `qc_check_item_config`;
INSERT INTO qc_check_item_config_bk_1 SELECT * FROM  `qc_check_item_config`;
-- 创建质检项分类
CREATE TABLE qc_check_item_group_bk_1 LIKE `qc_check_item_group`;
INSERT INTO qc_check_item_group_bk_1 SELECT * FROM  `qc_check_item_group`;

-------------------------------------------------------------------------------------------------

-- 插入新数据 qc_config
INSERT INTO qc_config( `id`, `org_id`, `ref_id`, `parent_id`, `code`, `name`, `check_type`, `check_count_type`, `record_type`, `check_count`,
        `auto_create_qc_task`,`scrap_inspection`, `task_create_type`, `task_create_interval`, `task_create_count`,
        `attachments`, `node_code`,
        `record_check_item_type`, `record_sample_result_type`, `check_entity_type`, `check_entity_unit_count`, `check_entity_unit_unit`)
 SELECT `id`, `org_id`, `ref_id`, `parent_id`, `code`, `name`, `check_type`, `check_count_type`, `record_type`, `check_count`,
        `auto_create_qc_task`,`scrap_inspection`, `task_create_type`, `task_create_interval`, `task_create_count`,
        `attachments`, `node_code`,
        `record_check_item_type`, `record_sample_result_type`, `check_entity_type`, `check_entity_unit_count`, `check_entity_unit_unit`
 FROM qc_config_bk;

-- 插入新数据qc_check_item
INSERT INTO qc_check_item( `id`,`org_id`, `code`, `name`, `desc`, `spell`, `group_id`, `method`, `standard`)
SELECT `id`, `org_id`, `code`, `name`, `desc`, `spell`, `group_id`, `method`, `standard` FROM qc_check_item_bk;

-- 插入新数据 qc_check_item_config
INSERT INTO qc_check_item_config( `id`,`org_id`,`qc_config_id`,`check_item_id`,`logic`,`max`,`min`,`base`,`unit_id`,`desc`,`seq`,`method`,`standard`)
SELECT `id`,`org_id`,`qc_config_id`,`check_item_id`,`logic`,`max`,`min`,`base`,`unit_id`,`desc`,`seq`,`method`,`standard` FROM qc_check_item_config_bk;

-- 插入新数据 qc_check_item_group
INSERT INTO qc_check_item_group( `id`,`org_id`, `name`) SELECT `id`, `org_id`, `name` FROM qc_check_item_group_bk;


