/*
 Navicat Premium Data Transfer

 Source Server         : mysql80
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3307
 Source Schema         : blog_z2

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001
 Author                : Ahzoo
 Github                : https://github.com/ooahz
 Date: 27/07/2024 16:05:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for b_access
-- ----------------------------
DROP TABLE IF EXISTS `b_access`;
CREATE TABLE `b_access`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL DEFAULT 0,
  `uv` int NULL DEFAULT NULL,
  `pv` int NULL DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 2 COMMENT '类型(1:全站,2:文章)',
  `date` datetime NOT NULL COMMENT '数据统计的时间',
  PRIMARY KEY (`id`, `article_id`) USING BTREE,
  UNIQUE INDEX `idx_b_article_ai`(`article_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_access
-- ----------------------------

-- ----------------------------
-- Table structure for b_article
-- ----------------------------
DROP TABLE IF EXISTS `b_article`;
CREATE TABLE `b_article`  (
  `id` bigint NOT NULL,
  `path` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文章路径',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文章标题',
  `description` varchar(520) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文章概述',
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文章预览图',
  `style` varchar(520) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '文章页背景样式',
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型（1：原创，2：转载）',
  `weight` tinyint NOT NULL DEFAULT 1 COMMENT '权重',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态（1：正常，2：隐藏，3：草稿）',
  `deprecated` tinyint(1) NOT NULL DEFAULT 0 COMMENT '废弃（1：废弃，0：正常）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_b_article_p`(`path`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '文章表：\r\n作者：十玖八柒（Ahzoo）\r\nGithub：https://github.com/ooahz' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_article
-- ----------------------------

-- ----------------------------
-- Table structure for b_article_column
-- ----------------------------
DROP TABLE IF EXISTS `b_article_column`;
CREATE TABLE `b_article_column`  (
  `column_id` bigint NOT NULL,
  `article_id` bigint NOT NULL,
  INDEX `idx_b_article_ci`(`column_id`) USING BTREE,
  INDEX `idx_b_article_ai`(`article_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_article_column
-- ----------------------------

-- ----------------------------
-- Table structure for b_article_content
-- ----------------------------
DROP TABLE IF EXISTS `b_article_content`;
CREATE TABLE `b_article_content`  (
  `article_id` bigint NOT NULL,
  `content_md` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'markdown原文',
  `content_html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT 'html原文',
  PRIMARY KEY (`article_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_article_content
-- ----------------------------

-- ----------------------------
-- Table structure for b_category
-- ----------------------------
DROP TABLE IF EXISTS `b_category`;
CREATE TABLE `b_category`  (
  `id` bigint NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_category
-- ----------------------------

-- ----------------------------
-- Table structure for b_category_column
-- ----------------------------
DROP TABLE IF EXISTS `b_category_column`;
CREATE TABLE `b_category_column`  (
  `category_id` bigint NOT NULL,
  `column_id` bigint NOT NULL,
  INDEX `idx_b_article_cai`(`category_id`) USING BTREE,
  INDEX `idx_b_article_coi`(`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_category_column
-- ----------------------------

-- ----------------------------
-- Table structure for b_column
-- ----------------------------
DROP TABLE IF EXISTS `b_column`;
CREATE TABLE `b_column`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '专栏名',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '专栏简介',
  `thumbnail` varchar(520) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '专栏缩略图',
  `style` varchar(520) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '专栏背景样式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_column
-- ----------------------------

-- ----------------------------
-- Table structure for b_friend
-- ----------------------------
DROP TABLE IF EXISTS `b_friend`;
CREATE TABLE `b_friend`  (
  `id` bigint NOT NULL,
  `old_website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `weight` int NULL DEFAULT NULL COMMENT '权重',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '类型(1:默认,2:技术,3:生活）',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态(0:不可见,1:正常,2审核中,3待更新)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b_friend
-- ----------------------------
INSERT INTO `b_friend` VALUES (10001, NULL, NULL, 'https://ahzoo.cn', '十玖八柒', NULL, 'https://ahzoo.cn/img/avatar.webp', 1, 1, 1);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '方法名',
  `request_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求方式',
  `request_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求源地址',
  `request_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求源ip',
  `param` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求参数',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `updated_time` datetime NOT NULL COMMENT '写入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `role_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 10001, 'admin');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL,
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_sys_user_e`(`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (10001, 'ahzoo@qq.com', 'ahzoo', 'aeac04f9dfb9db3b42785b8ebb88eee0be9a5645aa9cce3ee0bad55bf0fcbf3c', '580fa5e0665bc5301c83f7', 1);

SET FOREIGN_KEY_CHECKS = 1;
