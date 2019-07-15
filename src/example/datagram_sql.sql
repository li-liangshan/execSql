SELECT * FROM
(

SELECT id, org_id, m_bom_id, seq, node_code, process_code,  IFNULL(`input_materials`, '[]') as `input_materials`, `output_material` FROM `mbom_node` WHERE (id, `seq`) IN (SELECT min(`seq`) AS `seq`, min(id) as id FROM mbom_node where org_id=127 GROUP BY org_id, m_bom_id ) and org_id=127
UNION ALL
SELECT
A.id, A.org_id, A.m_bom_id, A.seq, A.node_code, A.process_code,JSON_MERGE(IFNULL(A.`input_materials`, '[]'), B.`output_material`) AS `input_materials`, A.`output_material`
FROM (
SELECT * FROM (select (@rowNO := @rowNO+1) AS row_no, a.* from (SELECT *  FROM mbom_node ORDER BY m_bom_id ASC , `seq` ASC ) a,(select @rowNO :=0) b) as `in_ner`
) AS A
JOIN (
SELECT * FROM (select (@rowN := @rowN+1) AS row_no, a.* from (SELECT *  FROM mbom_node ORDER BY m_bom_id ASC , `seq` ASC ) a,(select @rowN :=0) b) as `out_ner`
) AS B
ON
A.org_id = B.org_id AND A.m_bom_id = B.m_bom_id WHERE A.row_no = B.row_no + 1 and A.org_id=127

) AS C ORDER BY  id



-- MySQL中JSON LIST 列转多行
SELECT a.org_id, a.step_id, a.`sop_task_id`, a.`name`, substring_index(substring_index(a.spt, ',', b.help_topic_id + 1), ',', -1) as control_id
FROM (
SELECT `org_id`, `step_id`, `name`, `sop_task_id`, JSON_EXTRACT(`control_node_list`, "$[*].id") AS `sp`, substring(JSON_EXTRACT(`control_node_list`, "$[*].id") , 2, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) - 2) AS spt, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) AS len FROM sop_step
) as a
JOIN mysql.help_topic AS b ON b.help_topic_id <(length(a.spt) - length(REPLACE(a.spt, ',', '')) + 1) ;

-- MySQL中JSON LIST 列转多行
SELECT a.org_id, a.step_id, a.`sop_task_id`, a.`name`, substring_index(substring_index(a.spt, ',', b.help_topic_id + 1), ',', -1) as control_id
FROM (
SELECT `org_id`, `step_id`, `name`, `sop_task_id`, JSON_EXTRACT(`control_node_list`, "$[*].id") AS `sp`, substring(JSON_EXTRACT(`control_node_list`, "$[*].id") , 2, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) - 2) AS spt, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) AS len FROM sop_step
) as a
JOIN mysql.help_topic AS b ON b.help_topic_id <(length(a.spt) - length(REPLACE(a.spt, ',', '')) + 1) ;


SELECT sop_step.org_id, sop_step.sop_task_id, sop_step.step_id, sop_step.name, sop_step.`control_node_list`,
sop_task.`sop_task_code`,
sop_task.sop_name as sop_name,sop_task.`project_code`, sop_task.`process_code`, sop_task.`process_name`, sop_task.process_seq
FROM sop_step JOIN sop_task ON sop_step.sop_task_id = sop_task.id  AND sop_step.org_id = sop_task.org_id  WHERE sop_step.org_id = 94 AND (
sop_step.control_node_list IS NOT NULL OR JSON_LENGTH(sop_step.control_node_list) = 0) AND sop_task.`project_code` = 'wxg0001' AND sop_task.`process_code` = '0000000001' AND sop_task.process_seq = 1;


SELECT a.org_id, a.step_id, a.`sop_task_id`, a.`name`, a.`sop_task_code`,
a.sop_name,a.`project_code`, a.`process_code`, a.`process_name`, a.process_seq,
SUBSTRING_INDEX(SUBSTRING_INDEX(a.spt, ',', b.help_topic_id + 1), ',', -1) as control_id
FROM (
SELECT sop_step.org_id, sop_step.sop_task_id, sop_step.step_id, sop_step.name, sop_step.`control_node_list`,
sop_task.`sop_task_code`,
JSON_EXTRACT(`control_node_list`, "$[*].id") AS `sp`, SUBSTRING(JSON_EXTRACT(`control_node_list`, "$[*].id") , 2, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) - 2) AS spt,
sop_task.sop_name as sop_name,sop_task.`project_code`, sop_task.`process_code`, sop_task.`process_name`, sop_task.process_seq
FROM sop_step JOIN sop_task ON sop_step.sop_task_id = sop_task.id  AND sop_step.org_id = sop_task.org_id  WHERE sop_step.org_id = 94 AND (
sop_step.control_node_list IS NOT NULL OR JSON_LENGTH(sop_step.control_node_list) = 0) AND sop_task.`project_code` = 'wxg0001' AND sop_task.`process_code` = '0000000001' AND sop_task.process_seq = 1
) as a
JOIN mysql.help_topic AS b ON b.help_topic_id <(length(a.spt) - length(REPLACE(a.spt, ',', '')) + 1)

