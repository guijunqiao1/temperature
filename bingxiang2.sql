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

 Date: 26/08/2025 16:23:52
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
) ENGINE = InnoDB AUTO_INCREMENT = 257 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operate_history
-- ----------------------------
INSERT INTO `operate_history` VALUES (256, '光照上限', '修改为10', '工位1', '2025-08-26 16:16:55');
INSERT INTO `operate_history` VALUES (255, '电磁阀开关', '修改为开', '工位1', '2025-08-24 11:09:05');
INSERT INTO `operate_history` VALUES (254, '电磁阀开关', '修改为开', '工位1', '2025-08-24 11:09:05');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6331 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_behavior_data
-- ----------------------------
INSERT INTO `t_behavior_data` VALUES (6314, '工位1', '1756003229699-1-ewegcd61a.jpeg', '1756003229714-2-fb2r5ikbn.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:40:29', '实时数据', 'picture', '0', '0.91');
INSERT INTO `t_behavior_data` VALUES (6315, '工位1', '1756003327037-1-nf1dcadvt.jpeg', '1756003327170-2-hmpk2ch9n.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:42:07', '实时数据', 'picture', '1', '0.61');
INSERT INTO `t_behavior_data` VALUES (6316, '工位1', '1756003436385-1-ev5qeacno.jpeg', '1756003436583-2-u0642dtew.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:43:56', '实时数据', 'picture', '1', '0.83');
INSERT INTO `t_behavior_data` VALUES (6317, '工位1', '1756003632974-1-qxfwv3els.jpeg', '1756003633045-2-g4p08j7b9.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:47:13', '实时数据', 'picture', '1', '0.86');
INSERT INTO `t_behavior_data` VALUES (6318, '工位1', '1756003647133-1-fezzdtivg.jpeg', '1756003647729-2-fyat5ntc3.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:47:27', '实时数据', 'picture', '1', '0.84');
INSERT INTO `t_behavior_data` VALUES (6319, '工位1', '1756003702758-1-pd11qczzz.jpeg', '1756003702860-2-za1rx0ldt.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:22', '实时数据', 'picture', '1', '0.93');
INSERT INTO `t_behavior_data` VALUES (6320, '工位1', '1756003764491-1-6una2wmjg.jpeg', '1756003764547-2-vdharzlxz.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:49:24', '实时数据', 'picture', '1', '0.78');
INSERT INTO `t_behavior_data` VALUES (6321, '工位1', '1756003788334-1-slf5yo9nd.jpeg', '1756003788344-2-1pjhkq7mu.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:49:48', '实时数据', 'picture', '1', '0.87');
INSERT INTO `t_behavior_data` VALUES (6322, '工位1', '1756003817909-1-zq6mwak5g.jpeg', '1756003817967-2-srp45obcj.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:50:18', '实时数据', 'picture', '1', '0.80');
INSERT INTO `t_behavior_data` VALUES (6323, '工位1', '1756003926692-1-494nzx3ze.jpeg', '1756003926926-2-iu758ysnt.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:52:06', '实时数据', 'picture', '1', '0.79');
INSERT INTO `t_behavior_data` VALUES (6324, '工位1', '1756003969698-1-1qvpxnfi6.jpeg', '1756003969818-2-193b17dcq.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:52:49', '实时数据', 'picture', '1', '0.88');
INSERT INTO `t_behavior_data` VALUES (6325, '工位1', '1756004826069-1-zvf57lyun.jpeg', '1756004826234-2-yrnutmc70.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:07:06', '实时数据', 'picture', '1', '0.83');
INSERT INTO `t_behavior_data` VALUES (6326, '工位1', '1756004851346-1-iup4dsclo.jpeg', '1756004851364-2-fbdnl8q0r.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:07:31', '实时数据', 'picture', '1', '0.83');
INSERT INTO `t_behavior_data` VALUES (6327, '工位1', '1756004896866-1-h93n12kh8.jpeg', '1756004896885-2-vqtct7xqn.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:16', '实时数据', 'picture', '1', '0.76');
INSERT INTO `t_behavior_data` VALUES (6328, '工位1', '1756004907278-1-igko1nfcp.jpeg', '1756004907351-2-yj284xo7z.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:27', '实时数据', 'picture', '1', '0.85');
INSERT INTO `t_behavior_data` VALUES (6329, '工位1', '1756004939801-1-t284fwkf2.jpeg', '1756004939814-2-qwzmi3sod.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:00', '实时数据', 'picture', '1', '0.81');
INSERT INTO `t_behavior_data` VALUES (6330, '工位1', '1756005959775-1-s0sxiyrd3.jpeg', '1756005959926-2-fl00res10.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:00', '实时数据', 'picture', '1', '0.63');

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
) ENGINE = InnoDB AUTO_INCREMENT = 53899 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_data
-- ----------------------------
INSERT INTO `t_data` VALUES (1, '工位1', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (48502, '工位2', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (48503, '工位3', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (52726, '工位1', '29.1', '34.0', '21.8', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:36', '实时数据', 3);
INSERT INTO `t_data` VALUES (52727, '工位1', '29.1', '34.0', '21.8', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:37', '实时数据', 3);
INSERT INTO `t_data` VALUES (52728, '工位1', '29.1', '34.0', '21.9', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:39', '实时数据', 3);
INSERT INTO `t_data` VALUES (52729, '工位1', '29.1', '34.0', '20.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:40', '实时数据', 3);
INSERT INTO `t_data` VALUES (52730, '工位1', '29.1', '34.0', '24', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:41', '实时数据', 3);
INSERT INTO `t_data` VALUES (52731, '工位1', '29.1', '34.0', '25', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:42', '实时数据', 3);
INSERT INTO `t_data` VALUES (52732, '工位1', '29.1', '34.0', '25.1', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:43', '实时数据', 3);
INSERT INTO `t_data` VALUES (52733, '工位1', '29.1', '34.0', '25.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:44', '实时数据', 3);
INSERT INTO `t_data` VALUES (52734, '工位1', '29.1', '34.0', '25.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:45', '实时数据', 3);
INSERT INTO `t_data` VALUES (52735, '工位1', '29.1', '34.0', '24.9', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:46', '实时数据', 3);
INSERT INTO `t_data` VALUES (52736, '工位1', '29.1', '34.0', '25.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:47', '实时数据', 3);
INSERT INTO `t_data` VALUES (52737, '工位1', '29.1', '34.0', '26.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:48', '实时数据', 3);
INSERT INTO `t_data` VALUES (52738, '工位1', '29.1', '34.0', '24', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:49', '实时数据', 3);
INSERT INTO `t_data` VALUES (52739, '工位1', '29.1', '34.0', '25.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:50', '实时数据', 3);
INSERT INTO `t_data` VALUES (52740, '工位1', '29.1', '34.0', '25.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:51', '实时数据', 3);
INSERT INTO `t_data` VALUES (52741, '工位1', '29.1', '34.0', '25.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:52', '实时数据', 3);
INSERT INTO `t_data` VALUES (52742, '工位1', '29.1', '34.0', '25.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:53', '实时数据', 3);
INSERT INTO `t_data` VALUES (52743, '工位1', '29.1', '34.0', '25.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:54', '实时数据', 3);
INSERT INTO `t_data` VALUES (52744, '工位1', '29.1', '34.0', '26.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:55', '实时数据', 3);
INSERT INTO `t_data` VALUES (52745, '工位1', '29.1', '34.0', '26.3', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:56', '实时数据', 3);
INSERT INTO `t_data` VALUES (52746, '工位1', '29.1', '34.0', '26.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:57', '实时数据', 3);
INSERT INTO `t_data` VALUES (52747, '工位1', '29.1', '34.0', '26.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:58', '实时数据', 3);
INSERT INTO `t_data` VALUES (52748, '工位1', '29.1', '34.0', '24.3', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:44:59', '实时数据', 3);
INSERT INTO `t_data` VALUES (52749, '工位1', '29.1', '34.0', '26', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:00', '实时数据', 3);
INSERT INTO `t_data` VALUES (52750, '工位1', '29.1', '34.0', '25.6', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:01', '实时数据', 3);
INSERT INTO `t_data` VALUES (52751, '工位1', '29.1', '34.0', '26', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:02', '实时数据', 3);
INSERT INTO `t_data` VALUES (52752, '工位1', '29.1', '34.0', '23.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:03', '实时数据', 3);
INSERT INTO `t_data` VALUES (52753, '工位1', '29.1', '34.0', '23.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:04', '实时数据', 3);
INSERT INTO `t_data` VALUES (52754, '工位1', '29.1', '34.0', '25.5', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:05', '实时数据', 3);
INSERT INTO `t_data` VALUES (52755, '工位1', '29.1', '34.0', '25.7', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:06', '实时数据', 3);
INSERT INTO `t_data` VALUES (52756, '工位1', '29.1', '34.0', '25.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:07', '实时数据', 3);
INSERT INTO `t_data` VALUES (52757, '工位1', '29.1', '34.0', '25.7', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:08', '实时数据', 3);
INSERT INTO `t_data` VALUES (52758, '工位1', '29.1', '34.0', '25.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:09', '实时数据', 3);
INSERT INTO `t_data` VALUES (52759, '工位1', '29.1', '34.0', '25.6', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:10', '实时数据', 3);
INSERT INTO `t_data` VALUES (52760, '工位1', '29.1', '34.0', '26', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:11', '实时数据', 3);
INSERT INTO `t_data` VALUES (52761, '工位1', '29.1', '34.0', '26.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:12', '实时数据', 3);
INSERT INTO `t_data` VALUES (52762, '工位1', '29.1', '34.0', '24.8', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:14', '实时数据', 3);
INSERT INTO `t_data` VALUES (52763, '工位1', '29.1', '34.0', '24.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:14', '实时数据', 3);
INSERT INTO `t_data` VALUES (52764, '工位1', '29.1', '34.0', '24.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:15', '实时数据', 3);
INSERT INTO `t_data` VALUES (52765, '工位1', '29.1', '34.0', '22.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:16', '实时数据', 3);
INSERT INTO `t_data` VALUES (52766, '工位1', '29.1', '34.0', '24.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:17', '实时数据', 3);
INSERT INTO `t_data` VALUES (52767, '工位1', '29.1', '34.0', '25.2', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:18', '实时数据', 3);
INSERT INTO `t_data` VALUES (52768, '工位1', '29.1', '34.0', '25.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:19', '实时数据', 3);
INSERT INTO `t_data` VALUES (52769, '工位1', '29.1', '34.0', '25.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:20', '实时数据', 3);
INSERT INTO `t_data` VALUES (52770, '工位1', '29.1', '34.0', '24.4', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:21', '实时数据', 3);
INSERT INTO `t_data` VALUES (52771, '工位1', '29.1', '34.0', '24.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:22', '实时数据', 3);
INSERT INTO `t_data` VALUES (52772, '工位1', '29.1', '34.0', '23.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:23', '实时数据', 3);
INSERT INTO `t_data` VALUES (52773, '工位1', '29.1', '34.0', '22.2', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:24', '实时数据', 3);
INSERT INTO `t_data` VALUES (52774, '工位1', '29.1', '34.0', '24.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:25', '实时数据', 3);
INSERT INTO `t_data` VALUES (52775, '工位1', '29.1', '34.0', '22.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:26', '实时数据', 3);
INSERT INTO `t_data` VALUES (52776, '工位1', '29.1', '34.0', '23.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:27', '实时数据', 3);
INSERT INTO `t_data` VALUES (52777, '工位1', '29.1', '34.0', '24', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:28', '实时数据', 3);
INSERT INTO `t_data` VALUES (52778, '工位1', '29.1', '34.0', '24', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:29', '实时数据', 3);
INSERT INTO `t_data` VALUES (52779, '工位1', '29.1', '34.0', '25.8', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:30', '实时数据', 3);
INSERT INTO `t_data` VALUES (52780, '工位1', '29.1', '34.0', '25.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:31', '实时数据', 3);
INSERT INTO `t_data` VALUES (52781, '工位1', '29.1', '34.0', '24', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:32', '实时数据', 3);
INSERT INTO `t_data` VALUES (52782, '工位1', '29.1', '34.0', '23.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:33', '实时数据', 3);
INSERT INTO `t_data` VALUES (52783, '工位1', '29.1', '34.0', '21.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:35', '实时数据', 3);
INSERT INTO `t_data` VALUES (52784, '工位1', '29.1', '34.0', '22.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:36', '实时数据', 3);
INSERT INTO `t_data` VALUES (52785, '工位1', '29.1', '34.0', '22.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:37', '实时数据', 3);
INSERT INTO `t_data` VALUES (52786, '工位1', '29.1', '34.0', '21.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:38', '实时数据', 3);
INSERT INTO `t_data` VALUES (52787, '工位1', '29.1', '34.0', '24.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:39', '实时数据', 3);
INSERT INTO `t_data` VALUES (52788, '工位1', '29.1', '34.0', '25.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:40', '实时数据', 3);
INSERT INTO `t_data` VALUES (52789, '工位1', '29.1', '34.0', '23.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:41', '实时数据', 3);
INSERT INTO `t_data` VALUES (52790, '工位1', '29.1', '34.0', '22.8', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:42', '实时数据', 3);
INSERT INTO `t_data` VALUES (52791, '工位1', '29.1', '34.0', '23.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:43', '实时数据', 3);
INSERT INTO `t_data` VALUES (52792, '工位1', '29.1', '34.0', '23.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:44', '实时数据', 3);
INSERT INTO `t_data` VALUES (52793, '工位1', '29.1', '34.0', '24.2', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:45', '实时数据', 3);
INSERT INTO `t_data` VALUES (52794, '工位1', '29.1', '34.0', '24.1', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:46', '实时数据', 3);
INSERT INTO `t_data` VALUES (52795, '工位1', '29.1', '34.0', '24.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:47', '实时数据', 3);
INSERT INTO `t_data` VALUES (52796, '工位1', '29.1', '34.0', '24.1', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:48', '实时数据', 3);
INSERT INTO `t_data` VALUES (52797, '工位1', '29.1', '34.0', '24.3', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:49', '实时数据', 3);
INSERT INTO `t_data` VALUES (52798, '工位1', '29.1', '34.0', '24.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:50', '实时数据', 3);
INSERT INTO `t_data` VALUES (52799, '工位1', '29.1', '34.0', '25.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:51', '实时数据', 3);
INSERT INTO `t_data` VALUES (52800, '工位1', '29.1', '34.0', '24.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:52', '实时数据', 3);
INSERT INTO `t_data` VALUES (52801, '工位1', '29.1', '34.0', '22.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:53', '实时数据', 3);
INSERT INTO `t_data` VALUES (52802, '工位1', '29.1', '34.0', '20.8', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:54', '实时数据', 3);
INSERT INTO `t_data` VALUES (52803, '工位1', '29.1', '34.0', '20.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:55', '实时数据', 3);
INSERT INTO `t_data` VALUES (52804, '工位1', '29.1', '34.0', '21.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:56', '实时数据', 3);
INSERT INTO `t_data` VALUES (52805, '工位1', '29.1', '34.0', '22.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:57', '实时数据', 3);
INSERT INTO `t_data` VALUES (52806, '工位1', '29.1', '34.0', '21.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:58', '实时数据', 3);
INSERT INTO `t_data` VALUES (52807, '工位1', '29.1', '34.0', '20.5', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:45:59', '实时数据', 3);
INSERT INTO `t_data` VALUES (52808, '工位1', '29.1', '34.0', '20.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:00', '实时数据', 3);
INSERT INTO `t_data` VALUES (52809, '工位1', '29.1', '34.0', '20.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:01', '实时数据', 3);
INSERT INTO `t_data` VALUES (52810, '工位1', '29.1', '34.0', '20.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:02', '实时数据', 3);
INSERT INTO `t_data` VALUES (52811, '工位1', '29.1', '34.0', '21.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:03', '实时数据', 3);
INSERT INTO `t_data` VALUES (52812, '工位1', '29.1', '34.0', '21.2', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:04', '实时数据', 3);
INSERT INTO `t_data` VALUES (52813, '工位1', '29.1', '34.0', '20.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:05', '实时数据', 3);
INSERT INTO `t_data` VALUES (52814, '工位1', '29.1', '34.0', '21.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:06', '实时数据', 3);
INSERT INTO `t_data` VALUES (52815, '工位1', '29.1', '34.0', '22.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:07', '实时数据', 3);
INSERT INTO `t_data` VALUES (52816, '工位1', '29.1', '34.0', '22.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:08', '实时数据', 3);
INSERT INTO `t_data` VALUES (52817, '工位1', '29.1', '34.0', '22.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:09', '实时数据', 3);
INSERT INTO `t_data` VALUES (52818, '工位1', '29.1', '34.0', '23.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:10', '实时数据', 3);
INSERT INTO `t_data` VALUES (52819, '工位1', '29.1', '34.0', '23.4', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:11', '实时数据', 3);
INSERT INTO `t_data` VALUES (52820, '工位1', '29.1', '34.0', '23.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:12', '实时数据', 3);
INSERT INTO `t_data` VALUES (52821, '工位1', '29.1', '34.0', '23.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:13', '实时数据', 3);
INSERT INTO `t_data` VALUES (52822, '工位1', '29.1', '34.0', '23.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:14', '实时数据', 3);
INSERT INTO `t_data` VALUES (52823, '工位1', '29.1', '34.0', '23.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:15', '实时数据', 3);
INSERT INTO `t_data` VALUES (52824, '工位1', '29.1', '34.0', '23.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:16', '实时数据', 3);
INSERT INTO `t_data` VALUES (52825, '工位1', '29.1', '34.0', '24.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:17', '实时数据', 3);
INSERT INTO `t_data` VALUES (52826, '工位1', '29.1', '34.0', '24.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:18', '实时数据', 3);
INSERT INTO `t_data` VALUES (52827, '工位1', '29.1', '34.0', '22.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:19', '实时数据', 3);
INSERT INTO `t_data` VALUES (52828, '工位1', '29.1', '34.0', '23.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:20', '实时数据', 3);
INSERT INTO `t_data` VALUES (52829, '工位1', '29.1', '34.0', '24.8', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:21', '实时数据', 3);
INSERT INTO `t_data` VALUES (52830, '工位1', '29.1', '34.0', '24.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:23', '实时数据', 3);
INSERT INTO `t_data` VALUES (52831, '工位1', '29.1', '34.0', '24.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:23', '实时数据', 3);
INSERT INTO `t_data` VALUES (52832, '工位1', '29.1', '34.0', '24.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:24', '实时数据', 3);
INSERT INTO `t_data` VALUES (52833, '工位1', '29.1', '34.0', '25', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:25', '实时数据', 3);
INSERT INTO `t_data` VALUES (52834, '工位1', '29.1', '34.0', '25.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:26', '实时数据', 3);
INSERT INTO `t_data` VALUES (52835, '工位1', '29.1', '34.0', '25.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:27', '实时数据', 3);
INSERT INTO `t_data` VALUES (52836, '工位1', '29.1', '34.0', '25.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:29', '实时数据', 3);
INSERT INTO `t_data` VALUES (52837, '工位1', '29.1', '34.0', '25.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:30', '实时数据', 3);
INSERT INTO `t_data` VALUES (52838, '工位1', '29.1', '34.0', '23.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:31', '实时数据', 3);
INSERT INTO `t_data` VALUES (52839, '工位1', '29.1', '34.0', '25', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:32', '实时数据', 3);
INSERT INTO `t_data` VALUES (52840, '工位1', '29.1', '34.0', '25.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:33', '实时数据', 3);
INSERT INTO `t_data` VALUES (52841, '工位1', '29.1', '34.0', '25.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:34', '实时数据', 3);
INSERT INTO `t_data` VALUES (52842, '工位1', '29.1', '34.0', '25.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:35', '实时数据', 3);
INSERT INTO `t_data` VALUES (52843, '工位1', '29.1', '34.0', '25.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:36', '实时数据', 3);
INSERT INTO `t_data` VALUES (52844, '工位1', '29.1', '34.0', '23', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:37', '实时数据', 3);
INSERT INTO `t_data` VALUES (52845, '工位1', '29.1', '34.0', '23.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:38', '实时数据', 3);
INSERT INTO `t_data` VALUES (52846, '工位1', '29.1', '34.0', '22.7', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:39', '实时数据', 3);
INSERT INTO `t_data` VALUES (52847, '工位1', '29.1', '34.0', '22.9', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:40', '实时数据', 3);
INSERT INTO `t_data` VALUES (52848, '工位1', '29.1', '34.0', '22.1', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:41', '实时数据', 3);
INSERT INTO `t_data` VALUES (52849, '工位1', '29.1', '34.0', '22.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:42', '实时数据', 3);
INSERT INTO `t_data` VALUES (52850, '工位1', '29.1', '34.0', '21.9', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:43', '实时数据', 3);
INSERT INTO `t_data` VALUES (52851, '工位1', '29.1', '34.0', '22.2', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:44', '实时数据', 3);
INSERT INTO `t_data` VALUES (52852, '工位1', '29.1', '34.0', '23.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:45', '实时数据', 3);
INSERT INTO `t_data` VALUES (52853, '工位1', '29.1', '34.0', '23.3', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:46', '实时数据', 3);
INSERT INTO `t_data` VALUES (52854, '工位1', '29.1', '34.0', '23.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:47', '实时数据', 3);
INSERT INTO `t_data` VALUES (52855, '工位1', '29.1', '34.0', '23.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:48', '实时数据', 3);
INSERT INTO `t_data` VALUES (52856, '工位1', '29.1', '34.0', '20.9', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:49', '实时数据', 3);
INSERT INTO `t_data` VALUES (52857, '工位1', '29.1', '34.0', '20.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:50', '实时数据', 3);
INSERT INTO `t_data` VALUES (52858, '工位1', '29.1', '34.0', '20.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:51', '实时数据', 3);
INSERT INTO `t_data` VALUES (52859, '工位1', '29.1', '34.0', '20.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:52', '实时数据', 3);
INSERT INTO `t_data` VALUES (52860, '工位1', '29.1', '34.0', '20.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:53', '实时数据', 3);
INSERT INTO `t_data` VALUES (52861, '工位1', '29.1', '34.0', '20.4', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:55', '实时数据', 3);
INSERT INTO `t_data` VALUES (52862, '工位1', '29.1', '34.0', '20.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:55', '实时数据', 3);
INSERT INTO `t_data` VALUES (52863, '工位1', '29.1', '34.0', '17.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:56', '实时数据', 3);
INSERT INTO `t_data` VALUES (52864, '工位1', '29.1', '34.0', '17.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:57', '实时数据', 4);
INSERT INTO `t_data` VALUES (52865, '工位1', '29.1', '34.0', '17.1', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:46:58', '实时数据', 4);
INSERT INTO `t_data` VALUES (52866, '工位1', '29.1', '36.0', '17.9', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:47:54', '实时数据', 4);
INSERT INTO `t_data` VALUES (52867, '工位1', '29.1', '36.0', '19.8', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:47:55', '实时数据', 4);
INSERT INTO `t_data` VALUES (52868, '工位1', '29.1', '36.0', '19.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:47:56', '实时数据', 4);
INSERT INTO `t_data` VALUES (52869, '工位1', '29.1', '36.0', '19.8', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:47:57', '实时数据', 4);
INSERT INTO `t_data` VALUES (52870, '工位1', '29.1', '36.0', '19.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:47:58', '实时数据', 4);
INSERT INTO `t_data` VALUES (52871, '工位1', '29.1', '36.0', '19.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:00', '实时数据', 4);
INSERT INTO `t_data` VALUES (52872, '工位1', '29.1', '36.0', '19.9', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:00', '实时数据', 4);
INSERT INTO `t_data` VALUES (52873, '工位1', '29.1', '36.0', '19.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:01', '实时数据', 4);
INSERT INTO `t_data` VALUES (52874, '工位1', '29.1', '36.0', '19.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:03', '实时数据', 4);
INSERT INTO `t_data` VALUES (52875, '工位1', '29.1', '36.0', '19.2', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:03', '实时数据', 4);
INSERT INTO `t_data` VALUES (52876, '工位1', '29.1', '36.0', '19.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:04', '实时数据', 4);
INSERT INTO `t_data` VALUES (52877, '工位1', '29.1', '36.0', '18.5', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:06', '实时数据', 4);
INSERT INTO `t_data` VALUES (52878, '工位1', '29.1', '36.0', '18.6', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:06', '实时数据', 4);
INSERT INTO `t_data` VALUES (52879, '工位1', '29.1', '36.0', '18.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:07', '实时数据', 4);
INSERT INTO `t_data` VALUES (52880, '工位1', '29.1', '36.0', '18.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:08', '实时数据', 4);
INSERT INTO `t_data` VALUES (52881, '工位1', '29.1', '36.0', '18.7', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:09', '实时数据', 4);
INSERT INTO `t_data` VALUES (52882, '工位1', '29.1', '36.0', '18.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:10', '实时数据', 4);
INSERT INTO `t_data` VALUES (52883, '工位1', '29.1', '36.0', '18.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:11', '实时数据', 4);
INSERT INTO `t_data` VALUES (52884, '工位1', '29.1', '36.0', '18.7', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:12', '实时数据', 4);
INSERT INTO `t_data` VALUES (52885, '工位1', '29.1', '36.0', '18.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:13', '实时数据', 4);
INSERT INTO `t_data` VALUES (52886, '工位1', '29.1', '36.0', '19.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:14', '实时数据', 4);
INSERT INTO `t_data` VALUES (52887, '工位1', '29.1', '36.0', '20.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:15', '实时数据', 4);
INSERT INTO `t_data` VALUES (52888, '工位1', '29.1', '36.0', '18.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:17', '实时数据', 4);
INSERT INTO `t_data` VALUES (52889, '工位1', '29.1', '36.0', '18.4', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:18', '实时数据', 4);
INSERT INTO `t_data` VALUES (52890, '工位1', '29.1', '36.0', '20.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:19', '实时数据', 4);
INSERT INTO `t_data` VALUES (52891, '工位1', '29.1', '36.0', '20.5', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:20', '实时数据', 4);
INSERT INTO `t_data` VALUES (52892, '工位1', '29.1', '36.0', '19.9', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:21', '实时数据', 4);
INSERT INTO `t_data` VALUES (52893, '工位1', '29.1', '36.0', '20.1', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:22', '实时数据', 4);
INSERT INTO `t_data` VALUES (52894, '工位1', '29.1', '36.0', '18.3', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:23', '实时数据', 4);
INSERT INTO `t_data` VALUES (52895, '工位1', '29.1', '36.0', '18.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:24', '实时数据', 4);
INSERT INTO `t_data` VALUES (52896, '工位1', '29.1', '36.0', '18.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:25', '实时数据', 4);
INSERT INTO `t_data` VALUES (52897, '工位1', '29.1', '36.0', '18.9', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:26', '实时数据', 4);
INSERT INTO `t_data` VALUES (52898, '工位1', '29.1', '36.0', '18.9', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:27', '实时数据', 4);
INSERT INTO `t_data` VALUES (52899, '工位1', '29.1', '36.0', '19.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:28', '实时数据', 4);
INSERT INTO `t_data` VALUES (52900, '工位1', '29.1', '36.0', '19.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:29', '实时数据', 4);
INSERT INTO `t_data` VALUES (52901, '工位1', '29.1', '36.0', '18.8', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:30', '实时数据', 4);
INSERT INTO `t_data` VALUES (52902, '工位1', '29.1', '36.0', '19.1', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:31', '实时数据', 4);
INSERT INTO `t_data` VALUES (52903, '工位1', '29.1', '36.0', '18.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:33', '实时数据', 4);
INSERT INTO `t_data` VALUES (52904, '工位1', '29.1', '36.0', '18.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:33', '实时数据', 4);
INSERT INTO `t_data` VALUES (52905, '工位1', '29.1', '36.0', '18.3', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:34', '实时数据', 4);
INSERT INTO `t_data` VALUES (52906, '工位1', '29.1', '36.0', '18.6', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:35', '实时数据', 4);
INSERT INTO `t_data` VALUES (52907, '工位1', '29.1', '36.0', '18.7', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:37', '实时数据', 4);
INSERT INTO `t_data` VALUES (52908, '工位1', '29.1', '36.0', '18.6', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:37', '实时数据', 4);
INSERT INTO `t_data` VALUES (52909, '工位1', '29.1', '36.0', '18.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:38', '实时数据', 4);
INSERT INTO `t_data` VALUES (52910, '工位1', '29.1', '36.0', '18.6', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:39', '实时数据', 4);
INSERT INTO `t_data` VALUES (52911, '工位1', '29.1', '36.0', '18.8', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:40', '实时数据', 4);
INSERT INTO `t_data` VALUES (52912, '工位1', '29.1', '36.0', '18.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:41', '实时数据', 4);
INSERT INTO `t_data` VALUES (52913, '工位1', '29.1', '36.0', '18.8', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:42', '实时数据', 4);
INSERT INTO `t_data` VALUES (52914, '工位1', '29.1', '36.0', '20.2', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:43', '实时数据', 4);
INSERT INTO `t_data` VALUES (52915, '工位1', '29.1', '36.0', '18.5', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:44', '实时数据', 4);
INSERT INTO `t_data` VALUES (52916, '工位1', '29.1', '36.0', '18.4', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:45', '实时数据', 4);
INSERT INTO `t_data` VALUES (52917, '工位1', '29.1', '36.0', '18.5', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:46', '实时数据', 4);
INSERT INTO `t_data` VALUES (52918, '工位1', '29.1', '36.0', '18.4', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:47', '实时数据', 4);
INSERT INTO `t_data` VALUES (52919, '工位1', '29.1', '36.0', '18.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:49', '实时数据', 4);
INSERT INTO `t_data` VALUES (52920, '工位1', '29.1', '36.0', '18.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:49', '实时数据', 4);
INSERT INTO `t_data` VALUES (52921, '工位1', '29.1', '36.0', '18.6', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:50', '实时数据', 4);
INSERT INTO `t_data` VALUES (52922, '工位1', '29.1', '36.0', '18.6', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:51', '实时数据', 4);
INSERT INTO `t_data` VALUES (52923, '工位1', '29.1', '36.0', '18.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:53', '实时数据', 4);
INSERT INTO `t_data` VALUES (52924, '工位1', '29.1', '36.0', '19.5', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:53', '实时数据', 4);
INSERT INTO `t_data` VALUES (52925, '工位1', '29.1', '36.0', '19.5', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:54', '实时数据', 4);
INSERT INTO `t_data` VALUES (52926, '工位1', '29.1', '36.0', '20.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:55', '实时数据', 4);
INSERT INTO `t_data` VALUES (52927, '工位1', '29.1', '36.0', '20.6', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:56', '实时数据', 4);
INSERT INTO `t_data` VALUES (52928, '工位1', '29.1', '36.0', '20.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:57', '实时数据', 4);
INSERT INTO `t_data` VALUES (52929, '工位1', '29.1', '36.0', '20.7', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:48:58', '实时数据', 4);
INSERT INTO `t_data` VALUES (52930, '工位1', '29.1', '36.0', '19.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (52931, '工位1', '29.1', '36.0', '19.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (52932, '工位1', '29.1', '36.0', '19.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (52933, '工位1', '29.1', '36.0', '21', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (52934, '工位1', '29.1', '36.0', '27.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:09', '实时数据', 5);
INSERT INTO `t_data` VALUES (52935, '工位1', '29.1', '36.0', '27.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (52936, '工位1', '29.1', '36.0', '27.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (52937, '工位1', '29.1', '36.0', '21.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (52938, '工位1', '29.1', '36.0', '25.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (52939, '工位1', '29.1', '36.0', '24.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (52940, '工位1', '29.1', '36.0', '24.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (52941, '工位1', '29.1', '36.0', '25.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (52942, '工位1', '29.1', '36.0', '25.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (52943, '工位1', '29.1', '36.0', '26', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (52944, '工位1', '29.1', '36.0', '26.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (52945, '工位1', '29.1', '36.0', '25.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (52946, '工位1', '29.1', '36.0', '23.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (52947, '工位1', '29.1', '36.0', '24.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (52948, '工位1', '29.1', '36.0', '28.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (52949, '工位1', '29.1', '36.0', '28.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (52950, '工位1', '29.1', '36.0', '30.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (52951, '工位1', '29.1', '36.0', '29.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (52952, '工位1', '29.1', '36.0', '27.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (52953, '工位1', '29.1', '36.0', '29.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (52954, '工位1', '29.1', '36.0', '27', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (52955, '工位1', '29.1', '36.0', '25.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:31', '实时数据', 5);
INSERT INTO `t_data` VALUES (52956, '工位1', '29.1', '36.0', '25.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (52957, '工位1', '29.1', '36.0', '26.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (52958, '工位1', '29.1', '36.0', '28.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (52959, '工位1', '29.1', '36.0', '30.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (52960, '工位1', '29.1', '36.0', '31.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:36', '实时数据', 5);
INSERT INTO `t_data` VALUES (52961, '工位1', '29.1', '36.0', '33.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (52962, '工位1', '29.1', '36.0', '37.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (52963, '工位1', '29.1', '36.0', '38.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (52964, '工位1', '29.1', '36.0', '38.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (52965, '工位1', '29.1', '36.0', '38.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (52966, '工位1', '29.1', '36.0', '38.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:42', '实时数据', 5);
INSERT INTO `t_data` VALUES (52967, '工位1', '29.1', '36.0', '38.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:43', '实时数据', 5);
INSERT INTO `t_data` VALUES (52968, '工位1', '29.1', '36.0', '38.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:44', '实时数据', 5);
INSERT INTO `t_data` VALUES (52969, '工位1', '29.1', '36.0', '35.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:45', '实时数据', 5);
INSERT INTO `t_data` VALUES (52970, '工位1', '29.1', '36.0', '35.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:46', '实时数据', 5);
INSERT INTO `t_data` VALUES (52971, '工位1', '29.1', '36.0', '34.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:47', '实时数据', 5);
INSERT INTO `t_data` VALUES (52972, '工位1', '29.1', '36.0', '32.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:48', '实时数据', 5);
INSERT INTO `t_data` VALUES (52973, '工位1', '29.1', '36.0', '31.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:49', '实时数据', 5);
INSERT INTO `t_data` VALUES (52974, '工位1', '29.1', '36.0', '33.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:50', '实时数据', 5);
INSERT INTO `t_data` VALUES (52975, '工位1', '29.1', '36.0', '33.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:51', '实时数据', 5);
INSERT INTO `t_data` VALUES (52976, '工位1', '29.1', '36.0', '30.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:52', '实时数据', 5);
INSERT INTO `t_data` VALUES (52977, '工位1', '29.1', '36.0', '25.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:53', '实时数据', 5);
INSERT INTO `t_data` VALUES (52978, '工位1', '29.1', '36.0', '30.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:54', '实时数据', 5);
INSERT INTO `t_data` VALUES (52979, '工位1', '29.1', '36.0', '32', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:55', '实时数据', 5);
INSERT INTO `t_data` VALUES (52980, '工位1', '29.1', '36.0', '32.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:56', '实时数据', 5);
INSERT INTO `t_data` VALUES (52981, '工位1', '29.1', '36.0', '32.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:57', '实时数据', 5);
INSERT INTO `t_data` VALUES (52982, '工位1', '29.1', '36.0', '32.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:58', '实时数据', 5);
INSERT INTO `t_data` VALUES (52983, '工位1', '29.1', '36.0', '32.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:53:59', '实时数据', 5);
INSERT INTO `t_data` VALUES (52984, '工位1', '29.1', '36.0', '32.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:00', '实时数据', 5);
INSERT INTO `t_data` VALUES (52985, '工位1', '29.1', '36.0', '31.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:01', '实时数据', 5);
INSERT INTO `t_data` VALUES (52986, '工位1', '29.1', '36.0', '38.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:02', '实时数据', 5);
INSERT INTO `t_data` VALUES (52987, '工位1', '29.1', '36.0', '38.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:03', '实时数据', 5);
INSERT INTO `t_data` VALUES (52988, '工位1', '29.1', '36.0', '32.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:04', '实时数据', 5);
INSERT INTO `t_data` VALUES (52989, '工位1', '29.1', '36.0', '30.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (52990, '工位1', '29.1', '36.0', '39.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (52991, '工位1', '29.1', '36.0', '39.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (52992, '工位1', '29.1', '36.0', '39.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (52993, '工位1', '29.1', '36.0', '39.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (52994, '工位1', '29.1', '36.0', '39.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (52995, '工位1', '29.1', '36.0', '39.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (52996, '工位1', '29.1', '36.0', '39.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (52997, '工位1', '29.1', '36.0', '39.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:14', '实时数据', 5);
INSERT INTO `t_data` VALUES (52998, '工位1', '29.1', '36.0', '39.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (52999, '工位1', '29.1', '36.0', '31.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (53000, '工位1', '29.1', '36.0', '32.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (53001, '工位1', '29.1', '36.0', '32.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (53002, '工位1', '29.1', '36.0', '39.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (53003, '工位1', '29.1', '36.0', '39.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (53004, '工位1', '29.1', '36.0', '39.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (53005, '工位1', '29.1', '36.0', '39.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (53006, '工位1', '29.1', '36.0', '38.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (53007, '工位1', '29.1', '36.0', '38.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (53008, '工位1', '29.1', '36.0', '37.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (53009, '工位1', '29.1', '36.0', '37.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (53010, '工位1', '29.1', '36.0', '36.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (53011, '工位1', '29.1', '36.0', '39.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (53012, '工位1', '29.1', '36.0', '38.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (53013, '工位1', '29.1', '36.0', '38.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (53014, '工位1', '29.1', '36.0', '38.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:31', '实时数据', 5);
INSERT INTO `t_data` VALUES (53015, '工位1', '29.1', '36.0', '38.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (53016, '工位1', '29.1', '36.0', '38.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (53017, '工位1', '29.1', '36.0', '38.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (53018, '工位1', '29.1', '36.0', '38.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (53019, '工位1', '29.1', '36.0', '38.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:36', '实时数据', 5);
INSERT INTO `t_data` VALUES (53020, '工位1', '29.1', '36.0', '38.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (53021, '工位1', '29.1', '36.0', '39', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (53022, '工位1', '29.1', '36.0', '38.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (53023, '工位1', '29.1', '36.0', '38.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (53024, '工位1', '29.1', '36.0', '37', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (53025, '工位1', '29.1', '36.0', '39.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:42', '实时数据', 5);
INSERT INTO `t_data` VALUES (53026, '工位1', '29.1', '36.0', '39.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:43', '实时数据', 5);
INSERT INTO `t_data` VALUES (53027, '工位1', '29.1', '36.0', '38.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:44', '实时数据', 5);
INSERT INTO `t_data` VALUES (53028, '工位1', '29.1', '36.0', '38.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:45', '实时数据', 5);
INSERT INTO `t_data` VALUES (53029, '工位1', '29.1', '36.0', '36.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:46', '实时数据', 5);
INSERT INTO `t_data` VALUES (53030, '工位1', '29.1', '36.0', '37.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:47', '实时数据', 5);
INSERT INTO `t_data` VALUES (53031, '工位1', '29.1', '36.0', '38.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:48', '实时数据', 5);
INSERT INTO `t_data` VALUES (53032, '工位1', '29.1', '36.0', '38.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:49', '实时数据', 5);
INSERT INTO `t_data` VALUES (53033, '工位1', '29.1', '36.0', '39.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:50', '实时数据', 5);
INSERT INTO `t_data` VALUES (53034, '工位1', '29.1', '36.0', '39.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:51', '实时数据', 5);
INSERT INTO `t_data` VALUES (53035, '工位1', '29.1', '36.0', '39.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:52', '实时数据', 5);
INSERT INTO `t_data` VALUES (53036, '工位1', '29.1', '36.0', '39.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:53', '实时数据', 5);
INSERT INTO `t_data` VALUES (53037, '工位1', '29.1', '36.0', '39.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:54', '实时数据', 5);
INSERT INTO `t_data` VALUES (53038, '工位1', '29.1', '36.0', '39.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:55', '实时数据', 5);
INSERT INTO `t_data` VALUES (53039, '工位1', '29.1', '36.0', '37.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:56', '实时数据', 5);
INSERT INTO `t_data` VALUES (53040, '工位1', '29.1', '36.0', '37.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:57', '实时数据', 5);
INSERT INTO `t_data` VALUES (53041, '工位1', '29.1', '36.0', '38', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:58', '实时数据', 5);
INSERT INTO `t_data` VALUES (53042, '工位1', '29.1', '36.0', '38.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:54:59', '实时数据', 5);
INSERT INTO `t_data` VALUES (53043, '工位1', '29.1', '36.0', '38.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:00', '实时数据', 5);
INSERT INTO `t_data` VALUES (53044, '工位1', '29.1', '36.0', '37.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:01', '实时数据', 5);
INSERT INTO `t_data` VALUES (53045, '工位1', '29.1', '36.0', '37.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:02', '实时数据', 5);
INSERT INTO `t_data` VALUES (53046, '工位1', '29.1', '36.0', '37.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:04', '实时数据', 5);
INSERT INTO `t_data` VALUES (53047, '工位1', '29.1', '36.0', '37.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (53048, '工位1', '29.1', '36.0', '33', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (53049, '工位1', '29.1', '36.0', '33.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (53050, '工位1', '29.1', '36.0', '35.4', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (53051, '工位1', '29.1', '36.0', '33.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:09', '实时数据', 5);
INSERT INTO `t_data` VALUES (53052, '工位1', '29.1', '36.0', '33.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (53053, '工位1', '29.1', '36.0', '33.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (53054, '工位1', '29.1', '36.0', '34.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (53055, '工位1', '29.1', '36.0', '33.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (53056, '工位1', '29.1', '36.0', '34.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:14', '实时数据', 5);
INSERT INTO `t_data` VALUES (53057, '工位1', '29.1', '36.0', '34.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (53058, '工位1', '29.1', '36.0', '35.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (53059, '工位1', '29.1', '36.0', '35.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (53060, '工位1', '29.1', '36.0', '35.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (53061, '工位1', '28.8', '36.0', '35.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (53062, '工位1', '28.8', '36.0', '35.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (53063, '工位1', '28.8', '36.0', '36.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (53064, '工位1', '28.8', '36.0', '35.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (53065, '工位1', '28.8', '36.0', '35.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (53066, '工位1', '28.8', '36.0', '35.7', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (53067, '工位1', '28.8', '36.0', '36.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (53068, '工位1', '28.8', '36.0', '36.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (53069, '工位1', '28.8', '36.0', '36.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (53070, '工位1', '28.8', '36.0', '37', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (53071, '工位1', '28.8', '36.0', '37', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (53072, '工位1', '28.8', '36.0', '37', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (53073, '工位1', '28.8', '36.0', '36.6', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:31', '实时数据', 5);
INSERT INTO `t_data` VALUES (53074, '工位1', '28.8', '36.0', '35.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (53075, '工位1', '28.8', '36.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (53076, '工位1', '28.8', '36.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (53077, '工位1', '28.8', '36.0', '37.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (53078, '工位1', '28.8', '36.0', '36.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:36', '实时数据', 5);
INSERT INTO `t_data` VALUES (53079, '工位1', '28.8', '36.0', '39.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (53080, '工位1', '28.8', '36.0', '39.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (53081, '工位1', '28.8', '36.0', '33.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (53082, '工位1', '28.8', '36.0', '36.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (53083, '工位1', '28.8', '36.0', '36.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (53084, '工位1', '28.8', '36.0', '36.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:42', '实时数据', 5);
INSERT INTO `t_data` VALUES (53085, '工位1', '28.8', '36.0', '37', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:43', '实时数据', 5);
INSERT INTO `t_data` VALUES (53086, '工位1', '28.8', '36.0', '39.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:44', '实时数据', 5);
INSERT INTO `t_data` VALUES (53087, '工位1', '28.8', '36.0', '39.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:45', '实时数据', 5);
INSERT INTO `t_data` VALUES (53088, '工位1', '28.8', '36.0', '39.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:46', '实时数据', 5);
INSERT INTO `t_data` VALUES (53089, '工位1', '28.8', '36.0', '39.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:47', '实时数据', 5);
INSERT INTO `t_data` VALUES (53090, '工位1', '28.8', '38.1', '39.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:48', '实时数据', 5);
INSERT INTO `t_data` VALUES (53091, '工位1', '28.8', '38.0', '39.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:49', '实时数据', 5);
INSERT INTO `t_data` VALUES (53092, '工位1', '28.8', '38.0', '40.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:50', '实时数据', 5);
INSERT INTO `t_data` VALUES (53093, '工位1', '28.8', '38.0', '40.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:51', '实时数据', 5);
INSERT INTO `t_data` VALUES (53094, '工位1', '28.8', '38.0', '39.8', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:52', '实时数据', 5);
INSERT INTO `t_data` VALUES (53095, '工位1', '28.8', '38.0', '39.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:53', '实时数据', 5);
INSERT INTO `t_data` VALUES (53096, '工位1', '28.8', '38.0', '39.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:54', '实时数据', 5);
INSERT INTO `t_data` VALUES (53097, '工位1', '28.8', '38.0', '39.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:55', '实时数据', 5);
INSERT INTO `t_data` VALUES (53098, '工位1', '28.8', '38.0', '35.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:56', '实时数据', 5);
INSERT INTO `t_data` VALUES (53099, '工位1', '28.8', '38.0', '33.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:57', '实时数据', 5);
INSERT INTO `t_data` VALUES (53100, '工位1', '28.8', '38.0', '37', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:55:58', '实时数据', 5);
INSERT INTO `t_data` VALUES (53101, '工位1', '28.8', '38.0', '38.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:00', '实时数据', 5);
INSERT INTO `t_data` VALUES (53102, '工位1', '28.8', '38.0', '39.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:01', '实时数据', 5);
INSERT INTO `t_data` VALUES (53103, '工位1', '28.8', '38.0', '38.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:02', '实时数据', 5);
INSERT INTO `t_data` VALUES (53104, '工位1', '28.8', '38.0', '37.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:03', '实时数据', 5);
INSERT INTO `t_data` VALUES (53105, '工位1', '28.8', '38.0', '37.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:04', '实时数据', 5);
INSERT INTO `t_data` VALUES (53106, '工位1', '28.8', '38.0', '35.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (53107, '工位1', '28.8', '38.0', '35.3', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (53108, '工位1', '28.8', '38.0', '35.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (53109, '工位1', '28.8', '38.0', '35.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (53110, '工位1', '28.8', '38.0', '35.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:09', '实时数据', 5);
INSERT INTO `t_data` VALUES (53111, '工位1', '28.8', '38.0', '35.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (53112, '工位1', '28.8', '38.0', '34.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (53113, '工位1', '28.8', '38.0', '33.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (53114, '工位1', '28.8', '38.0', '33.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (53115, '工位1', '28.8', '38.0', '35.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:14', '实时数据', 5);
INSERT INTO `t_data` VALUES (53116, '工位1', '28.8', '38.0', '35.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (53117, '工位1', '28.8', '38.0', '37.1', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (53118, '工位1', '28.8', '38.0', '37.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (53119, '工位1', '28.8', '38.0', '37.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (53120, '工位1', '28.8', '38.0', '34.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (53121, '工位1', '28.8', '38.0', '34.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (53122, '工位1', '28.8', '38.0', '36.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (53123, '工位1', '28.8', '38.0', '35.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (53124, '工位1', '28.8', '38.0', '33.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (53125, '工位1', '28.8', '38.0', '36', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (53126, '工位1', '28.8', '38.0', '36.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (53127, '工位1', '28.8', '38.0', '36.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (53128, '工位1', '28.8', '38.0', '34.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (53129, '工位1', '28.8', '38.0', '33.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (53130, '工位1', '28.8', '38.0', '35.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (53131, '工位1', '28.8', '38.0', '34.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (53132, '工位1', '28.8', '38.0', '35.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:31', '实时数据', 5);
INSERT INTO `t_data` VALUES (53133, '工位1', '28.8', '38.0', '35.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (53134, '工位1', '28.8', '38.0', '35.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (53135, '工位1', '28.8', '38.0', '35.9', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (53136, '工位1', '28.8', '38.0', '36', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (53137, '工位1', '28.8', '38.0', '35.5', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:36', '实时数据', 5);
INSERT INTO `t_data` VALUES (53138, '工位1', '28.8', '38.0', '37.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (53139, '工位1', '28.8', '38.0', '40.2', '4.94', '0.13', '0.6422000000000001', '0.13', '0.6422000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (53140, '工位1', '28.8', '38.0', '34.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (53141, '工位1', '28.8', '38.0', '34.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (53142, '工位1', '28.8', '38.0', '34.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (53143, '工位1', '28.8', '38.0', '36.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:42', '实时数据', 5);
INSERT INTO `t_data` VALUES (53144, '工位1', '28.8', '38.0', '36.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:43', '实时数据', 5);
INSERT INTO `t_data` VALUES (53145, '工位1', '28.8', '38.0', '35.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:44', '实时数据', 5);
INSERT INTO `t_data` VALUES (53146, '工位1', '28.8', '38.0', '34.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:45', '实时数据', 5);
INSERT INTO `t_data` VALUES (53147, '工位1', '28.8', '38.0', '31.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:46', '实时数据', 5);
INSERT INTO `t_data` VALUES (53148, '工位1', '28.8', '38.0', '30', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:47', '实时数据', 5);
INSERT INTO `t_data` VALUES (53149, '工位1', '28.8', '38.0', '30', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:48', '实时数据', 5);
INSERT INTO `t_data` VALUES (53150, '工位1', '28.8', '38.0', '30.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:49', '实时数据', 5);
INSERT INTO `t_data` VALUES (53151, '工位1', '28.8', '38.0', '27.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:50', '实时数据', 5);
INSERT INTO `t_data` VALUES (53152, '工位1', '28.8', '38.0', '28.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:51', '实时数据', 5);
INSERT INTO `t_data` VALUES (53153, '工位1', '28.8', '38.0', '32.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:52', '实时数据', 5);
INSERT INTO `t_data` VALUES (53154, '工位1', '28.8', '38.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:53', '实时数据', 5);
INSERT INTO `t_data` VALUES (53155, '工位1', '28.8', '38.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:55', '实时数据', 5);
INSERT INTO `t_data` VALUES (53156, '工位1', '28.8', '38.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:56', '实时数据', 5);
INSERT INTO `t_data` VALUES (53157, '工位1', '28.8', '38.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:57', '实时数据', 5);
INSERT INTO `t_data` VALUES (53158, '工位1', '28.8', '38.0', '33.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:58', '实时数据', 5);
INSERT INTO `t_data` VALUES (53159, '工位1', '28.8', '38.0', '34.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:56:59', '实时数据', 5);
INSERT INTO `t_data` VALUES (53160, '工位1', '28.8', '38.0', '33.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:00', '实时数据', 5);
INSERT INTO `t_data` VALUES (53161, '工位1', '28.8', '38.0', '33.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:01', '实时数据', 5);
INSERT INTO `t_data` VALUES (53162, '工位1', '28.8', '38.0', '33.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:02', '实时数据', 5);
INSERT INTO `t_data` VALUES (53163, '工位1', '28.8', '38.0', '33.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:03', '实时数据', 5);
INSERT INTO `t_data` VALUES (53164, '工位1', '28.8', '38.0', '33.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:04', '实时数据', 5);
INSERT INTO `t_data` VALUES (53165, '工位1', '28.8', '38.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (53166, '工位1', '28.8', '38.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (53167, '工位1', '28.8', '38.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (53168, '工位1', '28.8', '38.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (53169, '工位1', '28.8', '38.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:09', '实时数据', 5);
INSERT INTO `t_data` VALUES (53170, '工位1', '28.8', '38.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (53171, '工位1', '28.8', '38.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (53172, '工位1', '28.8', '38.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (53173, '工位1', '28.8', '38.0', '36', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (53174, '工位1', '28.8', '38.0', '32', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:14', '实时数据', 5);
INSERT INTO `t_data` VALUES (53175, '工位1', '28.8', '38.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (53176, '工位1', '28.8', '38.0', '32.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (53177, '工位1', '28.8', '38.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (53178, '工位1', '28.8', '38.0', '31.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (53179, '工位1', '28.8', '38.0', '31.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (53180, '工位1', '28.8', '38.0', '28.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (53181, '工位1', '28.8', '38.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (53182, '工位1', '28.8', '38.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (53183, '工位1', '28.8', '38.0', '33.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (53184, '工位1', '28.8', '38.0', '33.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (53185, '工位1', '28.8', '38.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (53186, '工位1', '28.8', '38.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (53187, '工位1', '28.8', '38.0', '33.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (53188, '工位1', '28.8', '38.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (53189, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (53190, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (53191, '工位1', '28.8', '40.0', '33.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:31', '实时数据', 5);
INSERT INTO `t_data` VALUES (53192, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (53193, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (53194, '工位1', '28.8', '40.0', '33.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (53195, '工位1', '28.8', '40.0', '32.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (53196, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:36', '实时数据', 5);
INSERT INTO `t_data` VALUES (53197, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (53198, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (53199, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (53200, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (53201, '工位1', '28.8', '40.0', '33.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (53202, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:42', '实时数据', 5);
INSERT INTO `t_data` VALUES (53203, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:43', '实时数据', 5);
INSERT INTO `t_data` VALUES (53204, '工位1', '28.8', '40.0', '32.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:44', '实时数据', 5);
INSERT INTO `t_data` VALUES (53205, '工位1', '28.8', '40.0', '33.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:45', '实时数据', 5);
INSERT INTO `t_data` VALUES (53206, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:46', '实时数据', 5);
INSERT INTO `t_data` VALUES (53207, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:47', '实时数据', 5);
INSERT INTO `t_data` VALUES (53208, '工位1', '28.8', '40.0', '35.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:49', '实时数据', 5);
INSERT INTO `t_data` VALUES (53209, '工位1', '28.8', '40.0', '33.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:50', '实时数据', 5);
INSERT INTO `t_data` VALUES (53210, '工位1', '28.8', '40.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:51', '实时数据', 5);
INSERT INTO `t_data` VALUES (53211, '工位1', '28.8', '40.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:52', '实时数据', 5);
INSERT INTO `t_data` VALUES (53212, '工位1', '28.8', '40.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:53', '实时数据', 5);
INSERT INTO `t_data` VALUES (53213, '工位1', '28.8', '40.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:54', '实时数据', 5);
INSERT INTO `t_data` VALUES (53214, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:55', '实时数据', 5);
INSERT INTO `t_data` VALUES (53215, '工位1', '28.8', '40.0', '33.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:56', '实时数据', 5);
INSERT INTO `t_data` VALUES (53216, '工位1', '28.8', '40.0', '33.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:57', '实时数据', 5);
INSERT INTO `t_data` VALUES (53217, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:58', '实时数据', 5);
INSERT INTO `t_data` VALUES (53218, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:57:59', '实时数据', 5);
INSERT INTO `t_data` VALUES (53219, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:00', '实时数据', 5);
INSERT INTO `t_data` VALUES (53220, '工位1', '28.8', '40.0', '32.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:01', '实时数据', 5);
INSERT INTO `t_data` VALUES (53221, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:02', '实时数据', 5);
INSERT INTO `t_data` VALUES (53222, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:03', '实时数据', 5);
INSERT INTO `t_data` VALUES (53223, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:04', '实时数据', 5);
INSERT INTO `t_data` VALUES (53224, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (53225, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (53226, '工位1', '28.8', '40.0', '33.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (53227, '工位1', '28.8', '40.0', '33.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (53228, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:09', '实时数据', 5);
INSERT INTO `t_data` VALUES (53229, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (53230, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (53231, '工位1', '28.8', '40.0', '32.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (53232, '工位1', '28.8', '40.0', '32.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (53233, '工位1', '28.8', '40.0', '32.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:14', '实时数据', 5);
INSERT INTO `t_data` VALUES (53234, '工位1', '28.8', '40.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (53235, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (53236, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (53237, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (53238, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (53239, '工位1', '28.8', '40.0', '33.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (53240, '工位1', '28.8', '40.0', '33.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (53241, '工位1', '28.8', '40.0', '33.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (53242, '工位1', '28.8', '40.0', '32.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (53243, '工位1', '28.8', '40.0', '32.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (53244, '工位1', '28.8', '40.0', '32.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (53245, '工位1', '28.8', '40.0', '31.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (53246, '工位1', '28.8', '40.0', '32.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (53247, '工位1', '28.8', '40.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (53248, '工位1', '28.8', '40.0', '33.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (53249, '工位1', '28.8', '40.0', '33.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (53250, '工位1', '28.8', '40.0', '33.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:31', '实时数据', 5);
INSERT INTO `t_data` VALUES (53251, '工位1', '28.8', '40.0', '33.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (53252, '工位1', '28.8', '40.0', '33.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (53253, '工位1', '28.8', '40.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (53254, '工位1', '28.8', '40.0', '32.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (53255, '工位1', '28.8', '40.0', '32.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:36', '实时数据', 5);
INSERT INTO `t_data` VALUES (53256, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (53257, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (53258, '工位1', '28.8', '40.0', '32.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (53259, '工位1', '28.8', '40.0', '31.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (53260, '工位1', '28.8', '40.0', '31.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (53261, '工位1', '28.8', '40.0', '32.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:42', '实时数据', 5);
INSERT INTO `t_data` VALUES (53262, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:44', '实时数据', 5);
INSERT INTO `t_data` VALUES (53263, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:45', '实时数据', 5);
INSERT INTO `t_data` VALUES (53264, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:46', '实时数据', 5);
INSERT INTO `t_data` VALUES (53265, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:47', '实时数据', 5);
INSERT INTO `t_data` VALUES (53266, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:48', '实时数据', 5);
INSERT INTO `t_data` VALUES (53267, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:49', '实时数据', 5);
INSERT INTO `t_data` VALUES (53268, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:50', '实时数据', 5);
INSERT INTO `t_data` VALUES (53269, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:51', '实时数据', 5);
INSERT INTO `t_data` VALUES (53270, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:52', '实时数据', 5);
INSERT INTO `t_data` VALUES (53271, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:53', '实时数据', 5);
INSERT INTO `t_data` VALUES (53272, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:54', '实时数据', 5);
INSERT INTO `t_data` VALUES (53273, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:55', '实时数据', 5);
INSERT INTO `t_data` VALUES (53274, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:56', '实时数据', 5);
INSERT INTO `t_data` VALUES (53275, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:57', '实时数据', 5);
INSERT INTO `t_data` VALUES (53276, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:58', '实时数据', 5);
INSERT INTO `t_data` VALUES (53277, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:58:59', '实时数据', 5);
INSERT INTO `t_data` VALUES (53278, '工位1', '28.8', '40.0', '33.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:00', '实时数据', 5);
INSERT INTO `t_data` VALUES (53279, '工位1', '28.8', '40.0', '32.7', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:01', '实时数据', 5);
INSERT INTO `t_data` VALUES (53280, '工位1', '28.8', '40.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:02', '实时数据', 5);
INSERT INTO `t_data` VALUES (53281, '工位1', '28.8', '40.0', '32.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:03', '实时数据', 5);
INSERT INTO `t_data` VALUES (53282, '工位1', '28.8', '40.0', '33', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:04', '实时数据', 5);
INSERT INTO `t_data` VALUES (53283, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (53284, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (53285, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (53286, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (53287, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:09', '实时数据', 5);
INSERT INTO `t_data` VALUES (53288, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (53289, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (53290, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (53291, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (53292, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:14', '实时数据', 5);
INSERT INTO `t_data` VALUES (53293, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (53294, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (53295, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (53296, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (53297, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (53298, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (53299, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (53300, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (53301, '工位1', '28.8', '40.0', '32.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (53302, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (53303, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (53304, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (53305, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (53306, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (53307, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (53308, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (53309, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:31', '实时数据', 5);
INSERT INTO `t_data` VALUES (53310, '工位1', '28.8', '40.0', '32.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (53311, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (53312, '工位1', '28.8', '40.0', '32.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (53313, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (53314, '工位1', '28.8', '40.0', '32.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (53315, '工位1', '28.8', '40.0', '32.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (53316, '工位1', '28.8', '40.0', '32.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (53317, '工位1', '28.8', '40.0', '30.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (53318, '工位1', '28.8', '40.0', '29.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (53319, '工位1', '28.8', '40.0', '29.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:42', '实时数据', 5);
INSERT INTO `t_data` VALUES (53320, '工位1', '28.8', '40.0', '29.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:43', '实时数据', 5);
INSERT INTO `t_data` VALUES (53321, '工位1', '28.8', '40.0', '29.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:44', '实时数据', 5);
INSERT INTO `t_data` VALUES (53322, '工位1', '28.8', '40.0', '29.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:45', '实时数据', 5);
INSERT INTO `t_data` VALUES (53323, '工位1', '28.8', '40.0', '28.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:46', '实时数据', 5);
INSERT INTO `t_data` VALUES (53324, '工位1', '28.8', '40.0', '29.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:47', '实时数据', 5);
INSERT INTO `t_data` VALUES (53325, '工位1', '28.8', '40.0', '29.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:48', '实时数据', 5);
INSERT INTO `t_data` VALUES (53326, '工位1', '28.8', '40.0', '29.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:49', '实时数据', 5);
INSERT INTO `t_data` VALUES (53327, '工位1', '28.8', '40.0', '29.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:50', '实时数据', 5);
INSERT INTO `t_data` VALUES (53328, '工位1', '28.8', '40.0', '31.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:51', '实时数据', 5);
INSERT INTO `t_data` VALUES (53329, '工位1', '28.8', '40.0', '30.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:52', '实时数据', 5);
INSERT INTO `t_data` VALUES (53330, '工位1', '28.8', '40.0', '30.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:53', '实时数据', 5);
INSERT INTO `t_data` VALUES (53331, '工位1', '28.8', '40.0', '31.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:54', '实时数据', 5);
INSERT INTO `t_data` VALUES (53332, '工位1', '28.8', '40.0', '31.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:55', '实时数据', 5);
INSERT INTO `t_data` VALUES (53333, '工位1', '28.8', '40.0', '30.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:56', '实时数据', 5);
INSERT INTO `t_data` VALUES (53334, '工位1', '28.8', '40.0', '30.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:57', '实时数据', 5);
INSERT INTO `t_data` VALUES (53335, '工位1', '28.8', '40.0', '30.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:58', '实时数据', 5);
INSERT INTO `t_data` VALUES (53336, '工位1', '28.8', '40.0', '30.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:59:59', '实时数据', 5);
INSERT INTO `t_data` VALUES (53337, '工位1', '28.8', '40.0', '30.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:00', '实时数据', 5);
INSERT INTO `t_data` VALUES (53338, '工位1', '28.8', '40.0', '30.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:01', '实时数据', 5);
INSERT INTO `t_data` VALUES (53339, '工位1', '28.8', '40.0', '30.5', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:02', '实时数据', 5);
INSERT INTO `t_data` VALUES (53340, '工位1', '28.8', '40.0', '32.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:03', '实时数据', 5);
INSERT INTO `t_data` VALUES (53341, '工位1', '28.8', '40.0', '31.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:04', '实时数据', 5);
INSERT INTO `t_data` VALUES (53342, '工位1', '28.8', '40.0', '32', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:05', '实时数据', 5);
INSERT INTO `t_data` VALUES (53343, '工位1', '28.8', '40.0', '32', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:06', '实时数据', 5);
INSERT INTO `t_data` VALUES (53344, '工位1', '28.8', '40.0', '31.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:07', '实时数据', 5);
INSERT INTO `t_data` VALUES (53345, '工位1', '28.8', '40.0', '31.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:08', '实时数据', 5);
INSERT INTO `t_data` VALUES (53346, '工位1', '28.8', '40.0', '31.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:09', '实时数据', 5);
INSERT INTO `t_data` VALUES (53347, '工位1', '28.8', '40.0', '32', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:10', '实时数据', 5);
INSERT INTO `t_data` VALUES (53348, '工位1', '28.8', '40.0', '31.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:11', '实时数据', 5);
INSERT INTO `t_data` VALUES (53349, '工位1', '28.8', '40.0', '31.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:12', '实时数据', 5);
INSERT INTO `t_data` VALUES (53350, '工位1', '28.8', '40.0', '31.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:13', '实时数据', 5);
INSERT INTO `t_data` VALUES (53351, '工位1', '28.8', '40.0', '30.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:14', '实时数据', 5);
INSERT INTO `t_data` VALUES (53352, '工位1', '28.8', '40.0', '30.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:15', '实时数据', 5);
INSERT INTO `t_data` VALUES (53353, '工位1', '28.8', '40.0', '30.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:16', '实时数据', 5);
INSERT INTO `t_data` VALUES (53354, '工位1', '28.8', '40.0', '30.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:17', '实时数据', 5);
INSERT INTO `t_data` VALUES (53355, '工位1', '28.8', '40.0', '25.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:18', '实时数据', 5);
INSERT INTO `t_data` VALUES (53356, '工位1', '28.8', '40.0', '23.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:19', '实时数据', 5);
INSERT INTO `t_data` VALUES (53357, '工位1', '28.8', '40.0', '23.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:20', '实时数据', 5);
INSERT INTO `t_data` VALUES (53358, '工位1', '28.8', '40.0', '23.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:21', '实时数据', 5);
INSERT INTO `t_data` VALUES (53359, '工位1', '28.8', '40.0', '23.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:22', '实时数据', 5);
INSERT INTO `t_data` VALUES (53360, '工位1', '28.8', '40.0', '23.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:23', '实时数据', 5);
INSERT INTO `t_data` VALUES (53361, '工位1', '28.8', '40.0', '30.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:24', '实时数据', 5);
INSERT INTO `t_data` VALUES (53362, '工位1', '28.8', '40.0', '31.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:25', '实时数据', 5);
INSERT INTO `t_data` VALUES (53363, '工位1', '28.8', '40.0', '31.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:26', '实时数据', 5);
INSERT INTO `t_data` VALUES (53364, '工位1', '28.8', '40.0', '31.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:27', '实时数据', 5);
INSERT INTO `t_data` VALUES (53365, '工位1', '28.8', '40.0', '31.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:28', '实时数据', 5);
INSERT INTO `t_data` VALUES (53366, '工位1', '28.8', '40.0', '31.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:29', '实时数据', 5);
INSERT INTO `t_data` VALUES (53367, '工位1', '28.8', '40.0', '31.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:30', '实时数据', 5);
INSERT INTO `t_data` VALUES (53368, '工位1', '28.8', '40.0', '31.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:32', '实时数据', 5);
INSERT INTO `t_data` VALUES (53369, '工位1', '28.8', '40.0', '31.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:33', '实时数据', 5);
INSERT INTO `t_data` VALUES (53370, '工位1', '28.8', '40.0', '31.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:34', '实时数据', 5);
INSERT INTO `t_data` VALUES (53371, '工位1', '28.8', '40.0', '31.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:35', '实时数据', 5);
INSERT INTO `t_data` VALUES (53372, '工位1', '28.8', '40.0', '31.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:36', '实时数据', 5);
INSERT INTO `t_data` VALUES (53373, '工位1', '28.8', '40.0', '31.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:37', '实时数据', 5);
INSERT INTO `t_data` VALUES (53374, '工位1', '28.8', '40.0', '31.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:38', '实时数据', 5);
INSERT INTO `t_data` VALUES (53375, '工位1', '28.8', '40.0', '31.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:39', '实时数据', 5);
INSERT INTO `t_data` VALUES (53376, '工位1', '28.8', '40.0', '31.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:40', '实时数据', 5);
INSERT INTO `t_data` VALUES (53377, '工位1', '28.8', '40.0', '31.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:00:41', '实时数据', 5);
INSERT INTO `t_data` VALUES (53378, '工位1', '28.8', '44.1', '37', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:00', '实时数据', 6);
INSERT INTO `t_data` VALUES (53379, '工位1', '28.8', '44.1', '40.6', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:01', '实时数据', 6);
INSERT INTO `t_data` VALUES (53380, '工位1', '28.8', '44.1', '38.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:02', '实时数据', 6);
INSERT INTO `t_data` VALUES (53381, '工位1', '28.8', '44.1', '38.7', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:03', '实时数据', 6);
INSERT INTO `t_data` VALUES (53382, '工位1', '28.8', '44.1', '39.6', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:04', '实时数据', 6);
INSERT INTO `t_data` VALUES (53383, '工位1', '28.8', '44.1', '36', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:05', '实时数据', 6);
INSERT INTO `t_data` VALUES (53384, '工位1', '28.8', '43.8', '31.1', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53385, '工位1', '28.8', '43.8', '32.9', '5.04', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53386, '工位1', '28.8', '43.8', '32.9', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53387, '工位1', '28.8', '43.8', '32.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53388, '工位1', '28.8', '43.8', '35.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53389, '工位1', '28.8', '43.8', '39.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53390, '工位1', '28.8', '43.8', '40.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53391, '工位1', '28.8', '43.8', '40.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53392, '工位1', '28.8', '43.8', '39', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53393, '工位1', '28.8', '43.8', '41.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53394, '工位1', '28.8', '43.8', '41.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53395, '工位1', '28.8', '43.8', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:33', '实时数据', 7);
INSERT INTO `t_data` VALUES (53396, '工位1', '28.8', '43.8', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53397, '工位1', '28.8', '43.8', '41.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53398, '工位1', '28.8', '43.8', '41.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53399, '工位1', '28.8', '43.8', '41.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53400, '工位1', '28.8', '43.8', '41.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (53401, '工位1', '28.8', '43.8', '37.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53402, '工位1', '28.8', '43.8', '37.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53403, '工位1', '28.8', '43.8', '43.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53404, '工位1', '28.8', '43.8', '42.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53405, '工位1', '28.8', '43.8', '43.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53406, '工位1', '28.8', '43.8', '42', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (53407, '工位1', '28.8', '43.8', '39.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53408, '工位1', '28.8', '43.8', '39.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53409, '工位1', '28.8', '43.8', '39.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53410, '工位1', '28.8', '43.8', '38.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:48', '实时数据', 7);
INSERT INTO `t_data` VALUES (53411, '工位1', '28.8', '43.8', '38', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53412, '工位1', '28.8', '43.8', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53413, '工位1', '28.8', '43.8', '47.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53414, '工位1', '28.8', '43.8', '47.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53415, '工位1', '28.8', '43.7', '47.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53416, '工位1', '28.8', '43.7', '47.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53417, '工位1', '28.8', '43.7', '47.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53418, '工位1', '28.8', '43.7', '47.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53419, '工位1', '28.8', '43.7', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53420, '工位1', '28.8', '43.7', '46', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53421, '工位1', '28.8', '43.7', '46.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53422, '工位1', '28.8', '43.7', '46.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53423, '工位1', '28.8', '43.7', '44.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53424, '工位1', '28.8', '43.7', '45.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53425, '工位1', '28.8', '43.6', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:03', '实时数据', 7);
INSERT INTO `t_data` VALUES (53426, '工位1', '28.8', '43.6', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53427, '工位1', '28.8', '43.6', '39.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53428, '工位1', '28.8', '43.6', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53429, '工位1', '28.8', '43.6', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53430, '工位1', '28.8', '43.6', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53431, '工位1', '28.8', '43.6', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53432, '工位1', '28.8', '43.6', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53433, '工位1', '28.8', '43.6', '43.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53434, '工位1', '28.8', '43.6', '42.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53435, '工位1', '28.8', '43.6', '39.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:14', '实时数据', 7);
INSERT INTO `t_data` VALUES (53436, '工位1', '28.8', '43.6', '39.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:15', '实时数据', 7);
INSERT INTO `t_data` VALUES (53437, '工位1', '28.8', '43.6', '39', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:16', '实时数据', 7);
INSERT INTO `t_data` VALUES (53438, '工位1', '28.8', '43.6', '38', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:17', '实时数据', 7);
INSERT INTO `t_data` VALUES (53439, '工位1', '28.8', '43.5', '37.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:18', '实时数据', 7);
INSERT INTO `t_data` VALUES (53440, '工位1', '28.8', '43.5', '37.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:19', '实时数据', 7);
INSERT INTO `t_data` VALUES (53441, '工位1', '28.8', '43.5', '37.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:20', '实时数据', 7);
INSERT INTO `t_data` VALUES (53442, '工位1', '28.8', '43.5', '37.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:21', '实时数据', 7);
INSERT INTO `t_data` VALUES (53443, '工位1', '28.8', '43.5', '38.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:22', '实时数据', 7);
INSERT INTO `t_data` VALUES (53444, '工位1', '28.8', '43.5', '38.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:23', '实时数据', 7);
INSERT INTO `t_data` VALUES (53445, '工位1', '28.8', '43.4', '40.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:24', '实时数据', 7);
INSERT INTO `t_data` VALUES (53446, '工位1', '28.8', '43.4', '40.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:25', '实时数据', 7);
INSERT INTO `t_data` VALUES (53447, '工位1', '28.8', '43.4', '40.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53448, '工位1', '28.8', '43.4', '39.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53449, '工位1', '28.8', '43.4', '40.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53450, '工位1', '28.8', '43.4', '40.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53451, '工位1', '28.8', '43.4', '42.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53452, '工位1', '28.8', '43.4', '41.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53453, '工位1', '28.8', '43.3', '41.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53454, '工位1', '28.8', '43.3', '43.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:33', '实时数据', 7);
INSERT INTO `t_data` VALUES (53455, '工位1', '28.8', '43.3', '43.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53456, '工位1', '28.8', '43.3', '41.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53457, '工位1', '28.8', '43.3', '45.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53458, '工位1', '28.8', '43.3', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53459, '工位1', '28.8', '43.2', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (53460, '工位1', '28.8', '43.2', '40.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53461, '工位1', '28.8', '43.2', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53462, '工位1', '28.8', '43.2', '47.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53463, '工位1', '28.8', '43.2', '47.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53464, '工位1', '28.8', '43.2', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53465, '工位1', '28.8', '43.2', '40.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (53466, '工位1', '28.8', '43.2', '40.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53467, '工位1', '28.8', '43.2', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53468, '工位1', '28.8', '43.2', '45.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53469, '工位1', '28.8', '43.2', '45.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:48', '实时数据', 7);
INSERT INTO `t_data` VALUES (53470, '工位1', '28.8', '43.1', '43', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53471, '工位1', '28.8', '43.1', '43.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53472, '工位1', '28.8', '43.1', '43.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53473, '工位1', '28.8', '43.1', '43.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53474, '工位1', '28.8', '43.1', '43.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53475, '工位1', '28.8', '43.1', '43.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53476, '工位1', '28.8', '43.1', '42.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53477, '工位1', '28.8', '43.1', '46.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53478, '工位1', '28.8', '43.1', '46.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53479, '工位1', '28.8', '43.1', '46', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53480, '工位1', '28.8', '43.1', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:10:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53481, '工位1', '28.8', '43.0', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53482, '工位1', '28.8', '43.0', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53483, '工位1', '28.8', '43.0', '47.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53484, '工位1', '28.8', '43.0', '46.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53485, '工位1', '28.8', '43.0', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53486, '工位1', '28.8', '43.0', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53487, '工位1', '28.8', '43.0', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53488, '工位1', '28.8', '43.0', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:08', '实时数据', 7);
INSERT INTO `t_data` VALUES (53489, '工位1', '28.8', '43.0', '46.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53490, '工位1', '28.8', '43.0', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53491, '工位1', '28.8', '43.0', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53492, '工位1', '28.8', '43.0', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53493, '工位1', '28.8', '43.0', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53494, '工位1', '28.8', '43.0', '47.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:14', '实时数据', 7);
INSERT INTO `t_data` VALUES (53495, '工位1', '28.8', '43.0', '45.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:15', '实时数据', 7);
INSERT INTO `t_data` VALUES (53496, '工位1', '28.8', '42.9', '46.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:16', '实时数据', 7);
INSERT INTO `t_data` VALUES (53497, '工位1', '28.8', '42.9', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:17', '实时数据', 7);
INSERT INTO `t_data` VALUES (53498, '工位1', '28.8', '42.9', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:18', '实时数据', 7);
INSERT INTO `t_data` VALUES (53499, '工位1', '28.8', '42.9', '44.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:19', '实时数据', 7);
INSERT INTO `t_data` VALUES (53500, '工位1', '28.8', '42.9', '47.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:20', '实时数据', 7);
INSERT INTO `t_data` VALUES (53501, '工位1', '28.8', '42.9', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:21', '实时数据', 7);
INSERT INTO `t_data` VALUES (53502, '工位1', '28.8', '42.9', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:22', '实时数据', 7);
INSERT INTO `t_data` VALUES (53503, '工位1', '28.8', '42.9', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:23', '实时数据', 7);
INSERT INTO `t_data` VALUES (53504, '工位1', '28.8', '42.9', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:24', '实时数据', 7);
INSERT INTO `t_data` VALUES (53505, '工位1', '28.8', '42.9', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:25', '实时数据', 7);
INSERT INTO `t_data` VALUES (53506, '工位1', '28.8', '42.9', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53507, '工位1', '28.8', '42.8', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53508, '工位1', '28.8', '42.8', '42.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53509, '工位1', '28.8', '42.8', '45.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53510, '工位1', '28.8', '42.8', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53511, '工位1', '28.8', '42.8', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53512, '工位1', '28.8', '42.8', '43.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53513, '工位1', '28.8', '42.8', '47.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:33', '实时数据', 7);
INSERT INTO `t_data` VALUES (53514, '工位1', '28.8', '42.8', '47.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53515, '工位1', '28.8', '42.8', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53516, '工位1', '28.8', '42.8', '47', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53517, '工位1', '28.8', '42.8', '46.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53518, '工位1', '28.8', '42.8', '46.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (53519, '工位1', '28.8', '42.8', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53520, '工位1', '28.8', '42.7', '46.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53521, '工位1', '28.8', '42.7', '43.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53522, '工位1', '28.8', '42.7', '45.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53523, '工位1', '28.8', '42.7', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53524, '工位1', '28.8', '42.6', '47.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (53525, '工位1', '28.8', '42.6', '47.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53526, '工位1', '28.8', '42.6', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53527, '工位1', '28.8', '42.6', '47.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53528, '工位1', '28.8', '42.6', '47.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:48', '实时数据', 7);
INSERT INTO `t_data` VALUES (53529, '工位1', '28.8', '42.6', '47.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53530, '工位1', '28.8', '42.6', '47.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53531, '工位1', '28.8', '42.6', '47.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53532, '工位1', '28.8', '42.6', '47.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53533, '工位1', '28.8', '42.6', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53534, '工位1', '28.8', '42.6', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53535, '工位1', '28.8', '42.5', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53536, '工位1', '28.8', '42.5', '46.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53537, '工位1', '28.8', '42.5', '46.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53538, '工位1', '28.8', '42.5', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:11:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53539, '工位1', '28.8', '42.5', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53540, '工位1', '28.8', '42.5', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53541, '工位1', '28.8', '42.4', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53542, '工位1', '28.8', '42.4', '42.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:03', '实时数据', 7);
INSERT INTO `t_data` VALUES (53543, '工位1', '28.8', '42.4', '42.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53544, '工位1', '28.8', '42.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53545, '工位1', '28.8', '42.3', '46.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53546, '工位1', '28.8', '42.3', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53547, '工位1', '28.8', '42.3', '45.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:08', '实时数据', 7);
INSERT INTO `t_data` VALUES (53548, '工位1', '28.8', '42.3', '45.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53549, '工位1', '28.8', '42.3', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53550, '工位1', '28.8', '42.2', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53551, '工位1', '28.8', '42.2', '46.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53552, '工位1', '28.8', '42.2', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53553, '工位1', '28.8', '42.2', '45.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:14', '实时数据', 7);
INSERT INTO `t_data` VALUES (53554, '工位1', '28.8', '42.2', '42.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:15', '实时数据', 7);
INSERT INTO `t_data` VALUES (53555, '工位1', '28.8', '42.2', '42.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:16', '实时数据', 7);
INSERT INTO `t_data` VALUES (53556, '工位1', '28.8', '42.2', '41.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:17', '实时数据', 7);
INSERT INTO `t_data` VALUES (53557, '工位1', '28.8', '42.1', '41.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:18', '实时数据', 7);
INSERT INTO `t_data` VALUES (53558, '工位1', '28.8', '42.1', '40.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:19', '实时数据', 7);
INSERT INTO `t_data` VALUES (53559, '工位1', '28.8', '42.1', '41.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:20', '实时数据', 7);
INSERT INTO `t_data` VALUES (53560, '工位1', '28.8', '42.1', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:21', '实时数据', 7);
INSERT INTO `t_data` VALUES (53561, '工位1', '28.8', '42.1', '39.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:22', '实时数据', 7);
INSERT INTO `t_data` VALUES (53562, '工位1', '28.8', '42.1', '39.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:23', '实时数据', 7);
INSERT INTO `t_data` VALUES (53563, '工位1', '28.8', '42.1', '40.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:24', '实时数据', 7);
INSERT INTO `t_data` VALUES (53564, '工位1', '28.8', '42.1', '41.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:25', '实时数据', 7);
INSERT INTO `t_data` VALUES (53565, '工位1', '28.8', '42.1', '40.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53566, '工位1', '28.8', '42.1', '40.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53567, '工位1', '28.8', '42.1', '41.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53568, '工位1', '28.8', '42.1', '42', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53569, '工位1', '28.8', '42.0', '42', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53570, '工位1', '28.8', '42.0', '41.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53571, '工位1', '28.8', '42.0', '41.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53572, '工位1', '28.8', '42.0', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:33', '实时数据', 7);
INSERT INTO `t_data` VALUES (53573, '工位1', '28.8', '42.0', '41.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53574, '工位1', '28.8', '41.9', '42.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53575, '工位1', '28.8', '41.9', '47.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53576, '工位1', '28.8', '41.9', '47.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53577, '工位1', '28.8', '41.9', '47.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (53578, '工位1', '28.8', '41.9', '48', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53579, '工位1', '28.8', '41.9', '48', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53580, '工位1', '28.8', '41.9', '48.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53581, '工位1', '28.8', '41.9', '47.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53582, '工位1', '28.8', '41.8', '47.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53583, '工位1', '28.8', '41.8', '47.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (53584, '工位1', '28.8', '41.8', '48', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53585, '工位1', '28.8', '41.8', '46', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53586, '工位1', '28.8', '41.8', '43.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53587, '工位1', '28.8', '41.7', '42.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:48', '实时数据', 7);
INSERT INTO `t_data` VALUES (53588, '工位1', '28.8', '41.7', '42.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53589, '工位1', '28.8', '41.7', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53590, '工位1', '28.8', '41.7', '45.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53591, '工位1', '28.8', '41.7', '45.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53592, '工位1', '28.8', '41.6', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53593, '工位1', '28.8', '41.6', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53594, '工位1', '28.8', '41.6', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53595, '工位1', '28.8', '41.6', '47.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53596, '工位1', '28.8', '41.6', '47.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53597, '工位1', '28.8', '41.5', '48.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:12:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53598, '工位1', '28.8', '41.5', '45.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53599, '工位1', '28.8', '41.5', '45.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53600, '工位1', '28.8', '41.5', '47.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53601, '工位1', '28.8', '41.5', '39.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:03', '实时数据', 7);
INSERT INTO `t_data` VALUES (53602, '工位1', '28.8', '41.4', '45.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53603, '工位1', '28.8', '41.4', '45.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53604, '工位1', '28.8', '41.4', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53605, '工位1', '28.8', '41.4', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53606, '工位1', '28.8', '41.4', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:08', '实时数据', 7);
INSERT INTO `t_data` VALUES (53607, '工位1', '28.8', '41.4', '46.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53608, '工位1', '28.8', '41.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53609, '工位1', '28.8', '41.3', '42.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53610, '工位1', '28.8', '41.3', '41.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53611, '工位1', '28.8', '41.3', '45.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53612, '工位1', '28.8', '41.2', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:14', '实时数据', 7);
INSERT INTO `t_data` VALUES (53613, '工位1', '28.8', '41.2', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:15', '实时数据', 7);
INSERT INTO `t_data` VALUES (53614, '工位1', '28.8', '41.2', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:16', '实时数据', 7);
INSERT INTO `t_data` VALUES (53615, '工位1', '28.8', '41.2', '48', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:17', '实时数据', 7);
INSERT INTO `t_data` VALUES (53616, '工位1', '28.8', '41.2', '40.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:18', '实时数据', 7);
INSERT INTO `t_data` VALUES (53617, '工位1', '28.8', '41.1', '39.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:19', '实时数据', 7);
INSERT INTO `t_data` VALUES (53618, '工位1', '28.8', '41.1', '39.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:20', '实时数据', 7);
INSERT INTO `t_data` VALUES (53619, '工位1', '28.8', '41.1', '48.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:21', '实时数据', 7);
INSERT INTO `t_data` VALUES (53620, '工位1', '28.8', '41.1', '45.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:22', '实时数据', 7);
INSERT INTO `t_data` VALUES (53621, '工位1', '28.8', '41.1', '45.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:23', '实时数据', 7);
INSERT INTO `t_data` VALUES (53622, '工位1', '28.8', '41.1', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:24', '实时数据', 7);
INSERT INTO `t_data` VALUES (53623, '工位1', '28.8', '41.1', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:25', '实时数据', 7);
INSERT INTO `t_data` VALUES (53624, '工位1', '28.8', '41.1', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53625, '工位1', '28.8', '41.1', '48.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53626, '工位1', '28.8', '41.0', '48.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53627, '工位1', '28.8', '41.0', '48.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53628, '工位1', '28.8', '41.0', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53629, '工位1', '28.8', '41.0', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53630, '工位1', '28.8', '41.0', '48.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53631, '工位1', '28.8', '41.0', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:33', '实时数据', 7);
INSERT INTO `t_data` VALUES (53632, '工位1', '28.8', '41.0', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53633, '工位1', '28.8', '41.0', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53634, '工位1', '28.8', '41.0', '48.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53635, '工位1', '28.8', '41.0', '48.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53636, '工位1', '28.8', '40.9', '48.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (53637, '工位1', '28.8', '40.9', '48.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53638, '工位1', '28.8', '40.9', '48.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53639, '工位1', '28.8', '40.9', '48.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53640, '工位1', '28.8', '40.9', '48.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53641, '工位1', '28.8', '40.9', '47.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53642, '工位1', '28.8', '40.8', '47.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (53643, '工位1', '28.8', '40.8', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53644, '工位1', '28.8', '40.8', '47.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53645, '工位1', '28.8', '40.8', '47.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53646, '工位1', '28.8', '40.8', '48.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53647, '工位1', '28.8', '40.8', '46.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53648, '工位1', '28.8', '40.7', '49.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53649, '工位1', '28.8', '40.7', '48.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53650, '工位1', '28.8', '40.7', '48.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53651, '工位1', '28.8', '40.7', '49.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53652, '工位1', '28.8', '40.7', '49.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53653, '工位1', '28.8', '40.7', '42.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53654, '工位1', '28.8', '40.7', '48.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53655, '工位1', '28.8', '40.7', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53656, '工位1', '28.8', '40.7', '45.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:13:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53657, '工位1', '28.8', '40.7', '45.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53658, '工位1', '28.8', '40.7', '45.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53659, '工位1', '28.8', '40.7', '43.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53660, '工位1', '28.8', '40.6', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:03', '实时数据', 7);
INSERT INTO `t_data` VALUES (53661, '工位1', '28.8', '40.6', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53662, '工位1', '28.8', '40.6', '45.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53663, '工位1', '28.8', '40.6', '45.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53664, '工位1', '28.8', '40.6', '45.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53665, '工位1', '28.8', '40.6', '45.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:08', '实时数据', 7);
INSERT INTO `t_data` VALUES (53666, '工位1', '28.8', '40.6', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53667, '工位1', '28.8', '40.6', '45.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53668, '工位1', '28.8', '40.6', '45.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53669, '工位1', '28.8', '40.6', '43.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53670, '工位1', '28.8', '40.6', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53671, '工位1', '28.8', '40.5', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:14', '实时数据', 7);
INSERT INTO `t_data` VALUES (53672, '工位1', '28.8', '40.5', '46.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:15', '实时数据', 7);
INSERT INTO `t_data` VALUES (53673, '工位1', '28.8', '40.5', '46.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:16', '实时数据', 7);
INSERT INTO `t_data` VALUES (53674, '工位1', '28.8', '40.5', '46', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:17', '实时数据', 7);
INSERT INTO `t_data` VALUES (53675, '工位1', '28.8', '40.5', '49.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:18', '实时数据', 7);
INSERT INTO `t_data` VALUES (53676, '工位1', '28.8', '40.5', '48.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:19', '实时数据', 7);
INSERT INTO `t_data` VALUES (53677, '工位1', '28.8', '40.5', '48', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:20', '实时数据', 7);
INSERT INTO `t_data` VALUES (53678, '工位1', '28.8', '40.5', '48', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:21', '实时数据', 7);
INSERT INTO `t_data` VALUES (53679, '工位1', '28.8', '40.5', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:22', '实时数据', 7);
INSERT INTO `t_data` VALUES (53680, '工位1', '28.8', '40.5', '48.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:23', '实时数据', 7);
INSERT INTO `t_data` VALUES (53681, '工位1', '28.8', '40.5', '48.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:24', '实时数据', 7);
INSERT INTO `t_data` VALUES (53682, '工位1', '28.8', '40.5', '49.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:25', '实时数据', 7);
INSERT INTO `t_data` VALUES (53683, '工位1', '28.8', '40.4', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53684, '工位1', '28.8', '40.4', '46.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53685, '工位1', '28.8', '40.4', '39.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53686, '工位1', '28.8', '40.4', '40.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53687, '工位1', '28.8', '40.4', '40.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53688, '工位1', '28.8', '40.4', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53689, '工位1', '28.8', '40.4', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53690, '工位1', '28.8', '40.4', '41.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:33', '实时数据', 7);
INSERT INTO `t_data` VALUES (53691, '工位1', '28.8', '40.4', '40.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53692, '工位1', '28.8', '40.4', '39.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53693, '工位1', '28.8', '40.4', '43.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53694, '工位1', '28.8', '40.4', '43.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53695, '工位1', '28.8', '40.4', '43.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (53696, '工位1', '28.8', '40.4', '43.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53697, '工位1', '28.8', '40.4', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53698, '工位1', '28.8', '40.3', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53699, '工位1', '28.8', '40.3', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53700, '工位1', '28.8', '40.3', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53701, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53702, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53703, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53704, '工位1', '28.8', '40.3', '43.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:48', '实时数据', 7);
INSERT INTO `t_data` VALUES (53705, '工位1', '28.8', '40.3', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53706, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53707, '工位1', '28.8', '40.3', '44.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53708, '工位1', '28.8', '40.3', '44.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53709, '工位1', '28.8', '40.3', '44.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53710, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53711, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53712, '工位1', '28.8', '40.3', '43.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53713, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53714, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53715, '工位1', '28.8', '40.3', '44.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:14:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53716, '工位1', '28.8', '40.3', '44.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53717, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53718, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53719, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:03', '实时数据', 7);
INSERT INTO `t_data` VALUES (53720, '工位1', '28.8', '40.3', '44.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53721, '工位1', '28.8', '40.3', '44.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53722, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53723, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53724, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:08', '实时数据', 7);
INSERT INTO `t_data` VALUES (53725, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53726, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53727, '工位1', '28.8', '40.3', '44.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53728, '工位1', '28.8', '40.3', '45.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53729, '工位1', '28.8', '40.3', '45.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53730, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:14', '实时数据', 7);
INSERT INTO `t_data` VALUES (53731, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:15', '实时数据', 7);
INSERT INTO `t_data` VALUES (53732, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:16', '实时数据', 7);
INSERT INTO `t_data` VALUES (53733, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:17', '实时数据', 7);
INSERT INTO `t_data` VALUES (53734, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:18', '实时数据', 7);
INSERT INTO `t_data` VALUES (53735, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:19', '实时数据', 7);
INSERT INTO `t_data` VALUES (53736, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:20', '实时数据', 7);
INSERT INTO `t_data` VALUES (53737, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:21', '实时数据', 7);
INSERT INTO `t_data` VALUES (53738, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:22', '实时数据', 7);
INSERT INTO `t_data` VALUES (53739, '工位1', '28.8', '40.3', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:23', '实时数据', 7);
INSERT INTO `t_data` VALUES (53740, '工位1', '28.8', '40.3', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:24', '实时数据', 7);
INSERT INTO `t_data` VALUES (53741, '工位1', '28.8', '40.3', '45.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:25', '实时数据', 7);
INSERT INTO `t_data` VALUES (53742, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53743, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53744, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53745, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53746, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53747, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53748, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53749, '工位1', '28.8', '40.3', '44.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:33', '实时数据', 7);
INSERT INTO `t_data` VALUES (53750, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53751, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53752, '工位1', '28.8', '40.3', '44.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53753, '工位1', '28.8', '40.3', '44.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53754, '工位1', '28.8', '40.3', '44.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53755, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53756, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53757, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53758, '工位1', '28.8', '40.3', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53759, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (53760, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53761, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53762, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53763, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:48', '实时数据', 7);
INSERT INTO `t_data` VALUES (53764, '工位1', '28.8', '40.3', '43.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53765, '工位1', '28.8', '40.3', '43.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53766, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53767, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53768, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53769, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53770, '工位1', '28.8', '40.3', '43.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53771, '工位1', '28.8', '40.3', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53772, '工位1', '28.8', '40.3', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53773, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53774, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:15:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53775, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53776, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53777, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53778, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:03', '实时数据', 7);
INSERT INTO `t_data` VALUES (53779, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53780, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53781, '工位1', '28.8', '40.3', '44.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53782, '工位1', '28.8', '40.3', '44', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53783, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:08', '实时数据', 7);
INSERT INTO `t_data` VALUES (53784, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53785, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53786, '工位1', '28.8', '40.3', '43.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53787, '工位1', '28.8', '40.3', '44.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53788, '工位1', '28.8', '40.3', '44.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53789, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:14', '实时数据', 7);
INSERT INTO `t_data` VALUES (53790, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:15', '实时数据', 7);
INSERT INTO `t_data` VALUES (53791, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:16', '实时数据', 7);
INSERT INTO `t_data` VALUES (53792, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:17', '实时数据', 7);
INSERT INTO `t_data` VALUES (53793, '工位1', '28.8', '40.3', '45', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:18', '实时数据', 7);
INSERT INTO `t_data` VALUES (53794, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:19', '实时数据', 7);
INSERT INTO `t_data` VALUES (53795, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:20', '实时数据', 7);
INSERT INTO `t_data` VALUES (53796, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:21', '实时数据', 7);
INSERT INTO `t_data` VALUES (53797, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:22', '实时数据', 7);
INSERT INTO `t_data` VALUES (53798, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:23', '实时数据', 7);
INSERT INTO `t_data` VALUES (53799, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:24', '实时数据', 7);
INSERT INTO `t_data` VALUES (53800, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:25', '实时数据', 7);
INSERT INTO `t_data` VALUES (53801, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:26', '实时数据', 7);
INSERT INTO `t_data` VALUES (53802, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:27', '实时数据', 7);
INSERT INTO `t_data` VALUES (53803, '工位1', '28.8', '40.3', '44.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:28', '实时数据', 7);
INSERT INTO `t_data` VALUES (53804, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:29', '实时数据', 7);
INSERT INTO `t_data` VALUES (53805, '工位1', '28.8', '40.3', '44.6', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:30', '实时数据', 7);
INSERT INTO `t_data` VALUES (53806, '工位1', '28.8', '40.3', '44.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:31', '实时数据', 7);
INSERT INTO `t_data` VALUES (53807, '工位1', '28.8', '40.3', '44.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:32', '实时数据', 7);
INSERT INTO `t_data` VALUES (53808, '工位1', '28.8', '40.3', '44.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:34', '实时数据', 7);
INSERT INTO `t_data` VALUES (53809, '工位1', '28.8', '40.3', '45.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:35', '实时数据', 7);
INSERT INTO `t_data` VALUES (53810, '工位1', '28.8', '40.3', '49.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:36', '实时数据', 7);
INSERT INTO `t_data` VALUES (53811, '工位1', '28.8', '40.3', '49.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:37', '实时数据', 7);
INSERT INTO `t_data` VALUES (53812, '工位1', '28.8', '40.3', '49.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:38', '实时数据', 7);
INSERT INTO `t_data` VALUES (53813, '工位1', '28.8', '40.3', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:39', '实时数据', 7);
INSERT INTO `t_data` VALUES (53814, '工位1', '28.8', '40.3', '47.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:40', '实时数据', 7);
INSERT INTO `t_data` VALUES (53815, '工位1', '28.8', '40.3', '45.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:41', '实时数据', 7);
INSERT INTO `t_data` VALUES (53816, '工位1', '28.8', '40.3', '44.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:42', '实时数据', 7);
INSERT INTO `t_data` VALUES (53817, '工位1', '28.8', '40.3', '39.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:43', '实时数据', 7);
INSERT INTO `t_data` VALUES (53818, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:44', '实时数据', 7);
INSERT INTO `t_data` VALUES (53819, '工位1', '28.8', '40.3', '44.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:45', '实时数据', 7);
INSERT INTO `t_data` VALUES (53820, '工位1', '28.8', '40.3', '47.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:46', '实时数据', 7);
INSERT INTO `t_data` VALUES (53821, '工位1', '28.8', '40.3', '49', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:47', '实时数据', 7);
INSERT INTO `t_data` VALUES (53822, '工位1', '28.8', '40.3', '48.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:48', '实时数据', 7);
INSERT INTO `t_data` VALUES (53823, '工位1', '28.8', '40.3', '49.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:49', '实时数据', 7);
INSERT INTO `t_data` VALUES (53824, '工位1', '28.8', '40.3', '49.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:50', '实时数据', 7);
INSERT INTO `t_data` VALUES (53825, '工位1', '28.8', '40.3', '49.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:51', '实时数据', 7);
INSERT INTO `t_data` VALUES (53826, '工位1', '28.8', '40.3', '48.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:52', '实时数据', 7);
INSERT INTO `t_data` VALUES (53827, '工位1', '28.8', '40.3', '48.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:53', '实时数据', 7);
INSERT INTO `t_data` VALUES (53828, '工位1', '28.8', '40.3', '48.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:54', '实时数据', 7);
INSERT INTO `t_data` VALUES (53829, '工位1', '28.8', '40.3', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:55', '实时数据', 7);
INSERT INTO `t_data` VALUES (53830, '工位1', '28.8', '40.3', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:56', '实时数据', 7);
INSERT INTO `t_data` VALUES (53831, '工位1', '28.8', '40.3', '46.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:57', '实时数据', 7);
INSERT INTO `t_data` VALUES (53832, '工位1', '28.8', '40.3', '42.5', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:58', '实时数据', 7);
INSERT INTO `t_data` VALUES (53833, '工位1', '28.8', '40.3', '40.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:16:59', '实时数据', 7);
INSERT INTO `t_data` VALUES (53834, '工位1', '28.8', '40.3', '40.4', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:00', '实时数据', 7);
INSERT INTO `t_data` VALUES (53835, '工位1', '28.8', '40.3', '39.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:01', '实时数据', 7);
INSERT INTO `t_data` VALUES (53836, '工位1', '28.8', '40.3', '39.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:02', '实时数据', 7);
INSERT INTO `t_data` VALUES (53837, '工位1', '28.8', '40.3', '43.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:03', '实时数据', 7);
INSERT INTO `t_data` VALUES (53838, '工位1', '28.8', '40.3', '44.2', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:04', '实时数据', 7);
INSERT INTO `t_data` VALUES (53839, '工位1', '28.8', '40.3', '39.9', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:05', '实时数据', 7);
INSERT INTO `t_data` VALUES (53840, '工位1', '28.8', '40.3', '40.1', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:06', '实时数据', 7);
INSERT INTO `t_data` VALUES (53841, '工位1', '28.8', '40.3', '40', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:07', '实时数据', 7);
INSERT INTO `t_data` VALUES (53842, '工位1', '28.8', '40.3', '40', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:08', '实时数据', 7);
INSERT INTO `t_data` VALUES (53843, '工位1', '28.8', '40.3', '39.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:09', '实时数据', 7);
INSERT INTO `t_data` VALUES (53844, '工位1', '28.8', '40.3', '39.8', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:10', '实时数据', 7);
INSERT INTO `t_data` VALUES (53845, '工位1', '28.8', '40.3', '39.7', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:11', '实时数据', 7);
INSERT INTO `t_data` VALUES (53846, '工位1', '28.8', '40.3', '40.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:12', '实时数据', 7);
INSERT INTO `t_data` VALUES (53847, '工位1', '28.8', '40.3', '40.3', '4.94', '0.14', '0.6916000000000001', '0.14', '0.6916000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:17:13', '实时数据', 7);
INSERT INTO `t_data` VALUES (53848, '工位1', '28.8', '37.4', '41.6', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:44', '实时数据', 8);
INSERT INTO `t_data` VALUES (53849, '工位1', '28.8', '37.4', '41.6', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:45', '实时数据', 8);
INSERT INTO `t_data` VALUES (53850, '工位1', '28.8', '37.4', '41.8', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:46', '实时数据', 8);
INSERT INTO `t_data` VALUES (53851, '工位1', '28.8', '37.4', '41.7', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:47', '实时数据', 8);
INSERT INTO `t_data` VALUES (53852, '工位1', '28.8', '37.4', '41.2', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:48', '实时数据', 8);
INSERT INTO `t_data` VALUES (53853, '工位1', '28.8', '37.4', '31.9', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:49', '实时数据', 8);
INSERT INTO `t_data` VALUES (53854, '工位1', '28.8', '37.4', '32.8', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:50', '实时数据', 8);
INSERT INTO `t_data` VALUES (53855, '工位1', '28.8', '37.4', '37.9', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:51', '实时数据', 8);
INSERT INTO `t_data` VALUES (53856, '工位1', '28.8', '37.4', '37.9', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:52', '实时数据', 8);
INSERT INTO `t_data` VALUES (53857, '工位1', '28.8', '37.4', '29.5', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:53', '实时数据', 8);
INSERT INTO `t_data` VALUES (53858, '工位1', '28.8', '37.4', '35.5', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:55', '实时数据', 8);
INSERT INTO `t_data` VALUES (53859, '工位1', '28.8', '37.4', '34.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:57', '实时数据', 8);
INSERT INTO `t_data` VALUES (53860, '工位1', '28.8', '37.4', '33.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:25:58', '实时数据', 8);
INSERT INTO `t_data` VALUES (53861, '工位1', '28.8', '37.4', '33.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:03', '实时数据', 8);
INSERT INTO `t_data` VALUES (53862, '工位1', '28.8', '37.4', '35.2', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:03', '实时数据', 8);
INSERT INTO `t_data` VALUES (53863, '工位1', '28.8', '37.4', '35.7', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:03', '实时数据', 8);
INSERT INTO `t_data` VALUES (53864, '工位1', '28.8', '37.4', '42.2', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:03', '实时数据', 8);
INSERT INTO `t_data` VALUES (53865, '工位1', '28.8', '37.4', '43.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:03', '实时数据', 8);
INSERT INTO `t_data` VALUES (53866, '工位1', '28.8', '37.4', '40.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:03', '实时数据', 8);
INSERT INTO `t_data` VALUES (53867, '工位1', '28.8', '37.4', '40.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:10', '实时数据', 8);
INSERT INTO `t_data` VALUES (53868, '工位1', '28.8', '37.4', '39.2', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:11', '实时数据', 8);
INSERT INTO `t_data` VALUES (53869, '工位1', '28.8', '37.4', '40.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:11', '实时数据', 8);
INSERT INTO `t_data` VALUES (53870, '工位1', '28.8', '37.4', '42.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:12', '实时数据', 8);
INSERT INTO `t_data` VALUES (53871, '工位1', '28.8', '37.4', '41.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:12', '实时数据', 8);
INSERT INTO `t_data` VALUES (53872, '工位1', '28.8', '37.4', '42.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:15', '实时数据', 8);
INSERT INTO `t_data` VALUES (53873, '工位1', '28.8', '37.4', '42.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:15', '实时数据', 8);
INSERT INTO `t_data` VALUES (53874, '工位1', '28.8', '37.4', '38.4', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:15', '实时数据', 8);
INSERT INTO `t_data` VALUES (53875, '工位1', '28.8', '37.4', '40', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:16', '实时数据', 8);
INSERT INTO `t_data` VALUES (53876, '工位1', '28.8', '37.4', '39.4', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:16', '实时数据', 8);
INSERT INTO `t_data` VALUES (53877, '工位1', '28.8', '37.4', '38.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:17', '实时数据', 8);
INSERT INTO `t_data` VALUES (53878, '工位1', '28.8', '37.4', '38.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:18', '实时数据', 8);
INSERT INTO `t_data` VALUES (53879, '工位1', '28.8', '37.4', '36.2', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:21', '实时数据', 8);
INSERT INTO `t_data` VALUES (53880, '工位1', '28.8', '37.4', '36.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:21', '实时数据', 8);
INSERT INTO `t_data` VALUES (53881, '工位1', '28.8', '37.4', '38.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:21', '实时数据', 8);
INSERT INTO `t_data` VALUES (53882, '工位1', '28.8', '37.4', '38.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:21', '实时数据', 8);
INSERT INTO `t_data` VALUES (53883, '工位1', '28.8', '37.4', '41.8', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:21', '实时数据', 8);
INSERT INTO `t_data` VALUES (53884, '工位1', '28.8', '37.4', '42.4', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:21', '实时数据', 8);
INSERT INTO `t_data` VALUES (53885, '工位1', '28.8', '37.4', '37.5', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:22', '实时数据', 8);
INSERT INTO `t_data` VALUES (53886, '工位1', '28.8', '37.4', '37.5', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:22', '实时数据', 8);
INSERT INTO `t_data` VALUES (53887, '工位1', '28.8', '37.4', '39', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:23', '实时数据', 8);
INSERT INTO `t_data` VALUES (53888, '工位1', '28.8', '37.4', '38.8', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:24', '实时数据', 8);
INSERT INTO `t_data` VALUES (53889, '工位1', '28.8', '37.4', '37.1', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:25', '实时数据', 8);
INSERT INTO `t_data` VALUES (53890, '工位1', '28.8', '37.4', '41.7', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:26', '实时数据', 8);
INSERT INTO `t_data` VALUES (53891, '工位1', '28.8', '37.4', '34.9', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:27', '实时数据', 8);
INSERT INTO `t_data` VALUES (53892, '工位1', '28.8', '37.4', '37.6', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:28', '实时数据', 8);
INSERT INTO `t_data` VALUES (53893, '工位1', '28.8', '37.4', '37.6', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:29', '实时数据', 8);
INSERT INTO `t_data` VALUES (53894, '工位1', '28.8', '37.4', '34.7', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:31', '实时数据', 8);
INSERT INTO `t_data` VALUES (53895, '工位1', '28.8', '37.4', '30.8', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:32', '实时数据', 8);
INSERT INTO `t_data` VALUES (53896, '工位1', '28.8', '37.4', '41.6', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:32', '实时数据', 8);
INSERT INTO `t_data` VALUES (53897, '工位1', '28.8', '37.4', '42.6', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:34', '实时数据', 8);
INSERT INTO `t_data` VALUES (53898, '工位1', '28.8', '37.4', '43.3', '4.95', '0.14', '0.6930000000000001', '0.14', '0.6930000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:34', '实时数据', 8);

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
) ENGINE = InnoDB AUTO_INCREMENT = 992 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = COMPACT;

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
INSERT INTO `t_direct` VALUES (964, 12, '关', '工位2');
INSERT INTO `t_direct` VALUES (966, 12, '关', '工位3');
INSERT INTO `t_direct` VALUES (968, 21, '10', '工位1');
INSERT INTO `t_direct` VALUES (969, 21, '10', '工位2');
INSERT INTO `t_direct` VALUES (970, 21, '10', '工位3');
INSERT INTO `t_direct` VALUES (977, 22, '5', '工位1');
INSERT INTO `t_direct` VALUES (978, 22, '5', '工位2');
INSERT INTO `t_direct` VALUES (979, 22, '5', '工位3');
INSERT INTO `t_direct` VALUES (980, 6, '10', '工位1');
INSERT INTO `t_direct` VALUES (981, 6, '10', '工位2');
INSERT INTO `t_direct` VALUES (982, 6, '10', '工位3');
INSERT INTO `t_direct` VALUES (983, 7, '5', '工位1');
INSERT INTO `t_direct` VALUES (984, 7, '5', '工位2');
INSERT INTO `t_direct` VALUES (985, 7, '5', '工位3');
INSERT INTO `t_direct` VALUES (986, 9, '10', '工位1');
INSERT INTO `t_direct` VALUES (987, 9, '10', '工位2');
INSERT INTO `t_direct` VALUES (988, 9, '10', '工位3');
INSERT INTO `t_direct` VALUES (989, 10, '5', '工位1');
INSERT INTO `t_direct` VALUES (990, 10, '5', '工位2');
INSERT INTO `t_direct` VALUES (991, 10, '5', '工位3');

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
INSERT INTO `t_direct_config` VALUES (6, 0, '自动', '温度上限', '2', 'T1', '0', '100', '0', NULL, 'direct', 'null', 'temperature2', 'yes', NULL, '1');
INSERT INTO `t_direct_config` VALUES (7, 0, '自动', '温度下限', '2', 'T2', '0', '100', '0', NULL, 'direct', 'null', 'temperature1', 'yes', NULL, '1');
INSERT INTO `t_direct_config` VALUES (8, 0, '自动', '光照阈值', '2', 'light_warning', '1', '300', '0', NULL, 'direct', 'null', 'light_min', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (9, 0, '自动', '湿度上限', '2', 'S1', '0', '300', '0', NULL, 'direct', 'null', 'shidu1', 'yes', NULL, NULL);
INSERT INTO `t_direct_config` VALUES (10, 0, '自动', '湿度下限', '2', 'S2', '0', '300', '0', NULL, 'direct', 'null', 'shidu2', 'yes', NULL, NULL);
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
INSERT INTO `t_direct_config` VALUES (21, 0, '手动', '光照上限', '2', 'L1', '0', '100', '0', NULL, 'direct', 'null', 'light1', 'yes', NULL, '1');
INSERT INTO `t_direct_config` VALUES (22, 0, '手动', '光照下限', '2', 'L2', '0', '100', '0', NULL, 'direct', 'null', 'light2', 'yes', NULL, '1');

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
) ENGINE = InnoDB AUTO_INCREMENT = 1338 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_error_msg
-- ----------------------------
INSERT INTO `t_error_msg` VALUES (1337, '2025-08-24 11:09:25', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1336, '2025-08-24 11:09:24', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1335, '2025-08-24 11:09:23', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1334, '2025-08-24 11:09:22', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1333, '2025-08-24 11:09:21', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1332, '2025-08-24 11:09:20', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1331, '2025-08-24 11:09:19', '光照越界', NULL, NULL, '工位1', '偏小');

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
  `sensor` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '是否为物理传感器的自然数据类型(0不是1是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_field_mapper
-- ----------------------------
INSERT INTO `t_field_mapper` VALUES (1, '温度', 'field1', 'T', '°C', '1');
INSERT INTO `t_field_mapper` VALUES (2, '湿度', 'field2', 'S', '%', '1');
INSERT INTO `t_field_mapper` VALUES (3, '光照', 'field3', 'L', '%', '1');
INSERT INTO `t_field_mapper` VALUES (4, '电压', 'field4', 'U', 'V', '0');
INSERT INTO `t_field_mapper` VALUES (5, '电流', 'field5', 'I', 'A', '0');
INSERT INTO `t_field_mapper` VALUES (6, '功率', 'field6', 'P', 'W', '0');
INSERT INTO `t_field_mapper` VALUES (7, '电量', 'field7', 'Q', 'C', '0');
INSERT INTO `t_field_mapper` VALUES (8, '用电量', 'field8', 'W', 'J', '0');

SET FOREIGN_KEY_CHECKS = 1;
