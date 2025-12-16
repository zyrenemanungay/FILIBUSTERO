-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 18, 2025 at 04:40 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `filibustero_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `game_sessions`
--

CREATE TABLE `game_sessions` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `session_start` timestamp NOT NULL DEFAULT current_timestamp(),
  `session_end` timestamp NULL DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `stage_reached` int(11) DEFAULT 1,
  `coins_earned_session` int(11) DEFAULT 0,
  `score_earned_session` int(11) DEFAULT 0,
  `quests_completed_session` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `leaderboard`
-- (See below for the actual view)
--
CREATE TABLE `leaderboard` (
);

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `player_name` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_answers`
--

CREATE TABLE `player_answers` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `selected_answer` char(1) DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `points_earned` int(11) DEFAULT 0,
  `answered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_quest_progress`
--

CREATE TABLE `player_quest_progress` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `score_earned` int(11) DEFAULT 0,
  `coins_earned` int(11) DEFAULT 0,
  `attempts` int(11) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_a` varchar(500) DEFAULT NULL,
  `option_b` varchar(500) DEFAULT NULL,
  `option_c` varchar(500) DEFAULT NULL,
  `option_d` varchar(500) DEFAULT NULL,
  `correct_answer` char(1) NOT NULL,
  `explanation` text DEFAULT NULL,
  `difficulty` enum('easy','medium','hard') DEFAULT 'medium',
  `points_value` int(11) DEFAULT 5,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `quest_id`, `question_text`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`, `explanation`, `difficulty`, `points_value`, `created_at`) VALUES
(1, 2, 'Sino ang pangunahing tauhan sa El Filibusterismo?', 'Crisostomo Ibarra', 'Simoun', 'Elias', 'Basilio', 'B', 'Si Simoun ang pangunahing tauhan sa El Filibusterismo, na siyang pagbabalik ni Crisostomo Ibarra.', 'easy', 5, '2025-08-04 08:08:13'),
(2, 4, 'Saan naganap ang unang kabanata ng El Filibusterismo?', 'Maynila', 'Sa barko patungong San Diego', 'San Diego', 'Tiani', 'B', 'Ang unang kabanata ay naganap sa isang bapor na patungo sa San Diego.', 'medium', 5, '2025-08-04 08:08:13'),
(3, 6, 'Ano ang layunin ni Simoun sa kanyang pagbabalik?', 'Magpatayo ng paaralan', 'Maghiganti at magrevolution', 'Magkasal kay Maria Clara', 'Maging gobernador', 'B', 'Ang layunin ni Simoun ay maghiganti at maghasik ng himagsikan laban sa mga Espanyol.', 'medium', 5, '2025-08-04 08:08:13');

-- --------------------------------------------------------

--
-- Table structure for table `quests`
--

