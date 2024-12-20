DROP TABLE IF EXISTS `t_hotel`;
CREATE TABLE `t_hotel`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `number` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '酒店编号',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '酒店名称',
  `site` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '酒店地点',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '酒店类型',
  `area` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '占地面积',
  `star` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '酒店星级',
  `score` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '酒店评分',
  `introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '酒店介绍',
  `photo` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '酒店图片',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '酒店状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_hotel
-- ----------------------------
INSERT INTO `t_hotel` VALUES ('0', '', 'xhotel', 'gdut', 'best', 1001, 5, 5, 'this is xhotel', 'no photo', 0, '2024-04-11 22:03:31', '2024-04-16 22:23:16');
INSERT INTO `t_hotel` VALUES ('007b530f46ab4e8385465f7cf4c2a595', '010208', '广州精品酒店第8号酒店', '', '', 118, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('03ef568a04e74ab886e5be6633aca141', '0102024', '广州精品酒店第24号酒店', '', '', 134, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('069129962e294ce58d51104d5807a9f5', '0102021', '广州精品酒店第21号酒店', '', '', 131, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('085016ef42c941efa70d1f89d969769a', '0102014', '广州精品酒店第14号酒店', '', '', 124, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('09e8e95416554e64a24a0de8585c0934', '0102010', '广州精品酒店第10号酒店', '', '', 120, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('0ba89fed5e7a4bc4ba59636cc26bc716', '0102014', '广州精品酒店第14号酒店', '', '', 124, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('12e42daeae4a40b5bf6abacb5282d145', '010207', '广州精品酒店第7号酒店', '', '', 117, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('15685346eac444c5940b51a815a781bd', '0102025', '广州精品酒店第25号酒店', '', '', 135, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('195628e1b25c4059979da1637428b04c', '010205', '广州精品酒店第5号酒店', '', '', 115, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('1b70c94ef3594962aa4693dbfe434122', '0102023', '广州精品酒店第23号酒店', '', '', 133, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('1c2ecdbeed8a4568b90351b9b19569e0', '0102018', '广州精品酒店第18号酒店', '', '', 128, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('1d45633718244e00bfe5f2a4f4bee0b9', '0102029', '广州精品酒店第29号酒店', '', '', 139, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('1f7dff2c9a7a4cecad9191d54029ce46', '0102013', '广州精品酒店第13号酒店', '', '', 123, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('212aed0bcff34928b3c542d166f76363', '0102011', '广州精品酒店第11号酒店', '', '', 121, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('2622e23d4fd54bf1a55ed0f654ddd185', '0102013', '广州精品酒店第13号酒店', '', '', 123, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('279bb990f7bb46a1b7e8665f15e4b0eb', '0102022', '广州精品酒店第22号酒店', '', '', 132, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('27badbfed36641deb388a723f13f8af8', '0102026', '广州精品酒店第26号酒店', '', '', 136, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('2bad3545d6694114b391332cda8366d8', '010203', '广州精品酒店第3号酒店', '', '', 113, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('2e925692e767416399e0a62c2749274b', '010201', '广州精品酒店第1号酒店', '', '', 111, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('340282baa3994872b88c970f58cf6001', '010206', '广州精品酒店第6号酒店', '', '', 116, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('38be850635a04912b7a52cca114b762d', '010209', '广州精品酒店第9号酒店', '', '', 119, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('3d006016d0974224a7399681fa7ec9ea', '010202', '广州精品酒店第2号酒店', '', '', 112, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('3f452448293d4f8fb5ce994f239c4123', '010203', '广州精品酒店第3号酒店', '', '', 113, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('40d56bf3a2d94e33a13f175bf6d86735', '0102025', '广州精品酒店第25号酒店', '', '', 135, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('414ee1ecbe704458b931654362f99b70', '0102014', '广州精品酒店第14号酒店', '', '', 124, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('4448573ff7c6476e990c3b4363941175', '0102026', '广州精品酒店第26号酒店', '', '', 136, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('4c779066791446d18535bb212e95382a', '010207', '广州精品酒店第7号酒店', '', '', 117, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('4e0ec025231444f89241f2c658356804', '0102022', '广州精品酒店第22号酒店', '', '', 132, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('4e1c1c85a6fb4c0cb406613d6782f0ec', '0102020', '广州精品酒店第20号酒店', '', '', 130, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('4e9fd404d42b4dc48d4dbe73dc1837d8', '0102016', '广州精品酒店第16号酒店', '', '', 126, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('525fbf75acf44ebdaf980ebb0449cddf', '0102015', '广州精品酒店第15号酒店', '', '', 125, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('52819461d802446789e942ab1c96c8da', '010206', '广州精品酒店第6号酒店', '', '', 116, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('52fa292e5e6f46a7802ce39163da8292', '010202', '广州精品酒店第2号酒店', '', '', 112, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('547151842bb84f8e83c244fc9fb35f82', '010205', '广州精品酒店第5号酒店', '', '', 115, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('574b664cb6de4ab2ad300d103afc0b34', '0102017', '广州精品酒店第17号酒店', '', '', 127, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('58a7c7e9dc344757a81c626f6be3cb68', '010200', '广州精品酒店第0号酒店', '', '', 110, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('5958b4e86ada4cb7ae34fe36488ea847', '0102015', '广州精品酒店第15号酒店', '', '', 125, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('5a65f9aaf6f243e5be182f9c550447af', '0102011', '广州精品酒店第11号酒店', '', '', 121, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('5b08ab03559d4586988ea96ae45edda6', '0102029', '广州精品酒店第29号酒店', '', '', 139, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('5c0eb271549549db9fdef3f90e9a8153', '0102010', '广州精品酒店第10号酒店', '', '', 120, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('5ddb5c0471a440c6830d3797029e9089', '0102021', '广州精品酒店第21号酒店', '', '', 131, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('60f6b95f27b44465b94e279f60db8c40', '0102016', '广州精品酒店第16号酒店', '', '', 126, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('631ec4e27566412a993cd8f84ba01bba', '0102020', '广州精品酒店第20号酒店', '', '', 130, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('661cfddc6da7469f8235d90ac1ea8702', '010207', '广州精品酒店第7号酒店', '', '', 117, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('671002977eaf48c0983182da9a3db108', '0102012', '广州精品酒店第12号酒店', '', '', 122, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('6ab1fbf8cc794ac3b6e91f41cb855314', '0102015', '广州精品酒店第15号酒店', '', '', 125, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('6d7d68937a6a4ee6b32106d8f508f48d', '0102028', '广州精品酒店第28号酒店', '', '', 138, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('6e8247b455a2485986501d9b7c543fe4', '010202', '广州精品酒店第2号酒店', '', '', 112, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('6f16309d5b504d4b941bf4afb3279696', '0102014', '广州精品酒店第14号酒店', '', '', 124, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('7207a97e45c7489f8e6c8550f29200cf', '0102024', '广州精品酒店第19号酒店', '', '', 129, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('739ffaa3457d485bbf0feb30e67f9dc9', '0102012', '广州精品酒店第12号酒店', '', '', 122, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('7e3aed9b2069497fb191ddad614a7caf', '010203', '广州精品酒店第3号酒店', '', '', 113, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('7fa63e4dc6b14324b1cdbb802687ea81', '0102021', '广州精品酒店第21号酒店', '', '', 131, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('8093d48f18c74327acb3b67b78a1bba5', '0102013', '广州精品酒店第13号酒店', '', '', 123, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('815ce0bc765e46fdbf73d556fc626b8f', '0102025', '广州精品酒店第25号酒店', '', '', 135, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('82e46ddde2c34ead9ef17e87d02cfd35', '010209', '广州精品酒店第9号酒店', '', '', 119, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('870808ca941442d8b5b7a4a30fd95100', '0102023', '广州精品酒店第23号酒店', '', '', 133, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('88f7f7c0a97c442ba5bee68a77bfac44', '0102020', '广州精品酒店第20号酒店', '', '', 130, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('89c068d94a064f158947a7f1dc30890c', '0102026', '广州精品酒店第26号酒店', '', '', 136, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('89e9c90753b8483cb793a102762f0db1', '010209', '广州精品酒店第9号酒店', '', '', 119, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('8cb482026eac4ab289e573ce196d3181', '010200', '广州精品酒店第0号酒店', '', '', 110, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('90f047753033448c88b999ef7df979e6', '0102024', '广州精品酒店第19号酒店', '', '', 129, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('9390dc8b677e4d3782857532c0094e65', '0102027', '广州精品酒店第27号酒店', '', '', 137, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('940478b774e541cb8f0ce483844a7d34', '010208', '广州精品酒店第8号酒店', '', '', 118, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('9414fec454034dbc81de6e9e1b5903a0', '010208', '广州精品酒店第8号酒店', '', '', 118, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('94f83adb35b549a2b8a451ceb6f069ab', '010205', '广州精品酒店第5号酒店', '', '', 115, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('960fc018c55d4503814664bdd681320c', '0102016', '广州精品酒店第16号酒店', '', '', 126, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('975bfe4d21b5483bb37650461bb12e8d', '0102027', '广州精品酒店第27号酒店', '', '', 137, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('9e759848f61343cca4eef9a7208fd0c8', '0102024', '广州精品酒店第24号酒店', '', '', 134, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('a22f67db55454449bd3093b3e154590f', '0102013', '广州精品酒店第13号酒店', '', '', 123, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('a2ac0009398a43888737871126ef14fb', '0102023', '广州精品酒店第23号酒店', '', '', 133, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('a457fe3613c24e3695ecfcc0e3c02f72', '0102010', '广州精品酒店第10号酒店', '', '', 120, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('a4fa3c7971fa45158e589c0e66d334a0', '0102016', '广州精品酒店第16号酒店', '', '', 126, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('a542d297c5024c65b10ebb3c128a83f9', '0102011', '广州精品酒店第11号酒店', '', '', 121, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('a5e4ff20febe47abb3a9c5092dbe1f79', '0102017', '广州精品酒店第17号酒店', '', '', 127, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('a6b89bebec7244878e7922c7bcfbbbf2', '010209', '广州精品酒店第9号酒店', '', '', 119, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('a8f1f867448c4c2f98df97332de5bedb', '010203', '广州精品酒店第3号酒店', '', '', 113, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('aa1e4ac882fb4c82bb6a3aba90ab85b3', '0102022', '广州精品酒店第22号酒店', '', '', 132, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('ac10b892465843bda47ed80ea9666f04', '0102027', '广州精品酒店第27号酒店', '', '', 137, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('b263b53e7db840d1a9b7a35d0acb5ea7', '0102023', '广州精品酒店第23号酒店', '', '', 133, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('b5b3bbcb2a3345dd818841510205053d', '0102028', '广州精品酒店第28号酒店', '', '', 138, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('b7172d6c5cf44249957f7ffefc1ab6ef', '0102026', '广州精品酒店第26号酒店', '', '', 136, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('bb09e383a64d4094808ba435e990ee74', '010200', '广州精品酒店第0号酒店', '', '', 110, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('bb0c519de85a45a78d77d4fdf8de7f72', '010201', '广州精品酒店第1号酒店', '', '', 111, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('bf681460cccb4809b3ebfc2ed46d96a1', '0102025', '广州精品酒店第25号酒店', '', '', 135, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('c175674678de49cfa89704940d7ea363', '0102018', '广州精品酒店第18号酒店', '', '', 128, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('c27e34c1306d45c784b3afbd0ce4c289', '0102029', '广州精品酒店第29号酒店', '', '', 139, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('c344f1f68e95449cb4bbf8927989c06f', '010201', '广州精品酒店第1号酒店', '', '', 111, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('c3999a712f8c487a88e0856430d8b65f', '0102012', '广州精品酒店第12号酒店', '', '', 122, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('c489cd0d83b24acaa48320866950e959', '010207', '广州精品酒店第7号酒店', '', '', 117, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('c79c31e54bcf4cbeb63581afb0d9a6cc', '0102024', '广州精品酒店第19号酒店', '', '', 129, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('c7ab7f35c3024fff85ac7fb702e7d8be', '010204', '广州精品酒店第4号酒店', '', '', 114, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('c8a0ba93d57c4c4d929425684778c23e', '0102024', '广州精品酒店第24号酒店', '', '', 134, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('cdb527a3aafa4b9ea4ea22791f79b11e', '0102018', '广州精品酒店第18号酒店', '', '', 128, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('d0bc6dbe766c4e89a005ca19b3cd3265', '010205', '广州精品酒店第5号酒店', '', '', 115, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('d3546fe17cd64b97ab0a8ffba1c9a439', '010200', '广州精品酒店第0号酒店', '', '', 110, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('d35e85bf2c6e48ff853ec85739e91b9c', '010204', '广州精品酒店第4号酒店', '', '', 114, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('d3b3c2db8e4842ed97b12df051010f52', '010201', '广州精品酒店第1号酒店', '', '', 111, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('d3dfab07b1b54b8fb7bb1a5094f70e81', '0102028', '广州精品酒店第28号酒店', '', '', 138, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('d65c4b29538a40bcb1be1cc8775ac280', '0102028', '广州精品酒店第28号酒店', '', '', 138, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('d731b549db0541dbbd9be40abe3a9a88', '0102029', '广州精品酒店第29号酒店', '', '', 139, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('dc8cbe4b171d41738e4be9461e213a7e', '010202', '广州精品酒店第2号酒店', '', '', 112, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('dc9b28c7c04240a0b6e848ec18300a94', '0102022', '广州精品酒店第22号酒店', '', '', 132, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('dd3a87afb8c345eab66abe478b1aefa1', '0102024', '广州精品酒店第19号酒店', '', '', 129, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('df1bf916b3c045cab5d1372030ce48c5', '0102015', '广州精品酒店第15号酒店', '', '', 125, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('e0854de92a9f4232b4e6e9bd06161956', '0102027', '广州精品酒店第27号酒店', '', '', 137, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('e09fe4e8858b4a8ab31f1cb86146d010', '010204', '广州精品酒店第4号酒店', '', '', 114, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('e1f5a98c1d1b4426a6aaabaeed67ce40', '010206', '广州精品酒店第6号酒店', '', '', 116, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('e316b76c2fa443d1a5f6aea32adc12a8', '0102018', '广州精品酒店第18号酒店', '', '', 128, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('e3ed7864ca5a4776879d00bd2231dd50', '0102024', '广州精品酒店第24号酒店', '', '', 134, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('e5b45f8d405a4bd0ab17c08e38bcb853', '0102020', '广州精品酒店第20号酒店', '', '', 130, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('e8834a5364e8493a914e8a5dacb39cbf', '0102017', '广州精品酒店第17号酒店', '', '', 127, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('ebc99f7d440f415b87a42f8635485bf7', '0102011', '广州精品酒店第11号酒店', '', '', 121, 0, 0, '', '', 0, '2024-04-18 03:13:46', '2024-04-18 03:13:46');
INSERT INTO `t_hotel` VALUES ('ebdc7a1d067044c78be0b8cfc68975e2', '0102021', '广州精品酒店第21号酒店', '', '', 131, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('ec2489895a4245d0abde526d4e92f559', '0102012', '广州精品酒店第12号酒店', '', '', 122, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('f0b187f3ac9f4dc9b44f008df4d5dc54', '0102017', '广州精品酒店第17号酒店', '', '', 127, 0, 0, '', '', 0, '2024-04-18 03:18:36', '2024-04-18 03:18:36');
INSERT INTO `t_hotel` VALUES ('f251929e713b4fa59056e3b70f3e2662', '0102010', '广州精品酒店第10号酒店', '', '', 120, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('f2b5737706774d1e986b5ba851306132', '010208', '广州精品酒店第8号酒店', '', '', 118, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');
INSERT INTO `t_hotel` VALUES ('f6d0c52afac74aec96d28e1fa277f1b6', '010206', '广州精品酒店第6号酒店', '', '', 116, 0, 0, '', '', 0, '2024-04-18 03:15:48', '2024-04-18 03:15:48');
INSERT INTO `t_hotel` VALUES ('f79577892ed44aaea232419bcafe5921', '010204', '广州精品酒店第4号酒店', '', '', 114, 0, 0, '', '', 0, '2024-04-18 03:19:55', '2024-04-18 03:19:55');

-- ----------------------------
-- Table structure for t_order_room
-- ----------------------------
DROP TABLE IF EXISTS `t_order_room`;
CREATE TABLE `t_order_room`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '自增主键',
  `number` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '订单编号',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '用户id',
  `room_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '房间id',
  `start_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '入住时间',
  `end_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '离开时间',
  `amount` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '交易金额',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order_room
