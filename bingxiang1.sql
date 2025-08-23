/*
 Navicat Premium Dump SQL

 Source Server         : mysql1
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : bingxiang

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 23/08/2025 10:21:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for operate_history
-- ----------------------------
DROP TABLE IF EXISTS `operate_history`;
CREATE TABLE `operate_history`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '被操作的设备',
  `operate` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '具体的操作',
  `place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '设备所在的机房',
  `ctime` datetime NULL DEFAULT NULL COMMENT '操作发生时间',
  PRIMARY KEY (`id` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 160 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operate_history
-- ----------------------------
INSERT INTO `operate_history` VALUES (159, '电磁阀开关', '修改为开', '工位1', '2025-08-21 15:20:53');
INSERT INTO `operate_history` VALUES (158, '电磁阀开关', '修改为开', '工位1', '2025-08-21 15:20:53');
INSERT INTO `operate_history` VALUES (157, '电磁阀开关', '修改为开', '工位1', '2025-08-21 15:20:52');
INSERT INTO `operate_history` VALUES (156, '电磁阀开关', '修改为关', '工位1', '2025-08-21 15:19:35');
INSERT INTO `operate_history` VALUES (155, '电磁阀开关', '修改为开', '工位3', '2025-08-19 16:38:09');
INSERT INTO `operate_history` VALUES (154, '电磁阀开关', '修改为开', '工位3', '2025-08-19 16:38:08');
INSERT INTO `operate_history` VALUES (153, '电磁阀开关', '修改为1', '工位3', '2025-08-19 16:38:08');
INSERT INTO `operate_history` VALUES (152, '电磁阀开关', '修改为关', '工位1', '2025-08-19 16:37:51');
INSERT INTO `operate_history` VALUES (151, '电磁阀开关', '修改为关', '工位1', '2025-08-19 16:37:50');
INSERT INTO `operate_history` VALUES (150, '电磁阀开关', '修改为0', '工位1', '2025-08-19 16:37:50');
INSERT INTO `operate_history` VALUES (149, '电磁阀开关', '修改为开', '工位1', '2025-08-19 16:37:41');
INSERT INTO `operate_history` VALUES (148, '电磁阀开关', '修改为开', '工位1', '2025-08-19 16:37:41');
INSERT INTO `operate_history` VALUES (147, '电磁阀开关', '修改为1', '工位1', '2025-08-19 16:37:40');
INSERT INTO `operate_history` VALUES (146, '电磁阀开关', '修改为关', '工位1', '2025-08-19 15:41:14');
INSERT INTO `operate_history` VALUES (134, '电磁阀开关', '修改为开', '工位1', '2025-07-31 18:24:54');

-- ----------------------------
-- Table structure for sensor_set
-- ----------------------------
DROP TABLE IF EXISTS `sensor_set`;
CREATE TABLE `sensor_set`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sensor1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '一号传感器',
  `sensor2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '二号传感器',
  `sensor3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '三号传感器',
  `sensor4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '四号传感器',
  `much` int NULL DEFAULT NULL COMMENT '每个工位的总传感器数量',
  `place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '机房',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensor_set
-- ----------------------------
INSERT INTO `sensor_set` VALUES (1, 'ok:温度传感器', 'ok:烟雾传感器', 'ok:水标传感器', 'ok:电传感器', 4, '工位1');
INSERT INTO `sensor_set` VALUES (2, 'ok:温度传感器', 'ok:烟雾传感器', 'ok:水标传感器', 'ok:电传感器', 4, '工位2');
INSERT INTO `sensor_set` VALUES (3, 'ok:温度传感器', 'ok:烟雾传感器', 'ok:水标传感器', 'ok:电传感器', 4, '工位3');

-- ----------------------------
-- Table structure for t_behavior_data
-- ----------------------------
DROP TABLE IF EXISTS `t_behavior_data`;
CREATE TABLE `t_behavior_data`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键，自动生成',
  `d_no` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '设备编码，有设备场景才填充。',
  `field1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预留10个字段，用于保存实时数据',
  `field2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field3` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field4` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field5` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field6` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field7` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field8` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field9` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field10` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `c_time` datetime NULL DEFAULT NULL COMMENT '数据更新时间',
  `is_saved` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否是断线保存的数据',
  `file_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `result` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '检测结果(1:0)',
  `confidence` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '可信度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6295 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_behavior_data
-- ----------------------------
INSERT INTO `t_behavior_data` VALUES (6, '工位3', '1.png', '11.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-25 10:23:57', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6272, '工位1', '1753943235335-1-8a7cec2ae.jpeg', '1753943235382-2-fgbjdydhf.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 14:27:15', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6273, '工位2', '1753943364408-1-6s872pfrc.jpeg', '1753943364447-2-n33x1tnyr.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 14:29:24', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6274, '工位2', '1753943456870-1-goo5r7ynv.jpeg', '1753943456874-2-vrqyaffov.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 14:30:56', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6275, '工位1', '1753945419005-1-8va1qiyzy.jpeg', '1753945419009-2-2fs3tsjih.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:03:39', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6277, '工位2', '1753945502566-1-o6g1ys534.jpeg', '1753945502631-2-nus0y823f.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:05:02', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6278, '工位3', '1753945510370-1-u8sxp9sws.jpeg', '1753945510470-2-24576vz0m.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:05:10', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6279, '工位1', '1753946874107-1-pp62bdq36.jpeg', '1753946874118-2-mh2wchbhr.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:27:54', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6280, '工位1', '1753947206884-1-79qvj6zw7.jpeg', '1753947206952-2-ex3jyhclq.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:33:27', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6281, '工位1', '1753947218193-1-5d1qa7cy2.jpeg', '1753947218212-2-sawi9hqjc.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:33:38', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6282, '工位1', '1753947414805-1-t5kg1ccj8.jpeg', '1753947414837-2-o8yt13dyo.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:36:54', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6283, '工位1', '1753947501347-1-hrrtspexw.jpeg', '1753947501442-2-6uva8dlso.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 15:38:21', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6284, '工位1', '1753949933598-1-cruk6z2dc.jpeg', '1753949933603-2-p8ej2lib8.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 16:18:53', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6285, '工位1', '1753949946605-1-8zb1r5rgj.jpeg', '1753949946611-2-825fgp6er.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 16:19:06', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6286, '工位1', '1753949972353-1-s7hn4qo9l.jpeg', '1753949972359-2-gzb3h1v44.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 16:19:32', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6287, '工位1', '1753950161439-1-6zgyomnu6.jpeg', '1753950161461-2-u5q5d0azi.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 16:22:41', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6288, '工位1', '1753950418868-1-u9delrt3k.jpeg', '1753950418871-2-btxjnvtth.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 16:26:58', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6289, '工位1', '1753950429606-1-w6gyg8nlv.jpeg', '1753950429712-2-1adpqp3v8.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-31 16:27:09', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6290, '工位1', '1755770101574-1-w4s4vr3hz.jpeg', '1755770101600-2-4alq296xn.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-21 17:55:01', '实时数据', 'picture', '0', 'undefined');
INSERT INTO `t_behavior_data` VALUES (6291, '工位1', '1755770265334-1-vuffl444r.jpeg', '1755770265344-2-jbotsuco5.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-21 17:57:45', '实时数据', 'picture', '0', 'undefined');
INSERT INTO `t_behavior_data` VALUES (6292, '工位1', '1755772740789-1-6gg48b6q6.jpeg', '1755772740967-2-qazxofr8c.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-21 18:39:00', '实时数据', 'picture', '0', 'undefined');
INSERT INTO `t_behavior_data` VALUES (6293, '工位1', '1755772881545-1-5unnh0w3m.jpeg', '1755772881554-2-67wmn0g8a.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-21 18:41:21', '实时数据', 'picture', '0', 'undefined');
INSERT INTO `t_behavior_data` VALUES (6294, '工位1', '1755774579462-1-xree1caz1.jpeg', '1755774579544-2-dxq223ofg.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-21 19:09:39', '实时数据', 'picture', '0', '0.826780378818512');

-- ----------------------------
-- Table structure for t_behavior_field_mapper
-- ----------------------------
DROP TABLE IF EXISTS `t_behavior_field_mapper`;
CREATE TABLE `t_behavior_field_mapper`  (
  `id` int NOT NULL,
  `f_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '前端显示的名称，自动生成实时数据表单或者历史数据的表头',
  `db_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '数据库的字段名称，用于查询的时候和前端映射起来',
  `p_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '物理层的上传的属性名称，用于解析上报数据时，与表字段联系起来',
  `unit` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '呈现类型--1：图片资源；2：视频资源',
  `is_show` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '判断当前是否渲染于图像',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_behavior_field_mapper
-- ----------------------------
INSERT INTO `t_behavior_field_mapper` VALUES (1, '图片数据', 'field1', 'P', 'mol', '1', '0');
INSERT INTO `t_behavior_field_mapper` VALUES (2, '视频数据', 'field2', 'V', 'mol', '2', '0');

-- ----------------------------
-- Table structure for t_data
-- ----------------------------
DROP TABLE IF EXISTS `t_data`;
CREATE TABLE `t_data`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键，自动生成',
  `d_no` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '设备编码，有设备场景才填充。\r\n跟底层约定好名称，不做字段的映射',
  `field1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '预留10个字段，用于保存实时数据',
  `field2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field3` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field4` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field5` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field6` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field7` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field8` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field9` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field10` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field11` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field12` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field13` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field14` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field15` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field16` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field17` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field18` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field19` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `field20` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `c_time` datetime NULL DEFAULT NULL COMMENT '收集时间',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '数据类型',
  `times` int NULL DEFAULT NULL COMMENT '次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52126 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_data
-- ----------------------------
INSERT INTO `t_data` VALUES (1, '工位1', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (48502, '工位2', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (48503, '工位3', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (52092, '工位1', '26.7', '41.2', '5.1', '0.31039999999999995', '0.009300000000000001', '0.0028867199999999997', '0.009300000000000001', '0.0028867199999999997', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:18:25', '实时数据', 6);
INSERT INTO `t_data` VALUES (52093, '工位1', '26.7', '41.2', '5.1', '0.3105', '0.009300000000000001', '0.0028876500000000003', '0.009300000000000001', '0.0028876500000000003', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:18:26', '实时数据', 6);
INSERT INTO `t_data` VALUES (52094, '工位1', '26.7', '41.2', '4.9', '0.3108', '0.0095', '0.0029526', '0.0095', '0.0029526', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:18:27', '实时数据', 6);
INSERT INTO `t_data` VALUES (52095, '工位1', '26.7', '41.2', '4.9', '0.31089999999999995', '0.0095', '0.0029535499999999997', '0.0095', '0.0029535499999999997', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:18:28', '实时数据', 6);
INSERT INTO `t_data` VALUES (52096, '工位1', '26.7', '41.2', '6', '0.3108', '0.0095', '0.0029526', '0.0095', '0.0029526', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:18:29', '实时数据', 6);
INSERT INTO `t_data` VALUES (52097, '工位1', '27', '43', '7.6', '0.3112', '0.0092', '0.00286304', '0.0092', '0.00286304', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:20:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (52098, '工位1', '27', '43', '7.6', '0.3103', '0.0094', '0.00291682', '0.0094', '0.00291682', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:20:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (52099, '工位1', '27', '43', '9.4', '0.31089999999999995', '0.0096', '0.0029846399999999993', '0.0096', '0.0029846399999999993', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:20:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (52100, '工位1', '27', '43', '8.8', '0.3105', '0.0096', '0.0029807999999999996', '0.0096', '0.0029807999999999996', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:20:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (52101, '工位1', '27', '43', '8.9', '0.311', '0.0095', '0.0029545', '0.0095', '0.0029545', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:20:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (52102, '工位1', '27', '43', '8.8', '0.31110000000000004', '0.009699999999999999', '0.00301767', '0.009699999999999999', '0.00301767', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:20:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (52103, '工位1', '27', '43', '9.3', '0.3103', '0.0092', '0.00285476', '0.0092', '0.00285476', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:20:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (52104, '工位1', '27', '43', '7.3', '0.31089999999999995', '0.0095', '0.0029535499999999997', '0.0095', '0.0029535499999999997', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:08', '实时数据', 8);
INSERT INTO `t_data` VALUES (52105, '工位1', '27', '43', '7.8', '0.3105', '0.0095', '0.00294975', '0.0095', '0.00294975', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:09', '实时数据', 8);
INSERT INTO `t_data` VALUES (52106, '工位1', '27', '43', '10', '0.3108', '0.0094', '0.0029215200000000004', '0.0094', '0.0029215200000000004', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:28', '实时数据', 9);
INSERT INTO `t_data` VALUES (52107, '工位1', '27', '43', '10.1', '0.3102', '0.0094', '0.00291588', '0.0094', '0.00291588', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:29', '实时数据', 9);
INSERT INTO `t_data` VALUES (52108, '工位1', '27', '43', '9.3', '0.3107', '0.0094', '0.00292058', '0.0094', '0.00292058', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:30', '实时数据', 9);
INSERT INTO `t_data` VALUES (52109, '工位1', '27', '43', '10.1', '0.31039999999999995', '0.009300000000000001', '0.0028867199999999997', '0.009300000000000001', '0.0028867199999999997', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:31', '实时数据', 9);
INSERT INTO `t_data` VALUES (52110, '工位1', '27', '43', '9.9', '0.31060000000000004', '0.0095', '0.0029507000000000005', '0.0095', '0.0029507000000000005', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:32', '实时数据', 9);
INSERT INTO `t_data` VALUES (52111, '工位1', '27', '43', '10.1', '0.3107', '0.0094', '0.00292058', '0.0094', '0.00292058', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:33', '实时数据', 9);
INSERT INTO `t_data` VALUES (52112, '工位1', '27', '43', '8.4', '0.31060000000000004', '0.009300000000000001', '0.002888580000000001', '0.009300000000000001', '0.002888580000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:34', '实时数据', 9);
INSERT INTO `t_data` VALUES (52113, '工位1', '27', '43', '8.4', '0.3108', '0.0096', '0.00298368', '0.0096', '0.00298368', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:35', '实时数据', 9);
INSERT INTO `t_data` VALUES (52114, '工位1', '27', '43', '8.2', '0.31039999999999995', '0.0092', '0.0028556799999999993', '0.0092', '0.0028556799999999993', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:36', '实时数据', 9);
INSERT INTO `t_data` VALUES (52115, '工位1', '27', '43', '9.9', '0.311', '0.0095', '0.0029545', '0.0095', '0.0029545', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:37', '实时数据', 9);
INSERT INTO `t_data` VALUES (52116, '工位1', '27', '43', '7.5', '0.3103', '0.0092', '0.00285476', '0.0092', '0.00285476', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:22:38', '实时数据', 9);
INSERT INTO `t_data` VALUES (52117, '工位1', '27', '43', '7', '0.3108', '0.0092', '0.00285936', '0.0092', '0.00285936', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:37', '实时数据', 10);
INSERT INTO `t_data` VALUES (52118, '工位1', '27', '43', '6.8', '0.311', '0.0094', '0.0029234', '0.0094', '0.0029234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:38', '实时数据', 10);
INSERT INTO `t_data` VALUES (52119, '工位1', '27', '43', '6.8', '0.3103', '0.0092', '0.00285476', '0.0092', '0.00285476', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:39', '实时数据', 10);
INSERT INTO `t_data` VALUES (52120, '工位1', '27', '43', '6.9', '0.3108', '0.0095', '0.0029526', '0.0095', '0.0029526', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:40', '实时数据', 10);
INSERT INTO `t_data` VALUES (52121, '工位1', '27', '43', '6.8', '0.3112', '0.0091', '0.00283192', '0.0091', '0.00283192', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:41', '实时数据', 10);
INSERT INTO `t_data` VALUES (52122, '工位1', '27', '43', '6.8', '0.31089999999999995', '0.0095', '0.0029535499999999997', '0.0095', '0.0029535499999999997', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:42', '实时数据', 10);
INSERT INTO `t_data` VALUES (52123, '工位1', '27', '43', '6.9', '0.3112', '0.0095', '0.0029563999999999997', '0.0095', '0.0029563999999999997', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:43', '实时数据', 10);
INSERT INTO `t_data` VALUES (52124, '工位1', '27', '43', '7.1', '0.3107', '0.0091', '0.00282737', '0.0091', '0.00282737', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:44', '实时数据', 10);
INSERT INTO `t_data` VALUES (52125, '工位1', '27', '43', '6.8', '0.3112', '0.0095', '0.0029563999999999997', '0.0095', '0.0029563999999999997', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-19 16:23:45', '实时数据', 10);

-- ----------------------------
-- Table structure for t_device
-- ----------------------------
DROP TABLE IF EXISTS `t_device`;
CREATE TABLE `t_device`  (
  `id` int NOT NULL COMMENT '主键',
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备名称',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标记',
  `ctime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备编号',
  `place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '位置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_device
-- ----------------------------
INSERT INTO `t_device` VALUES (1, '电冰箱', 'sign1', '2025-06-24 09:22:25', 'ji1', '工位1');
INSERT INTO `t_device` VALUES (2, '电冰箱', 'sign2', '2025-06-24 10:06:49', 'ji2', '工位2');
INSERT INTO `t_device` VALUES (3, '电冰箱', 'sign3', '2025-07-23 18:07:27', 'ji3', '工位3');

-- ----------------------------
-- Table structure for t_direct
-- ----------------------------
DROP TABLE IF EXISTS `t_direct`;
CREATE TABLE `t_direct`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `config_id` int NULL DEFAULT NULL COMMENT '指令名称',
  `value` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指令值；输入框：不配置；单选框：具体的值；滑动按钮：取值范围',
  `d_no` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 969 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_direct
-- ----------------------------
INSERT INTO `t_direct` VALUES (840, 0, '手动', 'null');
INSERT INTO `t_direct` VALUES (841, 3, '反转', 'null');
INSERT INTO `t_direct` VALUES (842, 2, '开', 'null');
INSERT INTO `t_direct` VALUES (843, 1, '关', 'null');
INSERT INTO `t_direct` VALUES (845, 4, '关', 'null');
INSERT INTO `t_direct` VALUES (846, 5, '关', 'null');
INSERT INTO `t_direct` VALUES (847, 6, '28', 'null');
INSERT INTO `t_direct` VALUES (848, 7, '22', 'null');
INSERT INTO `t_direct` VALUES (849, 8, '180', 'null');
INSERT INTO `t_direct` VALUES (850, 9, '22', 'null');
INSERT INTO `t_direct` VALUES (851, 10, '47', 'null');
INSERT INTO `t_direct` VALUES (951, 11, '关', 'null');
INSERT INTO `t_direct` VALUES (952, 12, '开', 'null');
INSERT INTO `t_direct` VALUES (953, 13, '关', 'null');
INSERT INTO `t_direct` VALUES (954, 14, '78', 'null');
INSERT INTO `t_direct` VALUES (955, 15, '关', 'null');
INSERT INTO `t_direct` VALUES (956, 16, '75', 'null');
INSERT INTO `t_direct` VALUES (957, 17, '制热', 'null');
INSERT INTO `t_direct` VALUES (958, 18, '2', 'null');
INSERT INTO `t_direct` VALUES (959, 19, '2025-05-08 03:04:43', 'null');
INSERT INTO `t_direct` VALUES (960, 20, '2025-05-13 12:02:43', 'null');
INSERT INTO `t_direct` VALUES (962, 12, '开', '工位1');
INSERT INTO `t_direct` VALUES (964, 12, '开', '工位2');
INSERT INTO `t_direct` VALUES (966, 12, '开', '工位3');
INSERT INTO `t_direct` VALUES (968, 55, '11', '工位4');

-- ----------------------------
-- Table structure for t_direct_config
-- ----------------------------
DROP TABLE IF EXISTS `t_direct_config`;
CREATE TABLE `t_direct_config`  (
  `id` int NOT NULL,
  `ref_id` int NULL DEFAULT NULL COMMENT '关联的指令配置Id',
  `ref_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联的指令配置值\r\n如果配置的Id的值与此处吻合，显示该指令配置',
  `t_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指令名称',
  `f_type` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '前端类型。1：开关按钮；2：输入框；3：滑动按钮；4：时间框；5：单选框',
  `f_value` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指令值；输入框：不配置；单选框：具体的值；滑动按钮：取值范围',
  `mode` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '模式。1=全局指令',
  `max` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `min` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `order` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '排序',
  `topic` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '指令对应的主题',
  `header` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `luyou` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '路由名称',
  `ok` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否将当前控件控制字段进行映射呈现',
  `label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '控制控件之间的关联关系',
  `label_boolean` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '控件呈现字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_direct_config
-- ----------------------------
INSERT INTO `t_direct_config` VALUES (0, 0, '手动', '控制模式', '1', '自动:zidong|手动:shodong', '0', NULL, NULL, NULL, 'direct', 'start|start', 'control', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (1, 0, '手动', '可调灯', '1', '开:deng|关:deng', '1', NULL, NULL, '0', 'direct', 'start|stop', 'ketiaodeng', 'no', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (2, 0, '手动', '步进电机', '1', '开:kaiqi|关:guanbi', '1', 'null', 'null', '1', 'direct', 'start|stop', 'bujindianji', 'no', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (3, 0, '手动', '电机模式', '5', '正转:zhengzhuan|反转:fanzhuan', '1', 'null', 'null', '3', 'direct', 'start|start', 'dianji_model', 'no', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (4, 0, '手动', '风扇1', '1', '开:fengshan1|关:fengshan1', '1', NULL, NULL, NULL, 'direct', 'start|stop', 'fengshan1', 'no', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (5, 0, '手动', '风扇2', '1', '开:fengshan2|关:fengshan2', '1', NULL, NULL, NULL, 'direct', 'start|stop', 'fengshan2', 'no', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (6, 0, '自动', '温度上限', '2', 'T1', '1', '100', '0', NULL, 'direct', 'null', 'temperature2', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (7, 0, '自动', '温度下限', '2', 'T2', '1', '100', '0', NULL, 'direct', 'null', 'temperature1', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (8, 0, '自动', '光照阈值', '2', 'light_warning', '1', '300', '0', NULL, 'direct', 'null', 'light_min', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (9, 0, '自动', '烟雾阈值1', '2', 'Yanwu1', '1', '300', '0', NULL, 'direct', 'null', 'smoke1', 'no', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (10, 0, '自动', '烟雾阈值2', '2', 'Yanwu2', '1', '300', '0', NULL, 'direct', 'null', 'smoke2', 'no', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (11, 0, '手动', '灯泡开关', '1', '开:deng|关:deng', '0', NULL, NULL, NULL, 'direct', 'start|stop', 'deng', 'no', 'deng', '1');
INSERT INTO `t_direct_config` VALUES (12, 0, '手动', '电磁阀开关', '1', '开:deng|关:deng', '0', NULL, NULL, NULL, 'send', 'start|stop', 'led', 'yes', 'deng_label', NULL);
INSERT INTO `t_direct_config` VALUES (13, 0, '手动', '风扇开关', '1', '开:fengshan|关:fengshan', '1', NULL, NULL, NULL, 'direct', 'start|stop', 'fengshan', 'no', 'fengshan', '1');
INSERT INTO `t_direct_config` VALUES (14, 0, '自动', '风扇功率', '3', 'fengshanV', '1', '100', '0', NULL, 'direct', 'null', 'fengshanV', 'no', 'fengshan_label', '1');
INSERT INTO `t_direct_config` VALUES (15, 0, '手动', '空调开关', '1', '开:kongtiao|关:kongtiao', '1', '', NULL, NULL, 'direct', 'start|stop', 'kongtiao', 'no', 'kongtiao', '1');
INSERT INTO `t_direct_config` VALUES (16, 0, '自动', '空调功率', '3', 'kongtiaoP', '1', '100', '0', NULL, 'direct', 'null', 'kongtiaoP', 'no', 'kongtiao_label', '1');
INSERT INTO `t_direct_config` VALUES (17, 0, '手动', '空调模式', '5', '制冷:cold|制热:hot', '1', NULL, NULL, NULL, 'direct', 'start|start', 'kongtiaoM', 'no', 'kongtiao_label', '1');
INSERT INTO `t_direct_config` VALUES (18, 0, '自动', '内外温差阈值', '2', 'TG', '1', '10', '0', NULL, 'direct', 'null', 'TG', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (19, 0, '手动', '起始时间', '4', 'BTime', '1', NULL, NULL, NULL, 'direct', 'null', 'BTime', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (20, 0, '手动', '终止时间', '4', 'ETime', '1', NULL, NULL, NULL, 'direct', 'null', 'ETime', 'no', NULL, '1');

-- ----------------------------
-- Table structure for t_error_msg
-- ----------------------------
DROP TABLE IF EXISTS `t_error_msg`;
CREATE TABLE `t_error_msg`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `c_time` datetime NULL DEFAULT NULL COMMENT '设备状态更新的最新时间',
  `e_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '告警错误类型，0：湿度超标；1：机械故障；2：箱内断电时间过长',
  `VStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态取值',
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '监听的领域',
  `d_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备编号',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '错误类型',
  PRIMARY KEY (`id` DESC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1031 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_error_msg
-- ----------------------------
INSERT INTO `t_error_msg` VALUES (1030, '2025-07-31 16:16:41', '温度越界', NULL, NULL, '工位1', NULL);
INSERT INTO `t_error_msg` VALUES (1029, '2025-07-31 16:15:57', '温度越界', NULL, NULL, '工位1', NULL);
INSERT INTO `t_error_msg` VALUES (1028, '2025-07-31 16:15:50', '温度越界', NULL, NULL, '工位1', NULL);
INSERT INTO `t_error_msg` VALUES (1027, '2025-07-31 16:14:24', '温度越界', NULL, NULL, '工位1', NULL);
INSERT INTO `t_error_msg` VALUES (1026, '2025-07-31 16:13:40', '温度越界', NULL, NULL, '工位1', NULL);
INSERT INTO `t_error_msg` VALUES (1025, '2025-07-31 16:12:39', '水位越界', NULL, NULL, '工位3', NULL);

-- ----------------------------
-- Table structure for t_field_mapper
-- ----------------------------
DROP TABLE IF EXISTS `t_field_mapper`;
CREATE TABLE `t_field_mapper`  (
  `id` int NOT NULL,
  `f_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '前端显示的名称，自动生成实时数据表单或者历史数据的表头',
  `db_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '数据库的字段名称，用于查询的时候和前端映射起来',
  `p_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '物理层的上传的属性名称，用于解析上报数据时，与表字段联系起来',
  `unit` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_field_mapper
-- ----------------------------
INSERT INTO `t_field_mapper` VALUES (1, '温度', 'field1', 'T', '°C');
INSERT INTO `t_field_mapper` VALUES (2, '湿度', 'field2', 'S', '%');
INSERT INTO `t_field_mapper` VALUES (3, '光照', 'field3', 'L', '%');
INSERT INTO `t_field_mapper` VALUES (4, '电压', 'field4', 'U', 'V');
INSERT INTO `t_field_mapper` VALUES (5, '电流', 'field5', 'I', 'A');
INSERT INTO `t_field_mapper` VALUES (6, '功率', 'field6', 'P', 'W');
INSERT INTO `t_field_mapper` VALUES (7, '电量', 'field7', 'Q', 'C');
INSERT INTO `t_field_mapper` VALUES (8, '用电量', 'field8', 'W', 'J');

SET FOREIGN_KEY_CHECKS = 1;