SELECT sop_step_control.*, sop_control.name FROM
(
SELECT a.org_id, a.step_id, a.`sop_task_id`, a.`name`, a.`sop_task_code`,
a.sop_name,a.`project_code`, a.`process_code`, a.`process_name`, a.process_seq,
SUBSTRING_INDEX(SUBSTRING_INDEX(a.spt, ',', b.help_topic_id + 1), ',', -1) as control_id
FROM (
SELECT sop_step.org_id, sop_step.sop_task_id, sop_step.step_id, sop_step.name, sop_step.`control_node_list`,
sop_task.`sop_task_code`,
JSON_EXTRACT(`control_node_list`, "$[*].id") AS `sp`, SUBSTRING(JSON_EXTRACT(`control_node_list`, "$[*].id") , 2, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) - 2) AS spt,
sop_task.sop_name as sop_name,sop_task.`project_code`, sop_task.`process_code`, sop_task.`process_name`, sop_task.process_seq
FROM sop_step JOIN sop_task ON sop_step.sop_task_id = sop_task.id  AND sop_step.org_id = sop_task.org_id  WHERE sop_step.org_id = 94 AND (
sop_step.control_node_list IS NOT NULL OR JSON_LENGTH(sop_step.control_node_list) = 0) AND sop_task.`project_code` = 'wxg0001' AND sop_task.`process_code` = '0000000001' AND sop_task.process_seq = 1
) as a
JOIN mysql.help_topic AS b ON b.help_topic_id <(length(a.spt) - length(REPLACE(a.spt, ',', '')) + 1)
) AS sop_step_control JOIN sop_control ON sop_step_control.org_id = sop_control.org_id AND sop_step_control.sop_task_id = sop_control.sop_task_id AND sop_step_control.control_id = sop_control.control_id


--+++++++====== new

SELECT
	 sop_task_step_control.*, sop_control_record.id AS sop_control_record_id, sop_control_record.step_exec_count, sop_control_record.value,
	 sop_control_record.weight_task_id, sop_control_record.sequence, sop_control_record.created_at
FROM `sop_control_record` RIGHT JOIN (
SELECT sop_step_control.*, sop_control.name AS sop_control_name FROM
(
SELECT a.org_id, a.step_id, a.`sop_task_id`, a.`name`, a.`sop_task_code`,
a.sop_name,a.`project_code`, a.`process_code`, a.`process_name`, a.process_seq,
SUBSTRING_INDEX(SUBSTRING_INDEX(a.spt, ',', row_no), ',', -1) as control_id
FROM (
SELECT sop_step.org_id, sop_step.sop_task_id, sop_step.step_id, sop_step.name, sop_step.`control_node_list`,
sop_task.`sop_task_code`, (@row_num := @row_num+1) AS row_no,
JSON_EXTRACT(`control_node_list`, "$[*].id") AS `sp`, SUBSTRING(JSON_EXTRACT(`control_node_list`, "$[*].id") , 2, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) - 2) AS spt,
sop_task.sop_name as sop_name,sop_task.`project_code`, sop_task.`process_code`, sop_task.`process_name`, sop_task.process_seq
FROM sop_step JOIN sop_task ON sop_step.sop_task_id = sop_task.id  AND sop_step.org_id = sop_task.org_id  WHERE sop_step.org_id = 162 AND (
sop_step.control_node_list IS NOT NULL OR JSON_LENGTH(sop_step.control_node_list) = 0) AND sop_task.`project_code` = '20190613001' AND sop_task.`process_code` = 'AD1-KL2-PFKL-CL' AND sop_task.process_seq = 10
) as a,(select @row_num :=0) as `row`
) AS sop_step_control JOIN sop_control ON sop_step_control.org_id = sop_control.org_id AND sop_step_control.sop_task_id = sop_control.sop_task_id AND sop_step_control.control_id = sop_control.control_id

) AS sop_task_step_control

ON sop_control_record.org_id = sop_task_step_control.org_id AND sop_control_record.sop_task_id = sop_task_step_control.sop_task_id AND sop_control_record.step_id = sop_task_step_control.step_id
AND sop_control_record.control_id = sop_task_step_control.control_id

ORDER BY created_at DESC

--++++++++======= old
SELECT
	 sop_task_step_control.*, sop_control_record.id AS sop_control_record_id, sop_control_record.step_exec_count, sop_control_record.value,
	 sop_control_record.weight_task_id, sop_control_record.sequence, sop_control_record.created_at