-- ----------------------------
INSERT INTO `t_order_room` VALUES ('02362214982242e8adf167c41296d8cf', '9092776', '', '38ed6a1a562d4343954eb99756474f9c', '2024-04-21', '2024-04-27', 0, '反对撒', 0, '2024-04-21 21:46:29', '2024-04-21 21:46:29');
INSERT INTO `t_order_room` VALUES ('071322ea2f114bb1984541caddb4a66f', '9092776', '', '38ed6a1a562d4343954eb99756474f9c', '2024-04-04', '2024-04-21', 0, '', 0, '2024-04-21 22:02:24', '2024-04-21 22:02:24');
INSERT INTO `t_order_room` VALUES ('0c43ec8947a346b08bf2cdbfc9a90d65', '1020', 'dac00243234949e185370902c636f578', 'c020afd4659947d183c8129049e49f51', '2024-04-16', '2024-04-16', 100, '', 0, '2024-04-16 22:37:57', '2024-04-21 20:47:53');
INSERT INTO `t_order_room` VALUES ('0d27c365b8454531b7e8fb8c49dafc66', '90907668', '', '4403e023cf5a4379a1dadf58fe5da58a', '2024-04-13', '2024-04-21', 0, '反对撒', 0, '2024-04-21 21:53:07', '2024-04-21 21:53:07');
INSERT INTO `t_order_room` VALUES ('0d9ca8d329084933aeaec3d4552eaad6', '1020', '0', '0', '2024-04-16', '2024-04-16', 100, '', 0, '2024-04-16 22:31:39', '2024-04-16 22:31:39');
INSERT INTO `t_order_room` VALUES ('1329d102b5434f98a73336b02acce1c3', '1020', '0', '0', '2024-04-16', '2024-04-16', 100, '', 0, '2024-04-16 22:44:39', '2024-04-16 22:44:39');
IINSERT INTO `t_order_room` VALUES ('fe3f2c8175104e47b3702c48cd805f24', '9096776', 'dac00243234949e185370902c636f578', '38ed6a1a562d4343954eb99756474f9c', '2024-04-05', '2024-04-21', 4999, '反对撒', 0, '2024-04-23 05:24:25', '2024-04-23 05:24:25');

