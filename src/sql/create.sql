--数据库
CREATE DATABASE IF NOT EXISTS `db`;
USE `db`;

CREATE DATABASE db_name DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8;
ALTER DATABASE db_name DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8;

-- 表定义
CREATE TABLE IF NOT EXISTS `daily_hit_counter`(
  `day` date NOT NULL COMMENT '时间',
  `slot` int(11) unsigned NOT NULL COMMENT '槽',
  `cnt` int(11) unsigned NOT NULL COMMENT '计数',
  PRIMARY KEY (`day`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '计数表';

CREATE TABLE `customer_dev` LIKE `customer`; -- 从现有表创建新表

