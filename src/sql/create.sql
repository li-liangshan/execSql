--数据库
CREATE DATABASE IF NOT EXISTS `db`;
USE `db`;

-- 表定义
CREATE TABLE IF NOT EXISTS `daily_hit_counter`(
  `day` date NOT NULL COMMENT '时间',
  `slot` int(11) unsigned NOT NULL COMMENT '槽',
  `cnt` int(11) unsigned NOT NULL COMMENT '计数',
  PRIMARY KEY (`day`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '计数表';

CREATE TABLE `customer_dev` LIKE `customer`; -- 从现有表创建新表

-- 表改名 -下面最好都要走一遍
RENAME TABLE `user_detail_1` TO `user_detail`;
SET NAMES 'utf8';
SHOW TABLE STATUS LIKE 'user_detail';
SHOW CREATE TABLE `user_detail`;
SET NAMES 'utf8mb4';
SELECT COUNT(1) FROM `user_detail`;

--