CREATE TABLE `quests` (
  `id` int(11) NOT NULL,
  `quest_name` varchar(200) NOT NULL,
  `stage` int(11) NOT NULL,
  `quest_type` enum('question','scavenger_hunt','event') NOT NULL,
  `points_reward` int(11) DEFAULT 5,
  `coins_reward` int(11) DEFAULT 1,
  `quest_order` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quests`
--

INSERT INTO `quests` (`id`, `quest_name`, `stage`, `quest_type`, `points_reward`, `coins_reward`, `quest_order`, `description`, `is_active`, `created_at`) VALUES
(1, 'Simula ng Paglalakbay', 1, 'event', 0, 1, 1, 'Introduction to the Filibustero story', 1, '2025-08-04 08:08:13'),
(2, 'Unang Tanong', 1, 'question', 5, 1, 2, 'First set of questions about the story', 1, '2025-08-04 08:08:13'),
(3, 'Paghahanap ng Susi', 2, 'scavenger_hunt', 0, 2, 3, 'Find the hidden key in San Diego', 1, '2025-08-04 08:08:13'),
(4, 'Mga Tanong sa San Diego', 2, 'question', 5, 1, 4, 'Questions about San Diego chapter', 1, '2025-08-04 08:08:13'),
(5, 'Paglalakbay sa Kabundukan', 3, 'event', 0, 1, 5, 'Journey through the mountains', 1, '2025-08-04 08:08:13'),
(6, 'Mga Hamon sa Daan', 3, 'question', 5, 1, 6, 'Challenges on the road', 1, '2025-08-04 08:08:13'),
(7, 'Pagdating sa Sementeryo', 4, 'scavenger_hunt', 0, 2, 7, 'Cemetery exploration', 1, '2025-08-04 08:08:13'),
(8, 'Mga Multo ng Nakaraan', 4, 'question', 5, 1, 8, 'Questions about the past', 1, '2025-08-04 08:08:13'),
(9, 'Pakikipagkita kay Elias', 5, 'event', 0, 1, 9, 'Meeting with Elias', 1, '2025-08-04 08:08:13'),
(10, 'Mga Aral ni Elias', 5, 'question', 5, 1, 10, 'Lessons from Elias', 1, '2025-08-04 08:08:13'),
(11, 'Paghahanda para sa Rebolusyon', 6, 'event', 0, 1, 11, 'Preparing for revolution', 1, '2025-08-04 08:08:13'),
(12, 'Mga Tanong sa Rebolusyon', 6, 'question', 5, 1, 12, 'Questions about revolution', 1, '2025-08-04 08:08:13'),
(13, 'Pagkakamatay ni Elias', 7, 'event', 0, 1, 13, 'Death of Elias', 1, '2025-08-04 08:08:13'),
(14, 'Mga Tanong sa Kamatayan', 7, 'question', 5, 1, 14, 'Questions about death themes', 1, '2025-08-04 08:08:13'),
(15, 'Simoun at ang Himagsikan', 8, 'event', 0, 1, 15, 'Simoun and the revolution', 1, '2025-08-04 08:08:13'),
(16, 'Mga Tanong kay Simoun', 8, 'question', 5, 1, 16, 'Questions about Simoun', 1, '2025-08-04 08:08:13'),
(17, 'Ang Pagkakakilala', 9, 'scavenger_hunt', 0, 2, 17, 'The revelation hunt', 1, '2025-08-04 08:08:13'),
(18, 'Mga Tanong sa Pagkakakilala', 9, 'question', 5, 1, 18, 'Questions about revelations', 1, '2025-08-04 08:08:13'),
(19, 'Ang Huling Plano', 10, 'event', 0, 1, 19, 'The final plan', 1, '2025-08-04 08:08:13'),
(20, 'Mga Tanong sa Plano', 10, 'question', 5, 1, 20, 'Questions about the plan', 1, '2025-08-04 08:08:13'),
(21, 'Ang Kabiguan', 11, 'event', 0, 1, 21, 'The failure', 1, '2025-08-04 08:08:13'),
(22, 'Mga Tanong sa Kabiguan', 11, 'question', 5, 1, 22, 'Questions about failure', 1, '2025-08-04 08:08:13'),
(23, 'Ang Pagkakamatay ni Simoun', 12, 'event', 0, 1, 23, 'Death of Simoun', 1, '2025-08-04 08:08:13'),
(24, 'Mga Huling Tanong', 12, 'question', 5, 1, 24, 'Final questions', 1, '2025-08-04 08:08:13'),
(25, 'Wakas ng Kuwento', 13, 'event', 0, 1, 25, 'End of the story', 1, '2025-08-04 08:08:13'),
(26, 'Panghuling Pagsusulit', 13, 'question', 5, 1, 26, 'Final examination', 1, '2025-08-04 08:08:13');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `total_questions` int(11) DEFAULT 0,
  `time_limit` int(11) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_assignments`
--

CREATE TABLE `quiz_assignments` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `section` varchar(50) NOT NULL,
  `assigned_by` int(11) NOT NULL,
  `due_date` datetime DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempts`
--

CREATE TABLE `quiz_attempts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `selected_answer` char(1) DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `points_earned` int(11) DEFAULT 0,
  `attempt_number` int(11) DEFAULT 1,
  `time_spent_seconds` int(11) DEFAULT 0,
  `answered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('multiple_choice','true_false','fill_blank') DEFAULT 'multiple_choice',
  `correct_answer` text NOT NULL,
  `option_a` varchar(500) DEFAULT NULL,
  `option_b` varchar(500) DEFAULT NULL,
  `option_c` varchar(500) DEFAULT NULL,
  `option_d` varchar(500) DEFAULT NULL,
  `points` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_sessions`
--

CREATE TABLE `quiz_sessions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quest_id` int(11) NOT NULL,
  `session_start` timestamp NOT NULL DEFAULT current_timestamp(),
  `session_end` timestamp NULL DEFAULT NULL,
  `total_questions` int(11) DEFAULT 0,
  `correct_answers` int(11) DEFAULT 0,
  `total_score` int(11) DEFAULT 0,
  `completion_time_seconds` int(11) DEFAULT 0,
  `is_completed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `user_id` int(11) NOT NULL,
  `section` varchar(50) NOT NULL,
  `year_level` varchar(20) NOT NULL,
  `rizal_professor` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`user_id`, `section`, `year_level`, `rizal_professor`) VALUES
(2, 'Grade 9 - Section A', '2', 'Prof. Dela Cruz'),
(7, 'Grade 9 - Section A', '9', 'Prof. Dela Cruz');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`user_id`) VALUES
(1),
(3),
(4),
(5),
(6);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_sections`
--

CREATE TABLE `teacher_sections` (
  `teacher_id` int(11) NOT NULL,
  `section` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_sections`
--

INSERT INTO `teacher_sections` (`teacher_id`, `section`) VALUES
(1, 'Grade 7 - Section A'),
(1, 'Grade 8 - Section A'),
(1, 'Grade 8 - Section B'),
(3, 'Grade 7 - Section A'),
(3, 'Grade 7 - Section B'),
(3, 'Grade 7 - Section C'),
(4, 'Grade 7 - Section A'),
(4, 'Grade 7 - Section B'),
(4, 'Grade 7 - Section C'),
(4, 'Grade 8 - Section A'),
(5, 'Grade 9 - Section A'),
(5, 'Grade 9 - Section B'),
(5, 'Grade 9 - Section C'),
(6, 'Grade 10 - Section A'),
(6, 'Grade 8 - Section A'),
(6, 'Grade 9 - Section B');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_type` enum('student','teacher','admin') NOT NULL,
  `id_number` varchar(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `temp_password` tinyint(1) DEFAULT 0,
  `reset_token` varchar(64) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_type`, `id_number`, `full_name`, `username`, `password_hash`, `created_at`, `updated_at`, `temp_password`, `reset_token`, `reset_expires`) VALUES
(1, 'teacher', '22L-1900', 'Charlene Etcubanas', 'Charlene', '$2y$10$kOe6Fg01t55q50MJ5J3gv.mjnH91WunOczX2Qk6Cp/u6yLyNr.0dC', '2025-07-29 11:14:26', '2025-07-29 11:14:26', 0, NULL, NULL),
(2, 'student', '22L-4555', 'Krizlee Anne Pauline A. Terciano', 'Krizlee', '$2y$10$nzPvIjEbXuX1w04JNwBJG.XRyF8rg4xdERXf0qenBQobHhf.BH2TK', '2025-08-02 11:53:52', '2025-08-02 11:53:52', 0, NULL, NULL),
(3, 'teacher', '22L-9000', 'Teacher', 'teacher', '$2y$10$z5sJzOdjAnOcJJ3NjW2fROuhFdoLiaIHQX1izIxZT.ExDf8vTB.TG', '2025-08-15 05:48:20', '2025-08-15 05:48:20', 0, NULL, NULL),
(4, 'teacher', '22L-3334', 'Rachelle Gagan', 'rachelle', '$2y$10$zdf2dilfYhIDkgFUBkTmDeW7DJv/wxqgnAlvavKJ76RrS97NmVFUu', '2025-08-17 06:35:00', '2025-08-17 06:35:00', 0, NULL, NULL),
(5, 'teacher', '22L-3344', 'Reynaldo Danganan', 'reynaldo', '$2y$10$Bj1yahRx2SEMrLuLcBnNC.zLh.4O2K74Tq24pbp8GNdKItAM0icFa', '2025-08-17 06:47:04', '2025-08-17 06:47:04', 0, NULL, NULL),
(6, 'teacher', '22L-2233', 'Debbie Belo', 'debbie', '$2y$10$MC5YUpscp02d5PK566/Rl.i8GEwYnmQrE.CRXvcZYBBtEwDl.MjrS', '2025-08-17 06:57:35', '2025-08-17 06:57:35', 0, NULL, NULL),
(7, 'student', '22L-0809', 'Michael Bong Pineda', 'michael', '$2y$10$w8W65n9ONtG8Qw3fyX6CKumdBJcPe0lM4SEnoT1VN.4mahym1Ch5W', '2025-08-18 14:24:13', '2025-08-18 14:24:13', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_progress`
--

CREATE TABLE `user_progress` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `overall_progress` decimal(5,2) DEFAULT 0.00,
  `story_progress` decimal(5,2) DEFAULT 0.00,
  `chapter_progress` decimal(5,2) DEFAULT 0.00,
  `quest_progress` decimal(5,2) DEFAULT 0.00,
  `item_progress` decimal(5,2) DEFAULT 0.00,
  `achievement_progress` decimal(5,2) DEFAULT 0.00,
  `playtime_hours` int(11) DEFAULT 0,
  `current_stage` int(11) DEFAULT 1,
  `coin_count` int(11) DEFAULT 0,
  `completed_switches` int(11) DEFAULT 0,
  `completed_chapters` int(11) DEFAULT 0,
  `completed_quests` int(11) DEFAULT 0,
  `collected_items` int(11) DEFAULT 0,
  `unlocked_achievements` int(11) DEFAULT 0,
  `environment_mode` varchar(20) DEFAULT 'production',
  `last_save_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `quiz_progress` decimal(5,2) DEFAULT 0.00,
  `total_coins_earned` int(11) DEFAULT 0,
  `quiz_sessions_completed` int(11) DEFAULT 0,
  `total_quiz_score` int(11) DEFAULT 0,
  `perfect_quiz_count` int(11) DEFAULT 0,
  `events_completed` text DEFAULT NULL,
  `last_completed_event` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_progress`
--

INSERT INTO `user_progress` (`id`, `user_id`, `overall_progress`, `story_progress`, `chapter_progress`, `quest_progress`, `item_progress`, `achievement_progress`, `playtime_hours`, `current_stage`, `coin_count`, `completed_switches`, `completed_chapters`, `completed_quests`, `collected_items`, `unlocked_achievements`, `environment_mode`, `last_save_date`, `created_at`, `updated_at`, `quiz_progress`, `total_coins_earned`, `quiz_sessions_completed`, `total_quiz_score`, `perfect_quiz_count`, `events_completed`, `last_completed_event`) VALUES
(1, 1, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 1, 0, 0, 0, 0, 0, 0, 'production', NULL, '2025-07-29 11:14:26', '2025-07-29 11:14:26', 0.00, 0, 0, 0, 0, NULL, NULL),
(2, 2, 0.60, 1.00, 0.00, 0.00, 2.00, 0.00, 0, 1, 0, 1, 0, 0, 1, 0, 'production', '2025-08-02 05:30:17', '2025-08-02 11:53:52', '2025-08-02 13:30:17', 0.00, 0, 0, 0, 0, NULL, NULL),
(3, 3, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 1, 0, 0, 0, 0, 0, 0, 'production', NULL, '2025-08-15 05:48:20', '2025-08-15 05:48:20', 0.00, 0, 0, 0, 0, NULL, NULL),
(4, 4, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 1, 0, 0, 0, 0, 0, 0, 'production', NULL, '2025-08-17 06:35:00', '2025-08-17 06:35:00', 0.00, 0, 0, 0, 0, NULL, NULL),
(5, 5, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 1, 0, 0, 0, 0, 0, 0, 'production', NULL, '2025-08-17 06:47:04', '2025-08-17 06:47:04', 0.00, 0, 0, 0, 0, NULL, NULL),
(6, 6, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 1, 0, 0, 0, 0, 0, 0, 'production', NULL, '2025-08-17 06:57:35', '2025-08-17 06:57:35', 0.00, 0, 0, 0, 0, NULL, NULL),
(7, 7, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0, 1, 0, 0, 0, 0, 0, 0, 'production', NULL, '2025-08-18 14:24:13', '2025-08-18 14:24:13', 0.00, 0, 0, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure for view `leaderboard`
--
DROP TABLE IF EXISTS `leaderboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `leaderboard`  AS SELECT `p`.`player_name` AS `player_name`, `gp`.`score` AS `score`, `gp`.`coins` AS `coins`, `gp`.`current_stage` AS `current_stage`, `gp`.`progress_percentage` AS `progress_percentage`, `gp`.`completed_quests` AS `completed_quests`, `gp`.`correct_answers` AS `correct_answers`, `gp`.`total_questions_answered` AS `total_questions_answered`, CASE WHEN `gp`.`total_questions_answered` > 0 THEN round(`gp`.`correct_answers` / `gp`.`total_questions_answered` * 100,2) ELSE 0 END AS `accuracy_percentage`, `gp`.`game_completed` AS `game_completed`, `gp`.`completion_time` AS `completion_time`, `gp`.`last_played` AS `last_played` FROM (`players` `p` join `game_progress` `gp` on(`p`.`id` = `gp`.`player_id`)) ORDER BY `gp`.`score` DESC, `gp`.`progress_percentage` DESC, `gp`.`completion_time` ASC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `game_sessions`
--
ALTER TABLE `game_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_player_sessions` (`player_id`),
  ADD KEY `idx_session_date` (`session_start`),
  ADD KEY `idx_game_sessions_duration` (`duration_minutes`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_player_name` (`player_name`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_players_created_at` (`created_at`),
  ADD KEY `idx_players_user_id` (`user_id`);

--
-- Indexes for table `player_answers`
--
ALTER TABLE `player_answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `idx_player_answers` (`player_id`,`question_id`),
  ADD KEY `idx_correct_answers` (`is_correct`),
  ADD KEY `idx_player_answers_answered_at` (`answered_at`);

--
-- Indexes for table `player_quest_progress`
--
ALTER TABLE `player_quest_progress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_player_quest` (`player_id`,`quest_id`),
  ADD KEY `quest_id` (`quest_id`),
  ADD KEY `idx_player_quest` (`player_id`,`quest_id`),
  ADD KEY `idx_completion_status` (`is_completed`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_quest_questions` (`quest_id`),
  ADD KEY `idx_difficulty` (`difficulty`);

--
-- Indexes for table `quests`
--
ALTER TABLE `quests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stage` (`stage`),
  ADD KEY `idx_quest_type` (`quest_type`),
  ADD KEY `idx_quest_order` (`quest_order`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `quiz_assignments`
--
ALTER TABLE `quiz_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`),
  ADD KEY `assigned_by` (`assigned_by`);

--
-- Indexes for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_question` (`user_id`,`question_id`),
  ADD KEY `idx_quest_attempts` (`quest_id`),
  ADD KEY `idx_attempt_date` (`answered_at`),
  ADD KEY `quiz_attempts_question_fk` (`question_id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_sessions` (`user_id`),
  ADD KEY `idx_quest_sessions` (`quest_id`),
  ADD KEY `idx_session_date` (`session_start`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `teacher_sections`
--
ALTER TABLE `teacher_sections`
  ADD PRIMARY KEY (`teacher_id`,`section`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_number` (`id_number`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_progress`
--
ALTER TABLE `user_progress`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `game_sessions`
--
ALTER TABLE `game_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_answers`
--
ALTER TABLE `player_answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `player_quest_progress`
--
ALTER TABLE `player_quest_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `quests`
--
ALTER TABLE `quests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_assignments`
--
ALTER TABLE `quiz_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_progress`
--
ALTER TABLE `user_progress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `game_sessions`
--
ALTER TABLE `game_sessions`
  ADD CONSTRAINT `game_sessions_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `player_answers`
--
ALTER TABLE `player_answers`
  ADD CONSTRAINT `player_answers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_quest_progress`
--
ALTER TABLE `player_quest_progress`
  ADD CONSTRAINT `player_quest_progress_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_quest_progress_ibfk_2` FOREIGN KEY (`quest_id`) REFERENCES `quests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`quest_id`) REFERENCES `quests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `teachers` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `quiz_assignments`
--
ALTER TABLE `quiz_assignments`
  ADD CONSTRAINT `quiz_assignments_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_assignments_ibfk_2` FOREIGN KEY (`assigned_by`) REFERENCES `teachers` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD CONSTRAINT `quiz_attempts_quest_fk` FOREIGN KEY (`quest_id`) REFERENCES `quests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_attempts_question_fk` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_attempts_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `quiz_questions_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_sessions`
--
ALTER TABLE `quiz_sessions`
  ADD CONSTRAINT `quiz_sessions_quest_fk` FOREIGN KEY (`quest_id`) REFERENCES `quests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_sessions_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `teacher_sections`
--
ALTER TABLE `teacher_sections`
  ADD CONSTRAINT `teacher_sections_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `user_progress`
--
ALTER TABLE `user_progress`
  ADD CONSTRAINT `user_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
