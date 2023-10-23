/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : 127.0.0.1:3306
 Source Schema         : flarum

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 23/10/2023 15:48:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for f_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `f_access_tokens`;
CREATE TABLE `f_access_tokens`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `token` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `last_activity_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `last_ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `last_user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `F_access_tokens_token_unique`(`token`) USING BTREE,
  INDEX `F_access_tokens_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `F_access_tokens_type_index`(`type`) USING BTREE,
  CONSTRAINT `F_access_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_access_tokens
-- ----------------------------
INSERT INTO `f_access_tokens` VALUES (1, 'woNU2xcBGQyaFitUysXwVeSvP9XyTM5AJrGtssqc', 1, '2023-10-23 07:47:03', '2023-10-23 07:35:08', 'session_remember', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36 Edg/118.0.2088.61');

-- ----------------------------
-- Table structure for f_api_keys
-- ----------------------------
DROP TABLE IF EXISTS `f_api_keys`;
CREATE TABLE `f_api_keys`  (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `allowed_ips` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_activity_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `F_api_keys_key_unique`(`key`) USING BTREE,
  INDEX `F_api_keys_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `F_api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_api_keys
-- ----------------------------

-- ----------------------------
-- Table structure for f_discussion_tag
-- ----------------------------
DROP TABLE IF EXISTS `f_discussion_tag`;
CREATE TABLE `f_discussion_tag`  (
  `discussion_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`discussion_id`, `tag_id`) USING BTREE,
  INDEX `f_discussion_tag_tag_id_foreign`(`tag_id`) USING BTREE,
  CONSTRAINT `f_discussion_tag_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `f_discussions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_discussion_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `f_tags` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_discussion_tag
-- ----------------------------

-- ----------------------------
-- Table structure for f_discussion_user
-- ----------------------------
DROP TABLE IF EXISTS `f_discussion_user`;
CREATE TABLE `f_discussion_user`  (
  `user_id` int(10) UNSIGNED NOT NULL,
  `discussion_id` int(10) UNSIGNED NOT NULL,
  `last_read_at` datetime NULL DEFAULT NULL,
  `last_read_post_number` int(10) UNSIGNED NULL DEFAULT NULL,
  `subscription` enum('follow','ignore') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `discussion_id`) USING BTREE,
  INDEX `F_discussion_user_discussion_id_foreign`(`discussion_id`) USING BTREE,
  CONSTRAINT `F_discussion_user_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `f_discussions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `F_discussion_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_discussion_user
-- ----------------------------
INSERT INTO `f_discussion_user` VALUES (1, 1, '2023-10-23 07:39:06', 1, NULL);

-- ----------------------------
-- Table structure for f_discussions
-- ----------------------------
DROP TABLE IF EXISTS `f_discussions`;
CREATE TABLE `f_discussions`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT 1,
  `participant_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `post_number_index` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `first_post_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `last_posted_at` datetime NULL DEFAULT NULL,
  `last_posted_user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `last_post_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `last_post_number` int(10) UNSIGNED NULL DEFAULT NULL,
  `hidden_at` datetime NULL DEFAULT NULL,
  `hidden_user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `is_approved` tinyint(1) NOT NULL DEFAULT 1,
  `is_sticky` tinyint(1) NOT NULL DEFAULT 0,
  `is_locked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `F_discussions_hidden_user_id_foreign`(`hidden_user_id`) USING BTREE,
  INDEX `F_discussions_first_post_id_foreign`(`first_post_id`) USING BTREE,
  INDEX `F_discussions_last_post_id_foreign`(`last_post_id`) USING BTREE,
  INDEX `F_discussions_last_posted_at_index`(`last_posted_at`) USING BTREE,
  INDEX `F_discussions_last_posted_user_id_index`(`last_posted_user_id`) USING BTREE,
  INDEX `F_discussions_created_at_index`(`created_at`) USING BTREE,
  INDEX `F_discussions_user_id_index`(`user_id`) USING BTREE,
  INDEX `F_discussions_comment_count_index`(`comment_count`) USING BTREE,
  INDEX `F_discussions_participant_count_index`(`participant_count`) USING BTREE,
  INDEX `F_discussions_hidden_at_index`(`hidden_at`) USING BTREE,
  INDEX `f_discussions_is_sticky_created_at_index`(`is_sticky`, `created_at`) USING BTREE,
  INDEX `f_discussions_is_sticky_last_posted_at_index`(`is_sticky`, `last_posted_at`) USING BTREE,
  INDEX `f_discussions_is_locked_index`(`is_locked`) USING BTREE,
  FULLTEXT INDEX `title`(`title`),
  CONSTRAINT `F_discussions_first_post_id_foreign` FOREIGN KEY (`first_post_id`) REFERENCES `f_posts` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `F_discussions_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `F_discussions_last_post_id_foreign` FOREIGN KEY (`last_post_id`) REFERENCES `f_posts` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `F_discussions_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `F_discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_discussions