-- ----------------------------
-- Table structure for t_order_serv
-- ----------------------------
DROP TABLE IF EXISTS `t_order_serv`;
CREATE TABLE `t_order_serv`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '订单编号',
  `serv_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '服务id',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '服务用户id',
  `room_id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '服务房间id',
  `start_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '服务开始时间',
  `end_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '服务结束时间',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '订单状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  `remark` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk`(`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_pictrue
-- ----------------------------
DROP TABLE IF EXISTS `t_pictrue`;
CREATE TABLE `t_pictrue`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `pictrue` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `author_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_pictrue
-- ----------------------------
INSERT INTO `t_pictrue` VALUES ('1', 1, '', '', '2024-04-19 18:28:18', '2024-04-19 18:28:18');

-- ----------------------------
-- Table structure for t_remark
-- ----------------------------
DROP TABLE IF EXISTS `t_remark`;
CREATE TABLE `t_remark`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键',
  `user_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '用户名',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_remark
-- ----------------------------
INSERT INTO `t_remark` VALUES ('d74b736dd2264d088394f229a06a39ad', 'wzm1742415101(默认昵称)', '这东西真好用', 0, '2024-04-25 22:42:25', '2024-04-25 22:42:25');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_room
-- ----------------------------
DROP TABLE IF EXISTS `t_room`;
CREATE TABLE `t_room`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '房间名称',
  `number` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '房间编号',
  `photo` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'default.jpg' COMMENT '房间照片',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '房间类型',
  `area` decimal(32, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '房间面积',
  `bed_width` decimal(32, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '床宽',
  `price` decimal(10, 0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '房间价格',
  `book_status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '空闲' COMMENT '被订状态',
  `level` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '房间等级',
  `score` decimal(20, 0) UNSIGNED NOT NULL DEFAULT 4 COMMENT '房间评分',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '没有备注信息' COMMENT '备注信息',
  `remark_num` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评分数量',
  `hotel_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '酒店id',
  `creator_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '创建者id',
  `editor_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '修改者id',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '房间状态(0可用）',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_editor_id`(`editor_id`) USING BTREE,
  INDEX `fk_creator_id`(`creator_id`) USING BTREE,
  INDEX `fk_hotel_id`(`hotel_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_room
-- ----------------------------
INSERT INTO `t_room` VALUES ('07b184b88a7445d1929383b8eca1cbbc', '阿布扎比宫殿酒店(Emirates Palace)商务间3059342', '3059342', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 112, 3, 6199, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('0ae1e0cb4a2e41a68feb8aa8a2dc5f90', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068342', '3068342', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 112, 3, 8199, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('10ed47323a2246be974f9846c54cb9de', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528345', '4528345', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 115, 3, 9499, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('13eda81a106c43929ff83c3f38ae0036', '维多利亚帝后饭店(Empress Hotel)商务间3028345', '3028345', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 115, 3, 5499, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('14ceb8fc5903415eaf3ca192985476be', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528341', '4528341', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 111, 3, 9099, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('20425a3bb42c40f6bd5a687aaf212356', '维多利亚帝后饭店(Empress Hotel)商务间3028346', '3028346', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 116, 3, 5599, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('28485cc05daa4b098106601c70d44624', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068346', '3068346', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 116, 3, 8599, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('2dce5f1352a44e8b9cb841c2cbd13231', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068340', '3068340', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 110, 3, 7999, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('2fb0d35466d64d7e92f4b735e2ebe5ba', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068348', '3068348', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 118, 3, 8799, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('32ce513863f5418cb892f0a98d69e643', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528342', '4528342', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 112, 3, 9199, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('35fb9f1c232e4d0d95f1a5f4089f797b', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528340', '4528340', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 110, 3, 8999, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('381d0255277644f1ae45aafd60c2bfb4', '阿布扎比宫殿酒店(Emirates Palace)商务间3059347', '3059347', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 117, 3, 6699, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('3c244501780642b5a8354ae9f78a0290', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068341', '3068341', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 111, 3, 8099, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('459399c7f8234e4e85698225511b6074', '阿布扎比宫殿酒店(Emirates Palace)商务间3059340', '3059340', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 110, 3, 5999, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('45dd54c3ea894f5bb943f7077d539541', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528346', '4528346', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 116, 3, 9599, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('4a9b2c8a14614780a3f22c7b04d2485d', '阿布扎比宫殿酒店(Emirates Palace)商务间3059346', '3059346', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 116, 3, 6599, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('667655b36236420bbb8d5743309bc937', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528347', '4528347', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 117, 3, 9699, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('6982c6a3b7cd428aae99a19f63fae21d', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528348', '4528348', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 118, 3, 9799, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('6a7ceb57ad564ddea7fbd464abeac1f9', '阿布扎比商务间3059388', '3059388', 'default.jpg', '双人', 70, 3, 4999, '空闲', '5', 4, '', 0, '0', '0', '0', 0, '2024-04-24 20:17:26', '2024-04-24 20:17:26');
INSERT INTO `t_room` VALUES ('6cea281c12384925bcc5089794039c95', '阿布扎比宫殿酒店(Emirates Palace)商务间3059348', '3059348', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 118, 3, 6799, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('71651961b39a45d2b9e88055c04448c0', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528343', '4528343', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 113, 3, 9299, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('7d855cac9332470f8687222c7ebce345', '阿布扎比宫殿酒店(Emirates Palace)商务间3059349', '3059349', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 119, 3, 6899, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('8438c75ca89a428d86c8e6962653c494', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528343', '4528343', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 113, 3, 9299, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('87343aa923c2441396a2e0b79b5b50cf', '维多利亚帝后饭店(Empress Hotel)商务间3028349', '3028349', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 119, 3, 5899, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('8770543b8f104347a0f85cb86a647317', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068344', '3068344', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 114, 3, 8399, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('89905bf05ec2487fa596d1c3aa332ea1', '维多利亚帝后饭店(Empress Hotel)商务间3028341', '3028341', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 111, 3, 5099, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('8a628f7158144d908123566702190a91', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528340', '4528340', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 110, 3, 8999, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('8cc50028d61b4f8ea2568b2be2c66a3e', '阿布扎比宫殿酒店(Emirates Palace)商务间3059344', '3059344', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 114, 3, 6399, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('907005d3b29c4b148415c77358cdb8c3', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528344', '4528344', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 114, 3, 9399, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('935225cae6dc4ff3afd8c47b0474fb32', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528348', '4528348', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 118, 3, 9799, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('9c2b100a187243ddb6f2df2141b07c31', '维多利亚帝后饭店(Empress Hotel)商务间3028342', '3028342', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 112, 3, 5199, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('9c60788043944a1396bd8fbed7c232ba', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528341', '4528341', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 111, 3, 9099, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('b081018983f442508e478291f3b7fb0c', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528344', '4528344', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 114, 3, 9399, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('b0b75b7154934e87ae228861c69aa0fc', '阿布扎比宫殿酒店(Emirates Palace)商务间3059341', '3059341', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 111, 3, 6099, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('b4d2b0ef3d144d01b651be6b3797bd4b', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528346', '4528346', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 116, 3, 9599, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('bcdedc4ea2c34dc98f74585ff35279cc', '维多利亚帝后饭店(Empress Hotel)商务间3028343', '3028343', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 113, 3, 5299, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('bd960cbb82ea476cab8ef6188cb4d025', '维多利亚帝后饭店(Empress Hotel)商务间3028347', '3028347', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 117, 3, 5699, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('c3a9221bfbe24955bc77c938ddcd380c', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528345', '4528345', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 115, 3, 9499, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('c85ba01193bc49c7beb0c7aca4028b56', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528349', '4528349', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 119, 3, 9899, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');
INSERT INTO `t_room` VALUES ('cbab76bd6c4d45d99eab37649ea5efe8', '维多利亚帝后饭店(Empress Hotel)商务间3028340', '3028340', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 110, 3, 4999, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('ce314819811a447b89eb329e8214d1f8', '阿布扎比宫殿酒店(Emirates Palace)商务间3059343', '3059343', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 113, 3, 6299, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('d4dc23c3e60749f88eabaca82255cdc8', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068349', '3068349', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 119, 3, 8899, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('d92579914aee4db685f00cd183076a22', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528342', '4528342', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 112, 3, 9199, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('e0fba000a9984dc8a229f61c8d8104b0', '阿布扎比宫殿酒店(Emirates Palace)商务间3059345', '3059345', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 115, 3, 6499, '空闲', '8星级', 5, '“满足你的一切愿望，实现你当国王的梦想”', 0, '0', '0', '0', 0, '2024-04-24 17:42:15', '2024-04-24 17:42:15');
INSERT INTO `t_room` VALUES ('efb236173fa643c093fc22da242be711', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528349', '4528349', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 119, 3, 9899, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:49:13', '2024-04-24 17:49:13');
INSERT INTO `t_room` VALUES ('f077db7830594cd78ea070c8d4dc7d75', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068343', '3068343', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 113, 3, 8299, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('f163a64cfc044ae18de8224470a34675', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068347', '3068347', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 117, 3, 8699, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('f5c60eda3e2a417f81fe42e6b211f587', '迪拜帆船酒店(Dubai Lugger Hotel)商务间3068345', '3068345', 'b7fb2f8ad4df4440a762381ad8c56f0d.jpg', '双人', 115, 3, 8499, '空闲', '7星级', 5, '“位于中东地区阿拉伯联合酋长国迪拜酋长国的迪拜市，为全世界最豪华的酒店”', 0, '0', '0', '0', 0, '2024-04-24 17:44:20', '2024-04-24 17:44:20');
INSERT INTO `t_room` VALUES ('f652de18f97e43199b766ff7f9cf3039', '维多利亚帝后饭店(Empress Hotel)商务间3028344', '3028344', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 114, 3, 5399, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('fa86eabc53c94fc3881fa90569191ef6', '维多利亚帝后饭店(Empress Hotel)商务间3028348', '3028348', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '双人', 118, 3, 5799, '空闲', '7星级', 5, '“加拿大CP HOTEL系列著名饭店之一”', 0, '0', '0', '0', 0, '2024-04-24 17:47:00', '2024-04-24 17:47:00');
INSERT INTO `t_room` VALUES ('fbbd12a93f934856bf2fd36d71682120', '文莱帝国酒店(Empire Hotel& Country Club)商务间4528347', '4528347', 'e93f57968f8d413f853b9130ff00bf0f.jpg', '多人', 117, 3, 9699, '空闲', '8星级', 5, '“十万元一晚的帝王级享受，对于懂得享受和追求奢华感觉的人士绝对是最佳的选择”', 0, '0', '0', '0', 0, '2024-04-24 17:51:28', '2024-04-24 17:51:28');

-- ----------------------------
-- Table structure for t_serv
-- ----------------------------
DROP TABLE IF EXISTS `t_serv`;
CREATE TABLE `t_serv`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `number` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务编号',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务名称',
  `detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '服务内容',
  `time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '服务时长',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '服务状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1234' COMMENT '登陆密码',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'USER' COMMENT '用户类型',
  `phone_number` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号码',
  `id_number` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '身份证号',
  `nick_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '默认昵称' COMMENT '用户昵称',
  `photo` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `balance` decimal(32, 0) NOT NULL DEFAULT 0 COMMENT '账户余额',
  `pay_pwd` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '4QrcOUm6Wau+VuBX8g+IPg==' COMMENT '支付密码',
  `status` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '插入时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('dac00243234949e185370902c636f578', 'ygz', 'e10adc3949ba59abbe56e057f20f883e', 'ADMIN', '15816019723', '440823199912202117', '喻官洲', 'a3b15733ce4140c08aa813fb73fcd4bd.jpg', 0, '4QrcOUm6Wau+VuBX8g+IPg==', 0, '2024-04-21 02:33:37', '2024-04-24 16:34:27');
INSERT INTO `t_user` VALUES ('daf2b614d4c9463fb34ec81d8ffc4792', 'ps', 'e10adc3949ba59abbe56e057f20f883e', 'USER', '', '', '彭', '', 0, '4QrcOUm6Wau+VuBX8g+IPg==', 0, '2024-04-25 22:13:51', '2024-04-25 22:13:51');
INSERT INTO `t_user` VALUES ('fb3a74b295404dc38627d3eeeb1d779d', 'yxh', 'e10adc3949ba59abbe56e057f20f883e', 'USER', '', '', '杨', '', 0, '4QrcOUm6Wau+VuBX8g+IPg==', 0, '2024-04-25 00:27:11', '2024-04-25 00:27:11');
INSERT INTO `t_user` VALUES ('fb942b30f55d43ca9b52bf275dd3f8dc', 'ty', 'e10adc3949ba59abbe56e057f20f883e', 'USER', '13424567876', '440102010101010101', '田', '', 0, '4QrcOUm6Wau+VuBX8g+IPg==', 0, '2024-04-25 00:59:18', '2024-04-25 21:58:50');
INSERT INTO `t_user` VALUES ('fd8f21ac4da14ee0924eba4faf8458c2', 'wly', 'e10adc3949ba59abbe56e057f20f883e', 'USER', '15816019724', '440823199912202118', 'tom王', '默认头像.jpg', 999230, '4QrcOUm6Wau+VuBX8g+IPg==', 0, '2024-04-20 20:21:30', '2024-04-20 20:21:30');

-- ----------------------------
-- Table structure for tb_base
-- ----------------------------
DROP TABLE IF EXISTS `tb_base`;
CREATE TABLE `tb_base`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `status` smallint(1) UNSIGNED NOT NULL COMMENT '状态',
  `gmt_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `gmt_modified` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
