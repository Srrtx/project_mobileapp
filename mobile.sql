-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 02, 2024 at 08:55 PM
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
-- Database: `mobile`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookinghistory`
--

CREATE TABLE `bookinghistory` (
  `history_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `timeslot_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT NULL,
  `log_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf16le COLLATE=utf16le_general_ci;

--
-- Dumping data for table `bookinghistory`
--

INSERT INTO `bookinghistory` (`history_id`, `room_id`, `timeslot_id`, `student_id`, `approver_id`, `status`, `log_date`) VALUES
(1, 1, 3, 1, 4, '', '2024-11-02 19:43:18'),
(2, 2, 6, 2, 4, 'approved', '2024-11-02 19:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `bookingrequests`
--

CREATE TABLE `bookingrequests` (
  `request_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `timeslot_id` int(11) DEFAULT NULL,
  `request_date` date NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `handled_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf16le COLLATE=utf16le_general_ci;

--
-- Dumping data for table `bookingrequests`
--

INSERT INTO `bookingrequests` (`request_id`, `student_id`, `room_id`, `timeslot_id`, `request_date`, `status`, `handled_by`, `created_at`) VALUES
(1, 1, 1, 1, '2024-11-03', 'pending', NULL, '2024-11-02 19:43:18'),
(2, 2, 2, 6, '2024-11-03', 'approved', 4, '2024-11-02 19:43:18');

-- --------------------------------------------------------

--
-- Stand-in structure for view `dashboard`
-- (See below for the actual view)
--
CREATE TABLE `dashboard` (
`free_slots` bigint(21)
,`pending_slots` bigint(21)
,`reserved_slots` bigint(21)
,`disabled_rooms` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `room_name` varchar(100) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `status` enum('enabled','disabled') DEFAULT 'enabled',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf16le COLLATE=utf16le_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `room_name`, `image_path`, `status`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Meeting Room 1', 'assets/images/meeting1.png', 'enabled', 3, '2024-11-02 19:43:18', '2024-11-02 19:43:18'),
(2, 'Conference Hall', 'assets/images/conference.png', 'enabled', 3, '2024-11-02 19:43:18', '2024-11-02 19:43:18'),
(3, 'Seminar Room', 'assets/images/seminar.png', 'enabled', 3, '2024-11-02 19:43:18', '2024-11-02 19:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `timeslots`
--

CREATE TABLE `timeslots` (
  `timeslot_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `time_slot` enum('08:00-10:00','10:00-12:00','13:00-15:00','15:00-17:00') NOT NULL,
  `status` enum('free','pending','reserved','disabled') DEFAULT 'free',
  `booked_by` int(11) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf16le COLLATE=utf16le_general_ci;

--
-- Dumping data for table `timeslots`
--

INSERT INTO `timeslots` (`timeslot_id`, `room_id`, `date`, `time_slot`, `status`, `booked_by`, `approved_by`, `created_at`) VALUES
(1, 1, '2024-11-03', '08:00-10:00', 'free', NULL, NULL, '2024-11-02 19:43:18'),
(2, 1, '2024-11-03', '10:00-12:00', 'free', NULL, NULL, '2024-11-02 19:43:18'),
(3, 1, '2024-11-03', '13:00-15:00', 'reserved', NULL, NULL, '2024-11-02 19:43:18'),
(4, 1, '2024-11-03', '15:00-17:00', 'disabled', NULL, NULL, '2024-11-02 19:43:18'),
(5, 2, '2024-11-03', '08:00-10:00', 'free', NULL, NULL, '2024-11-02 19:43:18'),
(6, 2, '2024-11-03', '10:00-12:00', 'pending', NULL, NULL, '2024-11-02 19:43:18'),
(7, 2, '2024-11-03', '13:00-15:00', 'free', NULL, NULL, '2024-11-02 19:43:18'),
(8, 2, '2024-11-03', '15:00-17:00', 'reserved', NULL, NULL, '2024-11-02 19:43:18'),
(9, 3, '2024-11-03', '08:00-10:00', 'disabled', NULL, NULL, '2024-11-02 19:43:18'),
(10, 3, '2024-11-03', '10:00-12:00', 'free', NULL, NULL, '2024-11-02 19:43:18'),
(11, 3, '2024-11-03', '13:00-15:00', 'free', NULL, NULL, '2024-11-02 19:43:18'),
(12, 3, '2024-11-03', '15:00-17:00', 'free', NULL, NULL, '2024-11-02 19:43:18');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `role` enum('Student','Staff','Approver') NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf16le COLLATE=utf16le_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `role`, `name`, `username`, `password`, `email`, `created_at`) VALUES
(1, 'Student', 'John Doe', 'johndoe', 'password123', 'john.doe@example.com', '2024-11-02 19:43:18'),
(2, 'Student', 'Jane Smith', 'janesmith', 'password456', 'jane.smith@example.com', '2024-11-02 19:43:18'),
(3, 'Staff', 'Emily White', 'emilywhite', 'staffpass123', 'emily.white@example.com', '2024-11-02 19:43:18'),
(4, 'Approver', 'Dr. Alan Brown', 'alanbrown', 'approverpass123', 'alan.brown@example.com', '2024-11-02 19:43:18'),
(5, 'Approver', 'Dr. Lisa Green', 'lisagreen', 'approverpass456', 'lisa.green@example.com', '2024-11-02 19:43:18');

-- --------------------------------------------------------

--
-- Structure for view `dashboard`
--
DROP TABLE IF EXISTS `dashboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dashboard`  AS SELECT (select count(0) from `timeslots` where `timeslots`.`status` = 'free') AS `free_slots`, (select count(0) from `timeslots` where `timeslots`.`status` = 'pending') AS `pending_slots`, (select count(0) from `timeslots` where `timeslots`.`status` = 'reserved') AS `reserved_slots`, (select count(0) from `rooms` where `rooms`.`status` = 'disabled') AS `disabled_rooms` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookinghistory`
--
ALTER TABLE `bookinghistory`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `timeslot_id` (`timeslot_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `approver_id` (`approver_id`);

--
-- Indexes for table `bookingrequests`
--
ALTER TABLE `bookingrequests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `timeslot_id` (`timeslot_id`),
  ADD KEY `handled_by` (`handled_by`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `timeslots`
--
ALTER TABLE `timeslots`
  ADD PRIMARY KEY (`timeslot_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `booked_by` (`booked_by`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookinghistory`
--
ALTER TABLE `bookinghistory`
  MODIFY `history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bookingrequests`
--
ALTER TABLE `bookingrequests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `timeslots`
--
ALTER TABLE `timeslots`
  MODIFY `timeslot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookinghistory`
--
ALTER TABLE `bookinghistory`
  ADD CONSTRAINT `bookinghistory_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`),
  ADD CONSTRAINT `bookinghistory_ibfk_2` FOREIGN KEY (`timeslot_id`) REFERENCES `timeslots` (`timeslot_id`),
  ADD CONSTRAINT `bookinghistory_ibfk_3` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookinghistory_ibfk_4` FOREIGN KEY (`approver_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `bookingrequests`
--
ALTER TABLE `bookingrequests`
  ADD CONSTRAINT `bookingrequests_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `bookingrequests_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`),
  ADD CONSTRAINT `bookingrequests_ibfk_3` FOREIGN KEY (`timeslot_id`) REFERENCES `timeslots` (`timeslot_id`),
  ADD CONSTRAINT `bookingrequests_ibfk_4` FOREIGN KEY (`handled_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `timeslots`
--
ALTER TABLE `timeslots`
  ADD CONSTRAINT `timeslots_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`),
  ADD CONSTRAINT `timeslots_ibfk_2` FOREIGN KEY (`booked_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `timeslots_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
