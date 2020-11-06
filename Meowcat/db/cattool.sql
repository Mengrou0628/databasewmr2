-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2020-11-06 03:20:07
-- 服务器版本： 10.4.11-MariaDB
-- PHP 版本： 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `cattool`
--

-- --------------------------------------------------------

--
-- 表的结构 `flproject`
--

CREATE TABLE `flproject` (
  `file_id` int(10) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `project_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `fltb`
--

CREATE TABLE `fltb` (
  `id` int(10) NOT NULL,
  `source` varchar(20) NOT NULL,
  `target` varchar(20) NOT NULL,
  `user_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `file_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `fltm`
--

CREATE TABLE `fltm` (
  `id` int(10) NOT NULL,
  `source` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `user_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `file_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `fltmtemp`
--

CREATE TABLE `fltmtemp` (
  `id` int(10) NOT NULL,
  `source` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `proofread`
--

CREATE TABLE `proofread` (
  `id` int(10) NOT NULL,
  `source` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `review` varchar(100) NOT NULL,
  `team_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `file_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `style_guide`
--

CREATE TABLE `style_guide` (
  `guide_id` int(10) NOT NULL,
  `content` varchar(50) NOT NULL,
  `field` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `teamfl`
--

CREATE TABLE `teamfl` (
  `user_id` int(10) NOT NULL,
  `team_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `teampm`
--

CREATE TABLE `teampm` (
  `team_id` int(10) NOT NULL,
  `user_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `teamproject`
--

CREATE TABLE `teamproject` (
  `file_id` int(10) NOT NULL,
  `filename` varchar(50) NOT NULL,
  `project_id` int(10) NOT NULL,
  `team_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `teamtb`
--

CREATE TABLE `teamtb` (
  `id` int(10) NOT NULL,
  `source` varchar(20) NOT NULL,
  `target` varchar(20) NOT NULL,
  `team_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `file_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `teamtm`
--

CREATE TABLE `teamtm` (
  `id` int(10) NOT NULL,
  `source` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `team_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `file_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `teamtmtemp`
--

CREATE TABLE `teamtmtemp` (
  `id` int(10) NOT NULL,
  `source` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `team_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE `users` (
  `user_id` int(10) NOT NULL,
  `user_name` varchar(10) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `duty` int(1) NOT NULL,
  `field` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转储表的索引
--

--
-- 表的索引 `flproject`
--
ALTER TABLE `flproject`
  ADD PRIMARY KEY (`file_id`,`project_id`),
  ADD KEY `user_id` (`user_id`);

--
-- 表的索引 `fltb`
--
ALTER TABLE `fltb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_file_project_fltb` (`file_id`,`project_id`),
  ADD KEY `fk_id_fltb` (`user_id`);

--
-- 表的索引 `fltm`
--
ALTER TABLE `fltm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_fltm` (`user_id`),
  ADD KEY `fk_file_project_fltm` (`file_id`,`project_id`);

--
-- 表的索引 `fltmtemp`
--
ALTER TABLE `fltmtemp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_fltemp` (`user_id`);

--
-- 表的索引 `proofread`
--
ALTER TABLE `proofread`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_team_p` (`team_id`),
  ADD KEY `fk_file_project` (`file_id`,`project_id`),
  ADD KEY `fk_id_p` (`user_id`);

--
-- 表的索引 `style_guide`
--
ALTER TABLE `style_guide`
  ADD PRIMARY KEY (`guide_id`);

--
-- 表的索引 `teamfl`
--
ALTER TABLE `teamfl`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_team` (`team_id`);

--
-- 表的索引 `teampm`
--
ALTER TABLE `teampm`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `user_id` (`user_id`);

--
-- 表的索引 `teamproject`
--
ALTER TABLE `teamproject`
  ADD PRIMARY KEY (`file_id`,`project_id`),
  ADD KEY `team_id` (`team_id`);

--
-- 表的索引 `teamtb`
--
ALTER TABLE `teamtb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_team_tb` (`team_id`),
  ADD KEY `fk_file_project_tb` (`file_id`,`project_id`),
  ADD KEY `fk_id_tb` (`user_id`);

--
-- 表的索引 `teamtm`
--
ALTER TABLE `teamtm`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_team_tm` (`team_id`),
  ADD KEY `fk_id_tm` (`user_id`),
  ADD KEY `fk_file_project_tm` (`file_id`,`project_id`);

--
-- 表的索引 `teamtmtemp`
--
ALTER TABLE `teamtmtemp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_team_temp` (`team_id`),
  ADD KEY `fk_id_temp` (`user_id`);

--
-- 表的索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- 限制导出的表
--

--
-- 限制表 `flproject`
--
ALTER TABLE `flproject`
  ADD CONSTRAINT `flproject_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- 限制表 `fltb`
--
ALTER TABLE `fltb`
  ADD CONSTRAINT `fk_file_project_fltb` FOREIGN KEY (`file_id`,`project_id`) REFERENCES `teamproject` (`file_id`, `project_id`),
  ADD CONSTRAINT `fk_id_fltb` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- 限制表 `fltm`
--
ALTER TABLE `fltm`
  ADD CONSTRAINT `fk_file_project_fltm` FOREIGN KEY (`file_id`,`project_id`) REFERENCES `teamproject` (`file_id`, `project_id`),
  ADD CONSTRAINT `fk_id_fltm` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- 限制表 `fltmtemp`
--
ALTER TABLE `fltmtemp`
  ADD CONSTRAINT `fk_id_fltemp` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- 限制表 `proofread`
--
ALTER TABLE `proofread`
  ADD CONSTRAINT `fk_file_project` FOREIGN KEY (`file_id`,`project_id`) REFERENCES `teamproject` (`file_id`, `project_id`),
  ADD CONSTRAINT `fk_id_p` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_team_p` FOREIGN KEY (`team_id`) REFERENCES `teampm` (`team_id`);

--
-- 限制表 `teamfl`
--
ALTER TABLE `teamfl`
  ADD CONSTRAINT `fk_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_team` FOREIGN KEY (`team_id`) REFERENCES `teampm` (`team_id`);

--
-- 限制表 `teampm`
--
ALTER TABLE `teampm`
  ADD CONSTRAINT `teampm_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- 限制表 `teamproject`
--
ALTER TABLE `teamproject`
  ADD CONSTRAINT `teamproject_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teampm` (`team_id`);

--
-- 限制表 `teamtb`
--
ALTER TABLE `teamtb`
  ADD CONSTRAINT `fk_file_project_tb` FOREIGN KEY (`file_id`,`project_id`) REFERENCES `teamproject` (`file_id`, `project_id`),
  ADD CONSTRAINT `fk_id_tb` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_team_tb` FOREIGN KEY (`team_id`) REFERENCES `teampm` (`team_id`);

--
-- 限制表 `teamtm`
--
ALTER TABLE `teamtm`
  ADD CONSTRAINT `fk_file_project_tm` FOREIGN KEY (`file_id`,`project_id`) REFERENCES `teamproject` (`file_id`, `project_id`),
  ADD CONSTRAINT `fk_id_tm` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_team_tm` FOREIGN KEY (`team_id`) REFERENCES `teampm` (`team_id`);

--
-- 限制表 `teamtmtemp`
--
ALTER TABLE `teamtmtemp`
  ADD CONSTRAINT `fk_id_temp` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_team_temp` FOREIGN KEY (`team_id`) REFERENCES `teampm` (`team_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
