-- 表定义
CREATE TABLE IF NOT EXISTS `daily_hit_counter`(
  `day` date NOT NULL COMMENT '时间',
  `slot` int(11) unsigned NOT NULL COMMENT '槽',
  `cnt` int(11) unsigned NOT NULL COMMENT '计数',
  PRIMARY KEY (`day`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '计数表';

CREATE TABLE `customer_dev` LIKE `customer`; -- 从现有表创建新表
