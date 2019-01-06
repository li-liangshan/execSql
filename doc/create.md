## MySQL表创建方式

#### 基本定义形式创建
```sql
CREATE TABLE IF NOT EXISTS `daily_hit_counter`(
  `day` date NOT NULL COMMENT '时间',
  `slot` int(11) unsigned NOT NULL COMMENT '槽',
  `cnt` int(11) unsigned NOT NULL COMMENT '计数',
  PRIMARY KEY (`day`, `slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '计数表';
```

#### 根据现有表结构创建
```sql 
CREATE TABLE `customer_dev` LIKE `customer`;
```