-- ----------------------------
INSERT INTO `f_discussions` VALUES (1, '新人报道', 1, 1, 0, '2023-10-23 07:39:06', 1, 1, '2023-10-23 07:39:06', 1, 1, 1, NULL, NULL, '', 0, 1, 0, 0);

-- ----------------------------
-- Table structure for f_email_tokens
-- ----------------------------
DROP TABLE IF EXISTS `f_email_tokens`;
CREATE TABLE `f_email_tokens`  (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`token`) USING BTREE,
  INDEX `F_email_tokens_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `F_email_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_email_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for f_flags
-- ----------------------------
DROP TABLE IF EXISTS `f_flags`;
CREATE TABLE `f_flags`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `reason_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `f_flags_post_id_foreign`(`post_id`) USING BTREE,
  INDEX `f_flags_user_id_foreign`(`user_id`) USING BTREE,
  INDEX `f_flags_created_at_index`(`created_at`) USING BTREE,
  CONSTRAINT `f_flags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_flags_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_flags
-- ----------------------------

-- ----------------------------
-- Table structure for f_group_permission
-- ----------------------------
DROP TABLE IF EXISTS `f_group_permission`;
CREATE TABLE `f_group_permission`  (
  `group_id` int(10) UNSIGNED NOT NULL,
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`, `permission`) USING BTREE,
  CONSTRAINT `F_group_permission_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `f_groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_group_permission
-- ----------------------------
INSERT INTO `f_group_permission` VALUES (2, 'viewForum', NULL);
INSERT INTO `f_group_permission` VALUES (3, 'discussion.flagPosts', '2023-10-23 15:35:08');
INSERT INTO `f_group_permission` VALUES (3, 'discussion.likePosts', '2023-10-23 15:35:10');
INSERT INTO `f_group_permission` VALUES (3, 'discussion.reply', NULL);
INSERT INTO `f_group_permission` VALUES (3, 'discussion.replyWithoutApproval', '2023-10-23 15:35:09');
INSERT INTO `f_group_permission` VALUES (3, 'discussion.startWithoutApproval', '2023-10-23 15:35:09');
INSERT INTO `f_group_permission` VALUES (3, 'searchUsers', NULL);
INSERT INTO `f_group_permission` VALUES (3, 'startDiscussion', NULL);
INSERT INTO `f_group_permission` VALUES (4, 'discussion.approvePosts', '2023-10-23 15:35:09');
INSERT INTO `f_group_permission` VALUES (4, 'discussion.editPosts', NULL);
INSERT INTO `f_group_permission` VALUES (4, 'discussion.hide', NULL);
INSERT INTO `f_group_permission` VALUES (4, 'discussion.hidePosts', NULL);
INSERT INTO `f_group_permission` VALUES (4, 'discussion.lock', '2023-10-23 15:35:10');
INSERT INTO `f_group_permission` VALUES (4, 'discussion.rename', NULL);
INSERT INTO `f_group_permission` VALUES (4, 'discussion.sticky', '2023-10-23 15:35:10');
INSERT INTO `f_group_permission` VALUES (4, 'discussion.tag', '2023-10-23 15:35:09');
INSERT INTO `f_group_permission` VALUES (4, 'discussion.viewFlags', '2023-10-23 15:35:08');
INSERT INTO `f_group_permission` VALUES (4, 'discussion.viewIpsPosts', NULL);
INSERT INTO `f_group_permission` VALUES (4, 'user.suspend', '2023-10-23 15:35:10');
INSERT INTO `f_group_permission` VALUES (4, 'user.viewLastSeenAt', NULL);

-- ----------------------------
-- Table structure for f_group_user
-- ----------------------------
DROP TABLE IF EXISTS `f_group_user`;
CREATE TABLE `f_group_user`  (
  `user_id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `group_id`) USING BTREE,
  INDEX `F_group_user_group_id_foreign`(`group_id`) USING BTREE,
  CONSTRAINT `F_group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `f_groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `F_group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_group_user
-- ----------------------------
INSERT INTO `f_group_user` VALUES (1, 1, '2023-10-23 15:35:08');
INSERT INTO `f_group_user` VALUES (1, 4, '2023-10-23 15:36:14');

-- ----------------------------
-- Table structure for f_groups
-- ----------------------------
DROP TABLE IF EXISTS `f_groups`;
CREATE TABLE `f_groups`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_singular` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_plural` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_groups
-- ----------------------------
INSERT INTO `f_groups` VALUES (1, 'Admin', 'Admins', '#B72A2A', 'fas fa-wrench', 0, NULL, NULL);
INSERT INTO `f_groups` VALUES (2, 'Guest', 'Guests', NULL, NULL, 0, NULL, NULL);
INSERT INTO `f_groups` VALUES (3, 'Member', 'Members', NULL, NULL, 0, NULL, NULL);
INSERT INTO `f_groups` VALUES (4, 'Mod', 'Mods', '#80349E', 'fas fa-bolt', 0, NULL, NULL);

-- ----------------------------
-- Table structure for f_login_providers
-- ----------------------------
DROP TABLE IF EXISTS `f_login_providers`;
CREATE TABLE `f_login_providers`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `last_login_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `F_login_providers_provider_identifier_unique`(`provider`, `identifier`) USING BTREE,
  INDEX `F_login_providers_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `F_login_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_login_providers