FROM `sop_control_record` RIGHT JOIN (

SELECT sop_step_control.*, sop_control.name AS sop_control_name FROM
(
SELECT a.org_id, a.step_id, a.`sop_task_id`, a.`name`, a.`sop_task_code`,
a.sop_name,a.`project_code`, a.`process_code`, a.`process_name`, a.process_seq,
SUBSTRING_INDEX(SUBSTRING_INDEX(a.spt, ',', b.help_topic_id + 1), ',', -1) as control_id
FROM (
SELECT sop_step.org_id, sop_step.sop_task_id, sop_step.step_id, sop_step.name, sop_step.`control_node_list`,
sop_task.`sop_task_code`,
JSON_EXTRACT(`control_node_list`, "$[*].id") AS `sp`, SUBSTRING(JSON_EXTRACT(`control_node_list`, "$[*].id") , 2, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) - 2) AS spt,
sop_task.sop_name as sop_name,sop_task.`project_code`, sop_task.`process_code`, sop_task.`process_name`, sop_task.process_seq
FROM sop_step JOIN sop_task ON sop_step.sop_task_id = sop_task.id  AND sop_step.org_id = sop_task.org_id  WHERE sop_step.org_id = 211 AND (
sop_step.control_node_list IS NOT NULL OR JSON_LENGTH(sop_step.control_node_list) = 0) AND sop_task.`project_code` = '0000000007' AND sop_task.`process_code` = 'HOWELL-P-premix' AND sop_task.process_seq = 1
) as a
JOIN mysql.help_topic AS b ON b.help_topic_id <(length(a.spt) - length(REPLACE(a.spt, ',', '')) + 1)
) AS sop_step_control JOIN sop_control ON sop_step_control.org_id = sop_control.org_id AND sop_step_control.sop_task_id = sop_control.sop_task_id AND sop_step_control.control_id = sop_control.control_id

) AS sop_task_step_control

ON sop_control_record.org_id = sop_task_step_control.org_id AND sop_control_record.sop_task_id = sop_task_step_control.sop_task_id AND sop_control_record.step_id = sop_task_step_control.step_id
AND sop_control_record.control_id = sop_task_step_control.control_id

ORDER BY created_at DESC

--- ======== latest

SELECT
	 sop_task_step_control.*, sop_control_record.id AS sop_control_record_id, sop_control_record.step_exec_count, sop_control_record.value,
	 sop_control_record.weight_task_id, sop_control_record.sequence, sop_control_record.created_at
FROM `sop_control_record` RIGHT JOIN (

SELECT sop_step_control.*, sop_control.name AS sop_control_name FROM
(
SELECT a.org_id, a.step_id, a.`sop_task_id`, a.`name`, a.`sop_task_code`,
a.sop_name,a.`project_code`, a.`process_code`, a.`process_name`, a.process_seq,
SUBSTRING_INDEX(SUBSTRING_INDEX(a.spt, ',', b.help_topic_id), ',', -1) as control_id
FROM (
SELECT sop_step.org_id, sop_step.sop_task_id, sop_step.step_id, sop_step.name, sop_step.`control_node_list`,
sop_task.`sop_task_code`,
JSON_EXTRACT(`control_node_list`, "$[*].id") AS `sp`, SUBSTRING(JSON_EXTRACT(`control_node_list`, "$[*].id") , 2, Length(JSON_EXTRACT(`control_node_list`, "$[*].id") ) - 2) AS spt,
sop_task.sop_name as sop_name,sop_task.`project_code`, sop_task.`process_code`, sop_task.`process_name`, sop_task.process_seq
FROM sop_step JOIN sop_task ON sop_step.sop_task_id = sop_task.id  AND sop_step.org_id = sop_task.org_id  WHERE sop_step.org_id = 211 AND (
sop_step.control_node_list IS NOT NULL OR JSON_LENGTH(sop_step.control_node_list) = 0) AND sop_task.`project_code` = '0000000007' AND sop_task.`process_code` = 'HOWELL-P-premix' AND sop_task.process_seq = 1
) as a
JOIN (SELECT (@row_num := @row_num+1) AS help_topic_id FROM sop_control,(select @row_num :=0) as `row`) AS b ON b.help_topic_id <=(length(a.spt) - length(REPLACE(a.spt, ',', '')) + 1)
) AS sop_step_control JOIN sop_control ON sop_step_control.org_id = sop_control.org_id AND sop_step_control.sop_task_id = sop_control.sop_task_id AND sop_step_control.control_id = sop_control.control_id

) AS sop_task_step_control

ON sop_control_record.org_id = sop_task_step_control.org_id AND sop_control_record.sop_task_id = sop_task_step_control.sop_task_id AND sop_control_record.step_id = sop_task_step_control.step_id
AND sop_control_record.control_id = sop_task_step_control.control_id

ORDER BY created_at DESC




