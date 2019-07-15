SELECT `org_id`, `qc_config_id`, COUNT(`check_item_id`) AS `count` FROM `qc_check_item_config` GROUP BY `org_id`, `qc_config_id`;

SELECT `qc_check_item`.`org_id` AS `org_id`, COUNT(`qc_check_item`.`id`) AS `check_item_count`,
`organization`.`name` AS `name` FROM `qc_check_item`
JOIN `user`.`organization` ON  `qc_check_item`.`org_id` = `organization`.`id` GROUP BY `org_id`, `name`;

SELECT `org_id`, AVG(`count`) as `avg_count`, MAX(`count`), MIN(`count`) FROM (
	SELECT `org_id`, `qc_config_id`, COUNT(check_item_id) AS `count` FROM `qc_check_item_config` GROUP BY `org_id`, `qc_config_id`
) AS A GROUP BY `org_id`;



SELECT `B`.`org_id`, `C`.`name`,`C`.`code`, `C`.`check_item_count` , `B`.`avg_count`, `B`.`max_count`, `B`.`min_count`
FROM (SELECT `org_id` , AVG(`count`) as `avg_count`, MAX(`count`) as `max_count`, MIN(`count`) as `min_count`
FROM (
SELECT `org_id`, `qc_config_id`, COUNT(check_item_id) AS `count`
FROM `qc_check_item_config` GROUP BY `org_id`, `qc_config_id`
) AS A GROUP BY `org_id`) AS B JOIN (
SELECT `qc_check_item`.`org_id` AS `org_id`, COUNT(`qc_check_item`.`id`) AS `check_item_count`,
`organization`.`name` AS `name`, `organization`.`code` AS `code`
FROM `qc_check_item` JOIN `user`.`organization` ON  `qc_check_item`.`org_id` = `organization`.`id`
GROUP BY `org_id`, `name`
) AS C ON `B`.`org_id` = `C`.`org_id`;

---
SELECT `C`.`org_id`, `C`.`name`,`C`.`code`, `C`.`check_item_count` , `B`.`avg_count`, `B`.`max_count`, `B`.`min_count`
FROM (
SELECT `organization`.`id` AS `org_id`, COUNT(`qc_check_item`.`id`) AS `check_item_count`, `organization`.`name` AS `name`, `organization`.`code` AS `code` FROM `qc_check_item` RIGHT JOIN `user`.`organization` ON  `qc_check_item`.`org_id` = `organization`.`id` GROUP BY `org_id`, `name`, `code`
) AS C LEFT JOIN (
SELECT `org_id` , AVG(`count`) as `avg_count`, MAX(`count`) as `max_count`, MIN(`count`) as `min_count` FROM (SELECT `org_id`, `qc_config_id`, COUNT(check_item_id) AS `count` FROM `qc_check_item_config` GROUP BY `org_id`, `qc_config_id`) AS A GROUP BY `org_id`
) AS B ON `B`.`org_id` = `C`.`org_id` ORDER BY `C`.`org_id`;


CREATE TABLE `organization_qc` (
  `org_id` bigint(20) NOT NULL,
  `name` char(64) NOT NULL,
  `code` char(10) NOT NULL,
  `check_item_count` int(11) DEFAULT NULL,
  `avg_count` decimal(20,6) DEFAULT NULL,
  `max_count` decimal(20,6) DEFAULT NULL,
  `min_count` decimal(20,6) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工厂质检使用数据';
