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

 Date: 09/09/2025 14:27:37
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
) ENGINE = InnoDB AUTO_INCREMENT = 270 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of operate_history
-- ----------------------------
INSERT INTO `operate_history` VALUES (269, '电磁阀开关', '修改为开', '工位1', '2025-09-06 15:00:52');
INSERT INTO `operate_history` VALUES (268, '电磁阀开关', '修改为开', '工位1', '2025-09-06 15:00:51');
INSERT INTO `operate_history` VALUES (267, '电磁阀开关', '修改为关', '工位3', '2025-09-06 14:19:11');
INSERT INTO `operate_history` VALUES (266, '电磁阀开关', '修改为关', '工位3', '2025-09-06 14:19:10');
INSERT INTO `operate_history` VALUES (265, '电磁阀开关', '修改为关', '工位3', '2025-09-06 14:19:10');
INSERT INTO `operate_history` VALUES (264, '电磁阀开关', '修改为开', '工位3', '2025-09-06 14:18:44');
INSERT INTO `operate_history` VALUES (263, '电磁阀开关', '修改为开', '工位3', '2025-09-06 14:18:44');
INSERT INTO `operate_history` VALUES (262, '电磁阀开关', '修改为开', '工位3', '2025-09-06 14:18:43');
INSERT INTO `operate_history` VALUES (261, '光照上限', '修改为17', 'null', '2025-09-06 13:08:10');
INSERT INTO `operate_history` VALUES (260, '光照上限', '修改为10', 'null', '2025-08-29 20:55:30');
INSERT INTO `operate_history` VALUES (259, '光照上限', '修改为10', 'null', '2025-08-27 17:07:21');
INSERT INTO `operate_history` VALUES (258, '光照上限', '修改为10', 'null', '2025-08-27 17:07:11');
INSERT INTO `operate_history` VALUES (257, '湿度上限', '修改为10', 'null', '2025-08-27 17:06:13');
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
) ENGINE = InnoDB AUTO_INCREMENT = 6348 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

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
INSERT INTO `t_behavior_data` VALUES (6322, '工位1', '1756003817909-1-zq6mwak5g.jpeg', '1756003817967-2-srp45obcj.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:50:18', '实时数据', 'picture', '1', '0.80');
INSERT INTO `t_behavior_data` VALUES (6323, '工位1', '1756003926692-1-494nzx3ze.jpeg', '1756003926926-2-iu758ysnt.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:52:06', '实时数据', 'picture', '1', '0.79');
INSERT INTO `t_behavior_data` VALUES (6324, '工位1', '1756003969698-1-1qvpxnfi6.jpeg', '1756003969818-2-193b17dcq.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 10:52:49', '实时数据', 'picture', '1', '0.88');
INSERT INTO `t_behavior_data` VALUES (6325, '工位1', '1756004826069-1-zvf57lyun.jpeg', '1756004826234-2-yrnutmc70.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:07:06', '实时数据', 'picture', '1', '0.83');
INSERT INTO `t_behavior_data` VALUES (6326, '工位1', '1756004851346-1-iup4dsclo.jpeg', '1756004851364-2-fbdnl8q0r.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:07:31', '实时数据', 'picture', '1', '0.83');
INSERT INTO `t_behavior_data` VALUES (6327, '工位1', '1756004896866-1-h93n12kh8.jpeg', '1756004896885-2-vqtct7xqn.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:08:16', '实时数据', 'picture', '1', '0.76');
INSERT INTO `t_behavior_data` VALUES (6329, '工位1', '1756004939801-1-t284fwkf2.jpeg', '1756004939814-2-qwzmi3sod.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:09:00', '实时数据', 'picture', '1', '0.81');
INSERT INTO `t_behavior_data` VALUES (6330, '工位1', '1756005959775-1-s0sxiyrd3.jpeg', '1756005959926-2-fl00res10.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-24 11:26:00', '实时数据', 'picture', '1', '0.63');
INSERT INTO `t_behavior_data` VALUES (6331, '工位1', '1757139313583-1-gkssah8jc.jpeg', '1757139313653-2-6zgpocuhy.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:15:13', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6332, '工位1', '1757139327044-1-qvmksynxb.jpeg', '1757139327199-2-2y3defgpr.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:15:27', '实时数据', 'picture', '1', '0.88');
INSERT INTO `t_behavior_data` VALUES (6333, '工位2', '1757139352357-1-ug0hyqkfq.jpeg', '1757139352469-2-aa85ob0an.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:15:52', '实时数据', 'picture', '1', '0.84');
INSERT INTO `t_behavior_data` VALUES (6334, '工位3', '1757139374963-1-zj8dkrbw7.jpeg', '1757139374987-2-knnw9jtl4.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:16:15', '实时数据', 'picture', '1', '0.64');
INSERT INTO `t_behavior_data` VALUES (6335, '工位1', '1757139753076-1-b6depdn59.jpeg', '1757139753155-2-77c7yxmwl.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:22:33', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6336, '工位1', '1757139765545-1-sanjxr6o9.jpeg', '1757139765627-2-gahxlwuxn.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:22:45', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6337, '工位1', '1757139920256-1-dwzy3c0dd.jpeg', '1757139920366-2-3mr8jcrw1.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:25:20', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6338, '工位1', '1757139932079-1-m4338oo1q.jpeg', '1757139932088-2-jsxwqf5ye.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:25:32', '实时数据', 'picture', '1', '0.79');
INSERT INTO `t_behavior_data` VALUES (6339, '工位1', '1757140058339-1-tb1xcpr5f.jpeg', '1757140058342-2-zuzkegk4g.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:27:38', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6340, '工位1', '1757140067011-1-e3bgmc7f3.jpeg', '1757140067015-2-8kvzfvdx2.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:27:47', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6341, '工位1', '1757140073374-1-0lwhhkub6.jpeg', '1757140073487-2-z68r20oco.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:27:53', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6342, '工位1', '1757140078611-1-y9bc6k8w5.jpeg', '1757140078621-2-ivmnjn8u6.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:27:58', '实时数据', 'picture', '0', '1');
INSERT INTO `t_behavior_data` VALUES (6343, '工位1', '1757140093025-1-rk8g4bl73.jpeg', '1757140093095-2-khfgac7lo.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:28:13', '实时数据', 'picture', '1', '0.70');
INSERT INTO `t_behavior_data` VALUES (6344, '工位1', '1757140923382-1-yanwjjo2c.jpeg', '1757140923439-2-0wr1e9peh.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:42:03', '实时数据', 'picture', '1', '0.89');
INSERT INTO `t_behavior_data` VALUES (6345, '工位1', '1757141945989-1-0vrfb0059.jpeg', '1757141946006-2-h365ahx3k.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:59:06', '实时数据', 'picture', '1', '0.91');
INSERT INTO `t_behavior_data` VALUES (6346, '工位1', '1757141988030-1-jyk6wtvvy.jpeg', '1757141988052-2-hq0vb8w4g.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:59:48', '实时数据', 'picture', '1', '0.85');
INSERT INTO `t_behavior_data` VALUES (6347, '工位1', '1757142050783-1-v1fkf3vk8.jpeg', '1757142050789-2-vpppq8fsg.jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:00:50', '实时数据', 'picture', '1', '0.89');

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
) ENGINE = InnoDB AUTO_INCREMENT = 54027 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_data
-- ----------------------------
INSERT INTO `t_data` VALUES (1, '工位1', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (48502, '工位2', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (48503, '工位3', '1', '1', '1', '1', '1', '1', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-08-12 14:57:34', '实时数据', 0);
INSERT INTO `t_data` VALUES (53899, '工位1', '29.3', '32.8', '19.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:51', '实时数据', 1);
INSERT INTO `t_data` VALUES (53900, '工位1', '29.3', '32.8', '19.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:52', '实时数据', 1);
INSERT INTO `t_data` VALUES (53901, '工位1', '29.3', '32.8', '19.4', '5.03', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:53', '实时数据', 1);
INSERT INTO `t_data` VALUES (53902, '工位1', '29.3', '32.8', '19.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:54', '实时数据', 1);
INSERT INTO `t_data` VALUES (53903, '工位1', '29.3', '32.8', '19.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:55', '实时数据', 1);
INSERT INTO `t_data` VALUES (53904, '工位1', '29.3', '32.8', '19.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:56', '实时数据', 1);
INSERT INTO `t_data` VALUES (53905, '工位1', '29.3', '32.8', '19.3', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:57', '实时数据', 1);
INSERT INTO `t_data` VALUES (53906, '工位1', '29.3', '32.8', '19.3', '5.03', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:58', '实时数据', 1);
INSERT INTO `t_data` VALUES (53907, '工位1', '29.3', '32.8', '19.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:10:59', '实时数据', 1);
INSERT INTO `t_data` VALUES (53908, '工位1', '29.3', '32.8', '19.4', '5.03', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:11:00', '实时数据', 1);
INSERT INTO `t_data` VALUES (53909, '工位1', '29.3', '32.8', '19.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:11:01', '实时数据', 1);
INSERT INTO `t_data` VALUES (53910, '工位1', '29.3', '32.8', '19.4', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:11:02', '实时数据', 1);
INSERT INTO `t_data` VALUES (53911, '工位1', '29.3', '32.8', '19.5', '5.03', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:11:03', '实时数据', 1);
INSERT INTO `t_data` VALUES (53912, '工位1', '29.3', '32.8', '19.5', '5.05', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:11:04', '实时数据', 1);
INSERT INTO `t_data` VALUES (53913, '工位1', '29.3', '32.8', '19.6', '5.06', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:11:05', '实时数据', 1);
INSERT INTO `t_data` VALUES (53914, '工位1', '29.3', '32.8', '19.6', '5.03', '0.00', '0', '0', '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 14:11:06', '实时数据', 1);
INSERT INTO `t_data` VALUES (53915, '工位1', '28.7', '30.3', '20', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:47', '实时数据', 2);
INSERT INTO `t_data` VALUES (53916, '工位1', '28.7', '30.3', '20.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:48', '实时数据', 2);
INSERT INTO `t_data` VALUES (53917, '工位1', '28.7', '30.3', '20.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:49', '实时数据', 2);
INSERT INTO `t_data` VALUES (53918, '工位1', '28.7', '30.3', '20.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:50', '实时数据', 2);
INSERT INTO `t_data` VALUES (53919, '工位1', '28.7', '30.3', '20.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:51', '实时数据', 2);
INSERT INTO `t_data` VALUES (53920, '工位1', '28.7', '30.3', '20.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:52', '实时数据', 2);
INSERT INTO `t_data` VALUES (53921, '工位1', '28.7', '30.3', '20.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:53', '实时数据', 2);
INSERT INTO `t_data` VALUES (53922, '工位1', '28.7', '30.3', '20.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:54', '实时数据', 2);
INSERT INTO `t_data` VALUES (53923, '工位1', '28.7', '30.3', '20.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:55', '实时数据', 2);
INSERT INTO `t_data` VALUES (53924, '工位1', '28.7', '30.3', '20.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:56', '实时数据', 2);
INSERT INTO `t_data` VALUES (53925, '工位1', '28.7', '30.3', '20.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:57', '实时数据', 2);
INSERT INTO `t_data` VALUES (53926, '工位1', '28.7', '30.3', '20.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:58', '实时数据', 2);
INSERT INTO `t_data` VALUES (53927, '工位1', '28.7', '30.3', '20.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:01:59', '实时数据', 2);
INSERT INTO `t_data` VALUES (53928, '工位1', '28.7', '30.3', '20.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:00', '实时数据', 2);
INSERT INTO `t_data` VALUES (53929, '工位1', '28.7', '30.3', '20.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:01', '实时数据', 2);
INSERT INTO `t_data` VALUES (53930, '工位1', '28.7', '30.3', '20.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:02', '实时数据', 2);
INSERT INTO `t_data` VALUES (53931, '工位1', '28.7', '30.3', '20.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:03', '实时数据', 2);
INSERT INTO `t_data` VALUES (53932, '工位1', '28.7', '30.3', '20.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:04', '实时数据', 2);
INSERT INTO `t_data` VALUES (53933, '工位1', '28.7', '30.3', '20.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:05', '实时数据', 2);
INSERT INTO `t_data` VALUES (53934, '工位1', '28.7', '30.3', '20.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:06', '实时数据', 2);
INSERT INTO `t_data` VALUES (53935, '工位1', '28.7', '30.3', '20.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:07', '实时数据', 2);
INSERT INTO `t_data` VALUES (53936, '工位1', '28.7', '30.3', '20.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:08', '实时数据', 2);
INSERT INTO `t_data` VALUES (53937, '工位1', '28.7', '30.3', '20.5', '4.88', '0.11', '0.5367999999999999', '0.11', '0.5367999999999999', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:09', '实时数据', 2);
INSERT INTO `t_data` VALUES (53938, '工位1', '28.7', '30.3', '20.6', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:10', '实时数据', 2);
INSERT INTO `t_data` VALUES (53939, '工位1', '28.7', '30.3', '20.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:11', '实时数据', 2);
INSERT INTO `t_data` VALUES (53940, '工位1', '28.7', '30.3', '20.8', '4.88', '0.11', '0.5367999999999999', '0.11', '0.5367999999999999', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:12', '实时数据', 2);
INSERT INTO `t_data` VALUES (53941, '工位1', '28.7', '30.3', '20.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:13', '实时数据', 2);
INSERT INTO `t_data` VALUES (53942, '工位1', '28.7', '30.3', '20.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:14', '实时数据', 2);
INSERT INTO `t_data` VALUES (53943, '工位1', '28.7', '30.3', '20.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:15', '实时数据', 2);
INSERT INTO `t_data` VALUES (53944, '工位1', '28.7', '30.3', '20.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:16', '实时数据', 2);
INSERT INTO `t_data` VALUES (53945, '工位1', '28.7', '30.3', '20.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:17', '实时数据', 2);
INSERT INTO `t_data` VALUES (53946, '工位1', '28.7', '30.2', '20.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:18', '实时数据', 2);
INSERT INTO `t_data` VALUES (53947, '工位1', '28.7', '30.2', '20.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:19', '实时数据', 2);
INSERT INTO `t_data` VALUES (53948, '工位1', '28.7', '30.2', '21', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:20', '实时数据', 2);
INSERT INTO `t_data` VALUES (53949, '工位1', '28.7', '30.2', '21', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:21', '实时数据', 2);
INSERT INTO `t_data` VALUES (53950, '工位1', '28.7', '30.2', '21', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:22', '实时数据', 2);
INSERT INTO `t_data` VALUES (53951, '工位1', '28.7', '30.2', '21', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:23', '实时数据', 2);
INSERT INTO `t_data` VALUES (53952, '工位1', '28.7', '30.2', '21', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:24', '实时数据', 2);
INSERT INTO `t_data` VALUES (53953, '工位1', '28.7', '30.2', '21', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:26', '实时数据', 2);
INSERT INTO `t_data` VALUES (53954, '工位1', '28.7', '30.2', '21.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:27', '实时数据', 2);
INSERT INTO `t_data` VALUES (53955, '工位1', '28.7', '30.2', '21.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:28', '实时数据', 2);
INSERT INTO `t_data` VALUES (53956, '工位1', '28.7', '30.2', '21.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:29', '实时数据', 2);
INSERT INTO `t_data` VALUES (53957, '工位1', '28.7', '30.2', '21.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:30', '实时数据', 2);
INSERT INTO `t_data` VALUES (53958, '工位1', '28.7', '30.2', '21.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:31', '实时数据', 2);
INSERT INTO `t_data` VALUES (53959, '工位1', '28.7', '30.1', '21.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:32', '实时数据', 2);
INSERT INTO `t_data` VALUES (53960, '工位1', '28.7', '30.1', '21.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:33', '实时数据', 2);
INSERT INTO `t_data` VALUES (53961, '工位1', '28.7', '30.1', '21.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:34', '实时数据', 2);
INSERT INTO `t_data` VALUES (53962, '工位1', '28.7', '30.1', '21.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:35', '实时数据', 2);
INSERT INTO `t_data` VALUES (53963, '工位1', '28.7', '30.1', '21.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:36', '实时数据', 2);
INSERT INTO `t_data` VALUES (53964, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:37', '实时数据', 2);
INSERT INTO `t_data` VALUES (53965, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:38', '实时数据', 2);
INSERT INTO `t_data` VALUES (53966, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:39', '实时数据', 2);
INSERT INTO `t_data` VALUES (53967, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:40', '实时数据', 2);
INSERT INTO `t_data` VALUES (53968, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:41', '实时数据', 2);
INSERT INTO `t_data` VALUES (53969, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:42', '实时数据', 2);
INSERT INTO `t_data` VALUES (53970, '工位1', '28.7', '30.1', '21.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:43', '实时数据', 2);
INSERT INTO `t_data` VALUES (53971, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:44', '实时数据', 2);
INSERT INTO `t_data` VALUES (53972, '工位1', '28.7', '30.1', '21.4', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:45', '实时数据', 2);
INSERT INTO `t_data` VALUES (53973, '工位1', '28.7', '30.1', '21.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:46', '实时数据', 2);
INSERT INTO `t_data` VALUES (53974, '工位1', '28.7', '30.1', '21.5', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:47', '实时数据', 2);
INSERT INTO `t_data` VALUES (53975, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:48', '实时数据', 2);
INSERT INTO `t_data` VALUES (53976, '工位1', '28.7', '30.1', '21.6', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:50', '实时数据', 2);
INSERT INTO `t_data` VALUES (53977, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:50', '实时数据', 2);
INSERT INTO `t_data` VALUES (53978, '工位1', '28.7', '30.1', '21.6', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:51', '实时数据', 2);
INSERT INTO `t_data` VALUES (53979, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:52', '实时数据', 2);
INSERT INTO `t_data` VALUES (53980, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:53', '实时数据', 2);
INSERT INTO `t_data` VALUES (53981, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:54', '实时数据', 2);
INSERT INTO `t_data` VALUES (53982, '工位1', '28.7', '30.1', '21.6', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:55', '实时数据', 2);
INSERT INTO `t_data` VALUES (53983, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:56', '实时数据', 2);
INSERT INTO `t_data` VALUES (53984, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:57', '实时数据', 2);
INSERT INTO `t_data` VALUES (53985, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:58', '实时数据', 2);
INSERT INTO `t_data` VALUES (53986, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:02:59', '实时数据', 2);
INSERT INTO `t_data` VALUES (53987, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:00', '实时数据', 2);
INSERT INTO `t_data` VALUES (53988, '工位1', '28.7', '30.1', '21.7', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:01', '实时数据', 2);
INSERT INTO `t_data` VALUES (53989, '工位1', '28.7', '30.1', '21.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:02', '实时数据', 2);
INSERT INTO `t_data` VALUES (53990, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:03', '实时数据', 2);
INSERT INTO `t_data` VALUES (53991, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:04', '实时数据', 2);
INSERT INTO `t_data` VALUES (53992, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:05', '实时数据', 2);
INSERT INTO `t_data` VALUES (53993, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:06', '实时数据', 2);
INSERT INTO `t_data` VALUES (53994, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:07', '实时数据', 2);
INSERT INTO `t_data` VALUES (53995, '工位1', '28.7', '30.1', '21.8', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:08', '实时数据', 2);
INSERT INTO `t_data` VALUES (53996, '工位1', '28.7', '30.1', '21.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:09', '实时数据', 2);
INSERT INTO `t_data` VALUES (53997, '工位1', '28.7', '30.1', '21.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:10', '实时数据', 2);
INSERT INTO `t_data` VALUES (53998, '工位1', '28.7', '30.1', '21.9', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:11', '实时数据', 2);
INSERT INTO `t_data` VALUES (53999, '工位1', '28.7', '30.1', '22', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:12', '实时数据', 2);
INSERT INTO `t_data` VALUES (54000, '工位1', '28.7', '30.1', '22', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:13', '实时数据', 2);
INSERT INTO `t_data` VALUES (54001, '工位1', '28.7', '30.1', '22', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:14', '实时数据', 2);
INSERT INTO `t_data` VALUES (54002, '工位1', '28.7', '30.1', '22.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:15', '实时数据', 2);
INSERT INTO `t_data` VALUES (54003, '工位1', '28.7', '30.1', '22.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:16', '实时数据', 2);
INSERT INTO `t_data` VALUES (54004, '工位1', '28.7', '30.1', '22.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:17', '实时数据', 2);
INSERT INTO `t_data` VALUES (54005, '工位1', '28.7', '30.0', '22.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:18', '实时数据', 2);
INSERT INTO `t_data` VALUES (54006, '工位1', '28.7', '30.0', '22.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:19', '实时数据', 2);
INSERT INTO `t_data` VALUES (54007, '工位1', '28.7', '30.0', '22.1', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:20', '实时数据', 2);
INSERT INTO `t_data` VALUES (54008, '工位1', '28.7', '30.0', '22.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:21', '实时数据', 2);
INSERT INTO `t_data` VALUES (54009, '工位1', '28.7', '30.0', '22.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:23', '实时数据', 2);
INSERT INTO `t_data` VALUES (54010, '工位1', '28.7', '30.0', '22.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:24', '实时数据', 2);
INSERT INTO `t_data` VALUES (54011, '工位1', '28.7', '30.0', '22.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:25', '实时数据', 2);
INSERT INTO `t_data` VALUES (54012, '工位1', '28.7', '30.0', '22.2', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:26', '实时数据', 2);
INSERT INTO `t_data` VALUES (54013, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:27', '实时数据', 2);
INSERT INTO `t_data` VALUES (54014, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:28', '实时数据', 2);
INSERT INTO `t_data` VALUES (54015, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:29', '实时数据', 2);
INSERT INTO `t_data` VALUES (54016, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:30', '实时数据', 2);
INSERT INTO `t_data` VALUES (54017, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:31', '实时数据', 2);
INSERT INTO `t_data` VALUES (54018, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:32', '实时数据', 2);
INSERT INTO `t_data` VALUES (54019, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:33', '实时数据', 2);
INSERT INTO `t_data` VALUES (54020, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:34', '实时数据', 2);
INSERT INTO `t_data` VALUES (54021, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:35', '实时数据', 2);
INSERT INTO `t_data` VALUES (54022, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:36', '实时数据', 2);
INSERT INTO `t_data` VALUES (54023, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:37', '实时数据', 2);
INSERT INTO `t_data` VALUES (54024, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:38', '实时数据', 2);
INSERT INTO `t_data` VALUES (54025, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:39', '实时数据', 2);
INSERT INTO `t_data` VALUES (54026, '工位1', '28.7', '30.0', '22.3', '4.87', '0.11', '0.5357000000000001', '0.11', '0.5357000000000001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-09-06 15:03:40', '实时数据', 2);

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
INSERT INTO `t_direct` VALUES (849, 8, '180', 'null');
INSERT INTO `t_direct` VALUES (951, 11, '关', 'null');
INSERT INTO `t_direct` VALUES (952, 12, '关', 'null');
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
INSERT INTO `t_direct` VALUES (968, 21, '25', 'null');
INSERT INTO `t_direct` VALUES (977, 22, '20', 'null');
INSERT INTO `t_direct` VALUES (980, 6, '30', 'null');
INSERT INTO `t_direct` VALUES (985, 7, '25', 'null');
INSERT INTO `t_direct` VALUES (986, 9, '40', 'null');
INSERT INTO `t_direct` VALUES (991, 10, '30', 'null');

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
INSERT INTO `t_direct_config` VALUES (6, 0, '自动', '温度上限', '2', 'T1', '1', '100', '0', NULL, 'direct', 'null', 'temperature1', 'yes', NULL, '1');
INSERT INTO `t_direct_config` VALUES (7, 0, '自动', '温度下限', '2', 'T2', '1', '100', '0', NULL, 'direct', 'null', 'temperature2', 'yes', NULL, '1');
INSERT INTO `t_direct_config` VALUES (8, 0, '自动', '光照阈值', '2', 'light_warning', '1', '300', '0', NULL, 'direct', 'null', 'light_min', 'no', NULL, '1');
INSERT INTO `t_direct_config` VALUES (9, 0, '自动', '湿度上限', '2', 'S1', '1', '300', '0', NULL, 'direct', 'null', 'shidu1', 'yes', NULL, '1');
INSERT INTO `t_direct_config` VALUES (10, 0, '自动', '湿度下限', '2', 'S2', '1', '300', '0', NULL, 'direct', 'null', 'shidu2', 'yes', NULL, '1');
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
INSERT INTO `t_direct_config` VALUES (21, 0, '手动', '光照上限', '2', 'L1', '1', '100', '0', NULL, 'direct', 'null', 'light1', 'yes', NULL, '1');
INSERT INTO `t_direct_config` VALUES (22, 0, '手动', '光照下限', '2', 'L2', '1', '100', '0', NULL, 'direct', 'null', 'light2', 'yes', NULL, '1');

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
) ENGINE = InnoDB AUTO_INCREMENT = 2384 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_error_msg
-- ----------------------------
INSERT INTO `t_error_msg` VALUES (2383, '2025-09-06 15:06:42', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2382, '2025-09-06 15:06:41', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2381, '2025-09-06 15:06:41', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2380, '2025-09-06 15:06:40', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2379, '2025-09-06 15:06:39', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2378, '2025-09-06 15:06:38', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2377, '2025-09-06 15:06:36', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2376, '2025-09-06 15:06:35', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2375, '2025-09-06 15:06:34', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2374, '2025-09-06 15:06:33', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2373, '2025-09-06 15:06:32', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2372, '2025-09-06 15:06:31', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2371, '2025-09-06 15:06:30', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2370, '2025-09-06 15:06:29', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2369, '2025-09-06 15:06:28', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2368, '2025-09-06 15:06:27', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2367, '2025-09-06 15:06:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2366, '2025-09-06 15:06:25', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2365, '2025-09-06 15:06:24', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2364, '2025-09-06 15:06:23', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2363, '2025-09-06 15:06:22', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2362, '2025-09-06 15:06:21', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2361, '2025-09-06 15:06:20', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2360, '2025-09-06 15:06:19', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2359, '2025-09-06 15:06:18', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2358, '2025-09-06 15:06:17', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2357, '2025-09-06 15:06:16', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2356, '2025-09-06 15:06:15', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2355, '2025-09-06 15:06:14', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2354, '2025-09-06 15:06:13', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2353, '2025-09-06 15:06:12', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2352, '2025-09-06 15:06:11', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2351, '2025-09-06 15:06:09', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2350, '2025-09-06 15:06:08', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2349, '2025-09-06 15:06:07', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2348, '2025-09-06 15:06:06', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2347, '2025-09-06 15:06:05', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2346, '2025-09-06 15:06:04', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2345, '2025-09-06 15:06:03', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2344, '2025-09-06 15:06:02', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2343, '2025-09-06 15:06:01', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2342, '2025-09-06 15:06:00', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2341, '2025-09-06 15:05:59', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2340, '2025-09-06 15:05:58', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2339, '2025-09-06 15:05:57', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2338, '2025-09-06 15:05:56', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2337, '2025-09-06 15:05:55', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2336, '2025-09-06 15:05:54', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2335, '2025-09-06 15:05:53', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2334, '2025-09-06 15:05:52', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2333, '2025-09-06 15:05:51', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2332, '2025-09-06 15:05:50', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2331, '2025-09-06 15:05:49', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2330, '2025-09-06 15:05:48', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2329, '2025-09-06 15:05:47', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2328, '2025-09-06 15:05:46', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2327, '2025-09-06 15:05:45', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2326, '2025-09-06 15:05:44', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2325, '2025-09-06 15:05:43', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2324, '2025-09-06 15:05:42', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2323, '2025-09-06 15:05:42', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2322, '2025-09-06 15:05:40', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2321, '2025-09-06 15:05:39', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2320, '2025-09-06 15:05:38', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2319, '2025-09-06 15:05:37', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2318, '2025-09-06 15:05:36', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2317, '2025-09-06 15:05:35', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2316, '2025-09-06 15:05:34', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2315, '2025-09-06 15:05:33', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2314, '2025-09-06 15:05:32', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2313, '2025-09-06 15:05:31', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2312, '2025-09-06 15:05:30', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2311, '2025-09-06 15:05:29', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2310, '2025-09-06 15:05:28', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2309, '2025-09-06 15:05:27', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2308, '2025-09-06 15:05:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2307, '2025-09-06 15:05:25', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2306, '2025-09-06 15:05:24', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2305, '2025-09-06 15:05:23', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2304, '2025-09-06 15:05:22', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2303, '2025-09-06 15:05:21', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2302, '2025-09-06 15:05:20', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2301, '2025-09-06 15:05:19', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2300, '2025-09-06 15:05:18', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2299, '2025-09-06 15:05:17', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2298, '2025-09-06 15:05:16', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2297, '2025-09-06 15:05:15', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2296, '2025-09-06 15:05:14', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2295, '2025-09-06 15:05:13', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2294, '2025-09-06 15:05:11', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2293, '2025-09-06 15:05:10', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2292, '2025-09-06 15:05:09', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2291, '2025-09-06 15:05:08', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2290, '2025-09-06 15:05:07', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2289, '2025-09-06 15:05:06', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2288, '2025-09-06 15:05:05', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2287, '2025-09-06 15:05:04', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2286, '2025-09-06 15:05:03', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2285, '2025-09-06 15:05:02', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2284, '2025-09-06 15:05:01', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2283, '2025-09-06 15:05:00', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2282, '2025-09-06 15:04:59', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2281, '2025-09-06 15:04:58', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2280, '2025-09-06 15:04:57', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2279, '2025-09-06 15:04:56', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2278, '2025-09-06 15:04:55', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2277, '2025-09-06 15:04:54', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2276, '2025-09-06 15:04:53', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2275, '2025-09-06 15:04:52', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2274, '2025-09-06 15:04:51', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2273, '2025-09-06 15:04:50', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2272, '2025-09-06 15:04:49', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2271, '2025-09-06 15:04:48', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2270, '2025-09-06 15:04:47', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2269, '2025-09-06 15:04:46', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2268, '2025-09-06 15:04:45', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2267, '2025-09-06 15:04:44', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2266, '2025-09-06 15:04:43', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2265, '2025-09-06 15:04:42', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2264, '2025-09-06 15:04:41', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2263, '2025-09-06 15:04:40', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2262, '2025-09-06 15:04:39', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2261, '2025-09-06 15:04:38', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2260, '2025-09-06 15:04:37', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2259, '2025-09-06 15:04:36', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2258, '2025-09-06 15:04:35', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2257, '2025-09-06 15:04:34', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2256, '2025-09-06 15:04:33', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2255, '2025-09-06 15:04:32', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2254, '2025-09-06 15:04:31', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2253, '2025-09-06 15:04:30', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2252, '2025-09-06 15:04:29', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2251, '2025-09-06 15:04:28', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2250, '2025-09-06 15:04:27', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2249, '2025-09-06 15:04:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2248, '2025-09-06 15:04:25', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2247, '2025-09-06 15:04:24', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2246, '2025-09-06 15:04:23', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2245, '2025-09-06 15:04:22', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2244, '2025-09-06 15:04:21', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2243, '2025-09-06 15:04:20', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2242, '2025-09-06 15:04:19', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2241, '2025-09-06 15:04:18', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2240, '2025-09-06 15:04:16', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2239, '2025-09-06 15:04:15', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2238, '2025-09-06 15:04:14', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2237, '2025-09-06 15:04:13', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2236, '2025-09-06 15:04:12', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2235, '2025-09-06 15:04:11', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2234, '2025-09-06 15:04:10', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2233, '2025-09-06 15:04:09', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2232, '2025-09-06 15:04:08', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2231, '2025-09-06 15:04:07', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2230, '2025-09-06 15:04:06', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2229, '2025-09-06 15:04:05', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2228, '2025-09-06 15:04:04', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2227, '2025-09-06 15:04:03', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2226, '2025-09-06 15:04:02', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2225, '2025-09-06 15:04:01', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2224, '2025-09-06 15:04:00', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2223, '2025-09-06 15:03:59', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2222, '2025-09-06 15:03:58', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2221, '2025-09-06 15:03:57', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2220, '2025-09-06 15:03:56', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2219, '2025-09-06 15:03:55', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2218, '2025-09-06 15:03:54', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2217, '2025-09-06 15:03:53', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2216, '2025-09-06 15:03:52', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2215, '2025-09-06 15:03:51', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2214, '2025-09-06 15:03:50', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2213, '2025-09-06 15:03:49', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2212, '2025-09-06 15:03:48', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2211, '2025-09-06 15:03:47', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2210, '2025-09-06 15:03:46', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2209, '2025-09-06 15:03:45', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2208, '2025-09-06 15:03:44', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2207, '2025-09-06 15:03:43', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2206, '2025-09-06 15:03:42', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2205, '2025-09-06 15:03:41', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2204, '2025-09-06 15:01:46', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2203, '2025-09-06 15:01:45', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2202, '2025-09-06 15:01:44', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2201, '2025-09-06 15:01:43', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2200, '2025-09-06 15:01:42', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2199, '2025-09-06 15:01:41', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2198, '2025-09-06 15:01:40', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2197, '2025-09-06 15:01:39', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2196, '2025-09-06 15:01:38', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2195, '2025-09-06 15:01:37', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2194, '2025-09-06 15:01:36', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2193, '2025-09-06 15:01:35', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2192, '2025-09-06 15:01:34', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2191, '2025-09-06 15:01:32', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2190, '2025-09-06 15:01:31', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2189, '2025-09-06 15:01:30', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2188, '2025-09-06 15:01:29', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2187, '2025-09-06 15:01:28', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2186, '2025-09-06 15:01:27', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2185, '2025-09-06 15:01:26', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2184, '2025-09-06 15:01:25', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2183, '2025-09-06 15:01:25', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2182, '2025-09-06 15:01:23', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2181, '2025-09-06 15:01:22', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2180, '2025-09-06 15:01:21', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2179, '2025-09-06 15:01:20', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2178, '2025-09-06 15:01:19', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2177, '2025-09-06 15:01:18', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2176, '2025-09-06 15:01:17', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2175, '2025-09-06 15:01:16', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2174, '2025-09-06 15:01:15', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2173, '2025-09-06 15:01:14', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2172, '2025-09-06 15:01:13', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2171, '2025-09-06 15:01:12', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2170, '2025-09-06 15:01:11', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2169, '2025-09-06 15:01:10', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2168, '2025-09-06 15:01:09', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2167, '2025-09-06 15:01:08', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2166, '2025-09-06 15:01:07', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2165, '2025-09-06 15:01:06', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2164, '2025-09-06 15:01:05', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2163, '2025-09-06 15:01:04', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2162, '2025-09-06 15:01:03', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2161, '2025-09-06 15:01:02', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2160, '2025-09-06 15:01:01', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2159, '2025-09-06 15:01:00', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2158, '2025-09-06 15:00:59', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2157, '2025-09-06 15:00:58', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2156, '2025-09-06 15:00:57', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2155, '2025-09-06 15:00:56', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2154, '2025-09-06 15:00:55', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2153, '2025-09-06 15:00:54', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2152, '2025-09-06 15:00:53', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2151, '2025-09-06 15:00:52', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2150, '2025-09-06 15:00:50', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2149, '2025-09-06 15:00:49', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2148, '2025-09-06 15:00:48', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2147, '2025-09-06 15:00:47', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2146, '2025-09-06 15:00:46', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2145, '2025-09-06 15:00:45', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2144, '2025-09-06 14:10:37', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2143, '2025-09-06 14:10:36', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2142, '2025-09-06 14:10:35', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2141, '2025-09-06 14:10:34', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2140, '2025-09-06 14:10:33', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2139, '2025-09-06 14:10:32', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2138, '2025-09-06 14:10:31', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2137, '2025-09-06 14:10:30', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2136, '2025-09-06 14:10:29', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2135, '2025-09-06 14:10:28', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2134, '2025-09-06 14:10:27', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2133, '2025-09-06 14:10:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2132, '2025-09-06 14:10:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2131, '2025-09-06 14:10:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2130, '2025-09-06 14:10:24', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2129, '2025-09-06 14:10:22', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2128, '2025-09-06 14:10:21', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2127, '2025-09-06 14:10:20', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2126, '2025-09-06 14:10:19', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2125, '2025-09-06 14:10:18', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2124, '2025-09-06 14:10:17', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2123, '2025-09-06 14:10:16', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2122, '2025-09-06 14:10:15', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2121, '2025-09-06 14:10:14', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2120, '2025-09-06 14:10:13', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2119, '2025-09-06 14:10:12', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2118, '2025-09-06 14:10:11', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2117, '2025-09-06 14:10:10', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2116, '2025-09-06 14:10:09', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2115, '2025-09-06 14:10:08', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2114, '2025-09-06 14:10:07', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2113, '2025-09-06 14:10:06', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2112, '2025-09-06 14:10:05', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2111, '2025-09-06 14:10:04', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2110, '2025-09-06 14:10:03', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2109, '2025-09-06 14:10:02', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2108, '2025-09-06 14:10:01', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2107, '2025-09-06 14:10:00', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2106, '2025-09-06 14:09:59', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2105, '2025-09-06 14:09:58', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2104, '2025-09-06 14:09:57', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2103, '2025-09-06 14:09:56', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2102, '2025-09-06 14:09:55', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2101, '2025-09-06 14:09:54', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2100, '2025-09-06 14:09:53', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2099, '2025-09-06 14:09:52', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2098, '2025-09-06 14:09:51', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2097, '2025-09-06 14:09:49', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2096, '2025-09-06 14:09:48', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2095, '2025-09-06 14:09:47', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2094, '2025-09-06 14:09:46', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2093, '2025-09-06 14:09:45', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2092, '2025-09-06 14:09:44', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2091, '2025-09-06 14:09:43', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2090, '2025-09-06 14:09:42', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2089, '2025-09-06 14:09:41', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2088, '2025-09-06 14:09:40', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2087, '2025-09-06 14:09:39', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2086, '2025-09-06 14:09:38', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2085, '2025-09-06 14:09:37', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2084, '2025-09-06 14:09:36', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2083, '2025-09-06 14:09:35', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2082, '2025-09-06 14:09:34', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2081, '2025-09-06 14:09:33', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2080, '2025-09-06 14:09:32', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2079, '2025-09-06 14:09:31', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2078, '2025-09-06 14:09:30', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2077, '2025-09-06 14:09:29', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2076, '2025-09-06 14:09:28', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2075, '2025-09-06 14:09:27', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2074, '2025-09-06 14:09:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2073, '2025-09-06 14:09:25', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2072, '2025-09-06 14:09:24', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2071, '2025-09-06 14:09:23', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2070, '2025-09-06 14:09:22', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2069, '2025-09-06 14:09:21', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2068, '2025-09-06 14:09:20', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2067, '2025-09-06 14:09:19', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2066, '2025-09-06 14:09:18', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2065, '2025-09-06 14:08:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2064, '2025-09-06 14:08:25', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2063, '2025-09-06 14:08:24', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2062, '2025-09-06 14:08:23', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2061, '2025-09-06 14:08:22', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2060, '2025-09-06 14:08:21', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2059, '2025-09-06 14:08:20', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2058, '2025-09-06 14:08:19', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2057, '2025-09-06 14:08:18', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2056, '2025-09-06 14:08:17', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2055, '2025-09-06 14:08:16', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2054, '2025-09-06 14:08:15', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2053, '2025-09-06 14:08:14', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2052, '2025-09-06 14:08:13', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2051, '2025-09-06 14:08:12', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2050, '2025-09-06 14:08:11', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2049, '2025-09-06 14:08:10', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2048, '2025-09-06 14:08:09', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2047, '2025-09-06 14:08:08', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2046, '2025-09-06 14:08:07', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2045, '2025-09-06 14:08:06', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2044, '2025-09-06 14:08:05', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2043, '2025-09-06 14:08:04', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2042, '2025-09-06 14:08:03', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2041, '2025-09-06 14:08:02', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2040, '2025-09-06 14:08:01', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2039, '2025-09-06 14:08:00', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2038, '2025-09-06 14:07:59', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2037, '2025-09-06 14:07:57', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2036, '2025-09-06 14:06:36', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2035, '2025-09-06 14:06:36', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2034, '2025-09-06 14:06:35', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2033, '2025-09-06 14:06:35', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2032, '2025-09-06 14:06:34', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2031, '2025-09-06 14:06:34', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2030, '2025-09-06 14:06:33', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2029, '2025-09-06 14:06:33', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2028, '2025-09-06 14:06:32', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2027, '2025-09-06 14:06:32', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2026, '2025-09-06 14:06:31', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2025, '2025-09-06 14:06:31', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2024, '2025-09-06 14:06:30', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2023, '2025-09-06 14:06:30', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2022, '2025-09-06 14:06:29', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2021, '2025-09-06 14:06:29', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2020, '2025-09-06 14:06:28', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2019, '2025-09-06 14:06:28', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2018, '2025-09-06 14:06:27', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2017, '2025-09-06 14:06:27', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2016, '2025-09-06 14:06:26', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2015, '2025-09-06 14:06:26', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2014, '2025-09-06 14:06:25', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2013, '2025-09-06 14:06:25', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2012, '2025-09-06 14:06:24', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2011, '2025-09-06 14:06:24', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2010, '2025-09-06 14:06:23', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2009, '2025-09-06 14:06:23', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2008, '2025-09-06 14:06:22', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2007, '2025-09-06 14:06:22', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2006, '2025-09-06 14:06:21', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2005, '2025-09-06 14:06:21', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2004, '2025-09-06 14:06:20', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2003, '2025-09-06 14:06:20', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2002, '2025-09-06 14:06:19', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2001, '2025-09-06 14:06:19', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (2000, '2025-09-06 14:06:18', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1999, '2025-09-06 14:06:18', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1998, '2025-09-06 14:06:17', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1997, '2025-09-06 14:06:17', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1996, '2025-09-06 14:06:16', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1995, '2025-09-06 14:06:16', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1994, '2025-09-06 14:06:15', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1993, '2025-09-06 14:06:15', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1992, '2025-09-06 14:06:14', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1991, '2025-09-06 14:06:14', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1990, '2025-09-06 14:06:13', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1989, '2025-09-06 14:06:13', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1988, '2025-09-06 14:06:12', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1987, '2025-09-06 14:06:12', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1986, '2025-09-06 14:06:11', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1985, '2025-09-06 14:06:11', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1984, '2025-09-06 14:06:10', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1983, '2025-09-06 14:06:10', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1982, '2025-09-06 14:06:09', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1981, '2025-09-06 14:06:09', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1980, '2025-09-06 14:06:08', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1979, '2025-09-06 14:06:08', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1978, '2025-09-06 14:06:06', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1977, '2025-09-06 14:06:06', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1976, '2025-09-06 14:06:05', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1975, '2025-09-06 14:06:05', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1974, '2025-09-06 14:06:04', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1973, '2025-09-06 14:06:04', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1972, '2025-09-06 14:06:03', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1971, '2025-09-06 14:06:03', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1970, '2025-09-06 14:06:02', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1969, '2025-09-06 14:06:02', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1968, '2025-09-06 14:06:01', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1967, '2025-09-06 14:06:01', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1966, '2025-09-06 14:06:00', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1965, '2025-09-06 14:06:00', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1964, '2025-09-06 14:05:59', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1963, '2025-09-06 14:05:59', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1962, '2025-09-06 14:05:58', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1961, '2025-09-06 14:05:58', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1960, '2025-09-06 14:05:57', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1959, '2025-09-06 14:05:57', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1958, '2025-09-06 14:05:56', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1957, '2025-09-06 14:05:56', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1956, '2025-09-06 14:05:55', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1955, '2025-09-06 14:05:55', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1954, '2025-09-06 14:05:54', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1953, '2025-09-06 14:05:54', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1952, '2025-09-06 14:05:53', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1951, '2025-09-06 14:05:53', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1950, '2025-09-06 14:05:52', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1949, '2025-09-06 14:05:52', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1948, '2025-09-06 14:05:51', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1947, '2025-09-06 14:05:51', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1946, '2025-09-06 14:05:50', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1945, '2025-09-06 14:05:50', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1944, '2025-09-06 14:05:49', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1943, '2025-09-06 14:05:49', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1942, '2025-09-06 14:05:48', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1941, '2025-09-06 14:05:48', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1940, '2025-09-06 14:05:47', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1939, '2025-09-06 14:05:47', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1938, '2025-09-06 14:05:46', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1937, '2025-09-06 14:05:46', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1936, '2025-09-06 14:05:45', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1935, '2025-09-06 14:05:45', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1934, '2025-09-06 14:05:44', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1933, '2025-09-06 14:05:44', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1932, '2025-09-06 14:05:43', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1931, '2025-09-06 14:05:43', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1930, '2025-09-06 14:05:42', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1929, '2025-09-06 14:05:42', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1928, '2025-09-06 14:05:41', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1927, '2025-09-06 14:05:41', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1926, '2025-09-06 14:05:40', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1925, '2025-09-06 14:05:40', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1924, '2025-09-06 14:05:39', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1923, '2025-09-06 14:05:39', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1922, '2025-09-06 14:05:38', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1921, '2025-09-06 14:05:38', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1920, '2025-09-06 14:05:37', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1919, '2025-09-06 14:05:37', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1918, '2025-09-06 14:05:36', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1917, '2025-09-06 14:05:36', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1916, '2025-09-06 14:05:06', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1915, '2025-09-06 14:05:06', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1914, '2025-09-06 14:05:06', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1913, '2025-09-06 14:05:05', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1912, '2025-09-06 14:05:05', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1911, '2025-09-06 14:05:05', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1910, '2025-09-06 14:05:04', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1909, '2025-09-06 14:05:04', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1908, '2025-09-06 14:05:04', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1907, '2025-09-06 14:05:03', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1906, '2025-09-06 14:05:03', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1905, '2025-09-06 14:05:03', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1904, '2025-09-06 14:05:02', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1903, '2025-09-06 14:05:02', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1902, '2025-09-06 14:05:02', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1901, '2025-09-06 14:05:01', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1900, '2025-09-06 14:05:01', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1899, '2025-09-06 14:05:01', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1898, '2025-09-06 14:05:00', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1897, '2025-09-06 14:05:00', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1896, '2025-09-06 14:05:00', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1895, '2025-09-06 14:04:59', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1894, '2025-09-06 14:04:59', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1893, '2025-09-06 14:04:59', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1892, '2025-09-06 14:04:58', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1891, '2025-09-06 14:04:58', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1890, '2025-09-06 14:04:58', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1889, '2025-09-06 14:04:57', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1888, '2025-09-06 14:04:57', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1887, '2025-09-06 14:04:57', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1886, '2025-09-06 14:04:56', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1885, '2025-09-06 14:04:56', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1884, '2025-09-06 14:04:56', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1883, '2025-09-06 14:04:55', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1882, '2025-09-06 14:04:55', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1881, '2025-09-06 14:04:55', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1880, '2025-09-06 14:04:54', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1879, '2025-09-06 14:04:54', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1878, '2025-09-06 14:04:54', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1877, '2025-09-06 14:04:53', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1876, '2025-09-06 14:04:53', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1875, '2025-09-06 14:04:53', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1874, '2025-09-06 14:04:52', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1873, '2025-09-06 14:04:52', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1872, '2025-09-06 14:04:52', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1871, '2025-09-06 14:04:51', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1870, '2025-09-06 14:04:51', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1869, '2025-09-06 14:04:51', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1868, '2025-09-06 14:04:50', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1867, '2025-09-06 14:04:50', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1866, '2025-09-06 14:04:50', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1865, '2025-09-06 14:04:49', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1864, '2025-09-06 14:04:49', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1863, '2025-09-06 14:04:49', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1862, '2025-09-06 14:04:48', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1861, '2025-09-06 14:04:48', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1860, '2025-09-06 14:04:48', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1859, '2025-09-06 14:04:47', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1858, '2025-09-06 14:04:47', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1857, '2025-09-06 14:04:47', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1856, '2025-09-06 14:04:46', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1855, '2025-09-06 14:04:46', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1854, '2025-09-06 14:04:46', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1853, '2025-09-06 14:04:45', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1852, '2025-09-06 14:04:45', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1851, '2025-09-06 14:04:45', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1850, '2025-09-06 14:04:44', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1849, '2025-09-06 14:04:44', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1848, '2025-09-06 14:04:44', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1847, '2025-09-06 14:04:43', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1846, '2025-09-06 14:04:43', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1845, '2025-09-06 14:04:43', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1844, '2025-09-06 14:04:42', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1843, '2025-09-06 14:04:42', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1842, '2025-09-06 14:04:42', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1841, '2025-09-06 14:04:41', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1840, '2025-09-06 14:04:41', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1839, '2025-09-06 14:04:41', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1838, '2025-09-06 14:04:40', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1837, '2025-09-06 14:04:40', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1836, '2025-09-06 14:04:40', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1835, '2025-09-06 14:04:39', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1834, '2025-09-06 14:04:39', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1833, '2025-09-06 14:04:39', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1832, '2025-09-06 14:04:38', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1831, '2025-09-06 14:04:38', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1830, '2025-09-06 14:04:38', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1829, '2025-09-06 14:04:37', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1828, '2025-09-06 14:04:37', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1827, '2025-09-06 14:04:37', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1826, '2025-09-06 14:04:36', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1825, '2025-09-06 14:04:36', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1824, '2025-09-06 14:04:36', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1823, '2025-09-06 14:04:35', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1822, '2025-09-06 14:04:35', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1821, '2025-09-06 14:04:35', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1820, '2025-09-06 14:04:34', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1819, '2025-09-06 14:04:34', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1818, '2025-09-06 14:04:34', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1817, '2025-09-06 14:04:33', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1816, '2025-09-06 14:04:33', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1815, '2025-09-06 14:04:33', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1814, '2025-09-06 14:04:32', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1813, '2025-09-06 14:04:32', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1812, '2025-09-06 14:04:32', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1811, '2025-09-06 14:04:31', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1810, '2025-09-06 14:04:31', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1809, '2025-09-06 14:04:31', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1808, '2025-09-06 14:04:30', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1807, '2025-09-06 14:04:30', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1806, '2025-09-06 14:04:30', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1805, '2025-09-06 14:04:29', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1804, '2025-09-06 14:04:29', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1803, '2025-09-06 14:04:29', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1802, '2025-09-06 14:04:28', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1801, '2025-09-06 14:04:28', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1800, '2025-09-06 14:04:28', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1799, '2025-09-06 14:04:27', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1798, '2025-09-06 14:04:27', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1797, '2025-09-06 14:04:27', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1796, '2025-09-06 14:04:26', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1795, '2025-09-06 14:04:26', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1794, '2025-09-06 14:04:26', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1793, '2025-09-06 14:04:25', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1792, '2025-09-06 14:04:25', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1791, '2025-09-06 14:04:25', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1790, '2025-09-06 14:04:24', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1789, '2025-09-06 14:04:24', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1788, '2025-09-06 14:04:24', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1787, '2025-09-06 14:04:23', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1786, '2025-09-06 14:04:23', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1785, '2025-09-06 14:04:23', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1784, '2025-09-06 14:04:22', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1783, '2025-09-06 14:04:22', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1782, '2025-09-06 14:04:22', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1781, '2025-09-06 14:04:21', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1780, '2025-09-06 14:04:21', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1779, '2025-09-06 14:04:21', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1778, '2025-09-06 14:04:20', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1777, '2025-09-06 14:04:20', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1776, '2025-09-06 14:04:20', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1775, '2025-09-06 14:04:18', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1774, '2025-09-06 14:04:18', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1773, '2025-09-06 14:04:18', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1772, '2025-09-06 14:04:17', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1771, '2025-09-06 14:04:17', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1770, '2025-09-06 14:04:17', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1769, '2025-09-06 14:04:16', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1768, '2025-09-06 14:04:16', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1767, '2025-09-06 14:04:16', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1766, '2025-09-06 14:04:15', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1765, '2025-09-06 14:04:15', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1764, '2025-09-06 14:04:15', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1763, '2025-09-06 14:04:14', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1762, '2025-09-06 14:04:14', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1761, '2025-09-06 14:04:14', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1760, '2025-09-06 14:04:13', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1759, '2025-09-06 14:04:13', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1758, '2025-09-06 14:04:13', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1757, '2025-09-06 14:04:12', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1756, '2025-09-06 14:04:12', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1755, '2025-09-06 14:04:12', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1754, '2025-09-06 14:04:11', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1753, '2025-09-06 14:04:11', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1752, '2025-09-06 14:04:11', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1751, '2025-09-06 14:04:10', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1750, '2025-09-06 14:04:10', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1749, '2025-09-06 14:04:10', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1748, '2025-09-06 14:04:09', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1747, '2025-09-06 14:04:09', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1746, '2025-09-06 14:04:09', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1745, '2025-09-06 14:04:08', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1744, '2025-09-06 14:04:08', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1743, '2025-09-06 14:04:08', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1742, '2025-09-06 14:04:07', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1741, '2025-09-06 14:04:07', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1740, '2025-09-06 14:04:07', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1739, '2025-09-06 14:04:06', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1738, '2025-09-06 14:04:06', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1737, '2025-09-06 14:04:06', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1736, '2025-09-06 14:04:05', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1735, '2025-09-06 14:04:05', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1734, '2025-09-06 14:04:05', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1733, '2025-09-06 14:04:04', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1732, '2025-09-06 14:04:04', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1731, '2025-09-06 14:04:04', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1730, '2025-09-06 14:04:03', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1729, '2025-09-06 14:04:03', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1728, '2025-09-06 14:04:03', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1727, '2025-09-06 14:04:02', '光照越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1726, '2025-09-06 14:04:02', '湿度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1725, '2025-09-06 14:04:02', '温度越界', NULL, NULL, '工位1', '偏小');
INSERT INTO `t_error_msg` VALUES (1724, '2025-09-06 14:01:18', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1723, '2025-09-06 14:01:18', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1722, '2025-09-06 14:01:18', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1721, '2025-09-06 14:01:17', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1720, '2025-09-06 14:01:17', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1719, '2025-09-06 14:01:17', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1718, '2025-09-06 14:01:16', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1717, '2025-09-06 14:01:16', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1716, '2025-09-06 14:01:16', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1715, '2025-09-06 14:01:15', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1714, '2025-09-06 14:01:15', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1713, '2025-09-06 14:01:15', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1712, '2025-09-06 14:01:14', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1711, '2025-09-06 14:01:14', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1710, '2025-09-06 14:01:14', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1709, '2025-09-06 14:01:13', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1708, '2025-09-06 14:01:13', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1707, '2025-09-06 14:01:13', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1706, '2025-09-06 14:01:12', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1705, '2025-09-06 14:01:12', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1704, '2025-09-06 14:01:12', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1703, '2025-09-06 14:01:11', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1702, '2025-09-06 14:01:11', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1701, '2025-09-06 14:01:11', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1700, '2025-09-06 14:01:10', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1699, '2025-09-06 14:01:10', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1698, '2025-09-06 14:01:10', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1697, '2025-09-06 14:01:09', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1696, '2025-09-06 14:01:09', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1695, '2025-09-06 14:01:09', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1694, '2025-09-06 14:01:08', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1693, '2025-09-06 14:01:08', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1692, '2025-09-06 14:01:08', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1691, '2025-09-06 14:01:07', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1690, '2025-09-06 14:01:07', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1689, '2025-09-06 14:01:07', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1688, '2025-09-06 14:01:06', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1687, '2025-09-06 14:01:06', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1686, '2025-09-06 14:01:06', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1685, '2025-09-06 14:01:05', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1684, '2025-09-06 14:01:05', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1683, '2025-09-06 14:01:05', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1682, '2025-09-06 14:01:04', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1681, '2025-09-06 14:01:04', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1680, '2025-09-06 14:01:04', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1679, '2025-09-06 14:01:03', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1678, '2025-09-06 14:01:03', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1677, '2025-09-06 14:01:03', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1676, '2025-09-06 14:01:02', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1675, '2025-09-06 14:01:02', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1674, '2025-09-06 14:01:02', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1673, '2025-09-06 14:01:01', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1672, '2025-09-06 14:01:01', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1671, '2025-09-06 14:01:01', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1670, '2025-09-06 14:01:00', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1669, '2025-09-06 14:01:00', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1668, '2025-09-06 14:01:00', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1667, '2025-09-06 14:00:59', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1666, '2025-09-06 14:00:59', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1665, '2025-09-06 14:00:59', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1664, '2025-09-06 14:00:58', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1663, '2025-09-06 14:00:58', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1662, '2025-09-06 14:00:58', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1661, '2025-09-06 14:00:57', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1660, '2025-09-06 14:00:57', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1659, '2025-09-06 14:00:57', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1658, '2025-09-06 14:00:56', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1657, '2025-09-06 14:00:56', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1656, '2025-09-06 14:00:56', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1655, '2025-09-06 14:00:55', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1654, '2025-09-06 14:00:55', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1653, '2025-09-06 14:00:55', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1652, '2025-09-06 14:00:54', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1651, '2025-09-06 14:00:54', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1650, '2025-09-06 14:00:54', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1649, '2025-09-06 14:00:53', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1648, '2025-09-06 14:00:53', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1647, '2025-09-06 14:00:53', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1646, '2025-09-06 14:00:52', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1645, '2025-09-06 14:00:52', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1644, '2025-09-06 14:00:52', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1643, '2025-09-06 14:00:51', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1642, '2025-09-06 14:00:51', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1641, '2025-09-06 14:00:51', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1640, '2025-09-06 14:00:50', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1639, '2025-09-06 14:00:50', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1638, '2025-09-06 14:00:50', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1637, '2025-09-06 14:00:49', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1636, '2025-09-06 14:00:49', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1635, '2025-09-06 14:00:49', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1634, '2025-09-06 14:00:48', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1633, '2025-09-06 14:00:48', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1632, '2025-09-06 14:00:48', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1631, '2025-09-06 14:00:47', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1630, '2025-09-06 14:00:47', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1629, '2025-09-06 14:00:47', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1628, '2025-09-06 14:00:46', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1627, '2025-09-06 14:00:46', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1626, '2025-09-06 14:00:46', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1625, '2025-09-06 14:00:45', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1624, '2025-09-06 14:00:45', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1623, '2025-09-06 14:00:45', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1622, '2025-09-06 14:00:44', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1621, '2025-09-06 14:00:44', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1620, '2025-09-06 14:00:44', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1619, '2025-09-06 14:00:43', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1618, '2025-09-06 14:00:43', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1617, '2025-09-06 14:00:42', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1616, '2025-09-06 14:00:41', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1615, '2025-09-06 14:00:41', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1614, '2025-09-06 14:00:41', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1613, '2025-09-06 14:00:40', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1612, '2025-09-06 14:00:40', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1611, '2025-09-06 14:00:40', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1610, '2025-09-06 14:00:39', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1609, '2025-09-06 14:00:39', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1608, '2025-09-06 14:00:39', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1607, '2025-09-06 14:00:38', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1606, '2025-09-06 14:00:38', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1605, '2025-09-06 14:00:38', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1604, '2025-09-06 14:00:37', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1603, '2025-09-06 14:00:37', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1602, '2025-09-06 14:00:37', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1601, '2025-09-06 14:00:36', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1600, '2025-09-06 14:00:36', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1599, '2025-09-06 14:00:36', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1598, '2025-09-06 13:59:41', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1597, '2025-09-06 13:59:41', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1596, '2025-09-06 13:59:41', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1595, '2025-09-06 13:59:40', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1594, '2025-09-06 13:59:40', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1593, '2025-09-06 13:59:40', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1592, '2025-09-06 13:59:39', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1591, '2025-09-06 13:59:39', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1590, '2025-09-06 13:59:39', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1589, '2025-09-06 13:59:38', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1588, '2025-09-06 13:59:38', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1587, '2025-09-06 13:59:38', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1586, '2025-09-06 13:59:37', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1585, '2025-09-06 13:59:37', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1584, '2025-09-06 13:59:37', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1583, '2025-09-06 13:59:36', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1582, '2025-09-06 13:59:36', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1581, '2025-09-06 13:59:36', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1580, '2025-09-06 13:59:35', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1579, '2025-09-06 13:59:35', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1578, '2025-09-06 13:59:35', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1577, '2025-09-06 13:59:34', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1576, '2025-09-06 13:59:34', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1575, '2025-09-06 13:59:34', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1574, '2025-09-06 13:59:33', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1573, '2025-09-06 13:59:33', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1572, '2025-09-06 13:59:33', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1571, '2025-09-06 13:59:32', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1570, '2025-09-06 13:59:32', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1569, '2025-09-06 13:59:32', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1568, '2025-09-06 13:59:31', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1567, '2025-09-06 13:59:31', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1566, '2025-09-06 13:59:31', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1565, '2025-09-06 13:59:30', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1564, '2025-09-06 13:59:30', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1563, '2025-09-06 13:59:30', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1562, '2025-09-06 13:59:29', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1561, '2025-09-06 13:59:29', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1560, '2025-09-06 13:59:29', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1559, '2025-09-06 13:59:28', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1558, '2025-09-06 13:59:28', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1557, '2025-09-06 13:59:28', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1556, '2025-09-06 13:59:27', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1555, '2025-09-06 13:59:27', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1554, '2025-09-06 13:59:27', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1553, '2025-09-06 13:59:26', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1552, '2025-09-06 13:59:26', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1551, '2025-09-06 13:59:26', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1550, '2025-09-06 13:59:25', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1549, '2025-09-06 13:59:25', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1548, '2025-09-06 13:59:25', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1547, '2025-09-06 13:59:24', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1546, '2025-09-06 13:59:24', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1545, '2025-09-06 13:59:24', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1544, '2025-09-06 13:59:23', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1543, '2025-09-06 13:59:23', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1542, '2025-09-06 13:59:23', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1541, '2025-09-06 13:59:22', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1540, '2025-09-06 13:59:22', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1539, '2025-09-06 13:59:22', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1538, '2025-09-06 13:59:21', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1537, '2025-09-06 13:59:21', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1536, '2025-09-06 13:59:21', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1535, '2025-09-06 13:59:20', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1534, '2025-09-06 13:59:20', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1533, '2025-09-06 13:59:20', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1532, '2025-09-06 13:59:19', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1531, '2025-09-06 13:59:19', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1530, '2025-09-06 13:59:19', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1529, '2025-09-06 13:59:18', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1528, '2025-09-06 13:59:18', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1527, '2025-09-06 13:59:18', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1526, '2025-09-06 13:59:17', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1525, '2025-09-06 13:59:17', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1524, '2025-09-06 13:59:17', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1523, '2025-09-06 13:59:16', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1522, '2025-09-06 13:59:16', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1521, '2025-09-06 13:59:16', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1520, '2025-09-06 13:59:15', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1519, '2025-09-06 13:59:15', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1518, '2025-09-06 13:59:15', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1517, '2025-09-06 13:59:14', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1516, '2025-09-06 13:59:14', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1515, '2025-09-06 13:59:14', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1514, '2025-09-06 13:59:13', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1513, '2025-09-06 13:59:13', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1512, '2025-09-06 13:59:13', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1511, '2025-09-06 13:59:12', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1510, '2025-09-06 13:59:12', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1509, '2025-09-06 13:59:12', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1508, '2025-09-06 13:59:11', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1507, '2025-09-06 13:59:11', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1506, '2025-09-06 13:59:11', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1505, '2025-09-06 13:59:10', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1504, '2025-09-06 13:59:10', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1503, '2025-09-06 13:59:10', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1502, '2025-09-06 13:59:09', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1501, '2025-09-06 13:59:09', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1500, '2025-09-06 13:59:09', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1499, '2025-09-06 13:59:08', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1498, '2025-09-06 13:59:08', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1497, '2025-09-06 13:59:08', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1496, '2025-09-06 13:59:07', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1495, '2025-09-06 13:59:07', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1494, '2025-09-06 13:59:07', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1493, '2025-09-06 13:59:06', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1492, '2025-09-06 13:59:06', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1491, '2025-09-06 13:59:06', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1490, '2025-09-06 13:59:05', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1489, '2025-09-06 13:59:05', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1488, '2025-09-06 13:59:05', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1487, '2025-09-06 13:59:04', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1486, '2025-09-06 13:59:04', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1485, '2025-09-06 13:59:04', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1484, '2025-09-06 13:59:03', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1483, '2025-09-06 13:59:03', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1482, '2025-09-06 13:59:03', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1481, '2025-09-06 13:59:02', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1480, '2025-09-06 13:59:02', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1479, '2025-09-06 13:59:02', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1478, '2025-09-06 13:59:01', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1477, '2025-09-06 13:59:01', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1476, '2025-09-06 13:59:01', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1475, '2025-09-06 13:59:00', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1474, '2025-09-06 13:59:00', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1473, '2025-09-06 13:59:00', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1472, '2025-09-06 13:58:59', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1471, '2025-09-06 13:58:59', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1470, '2025-09-06 13:58:59', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1469, '2025-09-06 13:58:58', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1468, '2025-09-06 13:58:58', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1467, '2025-09-06 13:58:58', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1466, '2025-09-06 13:58:57', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1465, '2025-09-06 13:58:57', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1464, '2025-09-06 13:58:57', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1463, '2025-09-06 13:58:56', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1462, '2025-09-06 13:58:56', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1461, '2025-09-06 13:58:56', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1460, '2025-09-06 13:58:55', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1459, '2025-09-06 13:58:55', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1458, '2025-09-06 13:58:55', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1457, '2025-09-06 13:58:54', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1456, '2025-09-06 13:58:54', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1455, '2025-09-06 13:58:54', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1454, '2025-09-06 13:58:53', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1453, '2025-09-06 13:58:53', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1452, '2025-09-06 13:58:53', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1451, '2025-09-06 13:58:52', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1450, '2025-09-06 13:58:52', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1449, '2025-09-06 13:58:52', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1448, '2025-09-06 13:58:50', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1447, '2025-09-06 13:58:50', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1446, '2025-09-06 13:58:50', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1445, '2025-09-06 13:58:49', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1444, '2025-09-06 13:58:49', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1443, '2025-09-06 13:58:49', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1442, '2025-09-06 13:58:48', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1441, '2025-09-06 13:58:48', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1440, '2025-09-06 13:58:48', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1439, '2025-09-06 13:58:47', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1438, '2025-09-06 13:58:47', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1437, '2025-09-06 13:58:47', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1436, '2025-09-06 13:58:46', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1435, '2025-09-06 13:58:46', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1434, '2025-09-06 13:58:46', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1433, '2025-09-06 13:58:45', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1432, '2025-09-06 13:58:45', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1431, '2025-09-06 13:58:45', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1430, '2025-09-06 13:58:44', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1429, '2025-09-06 13:58:44', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1428, '2025-09-06 13:58:44', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1427, '2025-09-06 13:58:43', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1426, '2025-09-06 13:58:43', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1425, '2025-09-06 13:58:43', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1424, '2025-09-06 13:58:42', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1423, '2025-09-06 13:58:42', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1422, '2025-09-06 13:58:42', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1421, '2025-09-06 13:58:41', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1420, '2025-09-06 13:58:41', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1419, '2025-09-06 13:58:41', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1418, '2025-09-06 13:58:40', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1417, '2025-09-06 13:58:40', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1416, '2025-09-06 13:58:40', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1415, '2025-09-06 13:58:39', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1414, '2025-09-06 13:58:39', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1413, '2025-09-06 13:58:39', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1412, '2025-09-06 13:58:38', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1411, '2025-09-06 13:58:38', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1410, '2025-09-06 13:58:38', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1409, '2025-09-06 13:58:37', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1408, '2025-09-06 13:58:37', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1407, '2025-09-06 13:58:37', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1406, '2025-09-06 13:58:36', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1405, '2025-09-06 13:58:36', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1404, '2025-09-06 13:58:36', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1403, '2025-09-06 13:58:35', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1402, '2025-09-06 13:58:35', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1401, '2025-09-06 13:58:35', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1400, '2025-09-06 13:58:34', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1399, '2025-09-06 13:58:34', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1398, '2025-09-06 13:58:34', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1397, '2025-09-06 13:58:33', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1396, '2025-09-06 13:58:33', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1395, '2025-09-06 13:58:33', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1394, '2025-09-06 13:58:32', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1393, '2025-09-06 13:58:32', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1392, '2025-09-06 13:58:32', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1391, '2025-09-06 13:58:31', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1390, '2025-09-06 13:58:31', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1389, '2025-09-06 13:58:31', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1388, '2025-09-06 13:58:30', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1387, '2025-09-06 13:58:30', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1386, '2025-09-06 13:58:30', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1385, '2025-09-06 13:58:29', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1384, '2025-09-06 13:58:29', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1383, '2025-09-06 13:58:29', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1382, '2025-09-06 13:58:28', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1381, '2025-09-06 13:58:28', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1380, '2025-09-06 13:58:28', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1379, '2025-09-06 13:58:27', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1378, '2025-09-06 13:58:27', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1377, '2025-09-06 13:58:27', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1376, '2025-09-06 13:58:26', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1375, '2025-09-06 13:58:26', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1374, '2025-09-06 13:58:26', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1373, '2025-09-06 13:58:25', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1372, '2025-09-06 13:58:25', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1371, '2025-09-06 13:58:25', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1370, '2025-09-06 13:58:24', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1369, '2025-09-06 13:58:24', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1368, '2025-09-06 13:58:24', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1367, '2025-09-06 13:58:23', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1366, '2025-09-06 13:58:23', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1365, '2025-09-06 13:58:23', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1364, '2025-09-06 13:58:22', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1363, '2025-09-06 13:58:22', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1362, '2025-09-06 13:58:22', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1361, '2025-09-06 13:58:21', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1360, '2025-09-06 13:58:21', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1359, '2025-09-06 13:58:21', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1358, '2025-09-06 13:58:20', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1357, '2025-09-06 13:58:20', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1356, '2025-09-06 13:58:20', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1355, '2025-09-06 13:58:19', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1354, '2025-09-06 13:58:19', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1353, '2025-09-06 13:58:19', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1352, '2025-09-06 13:58:18', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1351, '2025-09-06 13:58:18', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1350, '2025-09-06 13:58:18', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1349, '2025-09-06 13:58:17', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1348, '2025-09-06 13:58:17', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1347, '2025-09-06 13:58:17', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1346, '2025-09-06 13:58:16', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1345, '2025-09-06 13:58:16', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1344, '2025-09-06 13:58:16', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1343, '2025-09-06 13:58:15', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1342, '2025-09-06 13:58:15', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1341, '2025-09-06 13:58:15', '温度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1340, '2025-09-06 13:58:14', '光照越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1339, '2025-09-06 13:58:14', '湿度越界', NULL, NULL, '工位1', '偏大');
INSERT INTO `t_error_msg` VALUES (1338, '2025-09-06 13:58:14', '温度越界', NULL, NULL, '工位1', '偏大');
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
