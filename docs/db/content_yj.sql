/*
Navicat MySQL Data Transfer

Source Server         : 39.104.66.23md
Source Server Version : 50721
Source Host           : 39.104.66.23:3306
Source Database       : content_yj

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001

Date: 2018-02-01 16:35:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cms_ad
-- ----------------------------
DROP TABLE IF EXISTS `cms_ad`;
CREATE TABLE `cms_ad` (
  `f_ad_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_adslot_id` int(11) NOT NULL,
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_begin_date` datetime DEFAULT NULL COMMENT '开始时间',
  `f_end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `f_url` varchar(255) DEFAULT NULL COMMENT '广告url',
  `f_text` varchar(255) DEFAULT NULL COMMENT '文字',
  `f_script` mediumtext COMMENT '代码',
  `f_image` varchar(255) DEFAULT NULL COMMENT '图片',
  `f_flash` varchar(255) DEFAULT NULL COMMENT 'flash',
  `f_seq` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  PRIMARY KEY (`f_ad_id`),
  KEY `fk_cms_ad_adslot` (`f_adslot_id`) USING BTREE,
  KEY `fk_cms_ad_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_ad_adslot` FOREIGN KEY (`f_adslot_id`) REFERENCES `cms_ad_slot` (`f_adslot_id`),
  CONSTRAINT `fk_cms_ad_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_ad
-- ----------------------------
INSERT INTO `cms_ad` VALUES ('2', '1', '1', 'jspxcms演示广告', null, null, 'http://www.jspxcms.com/', 'jspxcms演示广告', null, '/template/1/default/_files/img/dd.jpg', null, '50');

-- ----------------------------
-- Table structure for cms_ad_slot
-- ----------------------------
DROP TABLE IF EXISTS `cms_ad_slot`;
CREATE TABLE `cms_ad_slot` (
  `f_adslot_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_number` varchar(100) DEFAULT NULL COMMENT '编码',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_type` int(11) NOT NULL COMMENT '类型(1:文字,2:图片,3:FLASH,4:代码)',
  `f_template` varchar(255) NOT NULL COMMENT '模板',
  `f_width` int(11) NOT NULL COMMENT '宽度',
  `f_height` int(11) NOT NULL COMMENT '高度',
  PRIMARY KEY (`f_adslot_id`),
  KEY `fk_cms_adslot_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_adslot_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_ad_slot
-- ----------------------------
INSERT INTO `cms_ad_slot` VALUES ('1', '1', '首页广告', 'homepage', null, '2', '/sys_ad/ad_homepage.html', '1000', '80');

-- ----------------------------
-- Table structure for cms_attachment
-- ----------------------------
DROP TABLE IF EXISTS `cms_attachment`;
CREATE TABLE `cms_attachment` (
  `f_attachment_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_user_id` int(11) NOT NULL COMMENT '上传人',
  `f_name` varchar(150) NOT NULL COMMENT '文件名',
  `f_length` bigint(20) DEFAULT NULL COMMENT '文件长度',
  `f_ip` varchar(100) DEFAULT NULL COMMENT 'IP',
  `f_time` datetime NOT NULL COMMENT '时间',
  PRIMARY KEY (`f_attachment_id`),
  KEY `fk_cms_attachement_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_attachment_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_attachement_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_attachment_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for cms_attachment_ref
-- ----------------------------
DROP TABLE IF EXISTS `cms_attachment_ref`;
CREATE TABLE `cms_attachment_ref` (
  `f_attachementref_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_attachment_id` int(11) NOT NULL,
  `f_ftype` varchar(100) NOT NULL COMMENT '外表标识',
  `f_fid` int(11) NOT NULL COMMENT '外表ID',
  PRIMARY KEY (`f_attachementref_id`),
  KEY `fk_cms_attachmentref_attach` (`f_attachment_id`) USING BTREE,
  KEY `fk_cms_attachmentref_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_attachmentref_attach` FOREIGN KEY (`f_attachment_id`) REFERENCES `cms_attachment` (`f_attachment_id`),
  CONSTRAINT `fk_cms_attachmentref_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_attachment_ref
-- ----------------------------

-- ----------------------------
-- Table structure for cms_attribute
-- ----------------------------
DROP TABLE IF EXISTS `cms_attribute`;
CREATE TABLE `cms_attribute` (
  `f_attribute_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_number` varchar(20) NOT NULL COMMENT '代码',
  `f_name` varchar(50) NOT NULL COMMENT '名称',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_is_with_image` char(1) NOT NULL DEFAULT '0' COMMENT '是否包含图片',
  `f_is_scale` char(1) NOT NULL DEFAULT '0' COMMENT '是否图片压缩',
  `f_is_exact` char(1) NOT NULL DEFAULT '0' COMMENT '是否图片拉伸',
  `f_is_watermark` char(1) NOT NULL DEFAULT '0' COMMENT '是否图片水印',
  `f_image_width` int(11) DEFAULT NULL COMMENT '图片宽度',
  `f_image_height` int(11) DEFAULT NULL COMMENT '图片高度',
  PRIMARY KEY (`f_attribute_id`),
  KEY `fk_cms_attribute_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_attribute_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_attribute
-- ----------------------------
INSERT INTO `cms_attribute` VALUES ('2', '1', 'headlines', '头条', '6', '0', '0', '0', '0', null, null);
INSERT INTO `cms_attribute` VALUES ('5', '1', 'focusnews', '新闻焦点', '1', '1', '0', '0', '0', '660', '250');
INSERT INTO `cms_attribute` VALUES ('6', '1', 'focusphoto', '图片焦点', '2', '1', '0', '0', '0', '1000', '500');
INSERT INTO `cms_attribute` VALUES ('7', '1', 'focusvideo', '视频焦点', '3', '1', '0', '0', '0', '1000', '410');
INSERT INTO `cms_attribute` VALUES ('8', '1', 'focusproduct', '产品焦点', '4', '1', '0', '0', '0', '770', '190');
INSERT INTO `cms_attribute` VALUES ('9', '1', 'focusdownload', '下载焦点', '5', '1', '0', '0', '0', '310', '210');
INSERT INTO `cms_attribute` VALUES ('10', '1', 'focusmobile', '手机焦点', '7', '1', '0', '0', '0', '640', '330');
INSERT INTO `cms_attribute` VALUES ('12', '1', 'focus', '焦点', '0', '1', '0', '0', '0', '318', '212');

-- ----------------------------
-- Table structure for cms_collect
-- ----------------------------
DROP TABLE IF EXISTS `cms_collect`;
CREATE TABLE `cms_collect` (
  `f_collect_id` int(11) NOT NULL,
  `f_node_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_charset` varchar(100) NOT NULL DEFAULT 'UTF-8' COMMENT '字符集',
  `f_user_agent` varchar(255) NOT NULL DEFAULT 'Mozilla/5.0' COMMENT '用户代理',
  `f_interval_min` int(11) NOT NULL DEFAULT '0' COMMENT '最小间隔时间',
  `f_interval_max` int(11) NOT NULL DEFAULT '0' COMMENT '最大间隔时间',
  `f_list_pattern` varchar(2000) NOT NULL COMMENT '列表地址',
  `f_list_next_pattern` varchar(255) DEFAULT NULL COMMENT '下一页列表地址',
  `f_is_list_next_reg` char(1) NOT NULL DEFAULT '0' COMMENT '下一页列表地址是否正则',
  `f_item_area_pattern` varchar(255) DEFAULT NULL COMMENT '文章地址区域',
  `f_is_item_area_reg` char(1) NOT NULL DEFAULT '0' COMMENT '文章地址区域是否正则',
  `f_item_pattern` varchar(255) NOT NULL COMMENT '文章地址',
  `f_is_item_reg` char(1) NOT NULL DEFAULT '0' COMMENT '文章地址是否正则',
  `f_block_area_pattern` varchar(255) DEFAULT NULL COMMENT '文章块区域',
  `f_is_block_area_reg` char(1) NOT NULL DEFAULT '0' COMMENT '文章快区域是否正则',
  `f_block_pattern` varchar(255) DEFAULT NULL COMMENT '文章块',
  `f_is_block_reg` char(1) NOT NULL DEFAULT '0' COMMENT '文章块是否正则',
  `f_page_begin` int(11) NOT NULL DEFAULT '2' COMMENT '起始序号',
  `f_page_end` int(11) NOT NULL DEFAULT '10' COMMENT '结束序号',
  `f_is_desc` char(1) NOT NULL DEFAULT '1' COMMENT '是否倒序',
  `f_is_submit` char(1) NOT NULL DEFAULT '0' COMMENT '是否提交',
  `f_is_allow_duplicate` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许重复标题',
  `f_is_download_image` char(1) NOT NULL DEFAULT '1' COMMENT '是否采集正文中的图片',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:就绪,1:运行中,2:暂停)',
  PRIMARY KEY (`f_collect_id`),
  KEY `fk_cms_collect_node` (`f_node_id`) USING BTREE,
  KEY `fk_cms_collect_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_collect_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_collect_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_collect_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_collect_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_collect
-- ----------------------------
INSERT INTO `cms_collect` VALUES ('1', '42', '1', '1', '新浪新闻', 'UTF-8', 'Mozilla/5.0', '0', '0', 'http://roll.news.sina.com.cn/news/gnxw/gdxw1/index.shtml\r\nhttp://roll.news.sina.com.cn/news/gnxw/gdxw1/index_(*).shtml', null, '0', '<ul class=\"tl_shadow\">(*)</ul>', '0', '<li><a href=\"(*)\" target=\"_blank\">', '0', null, '0', null, '0', '2', '10', '1', '0', '0', '1', '1');

-- ----------------------------
-- Table structure for cms_collect_field
-- ----------------------------
DROP TABLE IF EXISTS `cms_collect_field`;
CREATE TABLE `cms_collect_field` (
  `f_collectfield_id` int(11) NOT NULL,
  `f_collect_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_code` varchar(100) NOT NULL COMMENT '代码',
  `f_type` int(11) NOT NULL DEFAULT '1' COMMENT '类型(1;系统字段,2:custom字段,3:clob字段)',
  `f_source_type` int(11) NOT NULL DEFAULT '1' COMMENT '来源(1:详细页,2:列表页,3:固定值,4:URL)',
  `f_source_url` varchar(255) DEFAULT NULL COMMENT '来源URL',
  `f_source_text` varchar(255) DEFAULT NULL COMMENT '来源文本',
  `f_data_area_pattern` varchar(255) DEFAULT NULL COMMENT '数据区域',
  `f_is_data_area_reg` char(1) NOT NULL DEFAULT '0' COMMENT '数据区域是否正则',
  `f_data_pattern` varchar(255) DEFAULT NULL COMMENT '匹配规则',
  `f_is_data_reg` char(1) NOT NULL DEFAULT '0' COMMENT '匹配规则是否正则',
  `f_date_format` varchar(255) DEFAULT NULL COMMENT '日期格式',
  `f_download_type` varchar(20) DEFAULT NULL COMMENT '下载类型(为空不下载)',
  `f_image_param` varchar(255) DEFAULT NULL COMMENT '图片参数',
  `f_filter` varchar(2000) DEFAULT NULL COMMENT '过滤规则',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排列顺序',
  PRIMARY KEY (`f_collectfield_id`),
  KEY `fk_cms_collectfield_collect` (`f_collect_id`) USING BTREE,
  KEY `fk_cms_collectfield_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_collectfield_collect` FOREIGN KEY (`f_collect_id`) REFERENCES `cms_collect` (`f_collect_id`),
  CONSTRAINT `fk_cms_collectfield_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_collect_field
-- ----------------------------
INSERT INTO `cms_collect_field` VALUES ('2', '1', '1', '标题', 'title', '1', '1', null, null, null, '0', '<meta property=\"og:title\" content=\"(*)\" />', '0', null, null, null, null, '2147483647');
INSERT INTO `cms_collect_field` VALUES ('3', '1', '1', '正文', 'text', '1', '1', null, null, null, '0', '<div class=\"article article_16\" id=\"artibody\">\r\n(*)\r\n			\r\n        </div>', '0', null, null, null, null, '2147483647');
INSERT INTO `cms_collect_field` VALUES ('4', '1', '1', '发布时间', 'publishDate', '1', '1', null, null, null, '0', '<span class=\"time-source\" id=\"navtimeSource\">(*)		<span>', '0', 'yyyy年MM月dd日HH:mm', null, null, null, '2147483647');

-- ----------------------------
-- Table structure for cms_collect_log
-- ----------------------------
DROP TABLE IF EXISTS `cms_collect_log`;
CREATE TABLE `cms_collect_log` (
  `f_collectlog_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_url` varchar(255) NOT NULL COMMENT '采集地址',
  `f_title` varchar(255) DEFAULT NULL COMMENT '标题',
  `f_message` varchar(255) DEFAULT NULL COMMENT '消息',
  `f_time` datetime NOT NULL COMMENT '时间',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:成功,1:失败)',
  PRIMARY KEY (`f_collectlog_id`),
  KEY `fk_cms_collectlog_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_collectlog_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_collect_log
-- ----------------------------

-- ----------------------------
-- Table structure for cms_comment
-- ----------------------------
DROP TABLE IF EXISTS `cms_comment`;
CREATE TABLE `cms_comment` (
  `f_comment_id` int(11) NOT NULL,
  `f_parent_id` int(11) DEFAULT NULL COMMENT '父评论ID',
  `f_site_id` int(11) NOT NULL COMMENT '站点ID',
  `f_creator_id` int(11) NOT NULL COMMENT '创建人',
  `f_auditor_id` int(11) DEFAULT NULL COMMENT '审核人',
  `f_ftype` varchar(50) NOT NULL COMMENT '外表标识',
  `f_fid` int(11) NOT NULL COMMENT '外表ID',
  `f_creation_date` datetime NOT NULL COMMENT '评论时间',
  `f_audit_date` datetime DEFAULT NULL COMMENT '审核时间',
  `f_ip` varchar(100) NOT NULL DEFAULT 'localhost' COMMENT 'IP地址',
  `f_country` varchar(100) DEFAULT NULL COMMENT '国家',
  `f_area` varchar(100) DEFAULT NULL COMMENT '地区',
  `f_score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '0:未审核;1:已审核;2:推荐;3:屏蔽',
  `f_text` mediumtext,
  PRIMARY KEY (`f_comment_id`),
  KEY `fk_cms_comment_auditor` (`f_auditor_id`) USING BTREE,
  KEY `fk_cms_comment_creator` (`f_creator_id`) USING BTREE,
  KEY `fk_cms_comment_parent` (`f_parent_id`) USING BTREE,
  KEY `fk_cms_comment_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_comment_auditor` FOREIGN KEY (`f_auditor_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_comment_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_comment_parent` FOREIGN KEY (`f_parent_id`) REFERENCES `cms_comment` (`f_comment_id`),
  CONSTRAINT `fk_cms_comment_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_comment
-- ----------------------------
INSERT INTO `cms_comment` VALUES ('16', null, '1', '1', null, 'Info', '28', '2014-02-22 12:40:48', null, '0:0:0:0:0:0:0:1', null, null, '0', '1', '很好看。我很喜欢。');
INSERT INTO `cms_comment` VALUES ('17', null, '1', '1', null, 'Info', '35', '2014-04-04 20:35:51', null, '0:0:0:0:0:0:0:1', null, null, '0', '1', '现在除了情人节、七夕节等传统的结婚登记吉日，5.20、9.9等谐音吉日也越来越受到年轻人的追捧。');
INSERT INTO `cms_comment` VALUES ('18', null, '1', '0', null, 'Info', '100', '2014-04-04 20:36:28', null, '0:0:0:0:0:0:0:1', null, null, '0', '1', '西班牙正考虑将直布罗陀争议诉至联合国与海牙国际法庭等国际机构，并考虑与阿根廷结成统一阵线');
INSERT INTO `cms_comment` VALUES ('19', null, '1', '0', null, 'Info', '73', '2014-04-04 20:40:51', null, '0:0:0:0:0:0:0:1', null, null, '0', '1', '生活中不仅有幸福和快乐，更有悲伤和无奈，都要笑纳，因为它们都是生活的组成部分。');
INSERT INTO `cms_comment` VALUES ('20', null, '1', '0', null, 'Info', '26', '2014-04-04 20:41:28', null, '0:0:0:0:0:0:0:1', null, null, '0', '1', '请市民减少出行，注意交通安全，山区防山洪、滑坡、泥石流地质灾害');

-- ----------------------------
-- Table structure for cms_favorite
-- ----------------------------
DROP TABLE IF EXISTS `cms_favorite`;
CREATE TABLE `cms_favorite` (
  `favorite_id_` int(11) NOT NULL,
  `user_id_` int(11) NOT NULL COMMENT '收藏用户',
  `dtype_` varchar(50) NOT NULL COMMENT '收藏数据类型',
  `did_` int(11) NOT NULL COMMENT '收藏数据ID',
  `created_` datetime NOT NULL COMMENT '收藏时间',
  PRIMARY KEY (`favorite_id_`),
  KEY `fk_reference_148` (`user_id_`) USING BTREE,
  CONSTRAINT `fk_reference_148` FOREIGN KEY (`user_id_`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for cms_friendlink
-- ----------------------------
DROP TABLE IF EXISTS `cms_friendlink`;
CREATE TABLE `cms_friendlink` (
  `f_friendlink_id` int(11) NOT NULL,
  `f_friendlinktype_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '网站名称',
  `f_url` varchar(255) NOT NULL COMMENT '网站地址',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_logo` varchar(255) DEFAULT NULL COMMENT '网站Logo',
  `f_description` varchar(255) DEFAULT NULL COMMENT '网站描述',
  `f_email` varchar(100) DEFAULT NULL COMMENT '站长Email',
  `f_is_with_logo` char(1) NOT NULL DEFAULT '0' COMMENT '是否带Logo',
  `f_is_recommend` char(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:已审核,1:未审核)',
  PRIMARY KEY (`f_friendlink_id`),
  KEY `fk_cms_friendlink_fltype` (`f_friendlinktype_id`) USING BTREE,
  KEY `fk_cms_friendlink_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_friendlink_fltype` FOREIGN KEY (`f_friendlinktype_id`) REFERENCES `cms_friendlink_type` (`f_friendlinktype_id`),
  CONSTRAINT `fk_cms_friendlink_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_friendlink
-- ----------------------------
INSERT INTO `cms_friendlink` VALUES ('7', '1', '1', 'JSPXCMS官方', 'http://www.jspxcms.com/', '2147483647', null, null, null, '0', '0', '0');
INSERT INTO `cms_friendlink` VALUES ('8', '3', '1', 'JAVA', 'http://www.java.com/', '2147483647', null, null, null, '0', '0', '0');
INSERT INTO `cms_friendlink` VALUES ('9', '3', '1', 'TOMCAT', 'http://tomcat.apache.org/', '2147483647', null, null, null, '0', '0', '0');

-- ----------------------------
-- Table structure for cms_friendlink_type
-- ----------------------------
DROP TABLE IF EXISTS `cms_friendlink_type`;
CREATE TABLE `cms_friendlink_type` (
  `f_friendlinktype_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_number` varchar(100) DEFAULT NULL COMMENT '编码',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_friendlinktype_id`),
  KEY `fk_cms_friendlinktype_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_friendlinktype_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_friendlink_type
-- ----------------------------
INSERT INTO `cms_friendlink_type` VALUES ('1', '1', '综合类', 'zonghe', '0');
INSERT INTO `cms_friendlink_type` VALUES ('3', '1', '技术类', 'yule', '1');

-- ----------------------------
-- Table structure for cms_global
-- ----------------------------
DROP TABLE IF EXISTS `cms_global`;
CREATE TABLE `cms_global` (
  `f_global_id` int(11) NOT NULL,
  `f_protocol` varchar(50) NOT NULL DEFAULT 'http' COMMENT '协议',
  `f_port` int(11) DEFAULT NULL COMMENT '服务端口号',
  `f_context_path` varchar(255) DEFAULT NULL COMMENT '上下文路径',
  `f_uploads_publishpoint_id` int(11) DEFAULT NULL COMMENT '附件发布点',
  `f_captcha_errors` int(11) NOT NULL DEFAULT '3' COMMENT '需要验证码的错误次数(总是需要则为0)',
  `f_version` varchar(50) NOT NULL COMMENT 'jspxcms版本号',
  PRIMARY KEY (`f_global_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_global
-- ----------------------------
INSERT INTO `cms_global` VALUES ('1', 'http', '8080', null, '1', '3', '8.0.0');

-- ----------------------------
-- Table structure for cms_global_clob
-- ----------------------------
DROP TABLE IF EXISTS `cms_global_clob`;
CREATE TABLE `cms_global_clob` (
  `f_global_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` mediumtext COMMENT '值',
  KEY `fk_cms_globalclob_global` (`f_global_id`) USING BTREE,
  CONSTRAINT `fk_cms_globalclob_global` FOREIGN KEY (`f_global_id`) REFERENCES `cms_global` (`f_global_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_global_clob
-- ----------------------------

-- ----------------------------
-- Table structure for cms_global_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_global_custom`;
CREATE TABLE `cms_global_custom` (
  `f_global_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_globalcustom_global` (`f_global_id`) USING BTREE,
  CONSTRAINT `fk_cms_globalcustom_global` FOREIGN KEY (`f_global_id`) REFERENCES `cms_global` (`f_global_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_global_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `cms_guestbook`;
CREATE TABLE `cms_guestbook` (
  `f_guestbook_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_guestbooktype_id` int(11) NOT NULL COMMENT '留言类型',
  `f_creator_id` int(11) NOT NULL COMMENT '创建者',
  `f_replyer_id` int(11) DEFAULT NULL COMMENT '回复者',
  `f_title` varchar(150) DEFAULT NULL COMMENT '留言标题',
  `f_text` mediumtext COMMENT '留言内容',
  `f_creation_date` datetime NOT NULL COMMENT '留言日期',
  `f_creation_ip` varchar(100) NOT NULL COMMENT '留言IP',
  `f_creation_country` varchar(100) DEFAULT NULL COMMENT '留言国家',
  `f_creation_area` varchar(100) DEFAULT NULL COMMENT '留言地区',
  `f_reply_text` mediumtext COMMENT '回复内容',
  `f_reply_date` datetime DEFAULT NULL COMMENT '回复日期',
  `f_reply_ip` varchar(100) DEFAULT NULL COMMENT '回复IP',
  `f_reply_country` varchar(100) DEFAULT NULL COMMENT '回复国家',
  `f_reply_area` varchar(100) DEFAULT NULL COMMENT '回复地区',
  `f_is_reply` char(1) NOT NULL DEFAULT '0' COMMENT '是否回复',
  `f_is_recommend` char(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:已审核,1:未审核,2:屏蔽)',
  `f_username` varchar(100) DEFAULT NULL COMMENT '用户名',
  `f_gender` char(1) DEFAULT NULL COMMENT '性别',
  `f_phone` varchar(100) DEFAULT NULL COMMENT '电话',
  `f_mobile` varchar(100) DEFAULT NULL COMMENT '手机',
  `f_qq` varchar(100) DEFAULT NULL COMMENT 'QQ号码',
  `f_email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  PRIMARY KEY (`f_guestbook_id`),
  KEY `fk_cms_guestbook_creator` (`f_creator_id`) USING BTREE,
  KEY `fk_cms_guestbook_guestbooktype` (`f_guestbooktype_id`) USING BTREE,
  KEY `fk_cms_guestbook_replyer` (`f_replyer_id`) USING BTREE,
  KEY `fk_cms_guestbook_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_guestbook_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_guestbook_guestbooktype` FOREIGN KEY (`f_guestbooktype_id`) REFERENCES `cms_guestbook_type` (`f_guestbooktype_id`),
  CONSTRAINT `fk_cms_guestbook_replyer` FOREIGN KEY (`f_replyer_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_guestbook_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_guestbook
-- ----------------------------
INSERT INTO `cms_guestbook` VALUES ('23', '1', '1', '1', '1', 'jspxcms升级了', '终于等到jspxcms升级了，期待很久了。\r\n呵呵！', '2013-08-12 08:54:43', '0:0:0:0:0:0:0:1', null, null, '非常感谢大家长久以来的支持！', '2013-08-12 08:56:00', '0:0:0:0:0:0:0:1', null, null, '1', '0', '0', null, '1', null, null, null, null);
INSERT INTO `cms_guestbook` VALUES ('28', '1', '8', '1', null, '功能有改进', '留言功能更好用了！', '2014-03-18 13:56:44', '0:0:0:0:0:0:0:1', null, null, null, null, null, null, null, '0', '0', '0', null, '1', null, null, null, null);

-- ----------------------------
-- Table structure for cms_guestbook_type
-- ----------------------------
DROP TABLE IF EXISTS `cms_guestbook_type`;
CREATE TABLE `cms_guestbook_type` (
  `f_guestbooktype_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_number` varchar(100) DEFAULT NULL COMMENT '编码',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`f_guestbooktype_id`),
  KEY `fk_cms_guestbooktype_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_guestbooktype_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_guestbook_type
-- ----------------------------
INSERT INTO `cms_guestbook_type` VALUES ('1', '1', '咨询', 'zixun', '1', '咨询');
INSERT INTO `cms_guestbook_type` VALUES ('4', '1', '投诉', 'tousu', '2', '投诉');
INSERT INTO `cms_guestbook_type` VALUES ('5', '1', '建议', 'jianyi', '3', '建议');
INSERT INTO `cms_guestbook_type` VALUES ('6', '1', '反馈', 'fankui', '4', '反馈');
INSERT INTO `cms_guestbook_type` VALUES ('7', '1', '其他', 'qita', '5', '其他');
INSERT INTO `cms_guestbook_type` VALUES ('8', '1', '普通', 'putong', '0', null);

-- ----------------------------
-- Table structure for cms_info
-- ----------------------------
DROP TABLE IF EXISTS `cms_info`;
CREATE TABLE `cms_info` (
  `f_info_id` int(11) NOT NULL,
  `f_org_id` int(11) NOT NULL COMMENT '组织',
  `f_creator_id` int(11) NOT NULL COMMENT '创建者',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_node_id` int(11) NOT NULL COMMENT '栏目',
  `f_publish_date` datetime NOT NULL COMMENT '发布日期',
  `f_off_date` datetime DEFAULT NULL COMMENT '关闭日期',
  `f_priority` tinyint(4) NOT NULL DEFAULT '0' COMMENT '优先级',
  `f_is_with_image` char(1) NOT NULL DEFAULT '0' COMMENT '是否包含图片',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_downloads` int(11) NOT NULL DEFAULT '0' COMMENT '下载总数',
  `f_comments` int(11) NOT NULL DEFAULT '0' COMMENT '评论总数',
  `f_diggs` int(11) NOT NULL DEFAULT '0' COMMENT '顶',
  `f_score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  `f_favorites` int(11) NOT NULL DEFAULT '0' COMMENT '收藏次数',
  `f_status` char(1) NOT NULL DEFAULT 'A' COMMENT '状态(0:发起者,1-9:审核中,A:已发布,B:草稿,C:投稿,D:退稿,E:采集,F:待发布,G:已过期,X:回收站,Z:归档)',
  `f_p0` tinyint(4) DEFAULT NULL COMMENT '自定义0',
  `f_p1` tinyint(4) DEFAULT NULL COMMENT '自定义1',
  `f_p2` tinyint(4) DEFAULT NULL COMMENT '自定义2',
  `f_p3` tinyint(4) DEFAULT NULL COMMENT '自定义3',
  `f_p4` tinyint(4) DEFAULT NULL COMMENT '自定义4',
  `f_p5` tinyint(4) DEFAULT NULL COMMENT '自定义5',
  `f_p6` tinyint(4) DEFAULT NULL COMMENT '自定义6',
  `f_html_status` char(1) NOT NULL DEFAULT '0' COMMENT 'HTML状态(0:未开启,1:待生成,2:待更新,3:已生成)',
  PRIMARY KEY (`f_info_id`),
  KEY `fk_cms_info_node` (`f_node_id`) USING BTREE,
  KEY `fk_cms_info_org` (`f_org_id`) USING BTREE,
  KEY `fk_cms_info_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_info_user_creator` (`f_creator_id`) USING BTREE,
  CONSTRAINT `fk_cms_info_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_info_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`),
  CONSTRAINT `fk_cms_info_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_info_user_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info
-- ----------------------------
INSERT INTO `cms_info` VALUES ('24', '1', '1', '1', '42', '2013-03-18 01:40:28', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('25', '1', '1', '1', '42', '2013-03-18 01:43:00', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('26', '1', '1', '1', '40', '2013-08-05 17:31:32', null, '0', '0', '0', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('27', '1', '1', '1', '42', '2013-03-18 01:46:31', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('28', '1', '1', '1', '42', '2013-08-05 17:31:36', null, '0', '0', '50', '0', '1', '2', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('30', '1', '1', '1', '44', '2013-08-05 17:31:32', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('32', '1', '1', '1', '44', '2014-03-06 07:31:32', null, '0', '1', '60', '0', '0', '1', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('33', '1', '1', '1', '42', '2013-08-05 17:31:32', null, '0', '1', '20', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('34', '1', '1', '1', '42', '2013-08-05 17:31:32', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('35', '1', '1', '1', '42', '2013-08-14 17:31:32', null, '0', '0', '10', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('36', '1', '1', '1', '42', '2013-08-06 17:31:32', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('43', '1', '1', '1', '38', '2013-08-11 00:55:52', null, '0', '1', '10', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('44', '1', '1', '1', '38', '2013-08-11 01:02:32', null, '0', '1', '10', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('45', '1', '1', '1', '38', '2013-03-11 01:06:31', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('46', '1', '1', '1', '38', '2013-08-11 01:09:43', null, '0', '0', '10', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('47', '1', '1', '1', '40', '2013-03-19 01:16:20', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('48', '1', '1', '1', '40', '2013-03-19 01:17:39', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('49', '1', '1', '1', '40', '2013-03-19 01:20:15', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('50', '1', '1', '1', '40', '2013-03-19 01:23:30', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('52', '1', '1', '1', '42', '2013-03-19 01:31:00', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('53', '1', '1', '1', '44', '2013-03-19 01:32:45', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('54', '1', '1', '1', '42', '2013-03-19 01:36:50', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('73', '1', '1', '1', '38', '2013-08-07 04:07:07', null, '0', '1', '10', '0', '1', '10', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('78', '1', '1', '1', '88', '2014-03-06 06:51:58', null, '0', '1', '10', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('80', '1', '1', '1', '90', '2013-08-06 08:26:57', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('81', '1', '1', '1', '90', '2014-03-06 08:36:28', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('83', '1', '1', '1', '79', '2013-08-06 09:32:47', null, '0', '1', '0', '6', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('87', '1', '1', '1', '82', '2014-12-28 02:53:12', null, '0', '1', '100', '0', '0', '3', '0', '0', 'A', null, '0', '1', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('93', '1', '1', '1', '78', '2013-08-08 07:32:47', null, '0', '1', '0', '5', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('94', '1', '1', '1', '84', '2014-03-05 07:35:46', null, '0', '1', '0', '0', '0', '0', '56', '0', 'A', null, '7', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('95', '1', '1', '1', '85', '2014-03-21 09:50:20', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('97', '1', '1', '1', '83', '2013-08-08 09:26:09', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('98', '1', '1', '1', '83', '2013-08-12 01:33:02', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('99', '1', '1', '1', '44', '2013-08-13 08:02:06', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('100', '1', '1', '1', '44', '2013-08-13 08:03:20', null, '0', '0', '0', '0', '1', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('117', '1', '1', '1', '69', '2014-03-18 14:36:08', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('118', '1', '1', '1', '69', '2014-03-18 14:36:40', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('126', '1', '1', '1', '42', '2014-03-23 22:11:43', null, '0', '0', '240', '0', '3', '1', '2', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('127', '1', '1', '1', '42', '2014-03-23 22:11:44', null, '0', '0', '480', '0', '8', '1', '8', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('128', '1', '1', '1', '42', '2014-03-23 22:11:40', null, '0', '0', '50', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('129', '1', '1', '1', '84', '2014-04-01 09:42:55', null, '0', '1', '30', '0', '0', '0', '0', '0', 'A', null, '0', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('130', '1', '1', '1', '83', '2014-04-01 14:26:53', null, '0', '1', '10', '0', '0', '0', '0', '0', 'A', null, '0', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('131', '1', '1', '1', '96', '2014-03-06 06:14:31', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('132', '1', '1', '1', '95', '2014-04-01 10:17:56', null, '0', '1', '0', '0', '0', '0', '3', '0', 'A', null, '0', '0', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('133', '1', '1', '1', '79', '2014-04-01 16:17:47', null, '0', '1', '0', '1', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('134', '1', '1', '1', '79', '2014-04-01 16:42:25', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('135', '1', '1', '1', '77', '2014-04-01 16:44:23', null, '0', '1', '10', '4', '0', '1', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('136', '1', '1', '1', '77', '2014-04-01 16:47:02', null, '0', '1', '0', '1', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('137', '1', '1', '1', '80', '2012-04-02 20:54:50', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '5', '2', '99', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('138', '1', '1', '1', '80', '2009-04-02 21:07:34', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '9', '11', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('139', '1', '1', '1', '81', '2010-04-02 21:14:10', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '0', '100', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('140', '1', '1', '1', '81', '2013-08-08 02:47:18', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '0', '100', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('141', '1', '1', '1', '88', '2014-03-07 22:15:56', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('142', '1', '1', '1', '87', '2014-04-03 23:05:08', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('143', '1', '1', '1', '88', '2014-04-03 23:11:05', null, '0', '1', '10', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('144', '1', '1', '1', '69', '2014-04-04 22:32:07', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('145', '1', '1', '1', '69', '2014-04-04 22:33:53', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('146', '1', '1', '1', '69', '2014-04-04 22:37:05', null, '0', '0', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('148', '1', '1', '1', '78', '2014-04-05 13:40:11', null, '0', '1', '10', '4', '0', '1', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('149', '1', '1', '1', '78', '2014-04-05 13:41:40', null, '0', '1', '0', '1', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('150', '1', '1', '1', '79', '2014-04-05 13:43:23', null, '0', '1', '10', '2', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('151', '1', '1', '1', '82', '2014-10-02 21:15:32', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '2', '13', '100', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('162', '1', '1', '1', '93', '2014-11-26 17:52:33', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('163', '1', '1', '1', '94', '2014-11-26 17:52:43', null, '0', '1', '20', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('164', '1', '1', '1', '87', '2014-12-09 11:29:10', null, '0', '1', '180', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('165', '1', '1', '1', '88', '2014-12-09 11:34:38', null, '0', '1', '540', '0', '0', '0', '0', '0', 'A', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('166', '1', '1', '1', '82', '2014-12-12 22:43:36', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '1', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('167', '1', '1', '1', '82', '2014-12-12 12:42:55', null, '0', '1', '0', '0', '0', '1', '0', '0', 'A', null, '0', '1', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('168', '1', '1', '1', '80', '2014-12-12 17:28:21', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '0', '99', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('169', '1', '1', '1', '80', '2014-10-01 17:40:22', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '3', '5', '99', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('170', '1', '1', '1', '81', '2014-12-12 14:25:30', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '1', '1', '99', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('172', '1', '1', '1', '82', '2014-12-17 11:05:19', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '1', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('173', '1', '1', '1', '82', '2014-12-17 11:09:02', null, '0', '1', '0', '0', '0', '0', '0', '0', 'A', null, '0', '1', null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('174', '1', '1', '1', '81', '2014-12-17 11:41:40', null, '0', '1', '30', '0', '0', '0', '0', '0', 'A', null, '0', '0', '100', null, null, null, '0');
INSERT INTO `cms_info` VALUES ('180', '1', '1', '1', '44', '2015-12-23 21:01:57', null, '0', '0', '0', '0', '0', '0', '0', '0', 'X', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('221', '1', '1', '1', '42', '2017-12-15 10:08:47', null, '0', '0', '0', '0', '0', '0', '0', '0', 'E', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('222', '1', '1', '1', '42', '2017-12-15 10:08:50', null, '0', '0', '0', '0', '0', '0', '0', '0', 'E', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('223', '1', '1', '1', '42', '2017-12-15 10:08:51', null, '0', '0', '0', '0', '0', '0', '0', '0', 'E', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('224', '1', '1', '1', '42', '2017-12-15 10:08:53', null, '0', '0', '0', '0', '0', '0', '0', '0', 'E', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('225', '1', '1', '1', '42', '2017-12-15 10:08:54', null, '0', '0', '0', '0', '0', '0', '0', '0', 'E', null, null, null, null, null, null, null, '0');
INSERT INTO `cms_info` VALUES ('226', '1', '1', '1', '42', '2017-12-15 10:08:56', null, '0', '0', '0', '0', '0', '0', '0', '0', 'E', null, null, null, null, null, null, null, '0');

-- ----------------------------
-- Table structure for cms_info_attribute
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_attribute`;
CREATE TABLE `cms_info_attribute` (
  `f_info_id` int(11) NOT NULL COMMENT '文档',
  `f_attribute_id` int(11) NOT NULL COMMENT '属性',
  `f_image` varchar(255) DEFAULT NULL COMMENT '属性图片',
  KEY `fk_cms_infoattr_attribute` (`f_attribute_id`) USING BTREE,
  KEY `fk_cms_infoattr_info` (`f_info_id`) USING BTREE,
  CONSTRAINT `fk_cms_infoattr_attribute` FOREIGN KEY (`f_attribute_id`) REFERENCES `cms_attribute` (`f_attribute_id`),
  CONSTRAINT `fk_cms_infoattr_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_buffer
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_buffer`;
CREATE TABLE `cms_info_buffer` (
  `f_info_id` int(11) NOT NULL,
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `f_downloads` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  `f_comments` int(11) NOT NULL DEFAULT '0' COMMENT '评论次数',
  `f_involveds` int(11) NOT NULL DEFAULT '0' COMMENT '评论参与人数',
  `f_diggs` int(11) NOT NULL DEFAULT '0' COMMENT '顶',
  `f_burys` int(11) NOT NULL DEFAULT '0' COMMENT '踩',
  `f_score` int(11) NOT NULL DEFAULT '0' COMMENT '得分',
  PRIMARY KEY (`f_info_id`),
  CONSTRAINT `fk_cms_infobuffer_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_buffer
-- ----------------------------
INSERT INTO `cms_info_buffer` VALUES ('24', '4', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('26', '8', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('27', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('28', '2', '0', '0', '0', '0', '0', '2');
INSERT INTO `cms_info_buffer` VALUES ('30', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('32', '9', '0', '0', '0', '0', '0', '1');
INSERT INTO `cms_info_buffer` VALUES ('33', '6', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('34', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('35', '4', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('36', '4', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('43', '5', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('44', '7', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('45', '8', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('46', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('48', '5', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('49', '8', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('50', '5', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('52', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('53', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('54', '8', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('73', '2', '0', '0', '0', '3', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('78', '4', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('80', '9', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('81', '7', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('83', '7', '0', '0', '0', '0', '1', '0');
INSERT INTO `cms_info_buffer` VALUES ('87', '4', '0', '0', '0', '0', '0', '2');
INSERT INTO `cms_info_buffer` VALUES ('93', '3', '0', '0', '0', '0', '0', '9');
INSERT INTO `cms_info_buffer` VALUES ('94', '7', '0', '0', '0', '0', '0', '9');
INSERT INTO `cms_info_buffer` VALUES ('95', '7', '0', '0', '0', '0', '0', '3');
INSERT INTO `cms_info_buffer` VALUES ('97', '5', '0', '0', '0', '0', '0', '8');
INSERT INTO `cms_info_buffer` VALUES ('98', '7', '0', '0', '0', '0', '0', '2');
INSERT INTO `cms_info_buffer` VALUES ('99', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('100', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('117', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('118', '5', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('126', '1', '0', '0', '0', '0', '1', '0');
INSERT INTO `cms_info_buffer` VALUES ('127', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('128', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('129', '6', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('130', '6', '0', '0', '0', '0', '0', '9');
INSERT INTO `cms_info_buffer` VALUES ('131', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('132', '6', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('133', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('134', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('135', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('136', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('137', '4', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('138', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('139', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('140', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('141', '9', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('142', '9', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('143', '7', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('144', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('145', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('146', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('148', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('149', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('150', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('151', '2', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('162', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('163', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('164', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('165', '7', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('166', '4', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('167', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('168', '3', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('169', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('170', '7', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('172', '6', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('173', '8', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('174', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('180', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('221', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('222', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('223', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('224', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('225', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `cms_info_buffer` VALUES ('226', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for cms_info_clob
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_clob`;
CREATE TABLE `cms_info_clob` (
  `f_info_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` mediumtext COMMENT '值',
  KEY `fk_cms_infoclob_info` (`f_info_id`) USING BTREE,
  CONSTRAINT `fk_cms_infoclob_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_clob
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_custom`;
CREATE TABLE `cms_info_custom` (
  `f_info_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_infocustom_info` (`f_info_id`) USING BTREE,
  CONSTRAINT `fk_cms_infocustom_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_detail
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_detail`;
CREATE TABLE `cms_info_detail` (
  `f_info_id` int(11) NOT NULL,
  `f_title` varchar(150) NOT NULL COMMENT '主标题',
  `f_html` varchar(255) DEFAULT NULL COMMENT 'HTML页面',
  `f_mobile_html` varchar(255) DEFAULT NULL COMMENT '手机端HTML页面',
  `f_subtitle` varchar(150) DEFAULT NULL COMMENT '副标题',
  `f_full_title` varchar(150) DEFAULT NULL COMMENT '完整标题',
  `f_link` varchar(255) DEFAULT NULL COMMENT '转向链接',
  `f_is_new_window` char(1) DEFAULT NULL COMMENT '是否在新窗口打开',
  `f_color` varchar(50) DEFAULT NULL COMMENT '颜色',
  `f_is_strong` char(1) NOT NULL DEFAULT '0' COMMENT '是否粗体',
  `f_is_em` char(1) NOT NULL DEFAULT '0' COMMENT '是否斜体',
  `f_info_path` varchar(255) DEFAULT NULL COMMENT '文档路径',
  `f_info_template` varchar(255) DEFAULT NULL COMMENT '文档模板',
  `f_meta_description` varchar(450) DEFAULT NULL COMMENT 'meta描述',
  `f_source` varchar(50) DEFAULT NULL COMMENT '来源名称',
  `f_source_url` varchar(255) DEFAULT NULL COMMENT '来源url',
  `f_author` varchar(50) DEFAULT NULL COMMENT '作者',
  `f_small_image` varchar(255) DEFAULT NULL COMMENT '小图',
  `f_large_image` varchar(255) DEFAULT NULL COMMENT '大图',
  `f_video` varchar(255) DEFAULT NULL COMMENT '视频url',
  `f_video_name` varchar(255) DEFAULT NULL COMMENT '视频名称',
  `f_video_length` bigint(20) DEFAULT NULL COMMENT '视频长度',
  `f_video_time` varchar(100) DEFAULT NULL COMMENT '视频时间',
  `f_file` varchar(255) DEFAULT NULL COMMENT '文件url',
  `f_file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `f_file_length` bigint(20) DEFAULT NULL COMMENT '文件长度',
  `f_doc` varchar(255) DEFAULT NULL COMMENT '文库url',
  `f_doc_name` varchar(255) DEFAULT NULL COMMENT '文库名称',
  `f_doc_length` varchar(255) DEFAULT NULL COMMENT '文库长度',
  `f_doc_pdf` varchar(255) DEFAULT NULL COMMENT '文库PDF',
  `f_doc_swf` varchar(255) DEFAULT NULL COMMENT '文库SWF',
  `f_is_allow_comment` char(1) DEFAULT NULL COMMENT '是否允许评论',
  `f_step_name` varchar(100) DEFAULT NULL COMMENT '审核步骤名称',
  PRIMARY KEY (`f_info_id`),
  CONSTRAINT `fk_cms_infodetail_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_detail
-- ----------------------------
INSERT INTO `cms_info_detail` VALUES ('24', '少林寺欲将功夫融入足球培训运动员', null, null, null, null, null, null, null, '0', '0', null, null, '少林足球近日，有关登封武校将少林功夫融入足球，培训足球运动员的新鲜事儿在网上流传，引起社会各界的关注。8月6日下午，记者电话采访了嵩山少林寺武僧团培训基地总教头释延鲁。释延鲁说，8月2日全国第六届高校足球教练培训研讨会在登封举行，他向与会的70多位国内各高校的足球教练员阐述了他的观点。释延鲁认为，', '南方日报', null, '杨春', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('25', '北京警方捣毁侵害公民信息团伙 抓获299人', null, null, null, null, null, null, null, '0', '0', null, null, '?北京警方10日通报，8月7日警方出动300名警力，对藏匿于一栋大厦内侵害公民个人信息的犯罪团伙实施抓捕，299名嫌犯落网，其中刑事拘留95人、行政拘留204人，并缴获数十箱公民个人信息名单。目前，涉案公司总裁仍在逃。北京市公安局丰台分局副局长郑威在10日的新闻发布会上介绍说，今年8月初，警方侦查发', '南方日报', null, '杨春', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('26', '北京发布雷电黄色预警 傍晚至夜间将有大到暴雨', null, null, null, null, null, null, null, '0', '0', null, null, '?\r\n11日凌晨开始，北京雷雨大作，持续一夜，至9时许雨量减弱，天气转阴。北京市气象台发布消息称，11日白天到夜间，北京将有大到暴雨，并伴有雷电。尤其是傍晚至夜间，雨势较大，山区须注意防范地质灾害。\r\n降雨带来了些许清凉，一解前几日的持续暑热。11日一早，许多市民趁雨停了，纷纷出门采买，但整个京城仍', '中国广播网', null, '王军', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('27', '聚划算成清仓专用 问题产品充斥', null, null, null, null, null, null, null, '0', '0', null, null, '作为淘宝最知名的团购平台，2011年是聚划算的爆发年，而历经反腐门之后，重新出台的聚划算团购服务竞拍规则(俗称“坑位费”)出台至今就重创了不少中小商家。据聚划算官网显示，其竞拍时间为每天上午10：00-11：00，竞拍起拍价为人民币1000元，单次加价幅度为100元及其整数倍，参与聚划算竞拍的卖家应', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('28', '七夕前夜英仙座流星雨助兴 我国处于最佳观测区', null, null, null, null, null, null, null, '0', '0', null, null, '“这是今年最值得向大家推荐观测的流星雨”，北京天文馆馆长朱进前日发微博“推介”即将于13日凌晨迎来极大值的英仙座流星雨，是日恰逢七夕。但天气预报显示，届时北京将以阴雨天气为主，市民能否一睹年度最佳流星雨，还要看天公是否做美。据国际流星组织(IMO)估计，今年英仙座流星雨的高峰期将在北京时间8月12日', '京华时报', null, '商西', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('30', '报告称中国取代英国成世界第5大常规武器出口国', null, null, null, null, null, null, null, '0', '0', null, null, '据美联社3月18日报道，瑞典智库斯德哥尔摩国际和平研究所(SIPRI)18日称，中国已取代英国成为世界第五大常规武器出口国。SIPRI在报告中称，中国在过去5年(2008-2012)中武器出口总量增长了163%，国际军火市场占有份额从2%增至5%，同时排名也从之前的第八升至第五。报告称，中国武器的最', '环球时报', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('32', '俄军主力战机集群出动应对乌克兰', null, null, null, null, null, null, null, '0', '0', null, null, '俄南部军区27日起在克拉斯诺达尔边疆区举行空中演习。据悉，在为期两天的时间里，苏－25SM3强击机机 组人员将完成约40架次的飞行，并在无线电干扰的情况下对假想敌进行约50次打击。俄国防部网站消息说，俄东部军区当天也开始了大规模空中演习。演习将在 哈巴罗夫斯克边疆区和滨海边疆区进行，将有超过30架包', '环球时报', null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140404213603_k0a0bc.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('33', '汽车高速爆胎致车祸 鉴定机构回避轮胎质量问题', null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201303/20130318084854_x4wvqy.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('34', '市民未插卡取款机吐出一万元 不受诱惑忙报警', null, null, null, null, null, null, null, '0', '0', null, null, '6日晚，在昆明市白龙路一自助银行里，来取钱的刘老师站在柜员机前捣鼓了半天&mdash;&mdash;卡插不进去，他在柜员机上随便按了“5000”，谁知50张百元钞票就吐到了他面前。机器出了问题？他又按了“5000”，又有5000元吐到了手里。仔细一查，发现柜员机里原来已有一张银行卡，刘老师忙报了警。', '春城晚报', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('35', '31省市最理想伴侣地图出炉：男性最想娶川妹子', null, null, null, null, null, null, null, '0', '0', null, null, '31省市男女最理想伴侣地图出炉\r\n首选嫁京男?最爱娶川妹\r\n超五成的青年择偶时首选本地人；女性最想嫁的外省人中，北京男最受欢迎；男性则最想娶川妹子。\r\n记者上午获悉，零点指标数据进行2013年七夕主题调查，对全国各地1074位18至45周岁的网民进行随机访问，绘出31省市青年男女最理想伴侣地图', '中国新闻网', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('36', '调查称逾九成被调查者对中国人身份感到自豪', null, null, null, null, null, null, null, '0', '0', null, null, '根据中国社科院相关机构进行的“中国公民政治文化”问卷调查：90．03％被调查者对“作为中国人，我很自豪”持赞同态度；72．23％被调查者认同“中国传统文化对个人具有很大的影响”。该调查在全国10个省份进行，获得6159份有效样本。', '东方网', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('43', '凤凰传奇赚1亿 人气搭档怎么分钱', null, null, null, null, null, null, null, '0', '0', null, null, '近日，有明星经纪公司爆料，唱遍大小春晚的“农业重金属组合”凤凰传奇，出场费已经涨到了60万/场，若加上代言，2012年约有1亿进账。1亿这个数字也许略有夸张，但实际收入肯定也不会少。网友们一边感叹农业重金属的力量不可小觑，一边又开始琢磨这么多钱他们怎么分呢？凤凰传奇经纪人接受采访时表示，“玲花和曾毅', '腾讯娱乐', null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201303/20130319005453_gcalyk.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('44', '羽泉同乐会为海泉庆生 9月开唱回馈歌迷', null, null, null, null, null, null, null, '0', '0', null, null, '?8月12日，羽泉(微博)(微信号：yuquanweixin?)携专辑《拾伍》在京举办粉丝同乐会。而活动第二天“七夕节”恰好是胡海泉(微博)的生日，歌迷们不仅为海泉准备了礼物还送上蛋糕，倍受感动的海泉感慨道：“对于羽泉来说，能在各位的陪伴和支持下一起走过的岁月就是最好的礼物。”为了纪念出道15周年，', '腾讯娱乐', null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201308/20130813072417_4y837l.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('45', '专访杨幂：“事业有成”离我很远 不着急完婚', null, null, null, null, null, null, null, '0', '0', null, null, '“大家好，我是制片人杨幂。”一身干练的黄色风衣，一句霸气外露的自我介绍，升级当了制片人的杨幂果然显现出女强人的气质。昨日，由其担任监制的都市时尚偶像剧《微时代之恋》在沪举行开机发布会，杨幂带着她钦点的男主角余文乐，以及她花费一年选出的八位新人齐齐亮相。腾讯网娱乐中心总监常斌到场助阵，宣布该剧官网正式', '腾讯娱乐', null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201303/20130319010624_en4gsf.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('46', '终极格斗激情上演', null, null, null, null, null, null, null, '0', '0', null, null, '重庆，12日，《一夜惊喜》见面会。女神范冰冰(微博)(微信号：fbbstudio916?)携李治廷空降山城重庆，在重庆各大影院轮番宣传最新电影《一夜惊喜》。电影中范冰冰和李治廷上演了姐弟恋，见面会现场，范爷霸气地将李治廷抱起来秀“恩爱”。当媒体问及范爷七夕怎么过时，范冰冰表示明天将在北京和“那个', '腾讯娱乐', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('47', '足协曾忧王迪成\"定时炸弹\" 两次漏判国安点球', null, null, null, null, null, null, null, '0', '0', null, null, '在上周六武汉卓尔与北京国安的比赛中，主裁判王迪先后错判国安外援格隆禁区内假摔，接着又漏判给故意踢人的卓尔球员柯钊红牌。中国足协裁委会赛后确认，王迪两次判罚属严重错、漏判。王迪面临停哨3至6场的重罚。据悉，王迪通过抽签获本场比赛执法资格后，足协曾有人提议由经验丰富的老裁判取而代之，但提议未被采纳。抽签', '腾讯体育', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('48', '热火不败继续称霸实力榜 湖人升至第9火箭第11', null, null, null, null, null, null, null, '0', '0', null, null, '3月18日体育专电（记者林德韧）NBA(微博)官方18日公布了最新一期的实力榜，拿下22连胜的迈阿密热火队当之无愧地继续排在榜首，圣安东尼奥马刺队和俄克拉荷马雷鸣队分居二、三位。\r\n　　在击败多伦多猛龙队之后，热火队保住了自己的不败金身，东区冠军的位置已经基本锁定，现在剩下的唯一悬念就是热火队的连胜', '新华网', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('49', '足协或罚武汉暴力后卫停赛2场 格隆停赛不变', null, null, null, null, null, null, null, '0', '0', null, null, '在上周六中超联赛卓尔与国安比赛下半时，卓尔球员柯钊暴踢国安外援马季奇的举动在足球界引起了不小反响。中国足协裁判委员会今天也出具报告提请纪律委员会对柯钊追罚。据了解，纪委会很可能将柯钊的犯规定性为暴力行为。由于他及其俱乐部认错态度良好，中国足协将按照底线处罚柯钊，柯钊面临停赛2场、1万元左右的追罚。电', '腾讯体育', null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201303/20130319012002_dsuaw3.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('50', '西媒：巴萨巴黎巅峰对决 皇马上签穆帅会老友', null, null, null, null, null, null, null, '0', '0', null, null, '北京时间3月15日晚，欧足联在瑞士尼翁总部进行了本赛季欧冠(微博 专题) 1/4决赛对阵形势抽签。杀进八强的三支西甲(微博 专题) 球队中，皇马(官方微博 数据) 抽中土超劲旅加拉塔萨雷，巴萨(官方微博 数据) 遭遇法甲大鳄巴黎圣日耳曼(微博 数据) ，马拉加(官方微博 数据) 则要迎接德甲球队', '腾讯体育', null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140404215630_ielobo.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('52', '尚德宣布可转债违约 成大陆首家公司债违约企业', null, null, null, null, null, null, null, '0', '0', null, null, null, '腾讯财经', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('53', '俄媒：苏联为买军火曾贿赂罗斯福', null, null, null, null, null, null, null, '0', '0', null, null, '上世纪30年代，为利用美国技术建造新型军舰，苏联领导人特批从国库划拨50万美元的“行政经费”(在当时是一笔不小的数目)，供一家苏联外贸公司使用，以便打通美国高层关节。但这笔钱最终打了水漂，并连累不少人获罪，俄罗斯《权力》杂志日前刊文披露了这段秘闻。　　1924年，苏联在美国注册成立了阿姆外贸集团公司', '新华网', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('54', 'WSJ：中国正在重蹈美国金融危机覆辙', null, null, null, null, null, null, null, '0', '0', null, null, '北京时间3月19日凌晨消息，华尔街日报中国实时报栏目周一文章称，两名经济学家指出，美国房地产市场崩溃之前曾有过的三个警示性信号已经在中国出现，这意味着中国只有非常有限的时间来摆脱困境。\r\n文章指出，在野村证券于上周六公布的一份报告中，经济学家张智威和陈家瑶指出，物业价格的上涨、杠杆化的快速积累和潜在', '东方网', null, '李军', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('73', '杨钰莹再谈与赖文峰恋情 面对爱情并不后悔', null, null, null, null, null, null, null, '0', '0', null, null, '?杨钰莹“女人不是因为美丽而可爱，是因为可爱而美丽。”俄罗斯文学家列夫&middot;托尔斯泰在《战争与和平》中的这句话，用在杨钰莹身上正合适。白裙子，长头发，低声说，轻声笑，杨钰莹完全保留着少女的神态。10多年的岁月，惊涛骇浪的往事，在她身上仿佛没留下痕迹。但交谈久了，还是不一样。你会发现，她从前', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201308/20130814133153_a6qtv0.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('78', '翘臀美女力挺开拓者 香艳宝贝支持灰熊', null, null, null, null, null, null, null, '0', '0', null, null, '翘臀美女力挺开拓者 香艳宝贝支持灰熊', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140403224743_k5txx2.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('80', '第十二届全运会礼仪小姐训练实拍', null, null, null, null, null, null, null, '0', '0', null, null, '第十二届全运会礼仪小姐训练实拍', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140403230102_j1ygy9.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('81', '两会上靓丽的礼仪小姐', null, null, null, null, null, null, null, '0', '0', null, null, '两会上靓丽的礼仪小姐', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140403224051_vro62p.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('83', '搜狗输入法', null, null, null, '搜狗输入法(搜狗拼音) 7.1c', null, null, null, '0', '0', null, null, '搜狗输入法作为国内汉字拼音输入法的领导者，搜狗输入法率先实现了输入法与互联网的结合。基于搜狗搜索引擎技术，对中文词库有突破性发展，开创了新一代中文输入法。即时高效地更新热门词库，大幅提升了输入效率，让输入速度产生了质的飞跃。在词库的广度、词语的准确度上，搜狗输入法都在行业内遥遥领先。', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401163838_4g7x6o.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224154447_njmwafxvgl.jpg', null, null, null, null, 'http://cdn2.ime.sogou.com/1ef422d9c97c66c1769eb774daa8644d/567ba27b/dl/index/1450769272/sogou_pinyin_78j.exe', 'sogou_pinyin_78j.exe', '36194023', null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('87', '台南资讯月曾甜热舞', null, null, null, null, null, null, null, '0', '0', null, null, '台南资讯月曾甜热舞', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234730_7ylyoq6qne.jpg', null, 'http://demo.jspxcms.com/uploads/1/video/public/201412/20141217105935_9qtt8vp9yj.mp4', '台南资讯月曾甜热舞_超清.mp4', '35252510', '3:53', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('93', 'QQ7.9', null, null, null, null, null, null, null, '0', '0', null, null, '免费的即时聊天软件，给上网带来更多沟通乐趣。腾讯QQ2013年度皮肤呈现视觉盛宴，皮肤编辑器实现个性化面板创意；QQ应用盒子全新呈现，丰富应用满足多彩生活；QQ短信首度面世，畅享无处不在的沟通体验；炫彩字体，炫出聊天个性与风采；QQ支持自定义标签，标签顺序随心换。提示：如果您正在运行着腾讯QQ或者T', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401163625_s9usmk.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224154307_d6dwqq2yll.jpg', null, null, null, null, 'http://dldir1.qq.com/qqfile/qq/QQ7.9/16638/QQ7.9.exe', 'QQ7.9.exe', '59068088', null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('94', '惠科（HKC）Q320 32英寸2K高分广视角护眼不闪LED背光液晶显示器', null, null, null, null, null, null, '#FF0000', '0', '0', null, null, '惠科（HKC）Q320 32英寸2K高分广视角护眼不闪LED背光液晶显示器', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224141639_p5kfadfqal.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224141645_8fnjf4vtop.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('95', '苏醒的乐园 2014春装 新款女装 韩版修身 中长款 风衣外套女 FY164 驼色 M', null, null, null, null, null, null, null, '0', '0', null, null, '苏醒的乐园 2014春装 新款女装 韩版修身 中长款 风衣外套女 FY164 驼色 M', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401151029_uk6wwv.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224144649_90stgfll7g.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('97', '苹果（APPLE）iPhone 6s 64G版 4G手机（金色）WCDMA/GSM', null, null, null, null, null, null, null, '0', '0', null, null, '苹果（APPLE）iPhone 6s 64G版 4G手机（金色）WCDMA/GSM', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401144253_nnavj0.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224122043_yqh1n9nbrd.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('98', '索尼（SONY） DSC-RX100 M2 黑卡数码相机', null, null, null, null, null, null, null, '0', '0', null, null, '索尼（SONY） DSC-RX100 M2 黑卡数码相机', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401142459_82smxp.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224121205_23l6sjouvm.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('99', '美官方统计：为避税放弃美国国籍人数1年暴增5倍', null, null, null, null, null, null, null, '0', '0', null, null, '?\r\n8月12日电 (记者 王欢)美国联邦公报最新公布的数据显示，2013年第二季度放弃美国国籍的人数再创新高，暴增至1131人，比去年同期的189人多出5倍。美国媒体称，美国政府为了增加税收应对拮据的财政状况，准备实施更严格的资产申报规定，使得放弃美国公民身份或绿卡的人数持续增长。\r\n　　报告显示', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('100', '英国派军舰赴地中海演习 西班牙称是恐吓行为', null, null, null, null, null, null, null, '0', '0', null, null, '\r\n8月12日电 (记者 周兆军)英国和西班牙围绕直布罗陀的主权争议升级，12日，英国皇家海军的的一支快速反应部队前往地中海进行年度演习，包括“光辉”号航母在内的多艘军舰将前往直布罗陀海域。\r\n英国国防部宣布，包括“光辉”号航空母舰、两艘护卫舰和辅助舰只在内的10艘军舰前往地中海进行演习。英国国防部', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('117', 'Java开发工程师', null, null, null, null, null, null, null, '0', '0', null, null, 'Java开发工程师', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('118', '网页设计师', null, null, null, null, null, null, null, '0', '0', null, null, '网页设计师', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('126', '以房养老拟在北上广汉试点 初次贷款不超500万', null, null, null, '以房养老拟在北上广汉试点\r\n初次贷款不超500万', null, null, null, '0', '0', null, null, '	　　每日经济新闻记者 黄俊玲 发自北京\r\n	　　千呼万唤，以房养老保险方案终于要成为现实。\r\n	　　《每日经济新闻》记者昨日(3月20日)获悉，为贯彻落实国务院《关于加快发展养老服务业的若干意见》有关要求，丰富养老保障方式的新途径，保监会决定开展老年人住房反向抵押养老保险试点。\r\n	　　同时，', '中国新闻网', 'http://www.chinanews.com/gn/2014/05-30/6233523.shtml', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('127', '最高检:严查以贿赂等手段破坏选举犯罪', null, null, null, null, null, null, null, '0', '0', null, null, '	　　依法严惩暴力伤害医务人员犯罪，加大外逃职务犯罪嫌疑人追捕力度\r\n	　　据新华社电 最高检20日召开会议对重大案件公开、打击涉医犯罪、追逃等工作作出要求和部署。会议要求各级检察机关要积极参与维护医疗秩序打击涉医违法犯罪专项行动，依法严惩暴力伤害医务人员犯罪。会议透露，检察机关将加强反腐败国际', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('128', '中方在南印度洋发现疑似MH370黑匣子信号', null, null, null, null, null, null, null, '0', '0', null, null, '	　　新快报讯 近日，山东省曲阜市出台新规：所有市级领导干部一律取消秘书配备，其事务性活动由各办公室统一协调安排。其中，包括曲阜市委书记、市长在内的10位市级领导秘书配备取消。同时，曲阜市要求，领导外出不得讲求排场，让轻车简从成为常态。\r\n	　　今年3月初，曲阜市通过向群众、网民、人大代表、政协', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('129', 'ThinkPad T550(20CKA00QCD) 15.6英寸笔记本电脑 (i7-5600U 8G 256GB 独显1G 蓝牙 指纹 WIN7Pro)', null, null, null, null, null, null, null, '0', '0', null, null, 'ThinkPad T550(20CKA00QCD) 15.6英寸笔记本电脑 (i7-5600U 8G 256GB 独显1G 蓝牙 指纹 WIN7Pro)', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401141615_kq36r7.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224122723_7i7de3ddcs.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('130', '佳能（Canon） EOS 5D Mark III 单反套机（EF 24-105mm f/4L IS USM 镜头）', null, null, null, null, null, null, null, '0', '0', null, null, '佳能（Canon） EOS 5D Mark III 单反套机（EF 24-105mm f/4L IS USM 镜头）', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401142650_bac6rd.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224120231_65sse24nht.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('131', '乔丹男子新款2015夏季耐磨透气篮球战靴OM3540101鲜红/黑色', null, null, null, null, null, null, null, '0', '0', null, null, '乔丹男子新款2015夏季耐磨透气篮球战靴OM3540101鲜红/黑色', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224145341_9nq3mp9otv.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224145344_89bwi3rykk.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('132', '米莱珠宝 4.27克拉红碧玺戒指 18K白金戒指 结婚戒指 情侣戒指 品位女士首饰【10天定制+证书】', null, null, null, null, null, null, null, '0', '0', null, null, '米莱珠宝 4.27克拉红碧玺戒指 18K白金戒指 结婚戒指 情侣戒指 品位女士首饰【10天定制+证书】', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401151753_4dd63k.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224144736_ewd1t08u7m.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('133', 'WPS 2013', null, null, null, 'wps office 2013 个人版 9.1.0.4555', null, null, null, '0', '0', null, null, 'WPS Office是由金山软件股份有限公司自主研发的一款办公软件套装，可以实现办公软件最常用的文字、表格、演示等多种功能。具有内存占用低、运行速度快、体积小巧、强大插件平台支持、免费提供海量在线存储空间及文档模板、支持阅读和输出PDF文件、全面兼容微软Office97-2010格式（doc/doc', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401162441_xft5mm.png', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224153817_vdahkda8my.jpg', null, null, null, null, 'http://wdl1.cache.wps.cn/wps/download/W.P.S.5400.19.552.exe', 'W.P.S.5400.19.552.exe', null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('134', '好压', null, null, null, '2345好压（HaoZip） 正式版 4.2.1.9445', null, null, null, '0', '0', null, null, '好压压缩软件(HaoZip)是强大的压缩文件管理器，是完全免费的新一代压缩软件，相比其它压缩软件占用更少的系统资源用，有更好的兼容性，压缩率高！好压压缩软件(HaoZip)的功能包括强力压缩、分卷、加密、自解压模块、智能图片转换、智能媒体文件合并等功能。完美支持鼠标拖放及外壳扩展！功能介绍支持rar', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401164223_bnlgl0.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224153551_2akebwrxnp.gif', null, null, null, null, 'http://dl.2345.com/haozip/haozip_v5.5_jt.multi.exe', 'haozip_v5.5_jt.multi.exe', null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('135', 'PotPlayer1.6', null, null, null, 'PotPlayer 正式版 1.6', null, null, null, '0', '0', null, null, 'PotPlayer播放器中文版是一款优秀的高清播放器，它的前身是著名的KMPlayer。它可以播放大多数主流的视频、音频文件，并不需要额外安装第三方解码器。它强大的定制性与扩展能力让它成为播放高清影片的不二之选。PotPlayer播放器中文版是kmplayer的原作者姜龙喜先生进入daum公司后的新', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151223183234_meu89ooh4v.png', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224153038_hlpu3gentd.png', null, null, null, null, 'http://demo.jspxcms.com/uploads/1/file/public/201512/20151224164602_edj1kwmpox.exe', 'PotPlayerSetup64.exe', '19892992', null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('136', 'Adobe Reader', null, null, null, 'Adobe Reader 11.0.00', null, null, null, '0', '0', null, null, 'Adobe Reader X 11.0.6 官方中文版下载，支持打开和使用 Adobe PDF 的工具，可查看、打印和管理 PDF。若已经安装过之前的版本，请先卸载后再安装此版本！在 Reader 中打开 PDF 后，可以使用多种工具快速查找信息。如果您收到一个 PDF 表单，则可以在线填写并以电子', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140401164659_g0lhr7.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224152444_6wle3i9xgp.png', null, null, null, null, 'http://dlc2.pconline.com.cn/filedown_1322_6950695/Xsx70db2/AdbeRdr11000_zh_CN.exe', 'AdbeRdr11000_zh_CN.exe', null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('137', '警察故事2013', null, null, null, null, null, null, null, '0', '0', null, null, '警察故事2013', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141216175409_1302a0rob7.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('138', '私人订制', null, null, null, null, null, null, null, '0', '0', null, null, '私人订制', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141216180617_rdipnf4txk.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('139', '爸爸去哪儿 第一季', null, null, null, null, null, null, null, '0', '0', null, null, '爸爸去哪儿 第一季', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141216180232_fgmao9eja0.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('140', '来自星星的你', null, null, null, '来自星星的你 第1集', null, null, null, '0', '0', null, null, '来自星星的你', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234745_y0bl80nkxj.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('141', '哈登参与林书豪与帕森斯的赛前仪式', null, null, null, null, null, null, null, '0', '0', null, null, '哈登参与林书豪与帕森斯的赛前仪式', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140403225253_hc5wh6.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('142', '孤独星球公布世界十大必看奇迹', null, null, null, null, null, null, null, '0', '0', null, null, '孤独星球公布世界十大必看奇迹', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140403230505_vxnp2f.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('143', '全能锋霸梅西的“七种武器”', null, null, null, null, null, null, null, '0', '0', null, null, '全能锋霸梅西的“七种武器”', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140404215204_mnasf7.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('144', '安卓 ios 软件工程师', null, null, null, null, null, null, null, '0', '0', null, null, '安卓 ios 软件工程师', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('145', '软件UI设计师', null, null, null, null, null, null, null, '0', '0', null, null, '软件UI设计师', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('146', '软件测试工程师', null, null, null, null, null, null, null, '0', '0', null, null, '软件测试工程师', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('148', '火狐浏览器', null, null, null, 'Firefox火狐浏览器 正式版 28.0', null, null, null, '0', '0', null, null, 'Mozilla Firefox，中文名通常称为“火狐”或“火狐浏览器”，是一个开源网页浏览器，使用Gecko引擎（非ie内核），支持多种操作系统如Windows、Mac和linux。', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140405134003_12my1m.png', 'http://demo.jspxcms.com/uploads/1/image/public/201501/20150112165457_3bbqyk222b.jpg', null, null, null, null, 'http://download.firefox.com.cn/releases-sha2/stub/official/zh-CN/Firefox-latest.exe', 'Firefox-latest.exe', '544235', null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('149', '迅雷7', null, null, null, '迅雷7 正式版 7.9.20.4754', null, null, null, '0', '0', null, null, '经过近9个月的研发，迅雷今天首度公开了7.9新版。迅雷7.9加快了启动速度，新增了一键立即下载、在开始前完成、批量任务分组、智能任务分类等功能，下面具体来看一下：　　——加快启动速度　　启动速度慢的罪魁祸首是“频繁、大量进行硬盘读写”，迅雷7.9从基础设计上追求最少、最精明的进行硬盘读写。　　——确', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140405134137_xedtaq.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224151905_wtle7104a4.png', null, null, null, null, 'http://down.sandai.net/thunder7/Thunder_dl_7.9.42.5050.exe', 'Thunder_dl_7.9.42.5050.exe', '59068088', null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('150', '360浏览器8.1', null, null, null, '360浏览器8.1官方下载 v8.1.0.396 网必通版', null, null, null, '0', '0', null, null, '360浏览器是一款小巧、快速、安全、功能强大的多窗口浏览器，它是完全免费，没有任何功能限制的绿色软件，最全的恶意网址库，最新的云安全引擎，“安全红绿灯”全面拦截木马病毒网站;“搜索引擎保护”自动标识搜索结果页中的风险网站，网必通是360极速浏览器推出的新功能，解决个别海外科技类网站打不开的问题。当开', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201404/20140405134321_jknrl9.png', 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224150332_8wfoyk10nb.png', null, null, null, null, 'http://down.360safe.com/se/360se8.1.1.118.exe', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('151', '江湖时尚：郭采洁隔空示爱杨幂', null, null, '郭采洁隔空示爱杨幂', null, null, null, null, '0', '0', null, null, '江湖时尚：郭采洁隔空示爱杨幂', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234650_p4hjxsxoka.jpg', null, null, null, null, '15:32', null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('162', 'Freemarker参考手册', null, null, null, null, null, null, null, '0', '0', null, null, 'Freemarker参考手册', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201501/20150114103540_4hhb9ohttu.png', null, null, null, null, null, null, null, null, null, null, null, null, 'http://demo.jspxcms.com/uploads/1/doc/jspxcms_x.swf', null, null);
INSERT INTO `cms_info_detail` VALUES ('163', 'Jspxcms安装手册', null, null, null, null, null, null, null, '0', '0', null, null, 'Jspxcms安装手册', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224155649_y8bm7pb496.png', null, null, null, null, null, null, null, null, null, null, null, null, 'http://demo.jspxcms.com/uploads/1/doc/jspxcms_x.swf', null, null);
INSERT INTO `cms_info_detail` VALUES ('164', '盘点2014年地球上任性的土豪们', null, null, null, null, null, null, null, '0', '0', null, null, '盘点2014年地球上任性的土豪们', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141209112942_fwf3ekao15.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('165', '2014年那些令人难忘的戎装丽人', null, null, null, null, null, null, null, '0', '0', null, null, '2014年那些令人难忘的戎装丽人', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141209113650_0lpn6qp59m.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('166', '维多利亚的秘密2014大秀', null, null, null, null, null, null, null, '0', '0', null, null, '维多利亚的秘密2014大秀', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234524_lx9s8ywe4u.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('167', '两岸秘史（一）北平无战事?', null, null, null, '晓松奇谈：两岸秘史（一）北平无战事?', null, null, null, '0', '0', null, null, '两岸秘史（一）北平无战事?', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234634_dpgi7u2xd1.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('168', '猩球崛起2：黎明之战', null, null, null, null, null, null, null, '0', '0', null, null, '猩球崛起2：黎明之战', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234558_sgnxtct1sl.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('169', '搞怪3宝：狂飙记', null, null, null, null, null, null, null, '0', '0', null, null, '搞怪3宝：狂飙记', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234703_t3r1hgrv7x.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('170', '妖怪名单：灵异校园中的恋情', null, null, null, '妖怪名单', null, null, null, '0', '0', null, null, '妖怪名单：灵异校园中的恋情', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141213234616_h5kn46mysu.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('172', '台南资讯月XL ARMY热舞', null, null, null, null, null, null, null, '0', '0', null, null, '台南资讯月XL ARMY热舞', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141217112855_w1e3qpt2iq.jpg', null, 'http://demo.jspxcms.com/uploads/1/video/public/201412/20141217110506_muad4rbmwk.mp4', '台南资讯月XL ARMY热舞_超清.mp4', '30131589', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('173', '台南资讯月钢管舞', null, null, null, null, null, null, null, '0', '0', null, null, '台南资讯月钢管舞', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141217113441_vsk6khemr3.jpg', null, 'http://demo.jspxcms.com/uploads/1/video/public/201412/20141217110855_uvsybihp4c.mp4', '台南资讯月钢管舞_超清.mp4', '36169477', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('174', '四十九日祭', null, null, null, null, null, null, null, '0', '0', null, null, '四十九日祭', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201412/20141217114138_ucs3sshpc4.jpg', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('180', '传中兴管理人员被蒙古国反贪局逮捕 公司否认', null, null, null, null, null, null, null, '0', '0', null, null, '　　【环球时报记者 赵倩】针对日前有报道称“中国中兴通讯股份有限公司在蒙古承建项目时涉嫌行贿，其管理人员已被蒙古国家反贪局逮捕”，中兴公司18日接受《环球时报》记者采访时予以否认。　　该报道称，本月13日，蒙古国家反贪局对中兴公司在当地的办事处、高管住处、私人汽车及车库进行搜查，将搜到的文件资料都带', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('221', '湖南2名官员被疑违规提拔 官方：正调查复核', null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('222', '内蒙古自治区党委开会学习纠正四风重要批示精神', null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('223', '陕西省委开会学习纠正四风重要批示精神', null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('224', '北京朝阳区火灾救出14人 其中5人遇难', null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('225', '韩国总统文在寅抵京 开始对中国进行国事访问', null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_info_detail` VALUES ('226', '甘肃省委开会学习纠正四风重要批示精神', null, null, null, null, null, null, null, '0', '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for cms_info_file
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_file`;
CREATE TABLE `cms_info_file` (
  `f_info_id` int(11) NOT NULL,
  `f_name` varchar(150) NOT NULL COMMENT '文件名称',
  `f_length` bigint(20) NOT NULL DEFAULT '0' COMMENT '文件长度',
  `f_file` varchar(255) NOT NULL COMMENT '文件地址',
  `f_index` int(11) NOT NULL DEFAULT '0' COMMENT '文件序号',
  `f_downloads` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  KEY `fk_cms_infofile_info` (`f_info_id`) USING BTREE,
  CONSTRAINT `fk_cms_infofile_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_file
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_image
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_image`;
CREATE TABLE `cms_info_image` (
  `f_info_id` int(11) NOT NULL,
  `f_name` varchar(150) DEFAULT NULL COMMENT '图片名称',
  `f_image` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `f_index` int(11) NOT NULL DEFAULT '0' COMMENT '图片序号',
  `f_text` mediumtext COMMENT '图片正文',
  KEY `fk_cms_infoimage_info` (`f_info_id`) USING BTREE,
  CONSTRAINT `fk_cms_infoimage_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_image
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_membergroup
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_membergroup`;
CREATE TABLE `cms_info_membergroup` (
  `f_membergroup_id` int(11) NOT NULL,
  `f_info_id` int(11) NOT NULL,
  `f_is_view_perm` char(1) NOT NULL DEFAULT '0' COMMENT '是否有浏览权限',
  KEY `fk_cms_infomgroup_info` (`f_info_id`) USING BTREE,
  KEY `fk_cms_infomgroup_mgroup` (`f_membergroup_id`) USING BTREE,
  CONSTRAINT `fk_cms_infomgroup_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infomgroup_mgroup` FOREIGN KEY (`f_membergroup_id`) REFERENCES `cms_member_group` (`f_membergroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_membergroup
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_node
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_node`;
CREATE TABLE `cms_info_node` (
  `f_info_id` int(11) NOT NULL COMMENT '文档',
  `f_node_id` int(11) NOT NULL COMMENT '栏目',
  `f_node_index` int(11) DEFAULT '0' COMMENT '栏目顺序',
  KEY `fk_cms_infonode_info` (`f_info_id`) USING BTREE,
  KEY `fk_cms_infonode_node` (`f_node_id`) USING BTREE,
  CONSTRAINT `fk_cms_infonode_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infonode_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_node
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_org
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_org`;
CREATE TABLE `cms_info_org` (
  `f_info_id` int(11) NOT NULL,
  `f_org_id` int(11) NOT NULL,
  `f_is_view_perm` char(1) NOT NULL DEFAULT '0' COMMENT '是否有浏览权限',
  KEY `fk_cms_infoorg_info` (`f_info_id`) USING BTREE,
  KEY `fk_cms_infoorg_org` (`f_org_id`) USING BTREE,
  CONSTRAINT `fk_cms_infoorg_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infoorg_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_org
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_special
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_special`;
CREATE TABLE `cms_info_special` (
  `f_info_id` int(11) NOT NULL COMMENT '文档',
  `f_special_id` int(11) NOT NULL COMMENT '专题',
  `f_special_index` int(11) DEFAULT '0' COMMENT '专题序号',
  KEY `fk_cms_infospecial_info` (`f_info_id`) USING BTREE,
  KEY `fk_cms_infospecial_special` (`f_special_id`) USING BTREE,
  CONSTRAINT `fk_cms_infospecial_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infospecial_special` FOREIGN KEY (`f_special_id`) REFERENCES `cms_special` (`f_special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_special
-- ----------------------------

-- ----------------------------
-- Table structure for cms_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `cms_info_tag`;
CREATE TABLE `cms_info_tag` (
  `f_info_id` int(11) NOT NULL COMMENT '文档',
  `f_tag_id` int(11) NOT NULL COMMENT 'tag',
  `f_tag_index` int(11) DEFAULT '0' COMMENT 'tag序号',
  KEY `fk_cms_infotag_info` (`f_info_id`) USING BTREE,
  KEY `fk_cms_infotag_tag` (`f_tag_id`) USING BTREE,
  CONSTRAINT `fk_cms_infotag_info` FOREIGN KEY (`f_info_id`) REFERENCES `cms_info` (`f_info_id`),
  CONSTRAINT `fk_cms_infotag_tag` FOREIGN KEY (`f_tag_id`) REFERENCES `cms_tag` (`f_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for cms_mail_inbox
-- ----------------------------
DROP TABLE IF EXISTS `cms_mail_inbox`;
CREATE TABLE `cms_mail_inbox` (
  `mailinbox_id_` int(11) NOT NULL,
  `mailoutbox_id_` int(11) NOT NULL,
  `mailtext_id_` int(11) NOT NULL,
  `sender_id_` int(11) DEFAULT NULL COMMENT '发件人',
  `receiver_id_` int(11) NOT NULL COMMENT '接收人',
  `receive_time_` datetime NOT NULL COMMENT '接收时间',
  `is_unread_` int(11) NOT NULL DEFAULT '1' COMMENT '是否未读',
  PRIMARY KEY (`mailinbox_id_`),
  KEY `fk_cms_mailinbox_outbox` (`mailoutbox_id_`) USING BTREE,
  KEY `fk_cms_mailinbox_receiver` (`receiver_id_`) USING BTREE,
  KEY `fk_cms_mailinbox_sender` (`sender_id_`) USING BTREE,
  KEY `fk_cms_mailinbox_text` (`mailtext_id_`) USING BTREE,
  CONSTRAINT `fk_cms_mailinbox_outbox` FOREIGN KEY (`mailoutbox_id_`) REFERENCES `cms_mail_outbox` (`mailoutbox_id_`),
  CONSTRAINT `fk_cms_mailinbox_receiver` FOREIGN KEY (`receiver_id_`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_mailinbox_sender` FOREIGN KEY (`sender_id_`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_mailinbox_text` FOREIGN KEY (`mailtext_id_`) REFERENCES `cms_mail_text` (`mailtext_id_`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_mail_inbox
-- ----------------------------

-- ----------------------------
-- Table structure for cms_mail_outbox
-- ----------------------------
DROP TABLE IF EXISTS `cms_mail_outbox`;
CREATE TABLE `cms_mail_outbox` (
  `mailoutbox_id_` int(11) NOT NULL,
  `mailtext_id_` int(11) NOT NULL,
  `sender_id_` int(11) DEFAULT NULL COMMENT '发送人',
  `send_time_` datetime NOT NULL COMMENT '发送时间',
  `receiver_number_` int(11) NOT NULL COMMENT '接收人数',
  `read_number_` int(11) NOT NULL COMMENT '已读人数',
  PRIMARY KEY (`mailoutbox_id_`),
  KEY `fk_cms_mailoutbox_sender` (`sender_id_`) USING BTREE,
  KEY `fk_cms_mailoutbox_text` (`mailtext_id_`) USING BTREE,
  CONSTRAINT `fk_cms_mailoutbox_sender` FOREIGN KEY (`sender_id_`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_mailoutbox_text` FOREIGN KEY (`mailtext_id_`) REFERENCES `cms_mail_text` (`mailtext_id_`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_mail_outbox
-- ----------------------------

-- ----------------------------
-- Table structure for cms_mail_text
-- ----------------------------
DROP TABLE IF EXISTS `cms_mail_text`;
CREATE TABLE `cms_mail_text` (
  `mailtext_id_` int(11) NOT NULL,
  `subject_` varchar(150) DEFAULT NULL COMMENT '标题',
  `text_` mediumtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`mailtext_id_`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_mail_text
-- ----------------------------

-- ----------------------------
-- Table structure for cms_member_group
-- ----------------------------
DROP TABLE IF EXISTS `cms_member_group`;
CREATE TABLE `cms_member_group` (
  `f_membergroup_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `f_description` varchar(255) DEFAULT NULL,
  `f_ip` mediumtext COMMENT 'IP',
  `f_type` int(11) NOT NULL DEFAULT '0' COMMENT '类型(0:普通组,1:游客组,2:IP组,3:待验证组)',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_membergroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_member_group
-- ----------------------------
INSERT INTO `cms_member_group` VALUES ('0', '游客组', null, null, '1', '0');
INSERT INTO `cms_member_group` VALUES ('1', '普通会员', null, null, '0', '2147483647');

-- ----------------------------
-- Table structure for cms_message
-- ----------------------------
DROP TABLE IF EXISTS `cms_message`;
CREATE TABLE `cms_message` (
  `message_id_` int(11) NOT NULL COMMENT '私信',
  `sender_id_` int(11) NOT NULL COMMENT '发送人',
  `receiver_id_` int(11) NOT NULL COMMENT '收件人',
  `send_time_` datetime NOT NULL COMMENT '发送时间',
  `deletion_flag_` int(11) NOT NULL DEFAULT '0' COMMENT '删除标志(0:正常;1:发件人删除;2:收件人删除;)',
  `is_unread_` int(11) NOT NULL DEFAULT '1' COMMENT '是否未读',
  PRIMARY KEY (`message_id_`),
  KEY `fk_cms_message_receiver` (`receiver_id_`) USING BTREE,
  KEY `fk_cms_message_sender` (`sender_id_`) USING BTREE,
  CONSTRAINT `fk_cms_message_receiver` FOREIGN KEY (`receiver_id_`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_message_sender` FOREIGN KEY (`sender_id_`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_message
-- ----------------------------

-- ----------------------------
-- Table structure for cms_message_text
-- ----------------------------
DROP TABLE IF EXISTS `cms_message_text`;
CREATE TABLE `cms_message_text` (
  `message_id_` int(11) NOT NULL COMMENT '私信',
  `subject_` varchar(150) DEFAULT NULL COMMENT '标题',
  `text_` mediumtext NOT NULL COMMENT '内容',
  PRIMARY KEY (`message_id_`),
  CONSTRAINT `fk_cms_messagetext_message` FOREIGN KEY (`message_id_`) REFERENCES `cms_message` (`message_id_`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_message_text
-- ----------------------------

-- ----------------------------
-- Table structure for cms_model
-- ----------------------------
DROP TABLE IF EXISTS `cms_model`;
CREATE TABLE `cms_model` (
  `f_model_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_type` varchar(100) NOT NULL COMMENT '类型(info:文档,node:栏目,node_home:首页;special:专题)',
  `f_name` varchar(50) NOT NULL COMMENT '名称',
  `f_number` varchar(100) DEFAULT NULL COMMENT '代码',
  `f_seq` int(11) NOT NULL DEFAULT '10' COMMENT '顺序',
  PRIMARY KEY (`f_model_id`),
  KEY `fk_cms_model_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_model_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_model
-- ----------------------------
INSERT INTO `cms_model` VALUES ('1', '1', 'node_home', '首页', null, '0');
INSERT INTO `cms_model` VALUES ('2', '1', 'info', '新闻', null, '0');
INSERT INTO `cms_model` VALUES ('3', '1', 'node', '新闻', null, '0');
INSERT INTO `cms_model` VALUES ('4', '1', 'node', '图集', null, '1');
INSERT INTO `cms_model` VALUES ('5', '1', 'info', '图集', null, '1');
INSERT INTO `cms_model` VALUES ('6', '1', 'node', '下载', null, '2');
INSERT INTO `cms_model` VALUES ('7', '1', 'info', '下载', null, '2');
INSERT INTO `cms_model` VALUES ('8', '1', 'node', '视频', null, '3');
INSERT INTO `cms_model` VALUES ('9', '1', 'info', '视频(电影)', null, '3');
INSERT INTO `cms_model` VALUES ('10', '1', 'node', '产品', null, '4');
INSERT INTO `cms_model` VALUES ('11', '1', 'info', '产品(服饰/内衣)', null, '7');
INSERT INTO `cms_model` VALUES ('12', '1', 'site', '站点模型', null, '2147483647');
INSERT INTO `cms_model` VALUES ('13', '1', 'node', '招聘', null, '6');
INSERT INTO `cms_model` VALUES ('15', '1', 'global', '系统', null, '2147483647');
INSERT INTO `cms_model` VALUES ('16', '1', 'node', '转向链接', null, '7');
INSERT INTO `cms_model` VALUES ('17', '1', 'special', '专题', null, '10');
INSERT INTO `cms_model` VALUES ('19', '1', 'node', '文库', 'doc', '5');
INSERT INTO `cms_model` VALUES ('20', '1', 'info', '文库', 'doc', '10');
INSERT INTO `cms_model` VALUES ('21', '1', 'info', '招聘', null, '11');
INSERT INTO `cms_model` VALUES ('23', '1', 'info', '视频(综艺)', null, '4');
INSERT INTO `cms_model` VALUES ('24', '1', 'info', '产品(手机数码)', null, '5');
INSERT INTO `cms_model` VALUES ('25', '1', 'info', '产品(电脑办公)', null, '6');
INSERT INTO `cms_model` VALUES ('26', '1', 'info', '产品(图书/音像)', null, '8');
INSERT INTO `cms_model` VALUES ('27', '1', 'info', '产品(家用电器)', null, '9');

-- ----------------------------
-- Table structure for cms_model_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_model_custom`;
CREATE TABLE `cms_model_custom` (
  `f_model_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_modelcustom_model` (`f_model_id`) USING BTREE,
  CONSTRAINT `fk_cms_modelcustom_model` FOREIGN KEY (`f_model_id`) REFERENCES `cms_model` (`f_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_model_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_model_field
-- ----------------------------
DROP TABLE IF EXISTS `cms_model_field`;
CREATE TABLE `cms_model_field` (
  `f_modefiel_id` int(11) NOT NULL,
  `f_model_id` int(11) NOT NULL COMMENT '模型',
  `f_type` int(11) NOT NULL COMMENT '输入类型',
  `f_inner_type` int(11) NOT NULL DEFAULT '0' COMMENT '内部类型(0:用户自定义字段;1:系统定义字段;2:预留大文本字段;3:预留可查询字段)',
  `f_label` varchar(50) NOT NULL COMMENT '字段标签',
  `f_name` varchar(50) NOT NULL COMMENT '字段名称',
  `f_prompt` varchar(255) DEFAULT NULL COMMENT '提示信息',
  `f_def_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `f_is_required` char(1) NOT NULL DEFAULT '0' COMMENT '是否必填项',
  `f_seq` int(11) NOT NULL DEFAULT '10' COMMENT '顺序',
  `f_is_dbl_column` char(1) NOT NULL DEFAULT '0' COMMENT '是否双列布局',
  `f_is_disabled` char(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  PRIMARY KEY (`f_modefiel_id`),
  KEY `fk_cms_modefiel_model` (`f_model_id`) USING BTREE,
  CONSTRAINT `fk_cms_modefiel_model` FOREIGN KEY (`f_model_id`) REFERENCES `cms_model` (`f_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_model_field
-- ----------------------------
INSERT INTO `cms_model_field` VALUES ('1', '1', '1', '2', '名称', 'name', null, null, '0', '0', '1', '0');
INSERT INTO `cms_model_field` VALUES ('2', '1', '1', '2', '编码', 'number', null, null, '0', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('5', '1', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('6', '1', '5', '2', '文档模型', 'infoModel', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('7', '1', '1', '2', '栏目页模板', 'nodeTemplate', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('8', '1', '1', '2', '文档页模板', 'infoTemplate', null, null, '0', '5', '1', '0');
INSERT INTO `cms_model_field` VALUES ('9', '1', '1', '2', '栏目页静态化', 'generateNode', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('10', '1', '1', '2', '文档页静态化', 'generateInfo', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('11', '1', '5', '2', '静态化方式', 'staticMethod', null, null, '0', '8', '1', '0');
INSERT INTO `cms_model_field` VALUES ('12', '1', '1', '2', '静态化页数', 'staticPage', null, '1', '1', '9', '1', '0');
INSERT INTO `cms_model_field` VALUES ('199', '4', '1', '2', '所属栏目', 'parent', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('200', '4', '1', '2', '名称', 'name', null, null, '0', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('201', '4', '1', '2', '编码', 'number', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('202', '4', '1', '2', '转向链接', 'link', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('203', '4', '5', '2', '新窗口打开', 'newWindow', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('216', '4', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '5', '1', '0');
INSERT INTO `cms_model_field` VALUES ('217', '4', '5', '2', '文档模型', 'infoModel', null, null, '0', '6', '1', '0');
INSERT INTO `cms_model_field` VALUES ('235', '2', '1', '2', '栏目', 'node', null, null, '0', '0', '1', '0');
INSERT INTO `cms_model_field` VALUES ('237', '2', '1', '2', '专题', 'specials', null, null, '0', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('239', '2', '1', '2', '颜色', 'color', null, null, '0', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('242', '2', '1', '2', '关键词', 'tagKeywords', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('243', '2', '6', '2', '描述', 'metaDescription', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('246', '2', '1', '2', '优先级', 'priority', null, null, '0', '7', '1', '0');
INSERT INTO `cms_model_field` VALUES ('247', '2', '2', '2', '发布时间', 'publishDate', null, null, '0', '8', '1', '0');
INSERT INTO `cms_model_field` VALUES ('248', '2', '1', '2', '来源', 'source', null, null, '0', '9', '1', '0');
INSERT INTO `cms_model_field` VALUES ('249', '2', '1', '2', '作者', 'author', null, null, '0', '10', '1', '0');
INSERT INTO `cms_model_field` VALUES ('250', '2', '1', '2', '属性', 'attributes', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('255', '2', '50', '2', '正文', 'text', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('256', '3', '1', '2', '所属栏目', 'parent', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('258', '3', '1', '2', '编码', 'number', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('259', '3', '1', '2', '转向链接', 'link', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('260', '3', '5', '2', '新窗口打开', 'newWindow', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('261', '3', '1', '2', '关键词', 'metaKeywords', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('262', '3', '1', '2', '描述', 'metaDescription', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('263', '3', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '8', '1', '0');
INSERT INTO `cms_model_field` VALUES ('264', '3', '5', '2', '文档模型', 'infoModel', null, null, '0', '9', '1', '0');
INSERT INTO `cms_model_field` VALUES ('265', '3', '1', '2', '栏目页模板', 'nodeTemplate', null, null, '0', '10', '1', '0');
INSERT INTO `cms_model_field` VALUES ('266', '3', '1', '2', '文档页模板', 'infoTemplate', null, null, '0', '11', '1', '0');
INSERT INTO `cms_model_field` VALUES ('267', '3', '1', '2', '栏目页静态化', 'generateNode', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('268', '3', '1', '2', '文档页静态化', 'generateInfo', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('269', '3', '5', '2', '静态化方式', 'staticMethod', null, null, '0', '14', '1', '0');
INSERT INTO `cms_model_field` VALUES ('270', '3', '1', '2', '静态化页数', 'staticPage', null, '1', '0', '15', '1', '0');
INSERT INTO `cms_model_field` VALUES ('273', '1', '1', '2', '关键词', 'metaKeywords', null, null, '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('274', '1', '1', '2', '描述', 'metaDescription', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('275', '5', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('276', '5', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('278', '5', '2', '2', '发布时间', 'publishDate', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('279', '5', '51', '2', '图片集', 'images', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('281', '5', '7', '2', '标题图', 'smallImage', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('282', '6', '1', '2', '所属栏目', 'parent', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('283', '6', '1', '2', '名称', 'name', null, null, '0', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('284', '6', '1', '2', '编码', 'number', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('287', '6', '1', '2', '转向链接', 'link', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('288', '6', '5', '2', '新窗口打开', 'newWindow', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('289', '6', '1', '2', '关键词', 'metaKeywords', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('290', '6', '1', '2', '描述', 'metaDescription', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('292', '6', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '7', '1', '0');
INSERT INTO `cms_model_field` VALUES ('293', '6', '5', '2', '文档模型', 'infoModel', null, null, '0', '8', '1', '0');
INSERT INTO `cms_model_field` VALUES ('294', '6', '1', '2', '栏目页模板', 'nodeTemplate', null, null, '0', '9', '1', '0');
INSERT INTO `cms_model_field` VALUES ('295', '6', '1', '2', '文档页模板', 'infoTemplate', null, null, '0', '10', '1', '0');
INSERT INTO `cms_model_field` VALUES ('296', '6', '1', '2', '栏目页静态化', 'generateNode', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('297', '6', '1', '2', '文档页静态化', 'generateInfo', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('298', '6', '5', '2', '静态化方式', 'staticMethod', null, null, '0', '13', '1', '0');
INSERT INTO `cms_model_field` VALUES ('299', '6', '1', '2', '静态化页数', 'staticPage', null, '1', '0', '14', '1', '0');
INSERT INTO `cms_model_field` VALUES ('303', '7', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('304', '7', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('305', '7', '50', '2', '软件介绍', 'text', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('306', '7', '4', '0', '软件类型', 'type', null, '国产软件', '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('307', '7', '4', '0', '授权方式', 'license', null, '免费软件', '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('308', '7', '4', '0', '界面语言', 'language', null, '简体中文', '0', '5', '1', '0');
INSERT INTO `cms_model_field` VALUES ('311', '7', '9', '2', '下载文件', 'file', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('312', '8', '1', '2', '所属栏目', 'parent', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('313', '8', '1', '2', '名称', 'name', null, null, '0', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('314', '8', '1', '2', '编码', 'number', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('315', '8', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('316', '8', '5', '2', '文档模型', 'infoModel', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('318', '9', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('319', '9', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('320', '9', '2', '2', '发布时间', 'publishDate', null, null, '0', '7', '1', '0');
INSERT INTO `cms_model_field` VALUES ('321', '9', '8', '2', '视频', 'video', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('322', '9', '7', '2', '标题图', 'smallImage', null, null, '0', '9', '0', '0');
INSERT INTO `cms_model_field` VALUES ('323', '10', '1', '2', '所属栏目', 'parent', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('324', '10', '1', '2', '名称', 'name', null, null, '0', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('325', '10', '1', '2', '编码', 'number', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('326', '11', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('327', '11', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('328', '11', '7', '2', '标题图', 'smallImage', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('329', '10', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('330', '10', '5', '2', '文档模型', 'infoModel', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('331', '11', '1', '0', '优惠价', 'price', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('332', '11', '1', '0', '市场价', 'marketPrice', null, null, '1', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('334', '11', '4', '0', '商品库存', 'stock', null, '有货', '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('335', '11', '50', '1', '商品介绍', 'introduce', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('336', '11', '50', '1', '规格参数', 'specification', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('337', '11', '50', '1', '包装清单', 'packingList', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('338', '11', '50', '1', '售后服务', 'services', null, null, '0', '14', '0', '0');
INSERT INTO `cms_model_field` VALUES ('339', '7', '3', '0', '运行环境', 'system', null, 'winxp,win7,win8', '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('340', '7', '7', '2', '标题图', 'smallImage', null, null, '0', '9', '0', '0');
INSERT INTO `cms_model_field` VALUES ('343', '3', '5', '2', '审核流程', 'workflow', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('344', '12', '1', '0', '公司名称', 'company', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('345', '12', '1', '0', '备案号', 'icp', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('346', '13', '1', '2', '所属栏目', 'parent', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('347', '13', '1', '2', '名称', 'name', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('348', '13', '1', '2', '编码', 'number', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('349', '13', '1', '2', '关键词', 'metaKeywords', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('350', '13', '1', '2', '描述', 'metaDescription', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('351', '13', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('352', '13', '5', '2', '文档模型', 'infoModel', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('364', '13', '3', '2', '浏览权限', 'viewGroups', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('365', '1', '3', '2', '浏览权限', 'viewGroups', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('366', '15', '1', '0', '版权信息', 'poweredby', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('367', '16', '1', '2', '所属栏目', 'parent', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('368', '16', '1', '2', '名称', 'name', null, null, '0', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('369', '16', '1', '2', '转向链接', 'link', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('370', '16', '5', '2', '新窗口打开', 'newWindow', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('371', '16', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('372', '17', '1', '2', '标题', 'title', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('373', '17', '1', '2', '关键词', 'metaKeywords', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('374', '17', '6', '2', '描述', 'metaDescription', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('375', '17', '1', '2', '类别', 'category', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('376', '17', '2', '2', '创建日期', 'creationDate', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('377', '17', '5', '2', '模型', 'model', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('378', '17', '1', '2', '独立模版', 'specialTemplate', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('379', '17', '4', '2', '推荐', 'recommend', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('380', '17', '1', '2', '浏览次数', 'views', null, null, '0', '2147483647', '1', '0');
INSERT INTO `cms_model_field` VALUES ('381', '17', '7', '2', '小图', 'smallImage', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('382', '17', '7', '2', '大图', 'largeImage', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('383', '17', '52', '2', '文件集', 'files', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('384', '17', '8', '2', '视频', 'video', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('385', '17', '51', '2', '图片集', 'images', null, null, '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('386', '5', '1', '2', '属性', 'attributes', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('387', '5', '1', '2', '关键词', 'tagKeywords', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('388', '5', '6', '2', '描述', 'metaDescription', null, null, '0', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('389', '11', '2', '2', '发布时间', 'publishDate', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('390', '7', '1', '2', '完整标题', 'fullTitle', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('392', '2', '7', '2', '标题图', 'smallImage', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('393', '3', '1', '2', '名称', 'name', null, null, '1', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('394', '2', '1', '2', '标题', 'title', null, null, '1', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('395', '4', '5', '2', '审核流程', 'workflow', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('396', '2', '6', '2', '完整标题', 'fullTitle', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('397', '9', '1', '2', '属性', 'attributes', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('399', '11', '1', '2', '属性', 'attributes', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('400', '7', '1', '2', '属性', 'attributes', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('401', '19', '1', '2', '所属栏目', 'parent', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('402', '19', '1', '2', '名称', 'name', null, null, '1', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('403', '19', '1', '2', '编码', 'number', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('404', '19', '1', '2', '转向链接', 'link', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('405', '19', '5', '2', '新窗口打开', 'newWindow', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('406', '19', '1', '2', '关键词', 'metaKeywords', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('407', '19', '1', '2', '描述', 'metaDescription', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('408', '19', '5', '2', '审核流程', 'workflow', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('409', '19', '5', '2', '栏目模型', 'nodeModel', null, null, '0', '8', '1', '0');
INSERT INTO `cms_model_field` VALUES ('410', '19', '5', '2', '文档模型', 'infoModel', null, null, '0', '9', '1', '0');
INSERT INTO `cms_model_field` VALUES ('411', '19', '1', '2', '栏目页模板', 'nodeTemplate', null, null, '0', '10', '1', '0');
INSERT INTO `cms_model_field` VALUES ('412', '19', '1', '2', '文档页模板', 'infoTemplate', null, null, '0', '11', '1', '0');
INSERT INTO `cms_model_field` VALUES ('413', '19', '1', '2', '栏目页静态化', 'generateNode', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('414', '19', '1', '2', '文档页静态化', 'generateInfo', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('415', '19', '5', '2', '静态化方式', 'staticMethod', null, null, '0', '14', '1', '0');
INSERT INTO `cms_model_field` VALUES ('416', '19', '1', '2', '静态化页数', 'staticPage', null, '1', '0', '15', '1', '0');
INSERT INTO `cms_model_field` VALUES ('417', '20', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('419', '20', '1', '2', '标题', 'title', null, null, '1', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('425', '20', '2', '2', '发布时间', 'publishDate', null, null, '0', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('432', '21', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('434', '21', '1', '2', '标题', 'title', null, null, '1', '1', '1', '0');
INSERT INTO `cms_model_field` VALUES ('440', '21', '2', '2', '发布时间', 'publishDate', null, null, '0', '2', '1', '0');
INSERT INTO `cms_model_field` VALUES ('453', '20', '1', '2', '关键词', 'tagKeywords', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('454', '20', '6', '2', '描述', 'metaDescription', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('455', '20', '10', '2', '文库', 'doc', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('456', '21', '1', '0', '公司名称', 'company', null, null, '0', '3', '1', '0');
INSERT INTO `cms_model_field` VALUES ('457', '21', '1', '0', '部门名称', 'dept', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('458', '21', '1', '0', '招聘人数', 'number', null, null, '0', '5', '1', '0');
INSERT INTO `cms_model_field` VALUES ('459', '21', '1', '0', '薪酬待遇', 'salary', null, null, '0', '6', '1', '0');
INSERT INTO `cms_model_field` VALUES ('460', '21', '1', '0', '工作地点', 'location', null, null, '0', '9', '1', '0');
INSERT INTO `cms_model_field` VALUES ('461', '21', '6', '0', '岗位职责', 'responsibilities', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('462', '21', '6', '0', '岗位要求', 'qualifications', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('463', '21', '1', '0', '工作经验', 'experience', null, null, '0', '7', '1', '0');
INSERT INTO `cms_model_field` VALUES ('464', '21', '1', '0', '最低学历', 'education', null, null, '0', '8', '1', '0');
INSERT INTO `cms_model_field` VALUES ('465', '21', '5', '0', '工作性质', 'jobtype', null, null, '0', '10', '1', '0');
INSERT INTO `cms_model_field` VALUES ('466', '9', '6', '2', '完整标题', 'fullTitle', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('467', '9', '101', '3', '地区', 'p1', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('468', '9', '101', '3', '类型', 'p2', null, null, '0', '5', '1', '0');
INSERT INTO `cms_model_field` VALUES ('469', '9', '101', '3', '年代', 'p3', null, null, '0', '6', '1', '0');
INSERT INTO `cms_model_field` VALUES ('480', '23', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('481', '23', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('482', '23', '6', '2', '完整标题', 'fullTitle', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('483', '23', '101', '3', '地区', 'p1', null, null, '0', '4', '1', '0');
INSERT INTO `cms_model_field` VALUES ('484', '23', '101', '3', '分类', 'p2', null, null, '0', '5', '1', '0');
INSERT INTO `cms_model_field` VALUES ('487', '23', '1', '2', '属性', 'attributes', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('488', '23', '7', '2', '标题图', 'smallImage', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('489', '23', '8', '2', '视频', 'video', null, null, '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('490', '23', '2', '2', '发布时间', 'publishDate', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('491', '9', '1', '2', '关键词', 'tagKeywords', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('492', '23', '1', '2', '关键词', 'tagKeywords', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('493', '9', '1', '0', 'flash地址', 'flashaddr', null, null, '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('494', '23', '1', '0', 'flash地址', 'flashaddr', null, null, '0', '9', '0', '0');
INSERT INTO `cms_model_field` VALUES ('495', '11', '101', '3', '面料', 'p1', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('496', '11', '101', '3', '适用季节', 'p2', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('498', '24', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('499', '24', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('500', '24', '2', '2', '发布时间', 'publishDate', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('501', '24', '1', '0', '优惠价', 'price', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('502', '24', '1', '0', '市场价', 'marketPrice', null, null, '1', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('503', '24', '101', '3', '有效像素', 'p1', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('504', '24', '101', '3', '机身颜色', 'p2', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('505', '24', '1', '2', '属性', 'attributes', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('506', '24', '7', '2', '标题图', 'smallImage', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('508', '24', '4', '0', '商品库存', 'stock', null, '有货', '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('509', '24', '50', '1', '商品介绍', 'introduce', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('510', '24', '50', '1', '规格参数', 'specification', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('511', '24', '50', '1', '包装清单', 'packingList', null, null, '0', '14', '0', '0');
INSERT INTO `cms_model_field` VALUES ('512', '24', '50', '1', '售后服务', 'services', null, null, '0', '15', '0', '0');
INSERT INTO `cms_model_field` VALUES ('513', '25', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('514', '25', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('515', '25', '2', '2', '发布时间', 'publishDate', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('516', '25', '1', '0', '优惠价', 'price', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('517', '25', '1', '0', '市场价', 'marketPrice', null, null, '1', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('518', '25', '101', '3', '尺寸', 'p1', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('519', '25', '101', '3', '处理器', 'p2', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('520', '25', '1', '2', '属性', 'attributes', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('521', '25', '7', '2', '标题图', 'smallImage', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('523', '25', '4', '0', '商品库存', 'stock', null, '有货', '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('524', '25', '50', '1', '商品介绍', 'introduce', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('525', '25', '50', '1', '规格参数', 'specification', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('526', '25', '50', '1', '包装清单', 'packingList', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('527', '25', '50', '1', '售后服务', 'services', null, null, '0', '14', '0', '0');
INSERT INTO `cms_model_field` VALUES ('528', '26', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('529', '26', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('530', '26', '2', '2', '发布时间', 'publishDate', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('531', '26', '1', '0', '优惠价', 'price', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('532', '26', '1', '0', '市场价', 'marketPrice', null, null, '1', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('533', '26', '101', '3', '类别', 'p1', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('535', '26', '1', '2', '属性', 'attributes', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('536', '26', '7', '2', '标题图', 'smallImage', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('538', '26', '4', '0', '商品库存', 'stock', null, '有货', '0', '9', '0', '0');
INSERT INTO `cms_model_field` VALUES ('539', '26', '50', '1', '商品介绍', 'introduce', null, null, '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('540', '26', '50', '1', '规格参数', 'specification', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('541', '26', '50', '1', '包装清单', 'packingList', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('542', '26', '50', '1', '售后服务', 'services', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('543', '27', '1', '2', '栏目', 'node', null, null, '0', '0', '0', '0');
INSERT INTO `cms_model_field` VALUES ('544', '27', '1', '2', '标题', 'title', null, null, '0', '1', '0', '0');
INSERT INTO `cms_model_field` VALUES ('545', '27', '2', '2', '发布时间', 'publishDate', null, null, '0', '2', '0', '0');
INSERT INTO `cms_model_field` VALUES ('546', '27', '1', '0', '优惠价', 'price', null, null, '0', '3', '0', '0');
INSERT INTO `cms_model_field` VALUES ('547', '27', '1', '0', '市场价', 'marketPrice', null, null, '1', '4', '0', '0');
INSERT INTO `cms_model_field` VALUES ('548', '27', '101', '3', '尺寸', 'p1', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('549', '27', '101', '3', '分辨率', 'p2', null, null, '0', '6', '0', '0');
INSERT INTO `cms_model_field` VALUES ('550', '27', '1', '2', '属性', 'attributes', null, null, '0', '7', '0', '0');
INSERT INTO `cms_model_field` VALUES ('551', '27', '7', '2', '标题图', 'smallImage', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('553', '27', '4', '0', '商品库存', 'stock', null, '有货', '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('554', '27', '50', '1', '商品介绍', 'introduce', null, null, '0', '11', '0', '0');
INSERT INTO `cms_model_field` VALUES ('555', '27', '50', '1', '规格参数', 'specification', null, null, '0', '12', '0', '0');
INSERT INTO `cms_model_field` VALUES ('556', '27', '50', '1', '包装清单', 'packingList', null, null, '0', '13', '0', '0');
INSERT INTO `cms_model_field` VALUES ('557', '27', '50', '1', '售后服务', 'services', null, null, '0', '14', '0', '0');
INSERT INTO `cms_model_field` VALUES ('558', '24', '7', '2', '正文图', 'largeImage', null, null, '0', '9', '0', '0');
INSERT INTO `cms_model_field` VALUES ('559', '7', '5', '0', '推荐星级', 'star', null, '★★★★★', '0', '6', '1', '0');
INSERT INTO `cms_model_field` VALUES ('560', '7', '7', '2', '正文图', 'largeImage', null, null, '0', '10', '0', '0');
INSERT INTO `cms_model_field` VALUES ('561', '20', '7', '2', '标题图', 'smallImage', null, null, '0', '5', '0', '0');
INSERT INTO `cms_model_field` VALUES ('562', '15', '5', '0', '第三方登录', 'oauth', null, '0', '0', '2147483647', '0', '0');
INSERT INTO `cms_model_field` VALUES ('563', '25', '7', '2', '正文图', 'largeImage', null, null, '0', '9', '0', '0');
INSERT INTO `cms_model_field` VALUES ('564', '11', '7', '2', '正文图', 'largeImage', null, null, '0', '9', '0', '0');
INSERT INTO `cms_model_field` VALUES ('565', '26', '7', '2', '正文图', 'largeImage', null, null, '0', '8', '0', '0');
INSERT INTO `cms_model_field` VALUES ('566', '27', '7', '2', '正文图', 'largeImage', null, null, '0', '9', '0', '0');

-- ----------------------------
-- Table structure for cms_model_field_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_model_field_custom`;
CREATE TABLE `cms_model_field_custom` (
  `f_modefiel_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_modfiecus_modefiel` (`f_modefiel_id`) USING BTREE,
  CONSTRAINT `fk_cms_modfiecus_modefiel` FOREIGN KEY (`f_modefiel_id`) REFERENCES `cms_model_field` (`f_modefiel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_model_field_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_node
-- ----------------------------
DROP TABLE IF EXISTS `cms_node`;
CREATE TABLE `cms_node` (
  `f_node_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_parent_id` int(11) DEFAULT NULL COMMENT '栏目点',
  `f_creator_id` int(11) NOT NULL COMMENT '创建者',
  `f_node_model_id` int(11) NOT NULL COMMENT '栏目模型',
  `f_workflow_id` int(11) DEFAULT NULL COMMENT '流程',
  `f_info_model_id` int(11) DEFAULT NULL COMMENT '文档模型',
  `f_number` varchar(100) DEFAULT NULL COMMENT '代码',
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_tree_number` varchar(100) NOT NULL DEFAULT '0000' COMMENT '树编码',
  `f_tree_level` int(11) NOT NULL DEFAULT '0' COMMENT '树级别',
  `f_tree_max` varchar(10) NOT NULL DEFAULT '0000' COMMENT '树子节点最大编码',
  `f_creation_date` datetime NOT NULL COMMENT '创建时间',
  `f_refers` int(11) NOT NULL DEFAULT '0' COMMENT '文档数量',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_is_real_node` char(1) NOT NULL DEFAULT '1' COMMENT '是否真实栏目',
  `f_is_hidden` char(1) NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `f_html_status` char(1) NOT NULL DEFAULT '0' COMMENT 'HTML状态(0:未开启,1:待生成,2:待更新,3:已生成)',
  `f_p0` tinyint(4) DEFAULT NULL COMMENT '自定义0',
  `f_p1` tinyint(4) DEFAULT NULL COMMENT '自定义1',
  `f_p2` tinyint(4) DEFAULT NULL COMMENT '自定义2',
  `f_p3` tinyint(4) DEFAULT NULL COMMENT '自定义3',
  `f_p4` tinyint(4) DEFAULT NULL COMMENT '自定义4',
  `f_p5` tinyint(4) DEFAULT NULL COMMENT '自定义5',
  `f_p6` tinyint(4) DEFAULT NULL COMMENT '自定义6',
  PRIMARY KEY (`f_node_id`),
  KEY `fk_cms_node_model_info` (`f_info_model_id`) USING BTREE,
  KEY `fk_cms_node_model_node` (`f_node_model_id`) USING BTREE,
  KEY `fk_cms_node_parent` (`f_parent_id`) USING BTREE,
  KEY `fk_cms_node_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_node_user_creator` (`f_creator_id`) USING BTREE,
  KEY `fk_cms_node_workflow` (`f_workflow_id`) USING BTREE,
  CONSTRAINT `fk_cms_node_model_info` FOREIGN KEY (`f_info_model_id`) REFERENCES `cms_model` (`f_model_id`),
  CONSTRAINT `fk_cms_node_model_node` FOREIGN KEY (`f_node_model_id`) REFERENCES `cms_model` (`f_model_id`),
  CONSTRAINT `fk_cms_node_parent` FOREIGN KEY (`f_parent_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_node_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_node_user_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_node_workflow` FOREIGN KEY (`f_workflow_id`) REFERENCES `cms_workflow` (`f_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node
-- ----------------------------
INSERT INTO `cms_node` VALUES ('1', '1', null, '1', '1', null, '2', 'index', '首页', '0000', '0', '000a', '2013-02-21 20:59:27', '-43', '140', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('36', '1', '1', '1', '3', null, '2', 'news', '新闻', '0000-0000', '1', '0005', '2013-03-04 22:18:36', '-9', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('38', '1', '36', '1', '3', null, '2', 'yule', '娱乐', '0000-0000-0003', '2', '0000', '2013-03-04 22:18:42', '-7', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('40', '1', '36', '1', '3', null, '2', 'sport', '体育', '0000-0000-0004', '2', '0000', '2013-03-18 01:27:48', '-2', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('42', '1', '36', '1', '3', null, '2', 'domestic', '国内', '0000-0000-0000', '2', '0001', '2013-03-18 01:30:03', '-1', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('44', '1', '36', '1', '3', null, '2', null, '国际', '0000-0000-0001', '2', '0000', '2013-03-18 01:33:48', '-19', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('48', '1', '1', '1', '4', null, '5', 'photo', '图片', '0000-0001', '1', '0003', '2013-08-06 02:11:53', '2', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('49', '1', '1', '1', '6', null, '7', 'download', '下载', '0000-0004', '1', '0003', '2013-08-06 08:45:34', '1', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('51', '1', '1', '1', '8', null, '9', 'video', '视频', '0000-0002', '1', '0003', '2013-08-08 01:42:51', '0', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('52', '1', '1', '1', '10', null, '11', 'product', '产品', '0000-0003', '1', '0005', '2013-08-08 05:56:39', '1', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('67', '1', '1', '1', '16', null, null, 'guestbook', '留言', '0000-0008', '1', '0000', '2013-08-09 08:44:10', '0', '0', '0', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('68', '1', '1', '1', '16', null, null, 'bbs', '论坛', '0000-0009', '1', '0000', '2013-08-14 06:41:58', '0', '0', '0', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('69', '1', '1', '1', '13', null, '21', 'jobs', '招聘', '0000-0007', '1', '0000', '2014-03-18 14:13:23', '5', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('74', '1', '1', '1', '16', null, null, null, '专题', '0000-0006', '1', '0000', '2014-03-26 11:56:45', '0', '0', '0', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('77', '1', '49', '1', '6', null, '7', null, '媒体软件', '0000-0004-0000', '2', '0000', '2014-04-01 16:58:31', '2', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('78', '1', '49', '1', '6', null, '7', null, '网络软件', '0000-0004-0001', '2', '0000', '2014-04-01 16:59:19', '3', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('79', '1', '49', '1', '6', null, '7', null, '系统工具', '0000-0004-0002', '2', '0000', '2014-04-01 16:59:24', '4', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('80', '1', '51', '1', '8', null, '9', null, '电影', '0000-0002-0000', '2', '0000', '2014-04-02 16:54:36', '4', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('81', '1', '51', '1', '8', null, '9', null, '电视剧', '0000-0002-0001', '2', '0000', '2014-04-02 16:54:42', '4', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('82', '1', '51', '1', '8', null, '23', null, '综艺', '0000-0002-0002', '2', '0000', '2014-04-02 16:56:04', '6', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('83', '1', '52', '1', '10', null, '24', null, '手机/数码', '0000-0003-0000', '2', '0000', '2014-04-02 16:59:26', '3', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('84', '1', '52', '1', '10', null, '25', null, '电脑办公', '0000-0003-0001', '2', '0000', '2014-04-02 17:02:14', '2', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('85', '1', '52', '1', '10', null, '11', null, '服饰/内衣', '0000-0003-0002', '2', '0000', '2014-04-02 17:02:26', '1', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('87', '1', '48', '1', '4', null, '5', null, '自然景观', '0000-0001-0002', '2', '0000', '2014-06-01 18:54:54', '2', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('88', '1', '48', '1', '4', null, '5', null, '人物图库', '0000-0001-0000', '2', '0000', '2014-06-01 18:55:10', '4', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('90', '1', '48', '1', '4', null, '5', null, '旅游摄影', '0000-0001-0001', '2', '0000', '2014-06-01 18:58:27', '2', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('92', '1', '1', '1', '19', null, '20', 'doc', '文库', '0000-0005', '1', '0002', '2014-06-01 19:01:26', '0', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('93', '1', '92', '1', '19', null, '20', null, '教育文库', '0000-0005-0000', '2', '0000', '2014-06-01 19:02:34', '1', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('94', '1', '92', '1', '19', null, '20', null, '专业资料', '0000-0005-0001', '2', '0000', '2014-06-01 19:02:48', '1', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('95', '1', '52', '1', '10', null, '26', null, '图书/音像', '0000-0003-0003', '2', '0000', '2014-12-17 12:01:36', '1', '0', '1', '0', '0', null, null, null, null, null, null, null);
INSERT INTO `cms_node` VALUES ('96', '1', '52', '1', '10', null, '27', null, '家用电器', '0000-0003-0004', '2', '0000', '2014-12-17 12:02:24', '1', '0', '1', '0', '0', null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for cms_node_buffer
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_buffer`;
CREATE TABLE `cms_node_buffer` (
  `f_node_id` int(11) NOT NULL,
  `f_views` int(11) NOT NULL COMMENT '浏览次数',
  PRIMARY KEY (`f_node_id`),
  CONSTRAINT `fk_cms_nodebuffer_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node_buffer
-- ----------------------------
INSERT INTO `cms_node_buffer` VALUES ('1', '7');
INSERT INTO `cms_node_buffer` VALUES ('38', '5');
INSERT INTO `cms_node_buffer` VALUES ('42', '1');
INSERT INTO `cms_node_buffer` VALUES ('44', '2');
INSERT INTO `cms_node_buffer` VALUES ('48', '0');
INSERT INTO `cms_node_buffer` VALUES ('49', '0');
INSERT INTO `cms_node_buffer` VALUES ('51', '0');
INSERT INTO `cms_node_buffer` VALUES ('52', '0');
INSERT INTO `cms_node_buffer` VALUES ('67', '0');
INSERT INTO `cms_node_buffer` VALUES ('68', '0');
INSERT INTO `cms_node_buffer` VALUES ('69', '0');
INSERT INTO `cms_node_buffer` VALUES ('74', '0');
INSERT INTO `cms_node_buffer` VALUES ('77', '0');
INSERT INTO `cms_node_buffer` VALUES ('78', '0');
INSERT INTO `cms_node_buffer` VALUES ('79', '0');
INSERT INTO `cms_node_buffer` VALUES ('80', '0');
INSERT INTO `cms_node_buffer` VALUES ('81', '0');
INSERT INTO `cms_node_buffer` VALUES ('82', '0');
INSERT INTO `cms_node_buffer` VALUES ('83', '0');
INSERT INTO `cms_node_buffer` VALUES ('84', '0');
INSERT INTO `cms_node_buffer` VALUES ('85', '0');
INSERT INTO `cms_node_buffer` VALUES ('87', '0');
INSERT INTO `cms_node_buffer` VALUES ('88', '0');
INSERT INTO `cms_node_buffer` VALUES ('90', '0');
INSERT INTO `cms_node_buffer` VALUES ('92', '0');
INSERT INTO `cms_node_buffer` VALUES ('93', '0');
INSERT INTO `cms_node_buffer` VALUES ('94', '0');
INSERT INTO `cms_node_buffer` VALUES ('95', '0');
INSERT INTO `cms_node_buffer` VALUES ('96', '0');

-- ----------------------------
-- Table structure for cms_node_clob
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_clob`;
CREATE TABLE `cms_node_clob` (
  `f_node_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` mediumtext COMMENT '值',
  KEY `fk_cms_nodeclob_node` (`f_node_id`) USING BTREE,
  CONSTRAINT `fk_cms_nodeclob_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node_clob
-- ----------------------------

-- ----------------------------
-- Table structure for cms_node_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_custom`;
CREATE TABLE `cms_node_custom` (
  `f_node_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_nodecustom_node` (`f_node_id`) USING BTREE,
  CONSTRAINT `fk_cms_nodecustom_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_node_detail
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_detail`;
CREATE TABLE `cms_node_detail` (
  `f_node_id` int(11) NOT NULL,
  `f_link` varchar(255) DEFAULT NULL COMMENT '转向链接',
  `f_html` varchar(255) DEFAULT NULL COMMENT 'HTML页面',
  `f_mobile_html` varchar(255) DEFAULT NULL COMMENT '手机端HTML页面',
  `f_meta_keywords` varchar(150) DEFAULT NULL COMMENT '关键字',
  `f_meta_description` varchar(450) DEFAULT NULL COMMENT '描述',
  `f_is_new_window` char(1) DEFAULT NULL COMMENT '是否在新窗口打开',
  `f_node_template` varchar(255) DEFAULT NULL COMMENT '栏目模板',
  `f_info_template` varchar(255) DEFAULT NULL COMMENT '文档模板',
  `f_is_generate_node` char(1) DEFAULT NULL COMMENT '是否生成栏目页',
  `f_is_generate_info` char(1) DEFAULT NULL COMMENT '是否生成文档页',
  `f_node_extension` varchar(10) DEFAULT NULL COMMENT '栏目页扩展名',
  `f_info_extension` varchar(10) DEFAULT NULL COMMENT '文档页扩展名',
  `f_node_path` varchar(100) DEFAULT NULL COMMENT '栏目路径',
  `f_info_path` varchar(100) DEFAULT NULL COMMENT '文档路径',
  `f_is_def_page` char(1) DEFAULT NULL COMMENT '是否默认页',
  `f_static_method` int(11) DEFAULT NULL COMMENT '静态页生成方式(0:手动生成;1:自动生成栏目页;2:自动生成文档页及栏目页;3:自动生成文档页、栏目页、父栏目页、首页)',
  `f_static_page` int(11) DEFAULT NULL COMMENT '栏目列表静态化页数',
  `f_small_image` varchar(255) DEFAULT NULL COMMENT '小图',
  `f_large_image` varchar(255) DEFAULT NULL COMMENT '大图',
  PRIMARY KEY (`f_node_id`),
  CONSTRAINT `fk_cms_nodedetail_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node_detail
-- ----------------------------
INSERT INTO `cms_node_detail` VALUES ('1', null, null, null, null, null, null, null, null, null, null, null, null, '/index', '/{node_number}/{info_id}', '1', null, '1', null, null);
INSERT INTO `cms_node_detail` VALUES ('36', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('38', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('40', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('42', null, null, null, null, null, null, null, null, '0', '0', '.html', '.html', '/news/{node_number}/index', '/news/{node_number}/{info_id}', '1', '4', '1', null, null);
INSERT INTO `cms_node_detail` VALUES ('44', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('48', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('49', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('51', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('52', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('67', '/guestbook', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('68', 'http://bbs.jspxcms.com/', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('69', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('74', '/special_category', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('77', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('78', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('79', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('80', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('81', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('82', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('83', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('84', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('85', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('87', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('88', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('90', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('92', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('93', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('94', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('95', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_node_detail` VALUES ('96', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for cms_node_membergroup
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_membergroup`;
CREATE TABLE `cms_node_membergroup` (
  `f_node_id` int(11) NOT NULL,
  `f_membergroup_id` int(11) NOT NULL,
  `f_is_view_perm` char(1) NOT NULL DEFAULT '1' COMMENT '是否有浏览权限',
  `f_is_contri_perm` char(1) NOT NULL DEFAULT '1' COMMENT '是否有投稿权限',
  `f_is_comment_perm` char(1) NOT NULL DEFAULT '1' COMMENT '是否有评论权限',
  KEY `fk_cms_nodemgroup_group` (`f_membergroup_id`) USING BTREE,
  KEY `fk_cms_nodemgroup_node` (`f_node_id`) USING BTREE,
  CONSTRAINT `fk_cms_nodemgroup_group` FOREIGN KEY (`f_membergroup_id`) REFERENCES `cms_member_group` (`f_membergroup_id`),
  CONSTRAINT `fk_cms_nodemgroup_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node_membergroup
-- ----------------------------

-- ----------------------------
-- Table structure for cms_node_org
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_org`;
CREATE TABLE `cms_node_org` (
  `f_org_id` int(11) NOT NULL,
  `f_node_id` int(11) NOT NULL,
  `f_is_view_perm` char(1) NOT NULL DEFAULT '0' COMMENT '是否有浏览权限',
  KEY `fk_cms_nodeorg_node` (`f_node_id`) USING BTREE,
  KEY `fk_cms_nodeorg_org` (`f_org_id`) USING BTREE,
  CONSTRAINT `fk_cms_nodeorg_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_nodeorg_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node_org
-- ----------------------------

-- ----------------------------
-- Table structure for cms_node_role
-- ----------------------------
DROP TABLE IF EXISTS `cms_node_role`;
CREATE TABLE `cms_node_role` (
  `f_node_id` int(11) NOT NULL,
  `f_role_id` int(11) NOT NULL,
  `f_is_node_perm` char(1) NOT NULL DEFAULT '1' COMMENT '栏目权限',
  `f_is_info_perm` char(1) NOT NULL DEFAULT '1' COMMENT '文档权限',
  KEY `fk_cms_noderole_node` (`f_node_id`) USING BTREE,
  KEY `fk_cms_noderole_role` (`f_role_id`) USING BTREE,
  CONSTRAINT `fk_cms_noderole_node` FOREIGN KEY (`f_node_id`) REFERENCES `cms_node` (`f_node_id`),
  CONSTRAINT `fk_cms_noderole_role` FOREIGN KEY (`f_role_id`) REFERENCES `cms_role` (`f_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_node_role
-- ----------------------------

-- ----------------------------
-- Table structure for cms_notification
-- ----------------------------
DROP TABLE IF EXISTS `cms_notification`;
CREATE TABLE `cms_notification` (
  `notification_id_` int(11) NOT NULL,
  `receiver_id_` int(11) NOT NULL COMMENT '接收者',
  `type_` varchar(50) NOT NULL COMMENT '类别',
  `key_` int(11) NOT NULL COMMENT 'KEY',
  `qty_` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `url_` varchar(255) DEFAULT NULL COMMENT 'URL',
  `backend_url_` varchar(255) DEFAULT NULL COMMENT '后端URL',
  `text_` varchar(2000) NOT NULL COMMENT '通知正文',
  `send_time_` datetime NOT NULL COMMENT '通知时间',
  PRIMARY KEY (`notification_id_`),
  KEY `fk_cms_notification_receiver` (`receiver_id_`) USING BTREE,
  CONSTRAINT `fk_cms_notification_receiver` FOREIGN KEY (`receiver_id_`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_notification
-- ----------------------------

-- ----------------------------
-- Table structure for cms_notification_source
-- ----------------------------
DROP TABLE IF EXISTS `cms_notification_source`;
CREATE TABLE `cms_notification_source` (
  `notification_id_` int(11) NOT NULL,
  `source_` varchar(255) NOT NULL,
  `source_order_` int(11) NOT NULL,
  KEY `fk_cms_notificationkey_notifi` (`notification_id_`) USING BTREE,
  CONSTRAINT `fk_cms_notificationkey_notifi` FOREIGN KEY (`notification_id_`) REFERENCES `cms_notification` (`notification_id_`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_notification_source
-- ----------------------------

-- ----------------------------
-- Table structure for cms_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `cms_operation_log`;
CREATE TABLE `cms_operation_log` (
  `f_operation_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL COMMENT '操作人',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_data_id` int(11) DEFAULT NULL COMMENT '数据ID',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_text` mediumtext COMMENT '详情',
  `f_ip` varchar(100) NOT NULL COMMENT 'IP',
  `f_country` varchar(100) DEFAULT NULL COMMENT '国家',
  `f_area` varchar(100) DEFAULT NULL COMMENT '地区',
  `f_time` datetime NOT NULL COMMENT '时间',
  `f_type` int(11) NOT NULL DEFAULT '1' COMMENT '类型(1:操作日志,2:登录日志,3:登录失败)',
  PRIMARY KEY (`f_operation_id`),
  KEY `fk_cms_operationlog_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_operationlog_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_operationlog_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_operationlog_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_operation_log
-- ----------------------------
INSERT INTO `cms_operation_log` VALUES ('1757', '0', '1', 'login.failure', null, 'admin:123456', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-04 10:04:31', '2');
INSERT INTO `cms_operation_log` VALUES ('1758', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-04 10:05:18', '2');
INSERT INTO `cms_operation_log` VALUES ('1767', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-04 11:21:57', '2');
INSERT INTO `cms_operation_log` VALUES ('1777', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-04 15:40:39', '2');
INSERT INTO `cms_operation_log` VALUES ('1778', '1', '1', 'opr.role.add', '17', '操作员', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-04 15:47:59', '1');
INSERT INTO `cms_operation_log` VALUES ('1787', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-07 22:01:06', '2');
INSERT INTO `cms_operation_log` VALUES ('1788', '1', '1', 'opr.confSite.baseEdit', '1', '国政舆情信息管理系统', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-07 22:03:50', '1');
INSERT INTO `cms_operation_log` VALUES ('1789', '1', '1', 'opr.confSite.baseEdit', '1', '国政舆情信息管理系统', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-07 22:04:02', '1');
INSERT INTO `cms_operation_log` VALUES ('1797', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-07 22:29:39', '2');
INSERT INTO `cms_operation_log` VALUES ('1807', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:12:15', '2');
INSERT INTO `cms_operation_log` VALUES ('1817', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:22:19', '2');
INSERT INTO `cms_operation_log` VALUES ('1827', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:26:28', '2');
INSERT INTO `cms_operation_log` VALUES ('1828', '1', '1', 'opr.sysdict.add', '1', 'sdsf', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:34:45', '1');
INSERT INTO `cms_operation_log` VALUES ('1829', '1', '1', 'opr.sysdict.add', '2', 'tsjy', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:52:22', '1');
INSERT INTO `cms_operation_log` VALUES ('1830', '1', '1', 'opr.sysdict.add', '3', 'red', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:53:33', '1');
INSERT INTO `cms_operation_log` VALUES ('1831', '1', '1', 'opr.sysdict.add', '4', 'yellow', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:53:59', '1');
INSERT INTO `cms_operation_log` VALUES ('1832', '1', '1', 'opr.sysdict.add', '5', 'primaryschool', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:55:36', '1');
INSERT INTO `cms_operation_log` VALUES ('1833', '1', '1', 'opr.sysdict.add', '6', 'middleschool', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:56:08', '1');
INSERT INTO `cms_operation_log` VALUES ('1834', '1', '1', 'opr.sysdict.add', '7', 'baidutb', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:57:35', '1');
INSERT INTO `cms_operation_log` VALUES ('1835', '1', '1', 'opr.sysdictGroup.edit', '7', '163new', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 13:58:05', '1');
INSERT INTO `cms_operation_log` VALUES ('1837', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:18:25', '2');
INSERT INTO `cms_operation_log` VALUES ('1847', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:22:03', '2');
INSERT INTO `cms_operation_log` VALUES ('1857', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:30:34', '2');
INSERT INTO `cms_operation_log` VALUES ('1867', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:35:32', '2');
INSERT INTO `cms_operation_log` VALUES ('1868', '1', '1', 'opr.sysdict.add', '8', 'china', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:37:25', '1');
INSERT INTO `cms_operation_log` VALUES ('1877', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:41:56', '2');
INSERT INTO `cms_operation_log` VALUES ('1878', '1', '1', 'opr.sysdict.add', '9', 'SC', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:43:50', '1');
INSERT INTO `cms_operation_log` VALUES ('1879', '1', '1', 'opr.sysdict.add', '10', 'SD', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:44:18', '1');
INSERT INTO `cms_operation_log` VALUES ('1887', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:51:51', '2');
INSERT INTO `cms_operation_log` VALUES ('1888', '1', '1', 'opr.sysdict.add', '11', 'fsdg', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:52:15', '1');
INSERT INTO `cms_operation_log` VALUES ('1889', '1', '1', 'opr.sysdict.add', '12', 'adsf', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:54:38', '1');
INSERT INTO `cms_operation_log` VALUES ('1890', '1', '1', 'opr.sysdictGroup.edit', '9', 'SC', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:55:12', '1');
INSERT INTO `cms_operation_log` VALUES ('1891', '1', '1', 'opr.sysdictGroup.edit', '10', 'SD', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:55:41', '1');
INSERT INTO `cms_operation_log` VALUES ('1892', '1', '1', 'opr.sysdict.add', '13', 'cd', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:56:52', '1');
INSERT INTO `cms_operation_log` VALUES ('1893', '1', '1', 'opr.sysdictGroup.edit', '13', 'CD', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:57:36', '1');
INSERT INTO `cms_operation_log` VALUES ('1894', '1', '1', 'opr.sysdict.add', '14', 'DY', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:58:18', '1');
INSERT INTO `cms_operation_log` VALUES ('1895', '1', '1', 'opr.sysdict.add', '15', 'QYQ', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 14:58:37', '1');
INSERT INTO `cms_operation_log` VALUES ('1897', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-10 15:03:46', '2');
INSERT INTO `cms_operation_log` VALUES ('1907', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 19:14:02', '2');
INSERT INTO `cms_operation_log` VALUES ('1917', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 20:04:33', '2');
INSERT INTO `cms_operation_log` VALUES ('1927', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 20:27:12', '2');
INSERT INTO `cms_operation_log` VALUES ('1928', '1', '1', 'opr.Customer.add', '1', '申达股份是梵蒂冈', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 20:27:44', '1');
INSERT INTO `cms_operation_log` VALUES ('1937', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 20:40:20', '2');
INSERT INTO `cms_operation_log` VALUES ('1947', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 21:06:08', '2');
INSERT INTO `cms_operation_log` VALUES ('1948', '1', '1', 'opr.customer.edit', '1', '申达股份是梵蒂冈1', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 21:07:08', '1');
INSERT INTO `cms_operation_log` VALUES ('1957', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 21:27:41', '2');
INSERT INTO `cms_operation_log` VALUES ('1967', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 21:49:54', '2');
INSERT INTO `cms_operation_log` VALUES ('1977', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 22:09:45', '2');
INSERT INTO `cms_operation_log` VALUES ('1978', '1', '1', 'opr.customer.edit', '1', '申达股份是梵蒂冈1', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 22:41:55', '1');
INSERT INTO `cms_operation_log` VALUES ('1979', '1', '1', 'opr.customer.edit', '1', '申达股份是梵蒂冈1', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 22:42:15', '1');
INSERT INTO `cms_operation_log` VALUES ('1980', '1', '1', 'opr.customer.edit', '1', '申达股份是梵蒂冈1', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 22:43:14', '1');
INSERT INTO `cms_operation_log` VALUES ('1981', '1', '1', 'opr.Customer.add', '2', '打的费', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-11 22:43:45', '1');
INSERT INTO `cms_operation_log` VALUES ('1987', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-12 20:40:00', '2');
INSERT INTO `cms_operation_log` VALUES ('1988', '1', '1', 'opr.customer.edit', '2', '打的费', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-12 20:40:26', '1');
INSERT INTO `cms_operation_log` VALUES ('1997', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-13 09:42:43', '2');
INSERT INTO `cms_operation_log` VALUES ('1998', '1', '1', 'opr.customer.edit', '2', '打的费', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-13 09:43:41', '1');
INSERT INTO `cms_operation_log` VALUES ('2007', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-13 11:29:51', '2');
INSERT INTO `cms_operation_log` VALUES ('2008', '1', '1', 'opr.customer.edit', '2', '打的费', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-13 11:31:06', '1');
INSERT INTO `cms_operation_log` VALUES ('2017', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 20:42:31', '2');
INSERT INTO `cms_operation_log` VALUES ('2027', '1', '1', 'opr.customer.edit', '2', '打的费', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 20:50:04', '1');
INSERT INTO `cms_operation_log` VALUES ('2028', '1', '1', 'opr.sysdictGroup.edit', '7', '163new', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 20:56:07', '1');
INSERT INTO `cms_operation_log` VALUES ('2029', '1', '1', 'opr.sysdictGroup.edit', '7', '163new', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 20:56:53', '1');
INSERT INTO `cms_operation_log` VALUES ('2030', '1', '1', 'opr.sysdict.add', '16', 'tianyabbs', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 20:57:32', '1');
INSERT INTO `cms_operation_log` VALUES ('2037', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 22:13:12', '2');
INSERT INTO `cms_operation_log` VALUES ('2047', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 22:51:44', '2');
INSERT INTO `cms_operation_log` VALUES ('2057', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 23:16:18', '2');
INSERT INTO `cms_operation_log` VALUES ('2067', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 23:35:00', '2');
INSERT INTO `cms_operation_log` VALUES ('2068', '1', '1', 'opr.sysfavorite.add', '1', '34324', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 23:41:47', '1');
INSERT INTO `cms_operation_log` VALUES ('2077', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 23:44:14', '2');
INSERT INTO `cms_operation_log` VALUES ('2078', '1', '1', 'opr.sysfavorite.edit', '1', '34324', null, '127.0.0.1', 'LAN', 'LAN', '2017-12-13 23:51:40', '1');
INSERT INTO `cms_operation_log` VALUES ('2087', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 09:18:57', '2');
INSERT INTO `cms_operation_log` VALUES ('2097', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 09:25:01', '2');
INSERT INTO `cms_operation_log` VALUES ('2098', '1', '1', 'opr.sysfavorite.edit', '1', '34324', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 09:32:47', '1');
INSERT INTO `cms_operation_log` VALUES ('2107', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 09:52:05', '2');
INSERT INTO `cms_operation_log` VALUES ('2108', '1', '1', 'opr.sysfavorite.edit', '1', '34324', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 09:52:27', '1');
INSERT INTO `cms_operation_log` VALUES ('2109', '1', '1', 'opr.sysfavorite.edit', '1', '34324', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 09:53:28', '1');
INSERT INTO `cms_operation_log` VALUES ('2110', '1', '1', 'opr.sysfavorite.edit', '1', '34324', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 09:53:49', '1');
INSERT INTO `cms_operation_log` VALUES ('2117', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-14 14:17:28', '2');
INSERT INTO `cms_operation_log` VALUES ('2127', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 20:02:15', '2');
INSERT INTO `cms_operation_log` VALUES ('2137', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 21:24:15', '2');
INSERT INTO `cms_operation_log` VALUES ('2138', '1', '1', 'opr.Contract.add', '1', '俺的沙发', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 22:01:51', '1');
INSERT INTO `cms_operation_log` VALUES ('2139', '1', '1', 'opr.Contract.edit', '1', '俺的沙发', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 22:10:46', '1');
INSERT INTO `cms_operation_log` VALUES ('2140', '1', '1', 'opr.Contract.edit', '1', '俺的沙发', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 22:12:06', '1');
INSERT INTO `cms_operation_log` VALUES ('2147', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 23:16:23', '2');
INSERT INTO `cms_operation_log` VALUES ('2148', '1', '1', 'opr.Sentiment.add', '1', null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 23:20:49', '1');
INSERT INTO `cms_operation_log` VALUES ('2157', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-14 23:32:35', '2');
INSERT INTO `cms_operation_log` VALUES ('2167', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-15 09:21:21', '2');
INSERT INTO `cms_operation_log` VALUES ('2168', '1', '1', 'opr.confSite.customEdit', '1', '国政舆情信息管理系统', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-15 09:28:42', '1');
INSERT INTO `cms_operation_log` VALUES ('2177', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-15 18:35:15', '2');
INSERT INTO `cms_operation_log` VALUES ('2187', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-15 18:50:45', '2');
INSERT INTO `cms_operation_log` VALUES ('2197', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-15 22:41:18', '2');
INSERT INTO `cms_operation_log` VALUES ('2198', '1', '1', 'opr.sysdict.add', '17', 'baidubbs', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-15 22:46:28', '1');
INSERT INTO `cms_operation_log` VALUES ('2199', '1', '1', 'opr.sysfavorite.add', '2', '成都七中吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-15 23:07:32', '1');
INSERT INTO `cms_operation_log` VALUES ('2200', '1', '1', 'opr.sysfavorite.edit', '2', '成都七中吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-15 23:09:22', '1');
INSERT INTO `cms_operation_log` VALUES ('2207', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 10:04:39', '2');
INSERT INTO `cms_operation_log` VALUES ('2217', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 10:33:37', '2');
INSERT INTO `cms_operation_log` VALUES ('2227', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 10:47:21', '2');
INSERT INTO `cms_operation_log` VALUES ('2237', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 11:12:47', '2');
INSERT INTO `cms_operation_log` VALUES ('2238', '1', '1', 'opr.sysfavorite.add', '3', '成都七中吧111', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 11:17:49', '1');
INSERT INTO `cms_operation_log` VALUES ('2239', '1', '1', 'opr.sysfavorite.edit', '3', '成都七中吧111', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 11:18:02', '1');
INSERT INTO `cms_operation_log` VALUES ('2240', '1', '1', 'opr.sysfavorite.add', '4', '成都七中吧3333', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 11:26:32', '1');
INSERT INTO `cms_operation_log` VALUES ('2241', '1', '1', 'opr.sysfavorite.add', '5', '成都七中吧2222', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 11:29:04', '1');
INSERT INTO `cms_operation_log` VALUES ('2242', '1', '1', 'opr.sysfavorite.add', '6', '成都七中吧444', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 11:30:07', '1');
INSERT INTO `cms_operation_log` VALUES ('2243', '1', '1', 'opr.sysfavorite.add', '7', '成都七中吧555', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-16 11:32:49', '1');
INSERT INTO `cms_operation_log` VALUES ('2247', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 11:45:13', '2');
INSERT INTO `cms_operation_log` VALUES ('2257', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:04:24', '2');
INSERT INTO `cms_operation_log` VALUES ('2258', '1', '1', 'opr.comment.edit', '20', '请市民减少出行，注意交通安全，山区防山洪、滑坡、泥石流地质灾害', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:11:44', '1');
INSERT INTO `cms_operation_log` VALUES ('2259', '1', '1', 'opr.user.add', '31', '日天', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:22:24', '1');
INSERT INTO `cms_operation_log` VALUES ('2260', '1', '1', 'opr.sysfavorite.edit', '2', '成都七中吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:30:29', '1');
INSERT INTO `cms_operation_log` VALUES ('2267', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:51:00', '2');
INSERT INTO `cms_operation_log` VALUES ('2268', '1', '1', 'opr.sysfavorite.edit', '2', '成都七中吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:55:42', '1');
INSERT INTO `cms_operation_log` VALUES ('2269', '1', '1', 'opr.Sentiment.add', '2', '求各位刚考过的一诊模拟测试文科数学的答案！！【成都七中吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:55:59', '1');
INSERT INTO `cms_operation_log` VALUES ('2270', '1', '1', 'opr.Sentiment.add', '3', '求各位刚考过的一诊模拟测试文科数学的答案！！【成都七中吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 14:59:46', '1');
INSERT INTO `cms_operation_log` VALUES ('2277', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 15:05:06', '2');
INSERT INTO `cms_operation_log` VALUES ('2278', '1', '1', 'opr.Sentiment.edit', '2', '求各位刚考过的一诊模拟测试文科数学的答案！！【成都七中吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 15:06:18', '1');
INSERT INTO `cms_operation_log` VALUES ('2287', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 16:54:47', '2');
INSERT INTO `cms_operation_log` VALUES ('2288', '1', '1', 'opr.customer.edit', '2', '打的费', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 16:59:14', '1');
INSERT INTO `cms_operation_log` VALUES ('2289', '1', '1', 'opr.Customer.add', '3', '成都华阳中学', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 17:01:10', '1');
INSERT INTO `cms_operation_log` VALUES ('2290', '1', '1', 'opr.sysdict.add', '18', 'GXQ', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 17:03:27', '1');
INSERT INTO `cms_operation_log` VALUES ('2291', '1', '1', 'opr.customer.edit', '3', '成都华阳中学', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 17:03:43', '1');
INSERT INTO `cms_operation_log` VALUES ('2292', '1', '1', 'opr.sysfavorite.add', '8', '成都华阳中学吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 17:04:53', '1');
INSERT INTO `cms_operation_log` VALUES ('2293', '1', '1', 'opr.sysfavorite.edit', '8', '成都华阳中学吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 17:05:48', '1');
INSERT INTO `cms_operation_log` VALUES ('2294', '1', '1', 'login.logout', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:36:19', '2');
INSERT INTO `cms_operation_log` VALUES ('2295', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:36:20', '2');
INSERT INTO `cms_operation_log` VALUES ('2296', '1', '1', 'opr.sysfavorite.edit', '8', '成都华阳中学吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:40:18', '1');
INSERT INTO `cms_operation_log` VALUES ('2297', '1', '1', 'opr.sysfavorite.edit', '8', '成都华阳中学吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:42:20', '1');
INSERT INTO `cms_operation_log` VALUES ('2298', '1', '1', 'opr.Sentiment.add', '4', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:42:34', '1');
INSERT INTO `cms_operation_log` VALUES ('2299', '1', '1', 'opr.Sentiment.add', '5', '有上一届学姐说他在核工业读了两年就工作了，才开始工资5000多，这么爽，想去读，有没有一起的啊【成都华阳中学吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:46:54', '1');
INSERT INTO `cms_operation_log` VALUES ('2300', '1', '1', 'opr.Sentiment.add', '6', '华阳中学上班族晚上可以去跑步吗？能进去吗？【成都华阳中学吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:54:08', '1');
INSERT INTO `cms_operation_log` VALUES ('2301', '1', '1', 'opr.Sentiment.add', '7', '单招【成都华阳中学吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:56:13', '1');
INSERT INTO `cms_operation_log` VALUES ('2307', '1', '1', 'login.logout', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:58:28', '2');
INSERT INTO `cms_operation_log` VALUES ('2308', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:58:30', '2');
INSERT INTO `cms_operation_log` VALUES ('2309', '1', '1', 'opr.Sentiment.add', '8', '成都华阳【成都华阳中学吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 18:59:23', '1');
INSERT INTO `cms_operation_log` VALUES ('2310', '1', '1', 'opr.Sentiment.add', '9', '成都华阳【成都华阳中学吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 19:00:30', '1');
INSERT INTO `cms_operation_log` VALUES ('2311', '1', '1', 'opr.Sentiment.add', '10', '有美术、传媒、音乐、书法爱好者请联糸13547895346【成都华阳中学吧】_百度贴吧', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 19:01:21', '1');
INSERT INTO `cms_operation_log` VALUES ('2317', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 19:09:44', '2');
INSERT INTO `cms_operation_log` VALUES ('2327', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-17 19:13:01', '2');
INSERT INTO `cms_operation_log` VALUES ('2337', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 09:11:55', '2');
INSERT INTO `cms_operation_log` VALUES ('2347', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 09:17:55', '2');
INSERT INTO `cms_operation_log` VALUES ('2357', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 09:21:37', '2');
INSERT INTO `cms_operation_log` VALUES ('2367', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 09:27:28', '2');
INSERT INTO `cms_operation_log` VALUES ('2377', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 09:54:39', '2');
INSERT INTO `cms_operation_log` VALUES ('2387', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:00:51', '2');
INSERT INTO `cms_operation_log` VALUES ('2397', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:06:11', '2');
INSERT INTO `cms_operation_log` VALUES ('2398', '1', '1', 'opr.sysdict.add', '19', 'orange', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:08:00', '1');
INSERT INTO `cms_operation_log` VALUES ('2407', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:13:50', '2');
INSERT INTO `cms_operation_log` VALUES ('2408', '1', '1', 'opr.sysdict.add', '20', 'blue', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:14:52', '1');
INSERT INTO `cms_operation_log` VALUES ('2417', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:20:14', '2');
INSERT INTO `cms_operation_log` VALUES ('2427', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:23:18', '2');
INSERT INTO `cms_operation_log` VALUES ('2437', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:25:43', '2');
INSERT INTO `cms_operation_log` VALUES ('2438', '1', '1', 'opr.sysdict.add', '21', 'blue', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:27:07', '1');
INSERT INTO `cms_operation_log` VALUES ('2439', '1', '1', 'opr.sysdict.add', '22', 'blue', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:27:12', '1');
INSERT INTO `cms_operation_log` VALUES ('2447', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:36:10', '2');
INSERT INTO `cms_operation_log` VALUES ('2448', '1', '1', 'opr.sysdict.add', '23', 'blue', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:36:52', '1');
INSERT INTO `cms_operation_log` VALUES ('2457', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:39:37', '2');
INSERT INTO `cms_operation_log` VALUES ('2458', '1', '1', 'opr.sysdict.add', '24', 'blue', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:40:45', '1');
INSERT INTO `cms_operation_log` VALUES ('2459', '1', '1', 'opr.sysdict.add', '25', 'zi', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:41:29', '1');
INSERT INTO `cms_operation_log` VALUES ('2467', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 10:50:53', '2');
INSERT INTO `cms_operation_log` VALUES ('2477', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 11:22:30', '2');
INSERT INTO `cms_operation_log` VALUES ('2478', '1', '1', 'opr.sysdict.add', '26', 'whtrit', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 11:23:49', '1');
INSERT INTO `cms_operation_log` VALUES ('2487', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 11:37:39', '2');
INSERT INTO `cms_operation_log` VALUES ('2497', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 11:43:03', '2');
INSERT INTO `cms_operation_log` VALUES ('2507', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 11:51:15', '2');
INSERT INTO `cms_operation_log` VALUES ('2517', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 13:35:26', '2');
INSERT INTO `cms_operation_log` VALUES ('2518', '1', '1', 'opr.sysdict.add', '28', 'blue', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-18 13:36:34', '1');
INSERT INTO `cms_operation_log` VALUES ('2527', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-18 20:17:12', '2');
INSERT INTO `cms_operation_log` VALUES ('2537', '1', '1', 'login.logout', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-18 21:01:55', '2');
INSERT INTO `cms_operation_log` VALUES ('2538', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-18 21:01:58', '2');
INSERT INTO `cms_operation_log` VALUES ('2547', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 10:47:25', '2');
INSERT INTO `cms_operation_log` VALUES ('2557', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 14:45:31', '2');
INSERT INTO `cms_operation_log` VALUES ('2558', '1', '1', 'opr.Sentiment.add', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 15:47:48', '1');
INSERT INTO `cms_operation_log` VALUES ('2559', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 16:37:07', '1');
INSERT INTO `cms_operation_log` VALUES ('2560', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 16:39:34', '1');
INSERT INTO `cms_operation_log` VALUES ('2561', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 16:40:05', '1');
INSERT INTO `cms_operation_log` VALUES ('2562', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 16:40:11', '1');
INSERT INTO `cms_operation_log` VALUES ('2563', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 16:40:15', '1');
INSERT INTO `cms_operation_log` VALUES ('2564', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 17:01:15', '1');
INSERT INTO `cms_operation_log` VALUES ('2565', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 17:02:57', '1');
INSERT INTO `cms_operation_log` VALUES ('2566', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 17:03:03', '1');
INSERT INTO `cms_operation_log` VALUES ('2567', '1', '1', 'opr.Sentiment.edit', '11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 17:03:55', '1');
INSERT INTO `cms_operation_log` VALUES ('2577', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-25 17:28:08', '2');
INSERT INTO `cms_operation_log` VALUES ('2587', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-25 22:31:05', '2');
INSERT INTO `cms_operation_log` VALUES ('2597', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-25 22:59:38', '2');
INSERT INTO `cms_operation_log` VALUES ('2607', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-26 09:13:55', '2');
INSERT INTO `cms_operation_log` VALUES ('2617', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-26 17:04:30', '2');
INSERT INTO `cms_operation_log` VALUES ('2627', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-26 21:10:13', '2');
INSERT INTO `cms_operation_log` VALUES ('2637', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-27 14:02:31', '2');
INSERT INTO `cms_operation_log` VALUES ('2647', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-27 16:29:07', '2');
INSERT INTO `cms_operation_log` VALUES ('2657', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-27 16:58:02', '2');
INSERT INTO `cms_operation_log` VALUES ('2667', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-27 17:01:10', '2');
INSERT INTO `cms_operation_log` VALUES ('2677', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2017-12-27 17:24:30', '2');
INSERT INTO `cms_operation_log` VALUES ('2687', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-27 22:21:21', '2');
INSERT INTO `cms_operation_log` VALUES ('2688', '1', '1', 'opr.Contract.add', '2', 'sadfasd', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-27 22:38:00', '1');
INSERT INTO `cms_operation_log` VALUES ('2689', '1', '1', 'opr.Contract.edit', '1', '俺的沙发', null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-27 22:47:19', '1');
INSERT INTO `cms_operation_log` VALUES ('2697', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2017-12-27 22:56:42', '2');
INSERT INTO `cms_operation_log` VALUES ('2707', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2017-12-28 10:57:20', '2');
INSERT INTO `cms_operation_log` VALUES ('2717', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2018-01-02 20:20:51', '2');
INSERT INTO `cms_operation_log` VALUES ('2727', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-02 20:28:30', '2');
INSERT INTO `cms_operation_log` VALUES ('2737', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 20:04:46', '2');
INSERT INTO `cms_operation_log` VALUES ('2747', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 20:31:59', '2');
INSERT INTO `cms_operation_log` VALUES ('2757', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 20:49:42', '2');
INSERT INTO `cms_operation_log` VALUES ('2767', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 20:53:44', '2');
INSERT INTO `cms_operation_log` VALUES ('2777', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 20:57:53', '2');
INSERT INTO `cms_operation_log` VALUES ('2787', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 21:00:56', '2');
INSERT INTO `cms_operation_log` VALUES ('2797', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 21:10:14', '2');
INSERT INTO `cms_operation_log` VALUES ('2807', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 21:31:59', '2');
INSERT INTO `cms_operation_log` VALUES ('2817', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 21:34:16', '2');
INSERT INTO `cms_operation_log` VALUES ('2827', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 21:37:22', '2');
INSERT INTO `cms_operation_log` VALUES ('2837', '1', '1', 'login.success', null, null, null, '192.168.1.7', '局域网', '对方和您在同一内部网', '2018-01-03 21:38:53', '2');
INSERT INTO `cms_operation_log` VALUES ('2847', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2018-01-09 14:45:46', '2');
INSERT INTO `cms_operation_log` VALUES ('2848', '1', '1', 'opr.customer.edit', '3', '成都华阳中学', null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2018-01-09 14:47:00', '1');
INSERT INTO `cms_operation_log` VALUES ('2849', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2018-01-09 14:59:49', '2');
INSERT INTO `cms_operation_log` VALUES ('2857', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2018-01-18 21:27:23', '2');
INSERT INTO `cms_operation_log` VALUES ('2867', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 21:31:19', '2');
INSERT INTO `cms_operation_log` VALUES ('2877', '1', '1', 'login.logout', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 21:55:18', '2');
INSERT INTO `cms_operation_log` VALUES ('2878', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 21:55:20', '2');
INSERT INTO `cms_operation_log` VALUES ('2887', '1', '1', 'login.logout', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 21:58:05', '2');
INSERT INTO `cms_operation_log` VALUES ('2888', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 21:58:07', '2');
INSERT INTO `cms_operation_log` VALUES ('2897', '1', '1', 'login.logout', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 21:58:56', '2');
INSERT INTO `cms_operation_log` VALUES ('2898', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 21:58:59', '2');
INSERT INTO `cms_operation_log` VALUES ('2907', '1', '1', 'login.logout', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 22:35:55', '2');
INSERT INTO `cms_operation_log` VALUES ('2908', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-18 22:35:58', '2');
INSERT INTO `cms_operation_log` VALUES ('2917', '1', '1', 'login.success', null, null, null, '0:0:0:0:0:0:0:1', 'LAN', 'LAN', '2018-01-23 21:10:37', '2');
INSERT INTO `cms_operation_log` VALUES ('2927', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-24 21:33:43', '2');
INSERT INTO `cms_operation_log` VALUES ('2937', '1', '1', 'login.success', null, null, null, '127.0.0.1', 'LAN', 'LAN', '2018-01-24 22:52:11', '2');
INSERT INTO `cms_operation_log` VALUES ('2947', '1', '1', 'login.success', null, null, null, '218.89.222.232', '四川省成都市', '电信', '2018-02-01 14:44:55', '2');
INSERT INTO `cms_operation_log` VALUES ('2948', '1', '1', 'login.logout', null, null, null, '218.89.222.232', '四川省成都市', '电信', '2018-02-01 14:45:41', '2');
INSERT INTO `cms_operation_log` VALUES ('2957', '1', '1', 'login.success', null, null, null, '218.89.222.232', '四川省成都市', '电信', '2018-02-01 14:47:24', '2');
INSERT INTO `cms_operation_log` VALUES ('2958', '0', '1', 'login.failure', null, 'zhangjie:123456', null, '171.217.113.157', '四川省成都市', '电信', '2018-02-01 14:53:11', '2');
INSERT INTO `cms_operation_log` VALUES ('2959', '41', '1', 'login.success', null, null, null, '171.217.113.157', '四川省成都市', '电信', '2018-02-01 14:53:49', '2');
INSERT INTO `cms_operation_log` VALUES ('2960', '0', '1', 'login.failure', null, 'admin:admin', null, '171.217.113.157', '四川省成都市', '电信', '2018-02-01 14:54:36', '2');
INSERT INTO `cms_operation_log` VALUES ('2961', '1', '1', 'login.success', null, null, null, '171.217.113.157', '四川省成都市', '电信', '2018-02-01 14:54:38', '2');
INSERT INTO `cms_operation_log` VALUES ('2967', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2018-02-01 14:52:13', '2');
INSERT INTO `cms_operation_log` VALUES ('2977', '1', '1', 'login.success', null, null, null, '218.89.222.232', '四川省成都市', '电信', '2018-02-01 14:57:48', '2');
INSERT INTO `cms_operation_log` VALUES ('2978', '1', '1', 'login.success', null, null, null, '171.214.214.136', '四川省成都市', '电信', '2018-02-01 14:59:06', '2');
INSERT INTO `cms_operation_log` VALUES ('2979', '1', '1', 'login.success', null, null, null, '171.217.113.157', '四川省成都市', '电信', '2018-02-01 15:15:14', '2');
INSERT INTO `cms_operation_log` VALUES ('2987', '1', '1', 'login.success', null, null, null, '192.168.100.88', '局域网', '对方和您在同一内部网', '2018-02-01 15:05:54', '2');
INSERT INTO `cms_operation_log` VALUES ('2997', '1', '1', 'login.success', null, null, null, '218.89.222.232', '四川省成都市', '电信', '2018-02-01 15:26:13', '2');
INSERT INTO `cms_operation_log` VALUES ('2998', '1', '1', 'login.success', null, null, null, '171.217.113.157', '四川省成都市', '电信', '2018-02-01 15:54:31', '2');

-- ----------------------------
-- Table structure for cms_org
-- ----------------------------
DROP TABLE IF EXISTS `cms_org`;
CREATE TABLE `cms_org` (
  `f_org_id` int(11) NOT NULL,
  `f_parent_id` int(11) DEFAULT NULL COMMENT '上级组织',
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_full_name` varchar(150) DEFAULT NULL COMMENT '全称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_contacts` varchar(100) DEFAULT NULL COMMENT '联系人',
  `f_number` varchar(100) DEFAULT NULL COMMENT '编码',
  `f_phone` varchar(100) DEFAULT NULL COMMENT '电话',
  `f_fax` varchar(100) DEFAULT NULL COMMENT '传真',
  `f_address` varchar(255) DEFAULT NULL COMMENT '地址',
  `f_tree_number` varchar(100) NOT NULL DEFAULT '0000' COMMENT '树编码',
  `f_tree_level` int(11) NOT NULL DEFAULT '0' COMMENT '树级别',
  `f_tree_max` varchar(10) NOT NULL DEFAULT '0000' COMMENT '树子节点最大编码',
  PRIMARY KEY (`f_org_id`),
  KEY `fk_cms_org_parent` (`f_parent_id`) USING BTREE,
  CONSTRAINT `fk_cms_org_parent` FOREIGN KEY (`f_parent_id`) REFERENCES `cms_org` (`f_org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_org
-- ----------------------------
INSERT INTO `cms_org` VALUES ('1', null, '集团总部', null, null, null, '000', null, null, null, '0000', '0', '0002');

-- ----------------------------
-- Table structure for cms_publish_point
-- ----------------------------
DROP TABLE IF EXISTS `cms_publish_point`;
CREATE TABLE `cms_publish_point` (
  `f_publishpoint_id` int(11) NOT NULL,
  `f_global_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_store_path` varchar(255) DEFAULT NULL COMMENT '保存路径',
  `f_display_path` varchar(255) DEFAULT NULL COMMENT '显示路径',
  `f_ftp_hostname` varchar(100) DEFAULT NULL COMMENT 'ftp服务器',
  `f_ftp_port` int(11) DEFAULT NULL COMMENT 'ftp端口',
  `f_ftp_username` varchar(100) DEFAULT NULL COMMENT 'ftp用户名',
  `f_ftp_password` varchar(100) DEFAULT NULL COMMENT 'ftp密码',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排列顺序',
  `f_method` int(11) NOT NULL DEFAULT '1' COMMENT '方式(1:文件系统,2:FTP)',
  `f_type` int(11) NOT NULL DEFAULT '1' COMMENT '类型(1:HTML发布,2:附件发布)',
  PRIMARY KEY (`f_publishpoint_id`),
  KEY `fk_cms_publishpoint_global` (`f_global_id`) USING BTREE,
  CONSTRAINT `fk_cms_publishpoint_global` FOREIGN KEY (`f_global_id`) REFERENCES `cms_global` (`f_global_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_publish_point
-- ----------------------------
INSERT INTO `cms_publish_point` VALUES ('1', '1', '附件默认发布点', null, '/uploads', '/uploads', null, null, null, null, '2147483647', '1', '2');
INSERT INTO `cms_publish_point` VALUES ('2', '1', 'HTML默认发布点', null, null, null, null, null, null, null, '2147483647', '1', '1');

-- ----------------------------
-- Table structure for cms_question
-- ----------------------------
DROP TABLE IF EXISTS `cms_question`;
CREATE TABLE `cms_question` (
  `f_question_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点ID',
  `f_title` varchar(150) NOT NULL COMMENT '标题',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_begin_date` datetime DEFAULT NULL COMMENT '开始日期',
  `f_end_date` datetime DEFAULT NULL COMMENT '结束日期',
  `f_creation_date` datetime NOT NULL COMMENT '创建日期',
  `f_mode` int(11) NOT NULL DEFAULT '1' COMMENT '模式(1:独立访客,2:独立IP,3:独立用户)',
  `f_interval` int(11) NOT NULL DEFAULT '0' COMMENT '间隔时间（天）',
  `f_total` int(11) NOT NULL DEFAULT '0' COMMENT '总票数',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:启用,1:禁用)',
  PRIMARY KEY (`f_question_id`),
  KEY `fk_cms_question_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_question_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_question
-- ----------------------------
INSERT INTO `cms_question` VALUES ('1', '1', '广州恒大再夺亚冠，你怎么看', '在刚刚结束的2015赛季亚冠决赛次回合比赛中，广州恒大凭借埃尔克森的进球， 1-0战胜迪拜阿赫利，总比分1-0获得本赛季亚冠联赛冠军，同时这也是恒大3年内两夺亚冠。', null, null, '2015-12-05 22:32:54', '1', '0', '4', '0');
INSERT INTO `cms_question` VALUES ('2', '1', '南方供暖已成各界共识，你对江西供暖怎么看？', '近年来，每逢供暖期，呼吁“南方集中供暖”的话题都会成为热点。清华大学建筑节能研究中心的调研报告显示，并非所有南方城市有供暖需求，真正需要的是国家划定的“夏热冬冷”地区，包括上海、重庆、湖北、湖南、安徽、江西、江苏、浙江、四川等。这些省份冬季室温远低于北方城市集中供热时的室内温度。作为一个江西人，你对江西供暖怎么看？', null, null, '2015-12-01 16:38:50', '1', '0', '0', '0');

-- ----------------------------
-- Table structure for cms_question_item
-- ----------------------------
DROP TABLE IF EXISTS `cms_question_item`;
CREATE TABLE `cms_question_item` (
  `f_questionitem_id` int(11) NOT NULL,
  `f_question_id` int(11) NOT NULL,
  `f_title` varchar(150) NOT NULL,
  `f_max_selected` int(11) NOT NULL DEFAULT '1' COMMENT '最多可选几项(0不限制)',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_is_essay` char(1) NOT NULL DEFAULT '0' COMMENT '是否问答题',
  PRIMARY KEY (`f_questionitem_id`),
  KEY `fk_cms_questionitem_question` (`f_question_id`) USING BTREE,
  CONSTRAINT `fk_cms_questionitem_question` FOREIGN KEY (`f_question_id`) REFERENCES `cms_question` (`f_question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_question_item
-- ----------------------------
INSERT INTO `cms_question_item` VALUES ('1', '1', '广州恒大再夺亚冠主要原因是什么?', '0', '0', '0');
INSERT INTO `cms_question_item` VALUES ('2', '1', '恒大本场决赛最佳球员是谁?', '1', '1', '0');
INSERT INTO `cms_question_item` VALUES ('4', '2', '你支持江西供暖吗？', '1', '0', '0');
INSERT INTO `cms_question_item` VALUES ('5', '2', '你觉得“集中供暖”和“分散供暖”哪个模式比较好？', '1', '1', '0');
INSERT INTO `cms_question_item` VALUES ('6', '2', '如果采取供暖，你比较担心以下哪些问题？', '1', '2', '0');
INSERT INTO `cms_question_item` VALUES ('7', '2', '您有什么建议？', '1', '3', '1');

-- ----------------------------
-- Table structure for cms_question_item_rec
-- ----------------------------
DROP TABLE IF EXISTS `cms_question_item_rec`;
CREATE TABLE `cms_question_item_rec` (
  `f_questionrecord_id` int(11) NOT NULL,
  `f_questionitem_id` int(11) NOT NULL,
  `f_answer` mediumtext COMMENT '回答',
  KEY `fk_cms_questionitemrec_item` (`f_questionitem_id`) USING BTREE,
  KEY `fk_cms_questionitemrec_rec` (`f_questionrecord_id`) USING BTREE,
  CONSTRAINT `fk_cms_questionitemrec_item` FOREIGN KEY (`f_questionitem_id`) REFERENCES `cms_question_item` (`f_questionitem_id`),
  CONSTRAINT `fk_cms_questionitemrec_rec` FOREIGN KEY (`f_questionrecord_id`) REFERENCES `cms_question_record` (`f_questionrecord_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_question_item_rec
-- ----------------------------

-- ----------------------------
-- Table structure for cms_question_opt_rec
-- ----------------------------
DROP TABLE IF EXISTS `cms_question_opt_rec`;
CREATE TABLE `cms_question_opt_rec` (
  `f_questionrecord_id` int(11) NOT NULL,
  `f_questionoption_id` int(11) NOT NULL,
  KEY `fk_cms_questionoptrec_opt` (`f_questionoption_id`) USING BTREE,
  KEY `fk_cms_questionoptrec_rec` (`f_questionrecord_id`) USING BTREE,
  CONSTRAINT `fk_cms_questionoptrec_opt` FOREIGN KEY (`f_questionoption_id`) REFERENCES `cms_question_option` (`f_questionoption_id`),
  CONSTRAINT `fk_cms_questionoptrec_rec` FOREIGN KEY (`f_questionrecord_id`) REFERENCES `cms_question_record` (`f_questionrecord_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_question_opt_rec
-- ----------------------------

-- ----------------------------
-- Table structure for cms_question_option
-- ----------------------------
DROP TABLE IF EXISTS `cms_question_option`;
CREATE TABLE `cms_question_option` (
  `f_questionoption_id` int(11) NOT NULL,
  `f_questionitem_id` int(11) NOT NULL,
  `f_title` varchar(150) DEFAULT NULL COMMENT '标题',
  `f_is_input` char(1) NOT NULL DEFAULT '0' COMMENT '是否输入框',
  `f_count` int(11) NOT NULL DEFAULT '0' COMMENT '得票数',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_questionoption_id`),
  KEY `fk_cms_questionoption_item` (`f_questionitem_id`) USING BTREE,
  CONSTRAINT `fk_cms_questionoption_item` FOREIGN KEY (`f_questionitem_id`) REFERENCES `cms_question_item` (`f_questionitem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_question_option
-- ----------------------------
INSERT INTO `cms_question_option` VALUES ('1', '1', '斯科拉里中途上任，对球队调教有方', '0', '1', '0');
INSERT INTO `cms_question_option` VALUES ('2', '1', '高拉特、保利尼奥加盟，成功补强球队', '0', '1', '1');
INSERT INTO `cms_question_option` VALUES ('3', '2', '埃尔克森', '0', '1', '0');
INSERT INTO `cms_question_option` VALUES ('4', '2', '郑龙', '0', '0', '1');
INSERT INTO `cms_question_option` VALUES ('5', '1', '郑智、黄博文、冯潇霆等国内球员给力', '0', '2', '2');
INSERT INTO `cms_question_option` VALUES ('6', '1', '其他', '0', '0', '3');
INSERT INTO `cms_question_option` VALUES ('7', '2', '金英权', '0', '2', '2');
INSERT INTO `cms_question_option` VALUES ('8', '2', '其他', '0', '1', '3');
INSERT INTO `cms_question_option` VALUES ('9', '4', '支持', '0', '0', '0');
INSERT INTO `cms_question_option` VALUES ('10', '4', '不支持', '0', '0', '1');
INSERT INTO `cms_question_option` VALUES ('11', '4', '无所谓', '0', '0', '2');
INSERT INTO `cms_question_option` VALUES ('12', '5', '集中供暖比较好', '0', '0', '0');
INSERT INTO `cms_question_option` VALUES ('13', '5', '分散供暖比较好', '0', '0', '1');
INSERT INTO `cms_question_option` VALUES ('14', '5', '无所谓', '0', '0', '2');
INSERT INTO `cms_question_option` VALUES ('15', '6', '花销', '0', '0', '0');
INSERT INTO `cms_question_option` VALUES ('16', '6', '环境污染', '0', '0', '1');
INSERT INTO `cms_question_option` VALUES ('17', '6', '冷热不均', '0', '0', '2');
INSERT INTO `cms_question_option` VALUES ('18', '6', '生活习惯改变引起身体不适', '0', '0', '3');

-- ----------------------------
-- Table structure for cms_question_record
-- ----------------------------
DROP TABLE IF EXISTS `cms_question_record`;
CREATE TABLE `cms_question_record` (
  `f_questionrecord_id` int(11) NOT NULL,
  `f_user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `f_question_id` int(11) NOT NULL COMMENT '调查问卷ID',
  `f_date` datetime NOT NULL COMMENT '日期',
  `f_ip` varchar(100) NOT NULL COMMENT 'IP',
  `f_cookie` varchar(100) NOT NULL COMMENT 'Cookie',
  PRIMARY KEY (`f_questionrecord_id`),
  KEY `fk_cms_questionrecord_question` (`f_question_id`) USING BTREE,
  KEY `fk_cms_questionrecord_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_questionrecord_question` FOREIGN KEY (`f_question_id`) REFERENCES `cms_question` (`f_question_id`),
  CONSTRAINT `fk_cms_questionrecord_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_question_record
-- ----------------------------
INSERT INTO `cms_question_record` VALUES ('3', '1', '1', '2015-12-08 16:12:28', '127.0.0.1', '2dde68cd95f54781b2fde279de89cb2d');
INSERT INTO `cms_question_record` VALUES ('4', null, '1', '2016-03-22 17:39:56', '127.0.0.1', 'c76e26ec3ed749e0b9bf4782ae50e4f5');

-- ----------------------------
-- Table structure for cms_role
-- ----------------------------
DROP TABLE IF EXISTS `cms_role`;
CREATE TABLE `cms_role` (
  `f_role_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_rank` int(11) NOT NULL DEFAULT '999' COMMENT '等级',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_perms` mediumtext COMMENT '功能权限',
  `f_is_all_perm` char(1) NOT NULL DEFAULT '1' COMMENT '是否拥有所有功能权限',
  `f_is_all_info_perm` char(1) NOT NULL DEFAULT '1' COMMENT '是否拥有所有文档权限',
  `f_is_all_node_perm` char(1) NOT NULL DEFAULT '1' COMMENT '是否拥有所有栏目权限',
  `f_is_info_final_perm` char(1) NOT NULL DEFAULT '0' COMMENT '是否拥有文档终审权限',
  `f_info_perm_type` int(11) NOT NULL DEFAULT '1' COMMENT '文档权限类型(1:所有;2:组织;3:自身)',
  PRIMARY KEY (`f_role_id`),
  KEY `fk_cms_role_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_role_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_role
-- ----------------------------
INSERT INTO `cms_role` VALUES ('1', '1', '管理员', null, '1', '2147483647', null, '1', '1', '1', '1', '1');
INSERT INTO `cms_role` VALUES ('17', '1', '操作员', null, '999', '2147483647', null, '1', '1', '1', '0', '1');

-- ----------------------------
-- Table structure for cms_schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `cms_schedule_job`;
CREATE TABLE `cms_schedule_job` (
  `f_schedulejob_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '任务名称',
  `f_group` varchar(100) DEFAULT NULL COMMENT '任务组',
  `f_code` varchar(100) NOT NULL COMMENT '任务代码',
  `f_data` mediumtext COMMENT '任务数据',
  `f_description` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `f_cron_expression` varchar(100) DEFAULT NULL COMMENT 'Cron表达式',
  `f_start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `f_end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `f_start_delay` bigint(20) DEFAULT NULL COMMENT '首次延迟时间(分钟)',
  `f_repeat_interval` bigint(20) DEFAULT NULL COMMENT '间隔时间',
  `f_unit` int(11) DEFAULT NULL COMMENT '时间单位(1:毫秒,2:秒,3:分,4:时,5:天,6:周,7:月,8:年)',
  `f_cycle` int(11) NOT NULL DEFAULT '1' COMMENT '执行周期(1:cron,2:simple)',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:启用;1:禁用)',
  PRIMARY KEY (`f_schedulejob_id`),
  KEY `fk_cms_schedulejob_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_schedulejob_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_schedulejob_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_schedulejob_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_schedule_job
-- ----------------------------

-- ----------------------------
-- Table structure for cms_score_board
-- ----------------------------
DROP TABLE IF EXISTS `cms_score_board`;
CREATE TABLE `cms_score_board` (
  `f_scoreboard_id` int(11) NOT NULL,
  `f_scoreitem_id` int(11) NOT NULL COMMENT '记分项',
  `f_ftype` varchar(50) NOT NULL COMMENT '外表标识',
  `f_fid` int(11) NOT NULL COMMENT '外表ID',
  `f_votes` int(11) NOT NULL DEFAULT '0' COMMENT '投票次数',
  PRIMARY KEY (`f_scoreboard_id`),
  KEY `fk_cms_scoreboard_scoreitem` (`f_scoreitem_id`) USING BTREE,
  CONSTRAINT `fk_cms_scoreboard_scoreitem` FOREIGN KEY (`f_scoreitem_id`) REFERENCES `cms_score_item` (`f_scoreitem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_score_board
-- ----------------------------
INSERT INTO `cms_score_board` VALUES ('1', '1', 'InfoScore', '97', '1');
INSERT INTO `cms_score_board` VALUES ('2', '1', 'InfoScore', '28', '1');
INSERT INTO `cms_score_board` VALUES ('3', '13', 'InfoScore', '94', '4');
INSERT INTO `cms_score_board` VALUES ('4', '11', 'InfoScore', '95', '1');
INSERT INTO `cms_score_board` VALUES ('5', '13', 'InfoScore', '93', '1');
INSERT INTO `cms_score_board` VALUES ('6', '2', 'InfoScore', '55', '1');
INSERT INTO `cms_score_board` VALUES ('7', '12', 'InfoScore', '93', '1');
INSERT INTO `cms_score_board` VALUES ('8', '10', 'InfoScore', '98', '1');
INSERT INTO `cms_score_board` VALUES ('9', '13', 'InfoScore', '97', '1');
INSERT INTO `cms_score_board` VALUES ('10', '3', 'InfoScore', '87', '1');
INSERT INTO `cms_score_board` VALUES ('11', '4', 'InfoScore', '87', '1');
INSERT INTO `cms_score_board` VALUES ('12', '5', 'InfoScore', '28', '1');
INSERT INTO `cms_score_board` VALUES ('13', '8', 'InfoScore', '126', '1');
INSERT INTO `cms_score_board` VALUES ('14', '2', 'InfoScore', '32', '1');
INSERT INTO `cms_score_board` VALUES ('15', '10', 'InfoScore', '94', '3');
INSERT INTO `cms_score_board` VALUES ('16', '9', 'InfoScore', '94', '16');
INSERT INTO `cms_score_board` VALUES ('17', '12', 'InfoScore', '94', '2');
INSERT INTO `cms_score_board` VALUES ('18', '11', 'InfoScore', '94', '2');
INSERT INTO `cms_score_board` VALUES ('19', '12', 'InfoScore', '130', '1');
INSERT INTO `cms_score_board` VALUES ('20', '13', 'InfoScore', '130', '1');
INSERT INTO `cms_score_board` VALUES ('21', '10', 'InfoScore', '97', '1');
INSERT INTO `cms_score_board` VALUES ('22', '6', 'InfoScore', '126', '1');
INSERT INTO `cms_score_board` VALUES ('23', '6', 'InfoScore', '127', '3');
INSERT INTO `cms_score_board` VALUES ('24', '5', 'InfoScore', '127', '3');
INSERT INTO `cms_score_board` VALUES ('25', '4', 'InfoScore', '127', '1');
INSERT INTO `cms_score_board` VALUES ('26', '7', 'InfoScore', '127', '1');
INSERT INTO `cms_score_board` VALUES ('27', '11', 'InfoScore', '132', '1');

-- ----------------------------
-- Table structure for cms_score_group
-- ----------------------------
DROP TABLE IF EXISTS `cms_score_group`;
CREATE TABLE `cms_score_group` (
  `f_scoregroup_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_number` varchar(100) DEFAULT NULL COMMENT '代码',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_scoregroup_id`),
  KEY `fk_cms_scoregroup_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_scoregroup_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_score_group
-- ----------------------------
INSERT INTO `cms_score_group` VALUES ('1', '1', '心情评分', 'mood', null, '0');
INSERT INTO `cms_score_group` VALUES ('2', '1', '星级评分', 'star', null, '1');

-- ----------------------------
-- Table structure for cms_score_item
-- ----------------------------
DROP TABLE IF EXISTS `cms_score_item`;
CREATE TABLE `cms_score_item` (
  `f_scoreitem_id` int(11) NOT NULL,
  `f_scoregroup_id` int(11) NOT NULL COMMENT '计分组',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_score` int(11) NOT NULL DEFAULT '1' COMMENT '分值',
  `f_icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_scoreitem_id`),
  KEY `fk_cms_scoreitem_scoregroup` (`f_scoregroup_id`) USING BTREE,
  KEY `fk_cms_scoreitem_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_scoreitem_scoregroup` FOREIGN KEY (`f_scoregroup_id`) REFERENCES `cms_score_group` (`f_scoregroup_id`),
  CONSTRAINT `fk_cms_scoreitem_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_score_item
-- ----------------------------
INSERT INTO `cms_score_item` VALUES ('1', '1', '1', '感动', '1', '/mood/0.gif', '0');
INSERT INTO `cms_score_item` VALUES ('2', '1', '1', '路过', '1', '/mood/1.gif', '1');
INSERT INTO `cms_score_item` VALUES ('3', '1', '1', '高兴', '1', '/mood/2.gif', '2');
INSERT INTO `cms_score_item` VALUES ('4', '1', '1', '难过', '1', '/mood/3.gif', '3');
INSERT INTO `cms_score_item` VALUES ('5', '1', '1', '搞笑', '1', '/mood/4.gif', '4');
INSERT INTO `cms_score_item` VALUES ('6', '1', '1', '无聊', '1', '/mood/5.gif', '5');
INSERT INTO `cms_score_item` VALUES ('7', '1', '1', '愤怒', '1', '/mood/6.gif', '6');
INSERT INTO `cms_score_item` VALUES ('8', '1', '1', '同情', '1', '/mood/7.gif', '7');
INSERT INTO `cms_score_item` VALUES ('9', '2', '1', '一星', '1', null, '0');
INSERT INTO `cms_score_item` VALUES ('10', '2', '1', '二星', '2', null, '1');
INSERT INTO `cms_score_item` VALUES ('11', '2', '1', '三星', '3', null, '2');
INSERT INTO `cms_score_item` VALUES ('12', '2', '1', '四星', '4', null, '3');
INSERT INTO `cms_score_item` VALUES ('13', '2', '1', '五星', '5', null, '4');

-- ----------------------------
-- Table structure for cms_sensitive_word
-- ----------------------------
DROP TABLE IF EXISTS `cms_sensitive_word`;
CREATE TABLE `cms_sensitive_word` (
  `f_sensitiveword_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '敏感词',
  `f_replacement` varchar(100) DEFAULT NULL COMMENT '替换词',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:启用,1:禁用)',
  PRIMARY KEY (`f_sensitiveword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_sensitive_word
-- ----------------------------

-- ----------------------------
-- Table structure for cms_site
-- ----------------------------
DROP TABLE IF EXISTS `cms_site`;
CREATE TABLE `cms_site` (
  `f_site_id` int(11) NOT NULL,
  `f_global_id` int(11) NOT NULL COMMENT '全局',
  `f_org_id` int(11) NOT NULL COMMENT '组织',
  `f_html_publishpoint_id` int(11) NOT NULL COMMENT 'HTML发布点',
  `f_mobile_publishpoint_id` int(11) DEFAULT NULL COMMENT '手机端发布点',
  `f_parent_id` int(11) DEFAULT NULL COMMENT '上级站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_number` varchar(100) NOT NULL COMMENT '代码',
  `f_full_name` varchar(100) DEFAULT NULL COMMENT '完整名称',
  `f_no_picture` varchar(255) NOT NULL DEFAULT '/img/no_picture.jpg' COMMENT '暂无图片',
  `f_template_theme` varchar(100) NOT NULL DEFAULT 'default' COMMENT '模板主题',
  `f_domain` varchar(100) NOT NULL DEFAULT 'localhost' COMMENT '域名',
  `f_is_identify_domain` char(1) NOT NULL DEFAULT '0' COMMENT '是否识别域名',
  `f_is_static_home` char(1) NOT NULL DEFAULT '0' COMMENT '是否静态首页',
  `f_mobile_theme` varchar(100) DEFAULT 'default' COMMENT '手机端模板主题',
  `f_mobile_domain` varchar(100) DEFAULT NULL COMMENT '手机端域名',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:正常,1:禁用)',
  `f_tree_number` varchar(100) NOT NULL DEFAULT '0000' COMMENT '树编码',
  `f_tree_level` int(11) NOT NULL DEFAULT '0' COMMENT '树级别',
  `f_tree_max` varchar(10) NOT NULL DEFAULT '0000' COMMENT '树子节点最大编码',
  PRIMARY KEY (`f_site_id`),
  UNIQUE KEY `ak_number` (`f_number`) USING BTREE,
  KEY `fk_cms_site_global` (`f_global_id`) USING BTREE,
  KEY `fk_cms_site_org` (`f_org_id`) USING BTREE,
  KEY `fk_cms_site_parent` (`f_parent_id`) USING BTREE,
  KEY `fk_cms_site_publishpoint` (`f_html_publishpoint_id`) USING BTREE,
  KEY `fk_cms_site_publishpoint_m` (`f_mobile_publishpoint_id`) USING BTREE,
  CONSTRAINT `fk_cms_site_global` FOREIGN KEY (`f_global_id`) REFERENCES `cms_global` (`f_global_id`),
  CONSTRAINT `fk_cms_site_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`),
  CONSTRAINT `fk_cms_site_parent` FOREIGN KEY (`f_parent_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_site_publishpoint` FOREIGN KEY (`f_html_publishpoint_id`) REFERENCES `cms_publish_point` (`f_publishpoint_id`),
  CONSTRAINT `fk_cms_site_publishpoint_m` FOREIGN KEY (`f_mobile_publishpoint_id`) REFERENCES `cms_publish_point` (`f_publishpoint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_site
-- ----------------------------
INSERT INTO `cms_site` VALUES ('1', '1', '1', '2', '2', null, '国政舆情信息管理系统', '1', '国政舆情信息管理系统', '/img/nopic.jpg', 'default', 'localhost', '0', '0', 'm', 'localhost', '0', '0000', '0', '0000');

-- ----------------------------
-- Table structure for cms_site_clob
-- ----------------------------
DROP TABLE IF EXISTS `cms_site_clob`;
CREATE TABLE `cms_site_clob` (
  `f_site_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` mediumtext COMMENT '值',
  KEY `fk_cms_siteclob_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_siteclob_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_site_clob
-- ----------------------------

-- ----------------------------
-- Table structure for cms_site_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_site_custom`;
CREATE TABLE `cms_site_custom` (
  `f_site_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_sitecustom_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_sitecustom_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_site_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_special
-- ----------------------------
DROP TABLE IF EXISTS `cms_special`;
CREATE TABLE `cms_special` (
  `f_special_id` int(11) NOT NULL,
  `f_creator_id` int(11) NOT NULL COMMENT '创建者',
  `f_model_id` int(11) NOT NULL COMMENT '模型',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_speccate_id` int(11) NOT NULL COMMENT '专题类别',
  `f_creation_date` datetime NOT NULL COMMENT '创建日期',
  `f_title` varchar(150) NOT NULL COMMENT '标题',
  `f_meta_keywords` varchar(150) DEFAULT NULL COMMENT '关键字',
  `f_meta_description` varchar(450) DEFAULT NULL COMMENT '描述',
  `f_special_template` varchar(255) DEFAULT NULL COMMENT '专题模板',
  `f_small_image` varchar(255) DEFAULT NULL COMMENT '小图',
  `f_large_image` varchar(255) DEFAULT NULL COMMENT '大图',
  `f_video` varchar(255) DEFAULT NULL COMMENT '视频',
  `f_video_name` varchar(255) DEFAULT NULL COMMENT '视频名称',
  `f_video_length` bigint(20) DEFAULT NULL COMMENT '视频长度',
  `f_video_time` varchar(100) DEFAULT NULL COMMENT '视频时间',
  `f_refers` int(11) NOT NULL DEFAULT '0' COMMENT '文档数量',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_is_with_image` char(1) NOT NULL DEFAULT '0' COMMENT '是否有图片',
  `f_is_recommend` char(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  PRIMARY KEY (`f_special_id`),
  KEY `fk_cms_special_creator` (`f_creator_id`) USING BTREE,
  KEY `fk_cms_special_model` (`f_model_id`) USING BTREE,
  KEY `fk_cms_special_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_special_speccate` (`f_speccate_id`) USING BTREE,
  CONSTRAINT `fk_cms_special_creator` FOREIGN KEY (`f_creator_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_special_model` FOREIGN KEY (`f_model_id`) REFERENCES `cms_model` (`f_model_id`),
  CONSTRAINT `fk_cms_special_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_special_speccate` FOREIGN KEY (`f_speccate_id`) REFERENCES `cms_special_category` (`f_speccate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_special
-- ----------------------------
INSERT INTO `cms_special` VALUES ('2', '1', '17', '1', '5', '2013-02-27 17:10:53', '文章姚笛出轨被曝', null, null, null, null, null, null, null, null, null, '8', '0', '0', '1');
INSERT INTO `cms_special` VALUES ('8', '1', '17', '1', '2', '2014-03-31 10:46:17', '2014索契冬奥会', '冬奥会, 2014冬奥会,索契冬奥会,2014索契冬奥会, 第22届冬奥会, 冬季奥林匹克运动会', '第22届冬季奥林匹克运动会于2014年2月7日～23日召开', null, 'http://demo.jspxcms.com/uploads/1/image/public/201403/20140331105551_obxbxw.jpg', null, null, null, null, null, '5', '1', '1', '1');
INSERT INTO `cms_special` VALUES ('10', '1', '17', '1', '1', '2013-03-19 02:58:35', '美国网络监控“棱镜”项目曝光', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224161821_1fftmaayvv.jpg', null, null, null, null, null, '6', '0', '1', '1');
INSERT INTO `cms_special` VALUES ('11', '1', '17', '1', '6', '2013-03-19 03:00:11', '乌克兰局势动荡', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224161637_b6hopxqp3l.jpg', null, null, null, null, null, '2', '0', '1', '1');
INSERT INTO `cms_special` VALUES ('12', '1', '17', '1', '1', '2013-03-19 03:00:39', '央视暗拍曝光东莞色情业', null, null, null, 'http://demo.jspxcms.com/uploads/1/image/public/201512/20151224161539_509ekqycst.jpg', null, null, null, null, null, '3', '0', '1', '1');
INSERT INTO `cms_special` VALUES ('13', '1', '17', '1', '2', '2014-03-18 00:00:02', '马航客机失联', '马航客机失联,MH370,马来西亚,飞机,北京,失联', '马来西亚航空公司8日凌晨，与一架载有239人的飞机失去联系。这架航班上共载227名乘客，含154名中国人。客机系波音777-200型号，计划于北京时间6：30分抵达北京。', null, 'http://demo.jspxcms.com/uploads/1/image/public/201403/20140330221351_nkb5c4.jpg', 'http://demo.jspxcms.com/uploads/1/image/public/201403/20140330221023_nrob4d.jpg', null, null, null, null, '2', '0', '1', '1');

-- ----------------------------
-- Table structure for cms_special_category
-- ----------------------------
DROP TABLE IF EXISTS `cms_special_category`;
CREATE TABLE `cms_special_category` (
  `f_speccate_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(50) NOT NULL COMMENT '名称',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_views` int(11) NOT NULL DEFAULT '0' COMMENT '浏览总数',
  `f_meta_keywords` varchar(150) DEFAULT NULL COMMENT '关键字',
  `f_meta_description` varchar(450) DEFAULT NULL COMMENT '描述',
  `f_creation_date` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`f_speccate_id`),
  KEY `fk_cms_speccategory_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_speccategory_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_special_category
-- ----------------------------
INSERT INTO `cms_special_category` VALUES ('1', '1', '国内', '0', '0', null, null, '2013-02-28 17:09:49');
INSERT INTO `cms_special_category` VALUES ('2', '1', '国际', '1', '0', null, null, '2013-03-18 02:22:45');
INSERT INTO `cms_special_category` VALUES ('5', '1', '娱乐', '2147483647', '0', null, null, '2014-11-27 20:47:03');
INSERT INTO `cms_special_category` VALUES ('6', '1', '体育', '2147483647', '0', null, null, '2014-11-27 20:47:09');

-- ----------------------------
-- Table structure for cms_special_clob
-- ----------------------------
DROP TABLE IF EXISTS `cms_special_clob`;
CREATE TABLE `cms_special_clob` (
  `f_special_id` int(11) NOT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` mediumtext COMMENT '值',
  KEY `fk_cms_specialclob_special` (`f_special_id`) USING BTREE,
  CONSTRAINT `fk_cms_specialclob_special` FOREIGN KEY (`f_special_id`) REFERENCES `cms_special` (`f_special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_special_clob
-- ----------------------------

-- ----------------------------
-- Table structure for cms_special_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_special_custom`;
CREATE TABLE `cms_special_custom` (
  `f_special_id` int(11) NOT NULL,
  `f_key` varchar(50) DEFAULT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_specialcustom_special` (`f_special_id`) USING BTREE,
  CONSTRAINT `fk_cms_specialcustom_special` FOREIGN KEY (`f_special_id`) REFERENCES `cms_special` (`f_special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_special_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_special_file
-- ----------------------------
DROP TABLE IF EXISTS `cms_special_file`;
CREATE TABLE `cms_special_file` (
  `f_special_id` int(11) NOT NULL,
  `f_name` varchar(150) NOT NULL COMMENT '文件名称',
  `f_length` bigint(20) NOT NULL DEFAULT '0' COMMENT '文件长度',
  `f_file` varchar(255) NOT NULL COMMENT '文件地址',
  `f_index` int(11) NOT NULL DEFAULT '0' COMMENT '文件序号',
  `f_downloads` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  KEY `fk_cms_specialfile_special` (`f_special_id`) USING BTREE,
  CONSTRAINT `fk_cms_specialfile_special` FOREIGN KEY (`f_special_id`) REFERENCES `cms_special` (`f_special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_special_file
-- ----------------------------

-- ----------------------------
-- Table structure for cms_special_image
-- ----------------------------
DROP TABLE IF EXISTS `cms_special_image`;
CREATE TABLE `cms_special_image` (
  `f_special_id` int(11) NOT NULL,
  `f_name` varchar(150) DEFAULT NULL COMMENT '图片名称',
  `f_image` varchar(255) DEFAULT NULL COMMENT '图片地址',
  `f_index` int(11) NOT NULL DEFAULT '0' COMMENT '图片序号',
  `f_text` mediumtext COMMENT '图片正文',
  KEY `fk_cms_specialimage_special` (`f_special_id`) USING BTREE,
  CONSTRAINT `fk_cms_specialimage_special` FOREIGN KEY (`f_special_id`) REFERENCES `cms_special` (`f_special_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_special_image
-- ----------------------------

-- ----------------------------
-- Table structure for cms_tag
-- ----------------------------
DROP TABLE IF EXISTS `cms_tag`;
CREATE TABLE `cms_tag` (
  `f_tag_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_creation_date` datetime NOT NULL COMMENT '创建日期',
  `f_refers` int(11) NOT NULL DEFAULT '0' COMMENT '文档数量',
  PRIMARY KEY (`f_tag_id`),
  KEY `fk_cms_tag_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_tag_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_tag
-- ----------------------------
INSERT INTO `cms_tag` VALUES ('56', '1', '中国', '2013-03-11 12:00:12', '3');
INSERT INTO `cms_tag` VALUES ('57', '1', '美国', '2013-03-11 12:00:12', '1');
INSERT INTO `cms_tag` VALUES ('58', '1', '中兴', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('59', '1', '蒙古国', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('60', '1', '反贪局', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('61', '1', '逮捕', '2013-03-19 02:08:21', '1');
INSERT INTO `cms_tag` VALUES ('62', '1', '金融危机', '2013-03-19 02:08:58', '1');
INSERT INTO `cms_tag` VALUES ('63', '1', '苏联', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('64', '1', '军火', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('65', '1', '贿赂', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('66', '1', '罗斯福', '2013-03-19 02:09:23', '1');
INSERT INTO `cms_tag` VALUES ('67', '1', '可转债', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('68', '1', '违约', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('69', '1', '首家', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('70', '1', '公司债', '2013-03-19 02:10:00', '1');
INSERT INTO `cms_tag` VALUES ('71', '1', '英国', '2013-03-19 02:27:44', '1');
INSERT INTO `cms_tag` VALUES ('72', '1', '常规武器', '2013-03-19 02:27:44', '1');
INSERT INTO `cms_tag` VALUES ('73', '1', '出口国', '2013-03-19 02:27:44', '1');
INSERT INTO `cms_tag` VALUES ('78', '1', '美女', '2014-03-31 15:03:17', '1');
INSERT INTO `cms_tag` VALUES ('79', '1', '宝贝', '2014-03-31 15:03:17', '1');
INSERT INTO `cms_tag` VALUES ('80', '1', '灰熊', '2014-03-31 15:03:18', '1');
INSERT INTO `cms_tag` VALUES ('81', '1', '南印度洋', '2014-06-14 10:27:25', '1');
INSERT INTO `cms_tag` VALUES ('82', '1', 'MH370', '2014-06-14 10:27:26', '1');
INSERT INTO `cms_tag` VALUES ('83', '1', '黑匣子', '2014-06-14 10:27:26', '1');
INSERT INTO `cms_tag` VALUES ('84', '1', '视频', '2014-12-16 15:25:53', '14');

-- ----------------------------
-- Table structure for cms_task
-- ----------------------------
DROP TABLE IF EXISTS `cms_task`;
CREATE TABLE `cms_task` (
  `f_task_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_name` varchar(150) NOT NULL COMMENT '名称',
  `f_description` mediumtext COMMENT '描述',
  `f_begin_time` datetime NOT NULL COMMENT '开始时间',
  `f_end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `f_total` int(11) NOT NULL DEFAULT '0' COMMENT '总完成数量',
  `f_type` int(11) NOT NULL DEFAULT '1' COMMENT '类型(1:栏目HTML生成,2:文档HTML生成,3:全文索引生成)',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:运行中,1:完成,2:中止,3:停止)',
  PRIMARY KEY (`f_task_id`),
  KEY `fk_cms_task_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_task_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_task_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_task_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_task
-- ----------------------------

-- ----------------------------
-- Table structure for cms_user
-- ----------------------------
DROP TABLE IF EXISTS `cms_user`;
CREATE TABLE `cms_user` (
  `f_user_id` int(11) NOT NULL,
  `f_org_id` int(11) NOT NULL COMMENT '组织',
  `f_membergroup_id` int(11) NOT NULL COMMENT '会员组',
  `f_global_id` int(11) NOT NULL COMMENT '全局',
  `f_username` varchar(50) NOT NULL COMMENT '用户名',
  `f_password` varchar(128) DEFAULT NULL COMMENT '密码',
  `f_salt` varchar(32) DEFAULT NULL COMMENT '加密混淆码',
  `f_email` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `f_mobile` varchar(100) DEFAULT NULL COMMENT '手机',
  `f_real_name` varchar(100) DEFAULT NULL COMMENT '用户实名',
  `f_gender` char(1) DEFAULT NULL COMMENT '性别',
  `f_birth_date` datetime DEFAULT NULL COMMENT '出生年月',
  `f_validation_type` varchar(50) DEFAULT NULL COMMENT '验证类型(用户激活,重置密码,邮箱激活)',
  `f_validation_key` varchar(100) DEFAULT NULL COMMENT '验证KEY',
  `f_rank` int(11) NOT NULL DEFAULT '99999' COMMENT '等级',
  `f_type` int(11) NOT NULL DEFAULT '0' COMMENT '类型(0:会员,1:管理员)',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:正常,1:锁定,2:待验证)',
  `f_qq_openid` varchar(64) DEFAULT NULL COMMENT 'qq openid',
  `f_weibo_uid` varchar(64) DEFAULT NULL COMMENT 'weibo uid',
  `f_weixin_openid` varchar(64) DEFAULT NULL COMMENT 'weixin openid',
  PRIMARY KEY (`f_user_id`),
  UNIQUE KEY `ak_username` (`f_username`) USING BTREE,
  KEY `fk_cms_user_global` (`f_global_id`) USING BTREE,
  KEY `fk_cms_user_membergroup` (`f_membergroup_id`) USING BTREE,
  KEY `fk_cms_user_org` (`f_org_id`) USING BTREE,
  CONSTRAINT `fk_cms_user_global` FOREIGN KEY (`f_global_id`) REFERENCES `cms_global` (`f_global_id`),
  CONSTRAINT `fk_cms_user_membergroup` FOREIGN KEY (`f_membergroup_id`) REFERENCES `cms_member_group` (`f_membergroup_id`),
  CONSTRAINT `fk_cms_user_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_user
-- ----------------------------
INSERT INTO `cms_user` VALUES ('0', '1', '1', '1', 'anonymous', null, null, null, null, null, 'M', null, null, null, '1', '1', '1', null, null, null);
INSERT INTO `cms_user` VALUES ('1', '1', '1', '1', 'admin', 'f9a0370e6bce9b8a393128469626694c6a829aab', '8dd661a6fdfcbe92', null, null, '管理员', null, null, null, null, '0', '1', '0', null, null, null);
INSERT INTO `cms_user` VALUES ('31', '1', '1', '1', '日天', null, '85e9c77db30b43db', null, null, '热', null, null, null, null, '1', '1', '0', null, null, null);
INSERT INTO `cms_user` VALUES ('41', '1', '1', '1', 'test', '2cc7a01598d8a2b42367fcf5a19a3136aae90b25', 'd520d8b2dacd45c3', 'test@test.com', null, null, null, null, null, null, '99999', '0', '0', null, null, null);

-- ----------------------------
-- Table structure for cms_user_clob
-- ----------------------------
DROP TABLE IF EXISTS `cms_user_clob`;
CREATE TABLE `cms_user_clob` (
  `f_user_id` int(11) DEFAULT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` mediumtext COMMENT '值',
  KEY `fk_cms_userclob_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_userclob_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_user_clob
-- ----------------------------

-- ----------------------------
-- Table structure for cms_user_custom
-- ----------------------------
DROP TABLE IF EXISTS `cms_user_custom`;
CREATE TABLE `cms_user_custom` (
  `f_user_id` int(11) DEFAULT NULL,
  `f_key` varchar(50) NOT NULL COMMENT '键',
  `f_value` varchar(2000) DEFAULT NULL COMMENT '值',
  KEY `fk_cms_usercustom_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_usercustom_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_user_custom
-- ----------------------------

-- ----------------------------
-- Table structure for cms_user_detail
-- ----------------------------
DROP TABLE IF EXISTS `cms_user_detail`;
CREATE TABLE `cms_user_detail` (
  `f_user_id` int(11) NOT NULL,
  `f_validation_date` datetime DEFAULT NULL COMMENT '验证生成时间',
  `f_login_error_date` datetime DEFAULT NULL COMMENT '登录错误时间',
  `f_login_error_count` int(11) NOT NULL DEFAULT '0' COMMENT '登录错误次数',
  `f_prev_login_date` datetime DEFAULT NULL COMMENT '上次登录日期',
  `f_prev_login_ip` varchar(100) DEFAULT NULL COMMENT '上次登录IP',
  `f_last_login_date` datetime DEFAULT NULL COMMENT '最后登录日期',
  `f_last_login_ip` varchar(100) DEFAULT NULL COMMENT '最后登录IP',
  `f_creation_date` datetime NOT NULL COMMENT '加入日期',
  `f_creation_ip` varchar(100) NOT NULL COMMENT '加入IP',
  `f_logins` int(11) NOT NULL DEFAULT '0' COMMENT '登录次数',
  `f_is_with_avatar` char(1) NOT NULL DEFAULT '0' COMMENT '是否有头像',
  `f_bio` varchar(255) DEFAULT NULL COMMENT '自我介绍',
  `f_come_from` varchar(100) DEFAULT NULL COMMENT '来自',
  `f_qq` varchar(100) DEFAULT NULL COMMENT 'QQ',
  `f_msn` varchar(100) DEFAULT NULL COMMENT 'MSN',
  `f_weixin` varchar(100) DEFAULT NULL COMMENT '微信',
  PRIMARY KEY (`f_user_id`),
  CONSTRAINT `fk_cms_userdetail_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_user_detail
-- ----------------------------
INSERT INTO `cms_user_detail` VALUES ('0', null, null, '0', null, null, null, null, '2013-03-09 22:18:56', '127.0.0.1', '0', '0', null, null, null, null, null);
INSERT INTO `cms_user_detail` VALUES ('1', '2015-04-12 10:27:43', null, '0', '2018-02-01 15:26:13', '218.89.222.232', '2018-02-01 15:54:31', '171.217.113.157', '2013-02-21 20:59:27', '127.0.0.1', '789', '1', null, null, null, null, null);
INSERT INTO `cms_user_detail` VALUES ('31', null, null, '0', null, null, null, null, '2017-12-17 14:22:24', '192.168.1.7', '0', '0', null, null, null, null, null);
INSERT INTO `cms_user_detail` VALUES ('41', null, null, '0', null, null, '2018-02-01 14:53:49', '171.217.113.157', '2018-02-01 14:53:41', '171.217.113.157', '1', '0', null, null, null, null, null);

-- ----------------------------
-- Table structure for cms_user_membergroup
-- ----------------------------
DROP TABLE IF EXISTS `cms_user_membergroup`;
CREATE TABLE `cms_user_membergroup` (
  `f_user_id` int(11) NOT NULL,
  `f_membergroup_id` int(11) NOT NULL,
  `f_group_index` int(11) DEFAULT '0' COMMENT '会员组排列顺序',
  KEY `fk_cms_usermgroup_mgroup` (`f_membergroup_id`) USING BTREE,
  KEY `fk_cms_usermgroup_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_usermgroup_mgroup` FOREIGN KEY (`f_membergroup_id`) REFERENCES `cms_member_group` (`f_membergroup_id`),
  CONSTRAINT `fk_cms_usermgroup_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_user_membergroup
-- ----------------------------
INSERT INTO `cms_user_membergroup` VALUES ('41', '1', '0');

-- ----------------------------
-- Table structure for cms_user_org
-- ----------------------------
DROP TABLE IF EXISTS `cms_user_org`;
CREATE TABLE `cms_user_org` (
  `f_user_id` int(11) NOT NULL,
  `f_org_id` int(11) NOT NULL,
  `f_org_index` int(11) DEFAULT '0' COMMENT '组织顺序',
  KEY `fk_cms_userorg_org` (`f_org_id`) USING BTREE,
  KEY `fk_cms_userorg_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_userorg_org` FOREIGN KEY (`f_org_id`) REFERENCES `cms_org` (`f_org_id`),
  CONSTRAINT `fk_cms_userorg_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_user_org
-- ----------------------------
INSERT INTO `cms_user_org` VALUES ('41', '1', '0');

-- ----------------------------
-- Table structure for cms_user_role
-- ----------------------------
DROP TABLE IF EXISTS `cms_user_role`;
CREATE TABLE `cms_user_role` (
  `f_user_id` int(11) NOT NULL,
  `f_role_id` int(11) NOT NULL,
  `f_role_index` int(11) DEFAULT '0' COMMENT '角色顺序',
  KEY `fk_cms_userrole_role` (`f_role_id`) USING BTREE,
  KEY `fk_cms_userrole_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_userrole_role` FOREIGN KEY (`f_role_id`) REFERENCES `cms_role` (`f_role_id`),
  CONSTRAINT `fk_cms_userrole_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_user_role
-- ----------------------------
INSERT INTO `cms_user_role` VALUES ('1', '1', '0');

-- ----------------------------
-- Table structure for cms_visit_log
-- ----------------------------
DROP TABLE IF EXISTS `cms_visit_log`;
CREATE TABLE `cms_visit_log` (
  `f_visitlog_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_user_id` int(11) DEFAULT NULL COMMENT '访问用户',
  `f_url` varchar(255) NOT NULL COMMENT '页面URL',
  `f_referrer` varchar(255) DEFAULT NULL COMMENT '来源URL',
  `f_source` varchar(100) DEFAULT NULL COMMENT '来源域名',
  `f_ip` varchar(100) DEFAULT NULL COMMENT 'IP地址',
  `f_cookie` varchar(100) DEFAULT NULL COMMENT 'COOKIE值',
  `f_user_agent` varchar(450) DEFAULT NULL COMMENT '用户代理',
  `f_browser` varchar(100) DEFAULT NULL COMMENT '浏览器',
  `f_os` varchar(100) DEFAULT NULL COMMENT '操作系统',
  `f_device` varchar(100) DEFAULT NULL COMMENT '设备(COMPUTER,MOBILE,TABLET,等)',
  `f_country` varchar(100) DEFAULT NULL COMMENT '国家',
  `f_area` varchar(100) DEFAULT NULL COMMENT '地区',
  `f_time_string` char(14) NOT NULL COMMENT '访问时间（字符串格式yyyyMMddHHmmss）',
  `f_time` datetime NOT NULL COMMENT '访问时间',
  PRIMARY KEY (`f_visitlog_id`),
  KEY `fk_cms_visitlog_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_visitlog_user` (`f_user_id`) USING BTREE,
  CONSTRAINT `fk_cms_visitlog_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_visitlog_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_visit_log
-- ----------------------------
INSERT INTO `cms_visit_log` VALUES ('4526', '1', '1', 'http://127.0.0.1:8080/', 'http://127.0.0.1:8080/cmscp/', 'DIRECT', '127.0.0.1', '4407d41b4d4a452eb62f0681520f4897', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36', 'CHROME', 'WINDOWS_7', 'COMPUTER', 'LAN', 'LAN', '20171207231806', '2017-12-07 23:18:06');
INSERT INTO `cms_visit_log` VALUES ('4576', '1', null, 'http://localhost:8080/', '', 'DIRECT', '0:0:0:0:0:0:0:1', 'b4c03ff78a7c4118b816e674868b4289', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36', 'CHROME', 'WINDOWS_7', 'COMPUTER', 'LAN', 'LAN', '20171210131203', '2017-12-10 13:12:03');
INSERT INTO `cms_visit_log` VALUES ('4626', '1', null, 'http://192.168.100.88:8080/', '', 'DIRECT', '192.168.100.88', '1904b8435426480e91cb436f493149df', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36', 'CHROME', 'WINDOWS_7', 'COMPUTER', '局域网', '对方和您在同一内部网', '20171214141722', '2017-12-14 14:17:22');
INSERT INTO `cms_visit_log` VALUES ('4676', '1', null, 'http://192.168.1.7:8080/', '', 'DIRECT', '192.168.1.7', 'da524d400d034d9aaaecda5285cea17e', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36', 'CHROME', 'WINDOWS_7', 'COMPUTER', '局域网', '对方和您在同一内部网', '20171214200142', '2017-12-14 20:01:42');
INSERT INTO `cms_visit_log` VALUES ('4677', '1', '1', 'http://192.168.1.7:8080/', 'http://192.168.1.7:8080//cmscp/login.do', 'DIRECT', '192.168.1.7', 'da524d400d034d9aaaecda5285cea17e', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36', 'CHROME', 'WINDOWS_7', 'COMPUTER', '局域网', '对方和您在同一内部网', '20171214200229', '2017-12-14 20:02:29');
INSERT INTO `cms_visit_log` VALUES ('4678', '1', '1', 'http://192.168.1.7:8080/', '', 'DIRECT', '192.168.1.7', 'da524d400d034d9aaaecda5285cea17e', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36', 'CHROME', 'WINDOWS_7', 'COMPUTER', '局域网', '对方和您在同一内部网', '20171214200258', '2017-12-14 20:02:58');
INSERT INTO `cms_visit_log` VALUES ('4726', '1', null, 'http://192.168.100.88:8080/', '', 'DIRECT', '192.168.100.88', '1904b8435426480e91cb436f493149df', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36', 'CHROME', 'WINDOWS_7', 'COMPUTER', '局域网', '对方和您在同一内部网', '20171225104715', '2017-12-25 10:47:15');

-- ----------------------------
-- Table structure for cms_vote
-- ----------------------------
DROP TABLE IF EXISTS `cms_vote`;
CREATE TABLE `cms_vote` (
  `f_vote_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_title` varchar(150) NOT NULL COMMENT '标题',
  `f_number` varchar(100) DEFAULT NULL COMMENT '代码',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_begin_date` datetime DEFAULT NULL COMMENT '开始日期',
  `f_end_date` datetime DEFAULT NULL COMMENT '结束日期',
  `f_interval` int(11) NOT NULL DEFAULT '0' COMMENT '间隔时间（天）',
  `f_max_selected` int(11) NOT NULL DEFAULT '1' COMMENT '最多可选几项(0不限制)',
  `f_mode` int(11) NOT NULL DEFAULT '1' COMMENT '模式(1:独立访客,2:独立IP,3:独立用户)',
  `f_total` int(11) NOT NULL DEFAULT '0' COMMENT '总票数',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:启用,1:禁用)',
  PRIMARY KEY (`f_vote_id`),
  KEY `fk_cms_vote_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_vote_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_vote
-- ----------------------------
INSERT INTO `cms_vote` VALUES ('1', '1', '您从哪里知道本网站的', null, '当中超进入足彩，你会投注么？中国足球顶级联赛进入彩票的距离，从来没有像今年那样离彩民如此之近。体育总局也多次发文称，支持中超进入竞彩，可以说，中超进入体彩只剩时间问题。', null, null, '0', '1', '1', '6', '999', '0');

-- ----------------------------
-- Table structure for cms_vote_mark
-- ----------------------------
DROP TABLE IF EXISTS `cms_vote_mark`;
CREATE TABLE `cms_vote_mark` (
  `f_votemark_id` int(11) NOT NULL,
  `f_ftype` varchar(50) NOT NULL COMMENT '外表标识',
  `f_fid` int(11) NOT NULL COMMENT '外表ID',
  `f_date` datetime NOT NULL COMMENT '日期',
  `f_user_id` int(11) DEFAULT NULL COMMENT '用户',
  `f_ip` varchar(100) NOT NULL COMMENT 'IP',
  `f_cookie` varchar(100) NOT NULL COMMENT 'Cookie',
  PRIMARY KEY (`f_votemark_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_vote_mark
-- ----------------------------

-- ----------------------------
-- Table structure for cms_vote_option
-- ----------------------------
DROP TABLE IF EXISTS `cms_vote_option`;
CREATE TABLE `cms_vote_option` (
  `f_voteoption_id` int(11) NOT NULL,
  `f_vote_id` int(11) NOT NULL,
  `f_title` varchar(150) NOT NULL COMMENT '标题',
  `f_count` int(11) NOT NULL DEFAULT '0' COMMENT '得票数',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_voteoption_id`),
  KEY `fk_cms_voteoption_vote` (`f_vote_id`) USING BTREE,
  CONSTRAINT `fk_cms_voteoption_vote` FOREIGN KEY (`f_vote_id`) REFERENCES `cms_vote` (`f_vote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_vote_option
-- ----------------------------
INSERT INTO `cms_vote_option` VALUES ('1', '1', '朋友或同事介绍的', '0', '0');
INSERT INTO `cms_vote_option` VALUES ('2', '1', '在技术网站中看到', '2', '1');
INSERT INTO `cms_vote_option` VALUES ('4', '1', '通过搜索引擎', '1', '2');
INSERT INTO `cms_vote_option` VALUES ('6', '1', '其它途径', '3', '3');

-- ----------------------------
-- Table structure for cms_workflow
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow`;
CREATE TABLE `cms_workflow` (
  `f_workflow_id` int(11) NOT NULL,
  `f_workflowgroup_id` int(11) NOT NULL COMMENT '工作流',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  `f_status` int(11) NOT NULL DEFAULT '1' COMMENT '状态(1:启用;2:禁用)',
  PRIMARY KEY (`f_workflow_id`),
  KEY `fk_cms_workflow_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_workflow_workflowgroup` (`f_workflowgroup_id`) USING BTREE,
  CONSTRAINT `fk_cms_workflow_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_workflow_workflowgroup` FOREIGN KEY (`f_workflowgroup_id`) REFERENCES `cms_workflow_group` (`f_workflowgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_workflow
-- ----------------------------

-- ----------------------------
-- Table structure for cms_workflow_group
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_group`;
CREATE TABLE `cms_workflow_group` (
  `f_workflowgroup_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_description` varchar(255) DEFAULT NULL COMMENT '描述',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_workflowgroup_id`),
  KEY `fk_cms_workflowgroup_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_cms_workflowgroup_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_workflow_group
-- ----------------------------
INSERT INTO `cms_workflow_group` VALUES ('2', '1', '文档审核', null, '2147483647');

-- ----------------------------
-- Table structure for cms_workflow_log
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_log`;
CREATE TABLE `cms_workflow_log` (
  `f_workflowlog_id` int(11) NOT NULL,
  `f_user_id` int(11) NOT NULL COMMENT '操作人',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_workflowprocess_id` int(11) NOT NULL COMMENT '过程',
  `f_from` varchar(100) NOT NULL COMMENT '从哪',
  `f_to` varchar(100) NOT NULL COMMENT '到哪',
  `f_creation_date` datetime NOT NULL COMMENT '创建时间',
  `f_opinion` varchar(255) DEFAULT NULL COMMENT '意见',
  `f_type` int(11) NOT NULL COMMENT '类型(1:前进;2后退:;3:原地)',
  PRIMARY KEY (`f_workflowlog_id`),
  KEY `fk_cms_workflowlog_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_workflowlog_user` (`f_user_id`) USING BTREE,
  KEY `fk_cms_workflowlog_wfprocess` (`f_workflowprocess_id`) USING BTREE,
  CONSTRAINT `fk_cms_workflowlog_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_workflowlog_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_workflowlog_wfprocess` FOREIGN KEY (`f_workflowprocess_id`) REFERENCES `cms_workflow_process` (`f_workflowprocess_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_workflow_log
-- ----------------------------

-- ----------------------------
-- Table structure for cms_workflow_process
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_process`;
CREATE TABLE `cms_workflow_process` (
  `f_workflowprocess_id` int(11) NOT NULL,
  `f_workflowstep_id` int(11) DEFAULT NULL COMMENT '步骤',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_workflow_id` int(11) NOT NULL COMMENT '流程',
  `f_user_id` int(11) NOT NULL COMMENT '发起人',
  `f_data_id` int(11) NOT NULL COMMENT '数据ID',
  `f_data_type` int(11) NOT NULL COMMENT '数据类型(1:文档)',
  `f_begin_date` datetime NOT NULL COMMENT '开始时间',
  `f_end_date` datetime DEFAULT NULL COMMENT '结束时间',
  `f_is_rejection` char(1) NOT NULL DEFAULT '0' COMMENT '是否退回',
  `f_is_end` char(1) NOT NULL DEFAULT '0' COMMENT '是否结束',
  PRIMARY KEY (`f_workflowprocess_id`),
  KEY `fk_cms_workflowproc_site` (`f_site_id`) USING BTREE,
  KEY `fk_cms_workflowproc_user` (`f_user_id`) USING BTREE,
  KEY `fk_cms_workflowproc_wfstep` (`f_workflowstep_id`) USING BTREE,
  KEY `fk_cms_workflowproc_workflow` (`f_workflow_id`) USING BTREE,
  CONSTRAINT `fk_cms_workflowproc_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`),
  CONSTRAINT `fk_cms_workflowproc_user` FOREIGN KEY (`f_user_id`) REFERENCES `cms_user` (`f_user_id`),
  CONSTRAINT `fk_cms_workflowproc_wfstep` FOREIGN KEY (`f_workflowstep_id`) REFERENCES `cms_workflow_step` (`f_workflowstep_id`),
  CONSTRAINT `fk_cms_workflowproc_workflow` FOREIGN KEY (`f_workflow_id`) REFERENCES `cms_workflow` (`f_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_workflow_process
-- ----------------------------

-- ----------------------------
-- Table structure for cms_workflow_step
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflow_step`;
CREATE TABLE `cms_workflow_step` (
  `f_workflowstep_id` int(11) NOT NULL,
  `f_workflow_id` int(11) NOT NULL COMMENT '工作流',
  `f_name` varchar(100) NOT NULL COMMENT '名称',
  `f_seq` int(11) NOT NULL DEFAULT '2147483647' COMMENT '排序',
  PRIMARY KEY (`f_workflowstep_id`),
  KEY `fk_cms_workflowstep_workflow` (`f_workflow_id`) USING BTREE,
  CONSTRAINT `fk_cms_workflowstep_workflow` FOREIGN KEY (`f_workflow_id`) REFERENCES `cms_workflow` (`f_workflow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_workflow_step
-- ----------------------------

-- ----------------------------
-- Table structure for cms_workflowstep_role
-- ----------------------------
DROP TABLE IF EXISTS `cms_workflowstep_role`;
CREATE TABLE `cms_workflowstep_role` (
  `f_role_id` int(11) NOT NULL,
  `f_workflowstep_id` int(11) NOT NULL,
  `f_role_index` int(11) DEFAULT '0' COMMENT '角色排列顺序',
  KEY `fk_cms_wfsteprole_role` (`f_role_id`) USING BTREE,
  KEY `fk_cms_wfsteprole_wfstep` (`f_workflowstep_id`) USING BTREE,
  CONSTRAINT `fk_cms_wfsteprole_role` FOREIGN KEY (`f_role_id`) REFERENCES `cms_role` (`f_role_id`),
  CONSTRAINT `fk_cms_wfsteprole_wfstep` FOREIGN KEY (`f_workflowstep_id`) REFERENCES `cms_workflow_step` (`f_workflowstep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cms_workflowstep_role
-- ----------------------------

-- ----------------------------
-- Table structure for cms_yq_contract
-- ----------------------------
DROP TABLE IF EXISTS `cms_yq_contract`;
CREATE TABLE `cms_yq_contract` (
  `f_contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_customer_id` int(11) DEFAULT NULL COMMENT 'cms_cusomer外键  客户',
  `f_contract_code` varchar(100) DEFAULT NULL,
  `f_operator` varchar(50) DEFAULT NULL COMMENT '经办人',
  `f_contract_money` decimal(11,2) DEFAULT NULL COMMENT '合同金额',
  `f_contract_create_time` date DEFAULT NULL COMMENT '合同日期',
  `f_contract_end_time` date DEFAULT NULL COMMENT '服务终止时间',
  `f_remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `f_area_id` int(11) DEFAULT NULL COMMENT '地区',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  PRIMARY KEY (`f_contract_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cms_yq_contract
-- ----------------------------
INSERT INTO `cms_yq_contract` VALUES ('1', '2', '俺的沙发', '大师傅', '21.22', '2017-12-14', '2018-12-23', '发多少', '14', '1');
INSERT INTO `cms_yq_contract` VALUES ('2', '3', 'sadfasd', 'asdf', '3232.00', '2017-12-27', '2018-02-01', 'dsffsd', '14', '1');
INSERT INTO `cms_yq_contract` VALUES ('4', '2', '俺的沙发', '大师傅', '21.22', '2017-10-01', '2017-11-23', '发多少', '14', '1');
INSERT INTO `cms_yq_contract` VALUES ('3', '2', '俺的沙发', '大师傅', '21.22', '2017-11-01', '2018-01-05', '发多少', '14', '1');

-- ----------------------------
-- Table structure for cms_yq_customer
-- ----------------------------
DROP TABLE IF EXISTS `cms_yq_customer`;
CREATE TABLE `cms_yq_customer` (
  `f_customer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `f_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '客户名称',
  `f_web_url` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '客户网站',
  `f_weixin_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '微信公众号',
  `f_area_id` int(11) NOT NULL COMMENT '所属区域,cms_dict外键',
  `f_code` varchar(200) NOT NULL COMMENT '信用统一代码',
  `f_clearance` tinyint(1) DEFAULT '0' COMMENT '是否结清',
  `f_remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:正常,1:锁定,2:待验证)',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_contact1` varchar(30) DEFAULT NULL COMMENT '联系人1',
  `f_contact1_phone` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `f_contact1_qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `f_contact1_weixin` varchar(20) DEFAULT NULL,
  `f_contact2` varchar(30) DEFAULT NULL COMMENT '联系人1',
  `f_contact2_phone` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `f_contact2_qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `f_contact2_weixin` varchar(20) DEFAULT NULL,
  `f_contact3` varchar(30) DEFAULT NULL COMMENT '联系人1',
  `f_contact3_phone` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `f_contact3_qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `f_contact3_weixin` varchar(20) DEFAULT NULL,
  `f_contact4` varchar(30) DEFAULT NULL COMMENT '联系人1',
  `f_contact4_phone` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `f_contact4_qq` varchar(20) DEFAULT NULL COMMENT 'qq',
  `f_contact4_weixin` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`f_customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cms_yq_customer
-- ----------------------------
INSERT INTO `cms_yq_customer` VALUES ('1', '申达股份是梵蒂冈1', '大所发生的1', '大所发生的1', '15', '的说法丰富的三1', '0', '是打发斯蒂芬1', '1', '1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_yq_customer` VALUES ('2', '打的费', 'http://dfadfasdf.womc', '大所发生的1', '14', '的说法丰富的三1', '1', '是打发斯蒂芬1', '1', '1', '3123111', '12311', '21321311', '23112311', '23122', '12322', '34354522', '654564522', '12333', '12333', '8765867833', '79878933', '21344', '12344', '8900980-944', '-09-09-44');
INSERT INTO `cms_yq_customer` VALUES ('3', '成都华阳中学', 'www.schyzx.com', '华阳中学', '18', '42342344242', '1', '是打发斯蒂芬1', '1', '1', '3123111', '12311', '21321311', '23112311', '23122', '12322', '34354522', '654564522', '12333', '12333', '8765867833', '79878933', '21344', '12344', '8900980-944', '-09-09-44');

-- ----------------------------
-- Table structure for cms_yq_dict
-- ----------------------------
DROP TABLE IF EXISTS `cms_yq_dict`;
CREATE TABLE `cms_yq_dict` (
  `f_dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `f_value` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '数据值',
  `f_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '标签名',
  `f_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '类型',
  `f_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '描述',
  `f_sort` int(11) NOT NULL COMMENT '排序（升序）',
  `f_parent_id` int(11) DEFAULT '0' COMMENT '父级编号',
  `f_remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `f_status` int(11) NOT NULL DEFAULT '0' COMMENT '状态(0:正常,1:锁定,2:待验证)',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_tree_number` varchar(100) DEFAULT '0000' COMMENT '树编码',
  PRIMARY KEY (`f_dict_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cms_yq_dict
-- ----------------------------
INSERT INTO `cms_yq_dict` VALUES ('14', 'DY', '德阳市', 'area_type', '行政区设置', '2', '9', null, '1', '1', '0000-0002-0002');
INSERT INTO `cms_yq_dict` VALUES ('1', 'sdsf', '师德师风', 'info_type', '舆情分类设置', '1', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('8', 'china', '中国', 'area_type', '行政区设置', '1', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('2', 'tsjy', '投诉建议', 'info_type', '舆情分类设置', '2', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('9', 'SC', '四川省', 'area_type', '行政区设置', '2', '8', null, '1', '1', '0000-0002');
INSERT INTO `cms_yq_dict` VALUES ('6', 'middleschool', '初中', 'school_level', '学位分段设置', '2', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('15', 'QYQ', '青羊区', 'area_type', '行政区设置', '1', '13', null, '1', '1', '0000-0002-0001-0001');
INSERT INTO `cms_yq_dict` VALUES ('16', 'tianyabbs', '天涯论坛', 'favorite_type', '收藏夹分类设置', '3', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('13', 'CD', '成都', 'area_type', '行政区设置', '1', '9', null, '1', '1', '0000-0002-0001');
INSERT INTO `cms_yq_dict` VALUES ('17', 'baidubbs', '百度贴吧', 'favorite_type', '收藏夹分类设置', '4', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('10', 'SD', '山东省', 'area_type', '行政区设置', '3', '8', null, '1', '1', '0000-0003');
INSERT INTO `cms_yq_dict` VALUES ('4', 'yellow', '黄', 'info_level', '舆情等级设置', '2', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('18', 'GXQ', '高新区', 'area_type', '行政区设置', '1', '13', null, '1', '1', '0000-0002-0001-0001');
INSERT INTO `cms_yq_dict` VALUES ('5', 'primaryschool', '小学', 'school_level', '学位分段设置', '1', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('28', 'blue', '蓝', 'info_level', '舆情等级设置', '3', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('3', 'red', '红', 'info_level', '舆情等级设置', '1', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('7', '163new', '网易新闻', 'favorite_type', '收藏夹分类设置', '2', null, null, '1', '1', '0000');
INSERT INTO `cms_yq_dict` VALUES ('19', 'orange', '橙', 'info_level', '舆情等级设置', '3', null, null, '1', '1', '0000');

-- ----------------------------
-- Table structure for cms_yq_favorite
-- ----------------------------
DROP TABLE IF EXISTS `cms_yq_favorite`;
CREATE TABLE `cms_yq_favorite` (
  `f_favorite_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_favorite_type_id` int(11) DEFAULT NULL COMMENT 'cms_dict表f_type=''favorite_type''',
  `f_favorite_name` varchar(255) DEFAULT NULL,
  `f_area_id` int(11) DEFAULT NULL COMMENT '地区',
  `f_customer_id` int(11) DEFAULT NULL COMMENT 'cms_cusomer外键',
  `f_customer_url` varchar(1024) DEFAULT NULL COMMENT '客户网站,统计的网站首页',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_items_pattern` varchar(300) DEFAULT NULL COMMENT '文章列表正则匹配模式',
  `f_real_url` varchar(500) DEFAULT NULL COMMENT '真实可访问的URL头',
  `f_original_url` varchar(500) DEFAULT NULL COMMENT '原始请求域名前缀',
  `f_title_pattern` varchar(300) DEFAULT NULL COMMENT '标题正则表达式',
  `f_content_create_time_pattern` varchar(300) DEFAULT NULL COMMENT '帖子发帖时间正则',
  `f_comment_num_pattern` varchar(300) DEFAULT NULL COMMENT '评论次数正则',
  `f_summary_pattern` varchar(300) DEFAULT NULL COMMENT '摘要正则',
  `f_agent` varchar(200) DEFAULT NULL COMMENT '代理名称',
  `f_charset` varchar(50) DEFAULT NULL COMMENT '编码格式',
  PRIMARY KEY (`f_favorite_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cms_yq_favorite
-- ----------------------------
INSERT INTO `cms_yq_favorite` VALUES ('1', '16', '34324', null, '2', '234234', '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `cms_yq_favorite` VALUES ('8', '17', '成都华阳中学吧', null, '3', 'https://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E5%8D%8E%E9%98%B3%E4%B8%AD%E5%AD%A6%20&fr=wwwt', '1', '<meta name=\"description\" content=\"(.*?)\" />', null, null, '<title>(.*?)</title>', '<span class=\"tail-info\">1楼</span><span class=\"tail-info\">(.*?)</span>', '<span class=\"red\" style=\"margin-right:3px\">(.*?)</span>', '<meta name=\"keywords\" content=\"(.*?)\"/>', 'Mozilla/5.0', 'utf-8');
INSERT INTO `cms_yq_favorite` VALUES ('2', '17', '成都七中吧', null, '1', 'http://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E4%B8%83%E4%B8%AD&ie=utf-8', '1', '<meta name=\"description\" content=\"(.*?)\" />', null, null, '<title>(.*?)</title>', 'date&quot;:&quot;(.*?)&quot;,', '<span class=\"red\" style=\"margin-right:3px\">(.*?)</span>', '<meta name=\"keywords\" content=\"(.*?)\"/>', 'Mozilla/5.0', 'utf-8');
INSERT INTO `cms_yq_favorite` VALUES ('6', '16', '成都七中吧444', null, '1', 'http://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E4%B8%83%E4%B8%AD&ie=utf-8', '1', '<meta name=\"description\" content=\"(.*?)\" />', null, null, '<title>(.*?)</title>', null, '<span class=\"red\" style=\"margin-right:3px\">(.*?)</span>', '<meta name=\"keywords\" content=\"(.*?)\"/>', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1', 'utf-8');
INSERT INTO `cms_yq_favorite` VALUES ('4', '16', '成都七中吧3333', null, '1', 'http://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E4%B8%83%E4%B8%AD&ie=utf-8', '1', '<meta name=\"description\" content=\"(.*?)\" />', null, null, '<title>(.*?)</title>', null, '<span class=\"red\" style=\"margin-right:3px\">(.*?)</span>', '<meta name=\"keywords\" content=\"(.*?)\"/>', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1', 'utf-8');
INSERT INTO `cms_yq_favorite` VALUES ('5', '16', '成都七中吧2222', null, '1', 'http://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E4%B8%83%E4%B8%AD&ie=utf-8', '1', '<meta name=\"description\" content=\"(.*?)\" />', null, null, '<title>(.*?)</title>', null, '<span class=\"red\" style=\"margin-right:3px\">(.*?)</span>', '<meta name=\"keywords\" content=\"(.*?)\"/>', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1', 'utf-8');
INSERT INTO `cms_yq_favorite` VALUES ('3', '16', '成都七中吧111', null, '1', 'http://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E4%B8%83%E4%B8%AD&ie=utf-8', '1', '<meta name=\"description\" content=\"(.*?)\" />', null, null, '<title>(.*?)</title>', null, '<span class=\"red\" style=\"margin-right:3px\">(.*?)</span>', '<meta name=\"keywords\" content=\"(.*?)\"/>', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1', 'utf-8');
INSERT INTO `cms_yq_favorite` VALUES ('7', '16', '成都七中吧555', null, '1', 'http://tieba.baidu.com/f?kw=%E6%88%90%E9%83%BD%E4%B8%83%E4%B8%AD&ie=utf-8', '1', '<meta name=\"description\" content=\"(.*?)\" />', null, null, '<title>(.*?)</title>', null, '<span class=\"red\" style=\"margin-right:3px\">(.*?)</span>', '<meta name=\"keywords\" content=\"(.*?)\"/>', 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1', 'utf-8');

-- ----------------------------
-- Table structure for cms_yq_sentiment
-- ----------------------------
DROP TABLE IF EXISTS `cms_yq_sentiment`;
CREATE TABLE `cms_yq_sentiment` (
  `f_sentiment_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_sentiment_title` varchar(100) DEFAULT NULL COMMENT '舆情标题',
  `f_sentiment_url` varchar(1024) DEFAULT NULL COMMENT '舆情网址',
  `f_user_id` int(11) DEFAULT NULL COMMENT 'cms_user外键',
  `f_info_level` int(11) DEFAULT NULL COMMENT '舆情等级',
  `f_info_type` int(11) DEFAULT NULL COMMENT '舆情分类',
  `f_create_datetime` datetime DEFAULT NULL COMMENT '采集日期,记录创建时间',
  `f_school_level` int(11) DEFAULT NULL COMMENT '学校等级',
  `f_area_id` int(11) DEFAULT NULL COMMENT '地区',
  `f_site_id` int(11) NOT NULL COMMENT '站点',
  `f_customer_id` int(11) DEFAULT NULL COMMENT 'cms_cusomer外键  客户',
  `f_content_create_time` varchar(20) DEFAULT NULL COMMENT '发帖时间',
  `f_relay_num` int(11) DEFAULT NULL COMMENT '转发数量',
  `f_comment_num` int(11) DEFAULT NULL COMMENT '评论数量',
  `f_summary` varchar(2000) DEFAULT NULL COMMENT '摘要',
  `f_sms_content` varchar(255) DEFAULT NULL COMMENT '短信内容',
  `f_favorite_id` int(11) DEFAULT NULL COMMENT '所属收藏夹',
  `f_case` tinyint(1) DEFAULT NULL COMMENT '是否为案例',
  PRIMARY KEY (`f_sentiment_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of cms_yq_sentiment
-- ----------------------------
INSERT INTO `cms_yq_sentiment` VALUES ('1', null, null, '1', null, null, '2017-12-21 15:47:48', null, '10', '1', '2', null, null, null, null, null, '2', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('8', '成都华阳【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/4799244433', '1', '3', '1', '2017-12-25 15:41:48', '5', '18', '1', '3', '2016-09-27 13:51', null, '1', '百度贴吧,成都华阳中学成都,华阳', null, '8', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('2', '求各位刚考过的一诊模拟测试文科数学的答案！！【成都七中吧】_百度贴吧', 'http://tieba.baidu.com/p/5480787907', '1', '4', '2', '2018-01-24 15:47:48', '6', '15', '1', null, '2017-12-16 11:12', '2', '1', '百度贴吧,成都七中求各,位刚,考过1', '21', '2', '1');
INSERT INTO `cms_yq_sentiment` VALUES ('9', '成都华阳【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/4799244433', '1', '3', '1', '2017-12-25 15:47:48', '5', '18', '1', '3', '2016-09-27 13:51', null, '1', '百度贴吧,成都华阳中学成都,华阳', null, '8', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('6', '华阳中学上班族晚上可以去跑步吗？能进去吗？【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/4989162624', '1', '4', '1', '2017-12-25 11:47:48', '5', '18', '1', null, '2017-02-20 12:33', null, '0', '百度贴吧,成都华阳中学华阳,中学,上班', null, '8', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('10', '有美术、传媒、音乐、书法爱好者请联糸13547895346【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/4752949237', '1', '3', '1', '2017-12-25 15:47:48', '5', '18', '1', '3', '2016-08-27 09:14', null, '0', '百度贴吧,成都华阳中学13547895346,美术,音乐', null, '8', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('4', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/5299746149', '1', '3', '1', '2017-12-24 15:47:48', '5', '18', '1', null, '2017-08-31 18:49', '1', '0', '百度贴吧,成都华阳中学17,阳中,级高', null, '3', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('5', '有上一届学姐说他在核工业读了两年就工作了，才开始工资5000多，这么爽，想去读，有没有一起的啊【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/5189449525', '1', '4', '2', '2017-12-25 15:47:48', '6', '18', '1', null, '2017-06-28 00:35', null, '0', '百度贴吧,成都华阳中学有上,一届,学姐', null, '8', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('11', '华阳中学17级高一重点班有哪些班？【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/5299746149', '1', '3', '1', '2017-12-25 15:47:48', '5', '18', '1', '3', '2017-08-31 18:49', null, '0', '百度贴吧,成都华阳中学17,阳中,级高', null, '8', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('3', '求各位刚考过的一诊模拟测试文科数学的答案！！【成都七中吧】_百度贴吧', 'http://tieba.baidu.com/p/5480787907', '1', '3', '1', '2018-01-24 15:47:48', '5', '15', '1', null, '2017-12-16 11:12', null, '1', '百度贴吧,成都七中求各,位刚,考过', null, '2', '0');
INSERT INTO `cms_yq_sentiment` VALUES ('7', '单招【成都华阳中学吧】_百度贴吧', 'https://tieba.baidu.com/p/4840172593', '1', '3', '1', '2017-12-25 15:47:48', '5', '18', '1', '3', '2016-10-28 14:48', null, '0', '百度贴吧,成都华阳中学单招', null, '8', '0');

-- ----------------------------
-- Table structure for hibernate_sequences
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequences`;
CREATE TABLE `hibernate_sequences` (
  `sequence_name` varchar(100) NOT NULL COMMENT '表名',
  `next_val` bigint(20) NOT NULL COMMENT 'ID值',
  PRIMARY KEY (`sequence_name`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hibernate_sequences
-- ----------------------------
INSERT INTO `hibernate_sequences` VALUES ('cms_ad', '23');
INSERT INTO `hibernate_sequences` VALUES ('cms_ad_slot', '22');
INSERT INTO `hibernate_sequences` VALUES ('cms_attachment', '375');
INSERT INTO `hibernate_sequences` VALUES ('cms_attachment_ref', '277');
INSERT INTO `hibernate_sequences` VALUES ('cms_attribute', '33');
INSERT INTO `hibernate_sequences` VALUES ('cms_collect', '22');
INSERT INTO `hibernate_sequences` VALUES ('cms_collect_field', '25');
INSERT INTO `hibernate_sequences` VALUES ('cms_comment', '52');
INSERT INTO `hibernate_sequences` VALUES ('cms_friendlink', '31');
INSERT INTO `hibernate_sequences` VALUES ('cms_friendlinktype', '24');
INSERT INTO `hibernate_sequences` VALUES ('cms_guestbook', '52');
INSERT INTO `hibernate_sequences` VALUES ('cms_guestbooktype', '29');
INSERT INTO `hibernate_sequences` VALUES ('cms_info', '240');
INSERT INTO `hibernate_sequences` VALUES ('cms_member_group', '22');
INSERT INTO `hibernate_sequences` VALUES ('cms_model', '52');
INSERT INTO `hibernate_sequences` VALUES ('cms_model_field', '632');
INSERT INTO `hibernate_sequences` VALUES ('cms_node', '119');
INSERT INTO `hibernate_sequences` VALUES ('cms_operation_log', '3016');
INSERT INTO `hibernate_sequences` VALUES ('cms_org', '24');
INSERT INTO `hibernate_sequences` VALUES ('cms_publish_point', '33');
INSERT INTO `hibernate_sequences` VALUES ('cms_question', '23');
INSERT INTO `hibernate_sequences` VALUES ('cms_question_item', '28');
INSERT INTO `hibernate_sequences` VALUES ('cms_question_option', '39');
INSERT INTO `hibernate_sequences` VALUES ('cms_question_record', '25');
INSERT INTO `hibernate_sequences` VALUES ('cms_role', '36');
INSERT INTO `hibernate_sequences` VALUES ('cms_rolenode_info', '21');
INSERT INTO `hibernate_sequences` VALUES ('cms_rolenode_node', '21');
INSERT INTO `hibernate_sequences` VALUES ('cms_role_site', '22');
INSERT INTO `hibernate_sequences` VALUES ('cms_schedule_job', '25');
INSERT INTO `hibernate_sequences` VALUES ('cms_scoreboard', '48');
INSERT INTO `hibernate_sequences` VALUES ('cms_scoregroup', '23');
INSERT INTO `hibernate_sequences` VALUES ('cms_scoreitem', '34');
INSERT INTO `hibernate_sequences` VALUES ('cms_site', '24');
INSERT INTO `hibernate_sequences` VALUES ('cms_special', '34');
INSERT INTO `hibernate_sequences` VALUES ('cms_special_category', '27');
INSERT INTO `hibernate_sequences` VALUES ('cms_tag', '105');
INSERT INTO `hibernate_sequences` VALUES ('cms_task', '46');
INSERT INTO `hibernate_sequences` VALUES ('cms_user', '60');
INSERT INTO `hibernate_sequences` VALUES ('cms_visit_log', '4825');
INSERT INTO `hibernate_sequences` VALUES ('cms_vote', '22');
INSERT INTO `hibernate_sequences` VALUES ('cms_vote_mark', '116');
INSERT INTO `hibernate_sequences` VALUES ('cms_vote_option', '27');
INSERT INTO `hibernate_sequences` VALUES ('cms_workflow', '24');
INSERT INTO `hibernate_sequences` VALUES ('cms_workflowprocess_user', '21');
INSERT INTO `hibernate_sequences` VALUES ('cms_workflow_group', '23');
INSERT INTO `hibernate_sequences` VALUES ('cms_workflow_step', '25');
INSERT INTO `hibernate_sequences` VALUES ('plug_resume', '24');

-- ----------------------------
-- Table structure for plug_resume
-- ----------------------------
DROP TABLE IF EXISTS `plug_resume`;
CREATE TABLE `plug_resume` (
  `f_resume_id` int(11) NOT NULL,
  `f_site_id` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL COMMENT '姓名',
  `f_post` varchar(100) NOT NULL COMMENT '应聘职位',
  `f_creation_date` datetime NOT NULL COMMENT '投递日期',
  `f_gender` char(1) NOT NULL DEFAULT 'M' COMMENT '性别',
  `f_birth_date` datetime DEFAULT NULL COMMENT '出生日期',
  `f_mobile` varchar(100) DEFAULT NULL COMMENT '手机',
  `f_email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `f_expected_salary` int(11) DEFAULT NULL COMMENT '期望薪水',
  `f_education_experience` mediumtext COMMENT '教育经历',
  `f_work_experience` mediumtext COMMENT '工作经历',
  `f_remark` mediumtext COMMENT '备注',
  PRIMARY KEY (`f_resume_id`),
  KEY `fk_plug_resume_site` (`f_site_id`) USING BTREE,
  CONSTRAINT `fk_plug_resume_site` FOREIGN KEY (`f_site_id`) REFERENCES `cms_site` (`f_site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of plug_resume
-- ----------------------------
INSERT INTO `plug_resume` VALUES ('3', '1', '123', '软件UI设计师', '2014-12-08 17:38:37', 'M', null, null, null, null, null, null, null);