-- ----------------------------

-- ----------------------------
-- Table structure for f_migrations
-- ----------------------------
DROP TABLE IF EXISTS `f_migrations`;
CREATE TABLE `f_migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 139 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_migrations
-- ----------------------------
INSERT INTO `f_migrations` VALUES (1, '2015_02_24_000000_create_access_tokens_table', NULL);
INSERT INTO `f_migrations` VALUES (2, '2015_02_24_000000_create_api_keys_table', NULL);
INSERT INTO `f_migrations` VALUES (3, '2015_02_24_000000_create_config_table', NULL);
INSERT INTO `f_migrations` VALUES (4, '2015_02_24_000000_create_discussions_table', NULL);
INSERT INTO `f_migrations` VALUES (5, '2015_02_24_000000_create_email_tokens_table', NULL);
INSERT INTO `f_migrations` VALUES (6, '2015_02_24_000000_create_groups_table', NULL);
INSERT INTO `f_migrations` VALUES (7, '2015_02_24_000000_create_notifications_table', NULL);
INSERT INTO `f_migrations` VALUES (8, '2015_02_24_000000_create_password_tokens_table', NULL);
INSERT INTO `f_migrations` VALUES (9, '2015_02_24_000000_create_permissions_table', NULL);
INSERT INTO `f_migrations` VALUES (10, '2015_02_24_000000_create_posts_table', NULL);
INSERT INTO `f_migrations` VALUES (11, '2015_02_24_000000_create_users_discussions_table', NULL);
INSERT INTO `f_migrations` VALUES (12, '2015_02_24_000000_create_users_groups_table', NULL);
INSERT INTO `f_migrations` VALUES (13, '2015_02_24_000000_create_users_table', NULL);
INSERT INTO `f_migrations` VALUES (14, '2015_09_15_000000_create_auth_tokens_table', NULL);
INSERT INTO `f_migrations` VALUES (15, '2015_09_20_224327_add_hide_to_discussions', NULL);
INSERT INTO `f_migrations` VALUES (16, '2015_09_22_030432_rename_notification_read_time', NULL);
INSERT INTO `f_migrations` VALUES (17, '2015_10_07_130531_rename_config_to_settings', NULL);
INSERT INTO `f_migrations` VALUES (18, '2015_10_24_194000_add_ip_address_to_posts', NULL);
INSERT INTO `f_migrations` VALUES (19, '2015_12_05_042721_change_access_tokens_columns', NULL);
INSERT INTO `f_migrations` VALUES (20, '2015_12_17_194247_change_settings_value_column_to_text', NULL);
INSERT INTO `f_migrations` VALUES (21, '2016_02_04_095452_add_slug_to_discussions', NULL);
INSERT INTO `f_migrations` VALUES (22, '2017_04_07_114138_add_is_private_to_discussions', NULL);
INSERT INTO `f_migrations` VALUES (23, '2017_04_07_114138_add_is_private_to_posts', NULL);
INSERT INTO `f_migrations` VALUES (24, '2018_01_11_093900_change_access_tokens_columns', NULL);
INSERT INTO `f_migrations` VALUES (25, '2018_01_11_094000_change_access_tokens_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (26, '2018_01_11_095000_change_api_keys_columns', NULL);
INSERT INTO `f_migrations` VALUES (27, '2018_01_11_101800_rename_auth_tokens_to_registration_tokens', NULL);
INSERT INTO `f_migrations` VALUES (28, '2018_01_11_102000_change_registration_tokens_rename_id_to_token', NULL);
INSERT INTO `f_migrations` VALUES (29, '2018_01_11_102100_change_registration_tokens_created_at_to_datetime', NULL);
INSERT INTO `f_migrations` VALUES (30, '2018_01_11_120604_change_posts_table_to_innodb', NULL);
INSERT INTO `f_migrations` VALUES (31, '2018_01_11_155200_change_discussions_rename_columns', NULL);
INSERT INTO `f_migrations` VALUES (32, '2018_01_11_155300_change_discussions_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (33, '2018_01_15_071700_rename_users_discussions_to_discussion_user', NULL);
INSERT INTO `f_migrations` VALUES (34, '2018_01_15_071800_change_discussion_user_rename_columns', NULL);
INSERT INTO `f_migrations` VALUES (35, '2018_01_15_071900_change_discussion_user_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (36, '2018_01_15_072600_change_email_tokens_rename_id_to_token', NULL);
INSERT INTO `f_migrations` VALUES (37, '2018_01_15_072700_change_email_tokens_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (38, '2018_01_15_072800_change_email_tokens_created_at_to_datetime', NULL);
INSERT INTO `f_migrations` VALUES (39, '2018_01_18_130400_rename_permissions_to_group_permission', NULL);
INSERT INTO `f_migrations` VALUES (40, '2018_01_18_130500_change_group_permission_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (41, '2018_01_18_130600_rename_users_groups_to_group_user', NULL);
INSERT INTO `f_migrations` VALUES (42, '2018_01_18_130700_change_group_user_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (43, '2018_01_18_133000_change_notifications_columns', NULL);
INSERT INTO `f_migrations` VALUES (44, '2018_01_18_133100_change_notifications_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (45, '2018_01_18_134400_change_password_tokens_rename_id_to_token', NULL);
INSERT INTO `f_migrations` VALUES (46, '2018_01_18_134500_change_password_tokens_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (47, '2018_01_18_134600_change_password_tokens_created_at_to_datetime', NULL);
INSERT INTO `f_migrations` VALUES (48, '2018_01_18_135000_change_posts_rename_columns', NULL);
INSERT INTO `f_migrations` VALUES (49, '2018_01_18_135100_change_posts_add_foreign_keys', NULL);
INSERT INTO `f_migrations` VALUES (50, '2018_01_30_112238_add_fulltext_index_to_discussions_title', NULL);
INSERT INTO `f_migrations` VALUES (51, '2018_01_30_220100_create_post_user_table', NULL);
INSERT INTO `f_migrations` VALUES (52, '2018_01_30_222900_change_users_rename_columns', NULL);
INSERT INTO `f_migrations` VALUES (55, '2018_09_15_041340_add_users_indicies', NULL);
INSERT INTO `f_migrations` VALUES (56, '2018_09_15_041828_add_discussions_indicies', NULL);
INSERT INTO `f_migrations` VALUES (57, '2018_09_15_043337_add_notifications_indices', NULL);
INSERT INTO `f_migrations` VALUES (58, '2018_09_15_043621_add_posts_indices', NULL);
INSERT INTO `f_migrations` VALUES (59, '2018_09_22_004100_change_registration_tokens_columns', NULL);
INSERT INTO `f_migrations` VALUES (60, '2018_09_22_004200_create_login_providers_table', NULL);
INSERT INTO `f_migrations` VALUES (61, '2018_10_08_144700_add_shim_prefix_to_group_icons', NULL);
INSERT INTO `f_migrations` VALUES (62, '2019_10_12_195349_change_posts_add_discussion_foreign_key', NULL);
INSERT INTO `f_migrations` VALUES (63, '2020_03_19_134512_change_discussions_default_comment_count', NULL);
INSERT INTO `f_migrations` VALUES (64, '2020_04_21_130500_change_permission_groups_add_is_hidden', NULL);
INSERT INTO `f_migrations` VALUES (65, '2021_03_02_040000_change_access_tokens_add_type', NULL);
INSERT INTO `f_migrations` VALUES (66, '2021_03_02_040500_change_access_tokens_add_id', NULL);
INSERT INTO `f_migrations` VALUES (67, '2021_03_02_041000_change_access_tokens_add_title_ip_agent', NULL);
INSERT INTO `f_migrations` VALUES (68, '2021_04_18_040500_change_migrations_add_id_primary_key', NULL);
INSERT INTO `f_migrations` VALUES (69, '2021_04_18_145100_change_posts_content_column_to_mediumtext', NULL);
INSERT INTO `f_migrations` VALUES (70, '2018_07_21_000000_seed_default_groups', NULL);
INSERT INTO `f_migrations` VALUES (71, '2018_07_21_000100_seed_default_group_permissions', NULL);
INSERT INTO `f_migrations` VALUES (72, '2021_05_10_000000_rename_permissions', NULL);
INSERT INTO `f_migrations` VALUES (73, '2022_05_20_000000_add_timestamps_to_groups_table', NULL);
INSERT INTO `f_migrations` VALUES (74, '2022_05_20_000001_add_created_at_to_group_user_table', NULL);
INSERT INTO `f_migrations` VALUES (75, '2022_05_20_000002_add_created_at_to_group_permission_table', NULL);
INSERT INTO `f_migrations` VALUES (76, '2022_07_14_000000_add_type_index_to_posts', NULL);
INSERT INTO `f_migrations` VALUES (77, '2022_07_14_000001_add_type_created_at_composite_index_to_posts', NULL);
INSERT INTO `f_migrations` VALUES (78, '2022_08_06_000000_change_access_tokens_last_activity_at_to_nullable', NULL);
INSERT INTO `f_migrations` VALUES (79, '2015_09_02_000000_add_flags_read_time_to_users_table', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (80, '2015_09_02_000000_create_flags_table', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (81, '2017_07_22_000000_add_default_permissions', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (82, '2018_06_27_101500_change_flags_rename_time_to_created_at', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (83, '2018_06_27_101600_change_flags_add_foreign_keys', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (84, '2018_06_27_105100_change_users_rename_flags_read_time_to_read_flags_at', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (85, '2018_09_15_043621_add_flags_indices', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (86, '2019_10_22_000000_change_reason_text_col_type', 'flarum-flags');
INSERT INTO `f_migrations` VALUES (87, '2015_09_21_011527_add_is_approved_to_discussions', 'flarum-approval');
INSERT INTO `f_migrations` VALUES (88, '2015_09_21_011706_add_is_approved_to_posts', 'flarum-approval');
INSERT INTO `f_migrations` VALUES (89, '2017_07_22_000000_add_default_permissions', 'flarum-approval');
INSERT INTO `f_migrations` VALUES (90, '2015_02_24_000000_create_discussions_tags_table', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (91, '2015_02_24_000000_create_tags_table', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (92, '2015_02_24_000000_create_users_tags_table', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (93, '2015_02_24_000000_set_default_settings', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (94, '2015_10_19_061223_make_slug_unique', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (95, '2017_07_22_000000_add_default_permissions', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (96, '2018_06_27_085200_change_tags_columns', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (97, '2018_06_27_085300_change_tags_add_foreign_keys', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (98, '2018_06_27_090400_rename_users_tags_to_tag_user', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (99, '2018_06_27_100100_change_tag_user_rename_read_time_to_marked_as_read_at', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (100, '2018_06_27_100200_change_tag_user_add_foreign_keys', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (101, '2018_06_27_103000_rename_discussions_tags_to_discussion_tag', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (102, '2018_06_27_103100_add_discussion_tag_foreign_keys', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (103, '2019_04_21_000000_add_icon_to_tags_table', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (104, '2022_05_20_000003_add_timestamps_to_tags_table', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (105, '2022_05_20_000004_add_created_at_to_discussion_tag_table', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (106, '2023_03_01_000000_create_post_mentions_tag_table', 'flarum-tags');
INSERT INTO `f_migrations` VALUES (107, '2015_05_11_000000_add_suspended_until_to_users_table', 'flarum-suspend');
INSERT INTO `f_migrations` VALUES (108, '2015_09_14_000000_rename_suspended_until_column', 'flarum-suspend');
INSERT INTO `f_migrations` VALUES (109, '2017_07_22_000000_add_default_permissions', 'flarum-suspend');
INSERT INTO `f_migrations` VALUES (110, '2018_06_27_111400_change_users_rename_suspend_until_to_suspended_until', 'flarum-suspend');
INSERT INTO `f_migrations` VALUES (111, '2021_10_27_000000_add_suspend_reason_and_message', 'flarum-suspend');
INSERT INTO `f_migrations` VALUES (112, '2015_05_11_000000_add_subscription_to_users_discussions_table', 'flarum-subscriptions');
INSERT INTO `f_migrations` VALUES (113, '2015_02_24_000000_add_sticky_to_discussions', 'flarum-sticky');
INSERT INTO `f_migrations` VALUES (114, '2017_07_22_000000_add_default_permissions', 'flarum-sticky');
INSERT INTO `f_migrations` VALUES (115, '2018_09_15_043621_add_discussions_indices', 'flarum-sticky');
INSERT INTO `f_migrations` VALUES (116, '2021_01_13_000000_add_discussion_last_posted_at_indices', 'flarum-sticky');
INSERT INTO `f_migrations` VALUES (117, '2015_05_11_000000_create_mentions_posts_table', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (118, '2015_05_11_000000_create_mentions_users_table', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (119, '2018_06_27_102000_rename_mentions_posts_to_post_mentions_post', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (120, '2018_06_27_102100_rename_mentions_users_to_post_mentions_user', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (121, '2018_06_27_102200_change_post_mentions_post_rename_mentions_id_to_mentions_post_id', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (122, '2018_06_27_102300_change_post_mentions_post_add_foreign_keys', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (123, '2018_06_27_102400_change_post_mentions_user_rename_mentions_id_to_mentions_user_id', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (124, '2018_06_27_102500_change_post_mentions_user_add_foreign_keys', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (125, '2021_04_19_000000_set_default_settings', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (126, '2022_05_20_000005_add_created_at_to_post_mentions_post_table', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (127, '2022_05_20_000006_add_created_at_to_post_mentions_user_table', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (128, '2022_10_21_000000_create_post_mentions_group_table', 'flarum-mentions');
INSERT INTO `f_migrations` VALUES (129, '2021_03_25_000000_default_settings', 'flarum-markdown');
INSERT INTO `f_migrations` VALUES (130, '2015_02_24_000000_add_locked_to_discussions', 'flarum-lock');
INSERT INTO `f_migrations` VALUES (131, '2017_07_22_000000_add_default_permissions', 'flarum-lock');
INSERT INTO `f_migrations` VALUES (132, '2018_09_15_043621_add_discussions_indices', 'flarum-lock');
INSERT INTO `f_migrations` VALUES (133, '2015_05_11_000000_create_posts_likes_table', 'flarum-likes');
INSERT INTO `f_migrations` VALUES (134, '2015_09_04_000000_add_default_like_permissions', 'flarum-likes');
INSERT INTO `f_migrations` VALUES (135, '2018_06_27_100600_rename_posts_likes_to_post_likes', 'flarum-likes');
INSERT INTO `f_migrations` VALUES (136, '2018_06_27_100700_change_post_likes_add_foreign_keys', 'flarum-likes');
INSERT INTO `f_migrations` VALUES (137, '2021_05_10_094200_add_created_at_to_post_likes_table', 'flarum-likes');
INSERT INTO `f_migrations` VALUES (138, '2018_09_29_060444_replace_emoji_shorcuts_with_unicode', 'flarum-emoji');

-- ----------------------------
-- Table structure for f_notifications
-- ----------------------------
DROP TABLE IF EXISTS `f_notifications`;
CREATE TABLE `f_notifications`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL,
  `from_user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `data` blob NULL,
  `created_at` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `F_notifications_from_user_id_foreign`(`from_user_id`) USING BTREE,
  INDEX `F_notifications_user_id_index`(`user_id`) USING BTREE,
  CONSTRAINT `F_notifications_from_user_id_foreign` FOREIGN KEY (`from_user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `F_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_notifications
-- ----------------------------

-- ----------------------------
-- Table structure for f_password_tokens
-- ----------------------------
DROP TABLE IF EXISTS `f_password_tokens`;
CREATE TABLE `f_password_tokens`  (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`token`) USING BTREE,
  INDEX `F_password_tokens_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `F_password_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_password_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_likes
-- ----------------------------
DROP TABLE IF EXISTS `f_post_likes`;
CREATE TABLE `f_post_likes`  (
  `post_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`, `user_id`) USING BTREE,
  INDEX `f_post_likes_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `f_post_likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_post_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_post_likes
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_mentions_group
-- ----------------------------
DROP TABLE IF EXISTS `f_post_mentions_group`;
CREATE TABLE `f_post_mentions_group`  (
  `post_id` int(10) UNSIGNED NOT NULL,
  `mentions_group_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`, `mentions_group_id`) USING BTREE,
  INDEX `f_post_mentions_group_mentions_group_id_foreign`(`mentions_group_id`) USING BTREE,
  CONSTRAINT `f_post_mentions_group_mentions_group_id_foreign` FOREIGN KEY (`mentions_group_id`) REFERENCES `f_groups` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_post_mentions_group_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_post_mentions_group
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_mentions_post
-- ----------------------------
DROP TABLE IF EXISTS `f_post_mentions_post`;
CREATE TABLE `f_post_mentions_post`  (
  `post_id` int(10) UNSIGNED NOT NULL,
  `mentions_post_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`, `mentions_post_id`) USING BTREE,
  INDEX `f_post_mentions_post_mentions_post_id_foreign`(`mentions_post_id`) USING BTREE,
  CONSTRAINT `f_post_mentions_post_mentions_post_id_foreign` FOREIGN KEY (`mentions_post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_post_mentions_post_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_post_mentions_post
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_mentions_tag
-- ----------------------------
DROP TABLE IF EXISTS `f_post_mentions_tag`;
CREATE TABLE `f_post_mentions_tag`  (
  `post_id` int(10) UNSIGNED NOT NULL,
  `mentions_tag_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`, `mentions_tag_id`) USING BTREE,
  INDEX `f_post_mentions_tag_mentions_tag_id_foreign`(`mentions_tag_id`) USING BTREE,
  CONSTRAINT `f_post_mentions_tag_mentions_tag_id_foreign` FOREIGN KEY (`mentions_tag_id`) REFERENCES `f_tags` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_post_mentions_tag_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_post_mentions_tag
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_mentions_user
-- ----------------------------
DROP TABLE IF EXISTS `f_post_mentions_user`;
CREATE TABLE `f_post_mentions_user`  (
  `post_id` int(10) UNSIGNED NOT NULL,
  `mentions_user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`, `mentions_user_id`) USING BTREE,
  INDEX `f_post_mentions_user_mentions_user_id_foreign`(`mentions_user_id`) USING BTREE,
  CONSTRAINT `f_post_mentions_user_mentions_user_id_foreign` FOREIGN KEY (`mentions_user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_post_mentions_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_post_mentions_user
-- ----------------------------

-- ----------------------------
-- Table structure for f_post_user
-- ----------------------------
DROP TABLE IF EXISTS `f_post_user`;
CREATE TABLE `f_post_user`  (
  `post_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`post_id`, `user_id`) USING BTREE,
  INDEX `F_post_user_user_id_foreign`(`user_id`) USING BTREE,
  CONSTRAINT `F_post_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `f_posts` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `F_post_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_post_user
-- ----------------------------

-- ----------------------------
-- Table structure for f_posts
-- ----------------------------
DROP TABLE IF EXISTS `f_posts`;
CREATE TABLE `f_posts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `discussion_id` int(10) UNSIGNED NOT NULL,
  `number` int(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT ' ',
  `edited_at` datetime NULL DEFAULT NULL,
  `edited_user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `hidden_at` datetime NULL DEFAULT NULL,
  `hidden_user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT 0,
  `is_approved` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `F_posts_discussion_id_number_unique`(`discussion_id`, `number`) USING BTREE,
  INDEX `F_posts_edited_user_id_foreign`(`edited_user_id`) USING BTREE,
  INDEX `F_posts_hidden_user_id_foreign`(`hidden_user_id`) USING BTREE,
  INDEX `F_posts_discussion_id_number_index`(`discussion_id`, `number`) USING BTREE,
  INDEX `F_posts_discussion_id_created_at_index`(`discussion_id`, `created_at`) USING BTREE,
  INDEX `F_posts_user_id_created_at_index`(`user_id`, `created_at`) USING BTREE,
  INDEX `f_posts_type_index`(`type`) USING BTREE,
  INDEX `f_posts_type_created_at_index`(`type`, `created_at`) USING BTREE,
  FULLTEXT INDEX `content`(`content`),
  CONSTRAINT `F_posts_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `f_discussions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `F_posts_edited_user_id_foreign` FOREIGN KEY (`edited_user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `F_posts_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `F_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_posts
-- ----------------------------
INSERT INTO `f_posts` VALUES (1, 1, 1, '2023-10-23 07:39:06', 1, 'comment', '<t><p>你好！</p></t>', NULL, NULL, NULL, NULL, '127.0.0.1', 0, 1);

-- ----------------------------
-- Table structure for f_registration_tokens
-- ----------------------------
DROP TABLE IF EXISTS `f_registration_tokens`;
CREATE TABLE `f_registration_tokens`  (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_attributes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`token`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_registration_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for f_settings
-- ----------------------------
DROP TABLE IF EXISTS `f_settings`;
CREATE TABLE `f_settings`  (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_settings
-- ----------------------------
INSERT INTO `f_settings` VALUES ('allow_hide_own_posts', 'reply');
INSERT INTO `f_settings` VALUES ('allow_post_editing', 'reply');
INSERT INTO `f_settings` VALUES ('allow_renaming', '10');
INSERT INTO `f_settings` VALUES ('allow_sign_up', '1');
INSERT INTO `f_settings` VALUES ('custom_less', '');
INSERT INTO `f_settings` VALUES ('default_locale', 'en');
INSERT INTO `f_settings` VALUES ('default_route', '/all');
INSERT INTO `f_settings` VALUES ('display_name_driver', 'username');
INSERT INTO `f_settings` VALUES ('extensions_enabled', '[\"flarum-flags\",\"flarum-approval\",\"flarum-tags\",\"flarum-suspend\",\"flarum-subscriptions\",\"flarum-sticky\",\"flarum-statistics\",\"flarum-mentions\",\"flarum-markdown\",\"flarum-lock\",\"flarum-likes\",\"flarum-lang-chinese-simplified\",\"flarum-emoji\",\"flarum-bbcode\"]');
INSERT INTO `f_settings` VALUES ('flarum-markdown.mdarea', '1');
INSERT INTO `f_settings` VALUES ('flarum-mentions.allow_username_format', '1');
INSERT INTO `f_settings` VALUES ('flarum-tags.max_primary_tags', '1');
INSERT INTO `f_settings` VALUES ('flarum-tags.max_secondary_tags', '3');
INSERT INTO `f_settings` VALUES ('flarum-tags.min_primary_tags', '1');
INSERT INTO `f_settings` VALUES ('flarum-tags.min_secondary_tags', '0');
INSERT INTO `f_settings` VALUES ('forum_description', '');
INSERT INTO `f_settings` VALUES ('forum_title', '酆');
INSERT INTO `f_settings` VALUES ('mail_driver', 'mail');
INSERT INTO `f_settings` VALUES ('mail_from', 'noreply@test.com');
INSERT INTO `f_settings` VALUES ('slug_driver_Flarum\\User\\User', 'default');
INSERT INTO `f_settings` VALUES ('theme_colored_header', '0');
INSERT INTO `f_settings` VALUES ('theme_dark_mode', '0');
INSERT INTO `f_settings` VALUES ('theme_primary_color', '#4D698E');
INSERT INTO `f_settings` VALUES ('theme_secondary_color', '#4D698E');
INSERT INTO `f_settings` VALUES ('version', '1.8.3');
INSERT INTO `f_settings` VALUES ('welcome_message', 'Enjoy your new forum! Hop over to discuss.flarum.org if you have any questions, or to join our community!');
INSERT INTO `f_settings` VALUES ('welcome_title', 'Welcome to 酆');

-- ----------------------------
-- Table structure for f_tag_user
-- ----------------------------
DROP TABLE IF EXISTS `f_tag_user`;
CREATE TABLE `f_tag_user`  (
  `user_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `marked_as_read_at` datetime NULL DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`, `tag_id`) USING BTREE,
  INDEX `f_tag_user_tag_id_foreign`(`tag_id`) USING BTREE,
  CONSTRAINT `f_tag_user_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `f_tags` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `f_tag_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `f_users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_tag_user
-- ----------------------------

-- ----------------------------
-- Table structure for f_tags
-- ----------------------------
DROP TABLE IF EXISTS `f_tags`;
CREATE TABLE `f_tags`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `background_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `background_mode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `position` int(11) NULL DEFAULT NULL,
  `parent_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `default_sort` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT 0,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0,
  `discussion_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `last_posted_at` datetime NULL DEFAULT NULL,
  `last_posted_discussion_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `last_posted_user_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `f_tags_slug_unique`(`slug`) USING BTREE,
  INDEX `f_tags_parent_id_foreign`(`parent_id`) USING BTREE,
  INDEX `f_tags_last_posted_user_id_foreign`(`last_posted_user_id`) USING BTREE,
  INDEX `f_tags_last_posted_discussion_id_foreign`(`last_posted_discussion_id`) USING BTREE,
  CONSTRAINT `f_tags_last_posted_discussion_id_foreign` FOREIGN KEY (`last_posted_discussion_id`) REFERENCES `f_discussions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `f_tags_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `f_users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `f_tags_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `f_tags` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_tags
-- ----------------------------
INSERT INTO `f_tags` VALUES (1, 'General', 'general', NULL, '#888', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for f_users
-- ----------------------------
DROP TABLE IF EXISTS `f_users`;
CREATE TABLE `f_users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_email_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `preferences` blob NULL,
  `joined_at` datetime NULL DEFAULT NULL,
  `last_seen_at` datetime NULL DEFAULT NULL,
  `marked_all_as_read_at` datetime NULL DEFAULT NULL,
  `read_notifications_at` datetime NULL DEFAULT NULL,
  `discussion_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `read_flags_at` datetime NULL DEFAULT NULL,
  `suspended_until` datetime NULL DEFAULT NULL,
  `suspend_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `suspend_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `F_users_username_unique`(`username`) USING BTREE,
  UNIQUE INDEX `F_users_email_unique`(`email`) USING BTREE,
  INDEX `F_users_joined_at_index`(`joined_at`) USING BTREE,
  INDEX `F_users_last_seen_at_index`(`last_seen_at`) USING BTREE,
  INDEX `F_users_discussion_count_index`(`discussion_count`) USING BTREE,
  INDEX `F_users_comment_count_index`(`comment_count`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_users
-- ----------------------------
INSERT INTO `f_users` VALUES (1, 'admin', '3290745769@qq.com', 1, '$2y$10$J83fEdTWKl3LVJbdhiUYb.Gu.H.8eSiz.vgp606MIYzKK39ZyeJOa', 'ZtT8eWJf9iYiSYzH.png', 0x7B22666F6C6C6F7741667465725265706C79223A66616C73652C22666C6172756D2D737562736372697074696F6E732E6E6F746966795F666F725F616C6C5F706F737473223A66616C73652C226E6F746966795F64697363757373696F6E52656E616D65645F616C657274223A747275652C226E6F746966795F7573657253757370656E6465645F616C657274223A747275652C226E6F746966795F7573657253757370656E6465645F656D61696C223A747275652C226E6F746966795F75736572556E73757370656E6465645F616C657274223A747275652C226E6F746966795F75736572556E73757370656E6465645F656D61696C223A747275652C226E6F746966795F6E6577506F73745F616C657274223A747275652C226E6F746966795F6E6577506F73745F656D61696C223A747275652C226E6F746966795F706F73744D656E74696F6E65645F616C657274223A747275652C226E6F746966795F706F73744D656E74696F6E65645F656D61696C223A66616C73652C226E6F746966795F757365724D656E74696F6E65645F616C657274223A747275652C226E6F746966795F757365724D656E74696F6E65645F656D61696C223A66616C73652C226E6F746966795F67726F75704D656E74696F6E65645F616C657274223A747275652C226E6F746966795F67726F75704D656E74696F6E65645F656D61696C223A66616C73652C226E6F746966795F64697363757373696F6E4C6F636B65645F616C657274223A747275652C226E6F746966795F706F73744C696B65645F616C657274223A747275652C22646973636C6F73654F6E6C696E65223A747275652C22696E64657850726F66696C65223A747275652C226C6F63616C65223A227A682D48616E73227D, '2023-10-23 07:35:08', '2023-10-23 07:46:49', NULL, NULL, 1, 1, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
