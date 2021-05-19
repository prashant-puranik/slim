-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2021 at 06:44 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `freestate`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED DEFAULT NULL,
  `hcp_id` int(11) UNSIGNED DEFAULT NULL,
  `type` enum('virtual','in-person') DEFAULT 'virtual',
  `topic` varchar(255) NOT NULL DEFAULT '',
  `date_time` int(11) NOT NULL,
  `length` int(3) NOT NULL DEFAULT 15,
  `status` enum('scheduled','started','cancelled') NOT NULL DEFAULT 'scheduled',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `started_at` int(11) DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_members`
--

CREATE TABLE `appointment_members` (
  `id` int(11) UNSIGNED NOT NULL,
  `appointment_id` int(11) UNSIGNED NOT NULL,
  `member_type` enum('hcp','patient') NOT NULL DEFAULT 'hcp',
  `member_id` int(10) UNSIGNED NOT NULL,
  `is_owner` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_reservations`
--

CREATE TABLE `appointment_reservations` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED DEFAULT NULL,
  `patient_id` int(11) UNSIGNED DEFAULT NULL,
  `expires` int(11) NOT NULL,
  `date_string` varchar(10) NOT NULL DEFAULT '1970-01-01',
  `timezone` varchar(255) NOT NULL DEFAULT 'UTC',
  `start` varchar(4) NOT NULL DEFAULT '0000',
  `end` varchar(4) NOT NULL DEFAULT '0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_reservation_members`
--

CREATE TABLE `appointment_reservation_members` (
  `id` int(11) UNSIGNED NOT NULL,
  `appointment_reservation_id` int(11) UNSIGNED NOT NULL,
  `member_type` enum('hcp','patient') NOT NULL DEFAULT 'hcp',
  `member_id` int(10) UNSIGNED NOT NULL,
  `is_owner` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `associative_languages`
--

CREATE TABLE `associative_languages` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `iso` char(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_tokens`
--

CREATE TABLE `auth_tokens` (
  `id` int(11) UNSIGNED NOT NULL,
  `token_id` varchar(36) NOT NULL DEFAULT '',
  `consumer_id` varchar(36) NOT NULL DEFAULT '',
  `expires` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `blood_pressure_alerts`
--

CREATE TABLE `blood_pressure_alerts` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `blood_pressure_threshold_id` int(11) UNSIGNED NOT NULL,
  `blood_pressure_entry_id` int(11) UNSIGNED NOT NULL,
  `min_value` int(11) UNSIGNED NOT NULL,
  `max_value` int(11) UNSIGNED NOT NULL,
  `value` int(11) UNSIGNED NOT NULL,
  `field` varchar(255) NOT NULL,
  `reason` enum('above','below') DEFAULT 'above',
  `source` enum('app','web','healthkit','googlefit','samsunghealth') DEFAULT 'web',
  `created_at` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `blood_pressure_entries`
--

CREATE TABLE `blood_pressure_entries` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `date_time` int(11) UNSIGNED NOT NULL,
  `systolic` tinyint(3) UNSIGNED NOT NULL,
  `diastolic` tinyint(3) UNSIGNED NOT NULL,
  `heart_rate` tinyint(3) UNSIGNED NOT NULL,
  `source` enum('app','web','healthkit','googlefit','samsunghealth') DEFAULT 'web',
  `created_at` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `blood_pressure_entry_queue`
--

CREATE TABLE `blood_pressure_entry_queue` (
  `id` int(11) UNSIGNED NOT NULL,
  `object` mediumtext DEFAULT NULL,
  `locked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `retries` tinyint(1) DEFAULT 0,
  `created_at` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `blood_pressure_thresholds`
--

CREATE TABLE `blood_pressure_thresholds` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `min_systolic` int(11) UNSIGNED NOT NULL,
  `max_systolic` int(11) UNSIGNED NOT NULL,
  `min_diastolic` int(11) UNSIGNED NOT NULL,
  `max_diastolic` int(11) UNSIGNED NOT NULL,
  `min_heart_rate` int(11) UNSIGNED NOT NULL,
  `max_heart_rate` int(11) UNSIGNED NOT NULL,
  `created_at` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(11) UNSIGNED NOT NULL,
  `timestamp` int(11) NOT NULL,
  `user_type` enum('patient','hcp') NOT NULL DEFAULT 'patient',
  `user_id` int(11) UNSIGNED NOT NULL,
  `user_name` varchar(255) NOT NULL DEFAULT '',
  `room` varchar(255) NOT NULL DEFAULT '',
  `type` enum('message','file') DEFAULT NULL,
  `value` text NOT NULL,
  `file_id` int(11) UNSIGNED DEFAULT NULL,
  `file_type` enum('doc','image') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `chat_message_read_states`
--

CREATE TABLE `chat_message_read_states` (
  `id` int(11) UNSIGNED NOT NULL,
  `chat_message_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `user_type` enum('patient','hcp') NOT NULL DEFAULT 'patient',
  `unread` tinyint(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `chat_rooms`
--

CREATE TABLE `chat_rooms` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `chat_room_users`
--

CREATE TABLE `chat_room_users` (
  `id` int(11) UNSIGNED NOT NULL,
  `chat_room_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `user_type` enum('patient','hcp') NOT NULL DEFAULT 'patient',
  `owner` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `device_tokens`
--

CREATE TABLE `device_tokens` (
  `id` int(11) UNSIGNED NOT NULL,
  `device_group` varchar(255) NOT NULL DEFAULT '',
  `token` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `docusign_templates`
--

CREATE TABLE `docusign_templates` (
  `id` int(11) UNSIGNED NOT NULL,
  `uid` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(255) DEFAULT '',
  `extension` varchar(10) NOT NULL DEFAULT '',
  `mime` varchar(255) DEFAULT NULL,
  `is_temp` tinyint(1) DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `failure_reason` varchar(255) NOT NULL DEFAULT '',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp`
--

CREATE TABLE `hcp` (
  `id` int(11) UNSIGNED NOT NULL,
  `eazyscript_id` int(11) DEFAULT NULL,
  `eazyscript_password` varchar(255) DEFAULT NULL,
  `sync_with_eazyscripts` tinyint(1) DEFAULT 0,
  `eazyscripts_sync_retries` tinyint(1) DEFAULT 0,
  `eazyscripts_sync_error` varchar(255) DEFAULT NULL,
  `hcp_type_id` int(11) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `remember_me_token` varchar(255) DEFAULT NULL,
  `avatar` int(11) DEFAULT NULL,
  `npi_number` int(11) DEFAULT NULL,
  `practice_name` text DEFAULT NULL,
  `healthcare_facility_id` int(11) UNSIGNED DEFAULT NULL,
  `cell_phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `address_line_1` varchar(255) DEFAULT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL DEFAULT 'United States',
  `password_reset_token` varchar(255) DEFAULT NULL,
  `password_reset_expiry` int(11) DEFAULT 0,
  `status` enum('active','pending_review','denied') DEFAULT 'pending_review',
  `availability` enum('available','unavailable') NOT NULL DEFAULT 'unavailable',
  `timezone` varchar(255) NOT NULL DEFAULT 'UTC',
  `device_group` varchar(255) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL,
  `signed_terms_id` int(11) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_availability`
--

CREATE TABLE `hcp_availability` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `type` enum('virtual','in-person') DEFAULT 'virtual',
  `day` varchar(4) DEFAULT '',
  `slot_length` int(3) NOT NULL DEFAULT 15,
  `date_string` varchar(10) DEFAULT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT 'UTC',
  `is_date` tinyint(1) NOT NULL DEFAULT 0,
  `unavailable` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_availability_slots`
--

CREATE TABLE `hcp_availability_slots` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_availability_id` int(11) UNSIGNED NOT NULL,
  `start` varchar(4) NOT NULL DEFAULT '0000',
  `end` varchar(4) NOT NULL DEFAULT '0015'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_healthcare_facilities`
--

CREATE TABLE `hcp_healthcare_facilities` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `healthcare_facility_id` int(11) UNSIGNED NOT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_language`
--

CREATE TABLE `hcp_language` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `language_id` int(11) UNSIGNED NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_license_dea`
--

CREATE TABLE `hcp_license_dea` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_license_state`
--

CREATE TABLE `hcp_license_state` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_patients`
--

CREATE TABLE `hcp_patients` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_patients_drop_reasons`
--

CREATE TABLE `hcp_patients_drop_reasons` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_preferred_medicines`
--

CREATE TABLE `hcp_preferred_medicines` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `medicine_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_specialties`
--

CREATE TABLE `hcp_specialties` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `specialty_id` int(11) UNSIGNED NOT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hcp_types`
--

CREATE TABLE `hcp_types` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `npi_required` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `dea_license_required` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `state_license_required` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `is_public` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hcp_types`
--

INSERT INTO `hcp_types` (`id`, `name`, `npi_required`, `dea_license_required`, `state_license_required`, `is_public`) VALUES
(1, 'Case Management/Social Work', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `healthcare_facilities`
--

CREATE TABLE `healthcare_facilities` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) DEFAULT '',
  `phone` varchar(255) DEFAULT '',
  `address_line_1` varchar(255) NOT NULL DEFAULT '',
  `address_line_2` varchar(255) DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `state` varchar(255) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `medical_histories`
--

CREATE TABLE `medical_histories` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED DEFAULT NULL,
  `past_health_problems` text DEFAULT NULL,
  `hospitalization` text DEFAULT NULL,
  `current_medication` text DEFAULT NULL,
  `obsolete_medication` text DEFAULT NULL,
  `medicine_allergy` text DEFAULT NULL,
  `other_hcp` text DEFAULT NULL,
  `allow_contact_hcp` tinyint(1) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `medical_histories_files`
--

CREATE TABLE `medical_histories_files` (
  `id` int(11) UNSIGNED NOT NULL,
  `medical_history_id` int(11) UNSIGNED NOT NULL,
  `file_id` int(11) UNSIGNED NOT NULL,
  `type` int(11) UNSIGNED NOT NULL,
  `created_at` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `on_call`
--

CREATE TABLE `on_call` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `healthcare_facility_id` int(11) UNSIGNED NOT NULL,
  `day` varchar(4) DEFAULT '',
  `date_string` varchar(10) DEFAULT NULL,
  `role` varchar(10) DEFAULT 'primary',
  `is_date` tinyint(1) NOT NULL DEFAULT 0,
  `timezone` varchar(255) NOT NULL DEFAULT 'UTC',
  `created_at` int(11) UNSIGNED NOT NULL,
  `updated_at` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `on_call_slots`
--

CREATE TABLE `on_call_slots` (
  `id` int(11) UNSIGNED NOT NULL,
  `on_call_id` int(11) UNSIGNED NOT NULL,
  `start` varchar(4) NOT NULL DEFAULT '0000',
  `end` varchar(4) NOT NULL DEFAULT '0015'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) UNSIGNED NOT NULL,
  `eazyscript_id` int(11) DEFAULT NULL,
  `eazyscript_password` varchar(255) DEFAULT NULL,
  `sync_with_eazyscripts` tinyint(1) DEFAULT 0,
  `eazyscripts_sync_retries` tinyint(1) DEFAULT 0,
  `eazyscripts_sync_error` varchar(255) DEFAULT NULL,
  `type` enum('guardian','patient','facility') NOT NULL DEFAULT 'patient',
  `name` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `remember_me_token` varchar(255) DEFAULT NULL,
  `stripe_customer_id` varchar(255) DEFAULT NULL,
  `avatar` int(11) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address_line_1` varchar(255) DEFAULT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT 'UTC',
  `proof_identification` int(11) DEFAULT NULL,
  `proof_card` int(11) DEFAULT NULL,
  `is_guardian` tinyint(1) DEFAULT 0,
  `guardian_name` varchar(255) DEFAULT NULL,
  `guardian_first_name` varchar(255) NOT NULL DEFAULT '',
  `guardian_last_name` varchar(255) NOT NULL DEFAULT '',
  `password_reset_token` varchar(32) DEFAULT NULL,
  `password_reset_expiry` int(11) DEFAULT NULL,
  `onboarding_step` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `device_group` varchar(255) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL,
  `signed_terms_id` int(11) DEFAULT NULL,
  `signature_file_id` int(11) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient_envelopes`
--

CREATE TABLE `patient_envelopes` (
  `id` int(11) UNSIGNED NOT NULL,
  `uid` varchar(255) NOT NULL DEFAULT '',
  `patient_id` int(11) UNSIGNED NOT NULL,
  `uri` varchar(255) NOT NULL DEFAULT '',
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `docusign_template` varchar(255) NOT NULL DEFAULT '',
  `created_at` int(11) UNSIGNED NOT NULL,
  `signed_at` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient_notes`
--

CREATE TABLE `patient_notes` (
  `id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `note` text NOT NULL,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient_uploads`
--

CREATE TABLE `patient_uploads` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED NOT NULL,
  `file_id` int(11) UNSIGNED NOT NULL,
  `category` varchar(11) NOT NULL DEFAULT '',
  `created_at` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(11) UNSIGNED NOT NULL,
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `amount` int(11) NOT NULL,
  `currency` varchar(11) NOT NULL DEFAULT 'usd',
  `interval_type` varchar(11) NOT NULL DEFAULT 'month',
  `interval_count` int(11) NOT NULL DEFAULT 1,
  `statement_descriptor` int(11) DEFAULT NULL,
  `trial_period_days` int(11) DEFAULT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `policies`
--

CREATE TABLE `policies` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `holder_name` varchar(255) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `policies_files`
--

CREATE TABLE `policies_files` (
  `id` int(11) UNSIGNED NOT NULL,
  `policy_id` int(11) UNSIGNED NOT NULL,
  `file_id` int(11) UNSIGNED NOT NULL,
  `created_at` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `providers`
--

CREATE TABLE `providers` (
  `id` int(11) UNSIGNED NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE `schema_migrations` (
  `version` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20170405215603'),
('20170406143445'),
('20170407101719'),
('20170410185318'),
('20170414193517'),
('20170414193532'),
('20170414193537'),
('20170414193545'),
('20170417192956'),
('20170418223150'),
('20170418223156'),
('20170420084810'),
('20170420113333'),
('20170424065502'),
('20170424125256'),
('20170426122230'),
('20170426152436'),
('20170426204443'),
('20170426230026'),
('20170427082550'),
('20170427164406'),
('20170427181751'),
('20170427183833'),
('20170428125921'),
('20170428130911'),
('20170504155941'),
('20170508202358'),
('20170509161036'),
('20170509195033'),
('20170510001227'),
('20170510001244'),
('20170510172337'),
('20170510172451'),
('20170510191358'),
('20170510191423'),
('20170510191429'),
('20170510194725'),
('20170510212354'),
('20170515120604'),
('20170518190038'),
('20170522155644'),
('20170522172627'),
('20170524200824'),
('20170526113416'),
('20170526182234'),
('20170530125743'),
('20170530165952'),
('20170530180355'),
('20170531170519'),
('20170531205554'),
('20170601112908'),
('20170602135806'),
('20170613103852'),
('20170619065626'),
('20170622151356'),
('20170626105113'),
('20170628114411'),
('20170628124232'),
('20170704173656'),
('20170705164558'),
('20170707183339'),
('20170711192428'),
('20170712111931'),
('20170712113329'),
('20170712121909'),
('20170719154026'),
('20170726173243'),
('20170727170232'),
('20170802191936'),
('20170808123055'),
('20170811142926'),
('20170817151213'),
('20170818095347'),
('20170821153912'),
('20170828184505'),
('20170830172207'),
('20170908144812'),
('20170914130347'),
('20170918172057'),
('20170919093613'),
('20170920101935'),
('20170920112335'),
('20170922112835'),
('20171002084441'),
('20171011113308'),
('20171011151219'),
('20171025081302'),
('20171025090725'),
('20171106115501'),
('20171106132650'),
('20171107092701'),
('20171108171251'),
('20171114100419'),
('20171116104941'),
('20171124211857'),
('20171204123034'),
('20171207170506'),
('20171211100923'),
('20171228174935'),
('20180104180633'),
('20180123131551'),
('20180124090140'),
('20180125154313'),
('20180208175556'),
('20180209135331'),
('20180215153125'),
('20180216114854'),
('20180218202951'),
('20180226172358'),
('20180302105418'),
('20180306152327'),
('20180405170213'),
('20180406133817'),
('20180411092112'),
('20180412120021'),
('20180412145757'),
('20180425160100'),
('20180427133143'),
('20180509135131'),
('20180511120419'),
('20180514111659'),
('20180522145151'),
('20180524230821'),
('20180530190700'),
('20180820192648'),
('20180828121627'),
('20180828133053'),
('20180829100909'),
('20210428072213');

-- --------------------------------------------------------

--
-- Table structure for table `specialties`
--

CREATE TABLE `specialties` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED DEFAULT NULL,
  `parent_subscription_id` int(11) UNSIGNED DEFAULT NULL,
  `stripe_id` varchar(255) NOT NULL DEFAULT '',
  `stripe_customer_id` varchar(255) NOT NULL DEFAULT '',
  `stripe_plan` varchar(255) NOT NULL DEFAULT '',
  `stripe_amount` int(11) NOT NULL DEFAULT 0,
  `stripe_status` varchar(255) NOT NULL DEFAULT 'active',
  `coupon` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `canceled_at` int(11) DEFAULT NULL,
  `expires_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_invites`
--

CREATE TABLE `subscription_invites` (
  `id` int(11) UNSIGNED NOT NULL,
  `subscription_id` int(11) UNSIGNED NOT NULL,
  `patient_id` int(11) UNSIGNED DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `token` varchar(255) NOT NULL DEFAULT '',
  `is_kid` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `terms`
--

CREATE TABLE `terms` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` enum('hcp','patient') DEFAULT 'patient',
  `part_1` text DEFAULT NULL,
  `part_2` text DEFAULT NULL,
  `part_3` text DEFAULT NULL,
  `state` enum('draft','published') DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `published_at` int(11) DEFAULT NULL,
  `deleted_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address_line_1` varchar(255) DEFAULT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `proof_identification` varchar(255) DEFAULT NULL,
  `is_guardian` tinyint(1) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `video_sessions`
--

CREATE TABLE `video_sessions` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` enum('call','recording') NOT NULL DEFAULT 'call',
  `session_id` varchar(255) NOT NULL DEFAULT '',
  `room` varchar(255) NOT NULL DEFAULT '',
  `timestamp` int(11) NOT NULL,
  `status` enum('invited','started','ended','declined') NOT NULL DEFAULT 'invited',
  `archive_status` enum('waiting','started','processing','finished','failed') NOT NULL DEFAULT 'waiting',
  `archive_started_at` int(11) DEFAULT NULL,
  `archive_retries` tinyint(1) NOT NULL DEFAULT 0,
  `archive` varchar(255) NOT NULL DEFAULT '',
  `audio` varchar(255) NOT NULL DEFAULT '',
  `thumbnail_status` enum('waiting','started','processing','finished','failed') NOT NULL DEFAULT 'waiting',
  `thumbnail_retries` tinyint(1) NOT NULL DEFAULT 0,
  `thumbnail` varchar(255) NOT NULL DEFAULT '',
  `archive_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `video_session_tags`
--

CREATE TABLE `video_session_tags` (
  `id` int(11) UNSIGNED NOT NULL,
  `type` enum('action','note') NOT NULL DEFAULT 'note',
  `video_session_id` int(11) UNSIGNED NOT NULL,
  `hcp_id` int(11) UNSIGNED NOT NULL,
  `timestamp` int(11) UNSIGNED NOT NULL,
  `notes` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `video_session_users`
--

CREATE TABLE `video_session_users` (
  `id` int(11) UNSIGNED NOT NULL,
  `video_session_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `user_type` enum('patient','hcp') NOT NULL DEFAULT 'patient',
  `uid` varchar(255) NOT NULL,
  `token` varchar(500) NOT NULL,
  `invite_token` varchar(255) DEFAULT NULL,
  `state` enum('pending','left','joined') NOT NULL DEFAULT 'pending',
  `is_caller` tinyint(1) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `credentials` (`email`(191),`password`(191)),
  ADD KEY `dates` (`created_at`,`updated_at`),
  ADD KEY `deleted_at` (`deleted_at`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `hcp_id` (`hcp_id`),
  ADD KEY `status` (`status`,`date_time`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `appointment_members`
--
ALTER TABLE `appointment_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `member_type` (`member_type`,`member_id`);

--
-- Indexes for table `appointment_reservations`
--
ALTER TABLE `appointment_reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_reservations_hcp` (`hcp_id`),
  ADD KEY `appointment_reservations_patient` (`patient_id`);

--
-- Indexes for table `appointment_reservation_members`
--
ALTER TABLE `appointment_reservation_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_reservation_id` (`appointment_reservation_id`),
  ADD KEY `member_type` (`member_type`,`member_id`);

--
-- Indexes for table `associative_languages`
--
ALTER TABLE `associative_languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `token_id` (`token_id`,`consumer_id`,`expires`);

--
-- Indexes for table `blood_pressure_alerts`
--
ALTER TABLE `blood_pressure_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blood_pressure_alerts_patient` (`patient_id`),
  ADD KEY `blood_pressure_alerts_blood_pressure_threshold` (`blood_pressure_threshold_id`),
  ADD KEY `blood_pressure_alerts_blood_pressure_entry` (`blood_pressure_entry_id`);

--
-- Indexes for table `blood_pressure_entries`
--
ALTER TABLE `blood_pressure_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blood_pressure_entries_patient` (`patient_id`),
  ADD KEY `date_time` (`date_time`,`patient_id`),
  ADD KEY `source` (`source`);

--
-- Indexes for table `blood_pressure_entry_queue`
--
ALTER TABLE `blood_pressure_entry_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `locked` (`locked`,`created_at`),
  ADD KEY `retries` (`retries`);

--
-- Indexes for table `blood_pressure_thresholds`
--
ALTER TABLE `blood_pressure_thresholds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blood_pressure_thresholds_patient` (`patient_id`),
  ADD KEY `blood_pressure_thresholds_hcp` (`hcp_id`),
  ADD KEY `min_systolic` (`min_systolic`,`max_systolic`,`min_diastolic`,`max_diastolic`,`min_heart_rate`,`max_heart_rate`,`created_at`,`patient_id`,`hcp_id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `user_type` (`user_type`,`user_id`,`user_name`(191)),
  ADD KEY `type` (`type`,`room`(191));

--
-- Indexes for table `chat_message_read_states`
--
ALTER TABLE `chat_message_read_states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_message_id` (`chat_message_id`),
  ADD KEY `unread` (`unread`);

--
-- Indexes for table `chat_rooms`
--
ALTER TABLE `chat_rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `deleted_at` (`deleted_at`);

--
-- Indexes for table `chat_room_users`
--
ALTER TABLE `chat_room_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chat_room_user_chat_room` (`chat_room_id`);

--
-- Indexes for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `token` (`token`,`created_at`),
  ADD KEY `updated_at` (`updated_at`);

--
-- Indexes for table `docusign_templates`
--
ALTER TABLE `docusign_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `is_public` (`is_public`);

--
-- Indexes for table `hcp`
--
ALTER TABLE `hcp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_healthcare_facility` (`healthcare_facility_id`),
  ADD KEY `availability` (`availability`),
  ADD KEY `hcp_type_id` (`hcp_type_id`),
  ADD KEY `eazyscript_id` (`eazyscript_id`),
  ADD KEY `sync_with_eazyscripts` (`sync_with_eazyscripts`),
  ADD KEY `deleted_at` (`deleted_at`),
  ADD KEY `signed_terms_id` (`signed_terms_id`),
  ADD KEY `firebase_notification_key` (`device_group`);

--
-- Indexes for table `hcp_availability`
--
ALTER TABLE `hcp_availability`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_availability_hcp` (`hcp_id`),
  ADD KEY `day` (`day`),
  ADD KEY `date_string` (`date_string`,`is_date`),
  ADD KEY `unavailable` (`unavailable`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `hcp_availability_slots`
--
ALTER TABLE `hcp_availability_slots`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_availability_slot_hcp_availability` (`hcp_availability_id`);

--
-- Indexes for table `hcp_healthcare_facilities`
--
ALTER TABLE `hcp_healthcare_facilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_id` (`hcp_id`),
  ADD KEY `healthcare_facility_id` (`healthcare_facility_id`);

--
-- Indexes for table `hcp_language`
--
ALTER TABLE `hcp_language`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_id` (`hcp_id`),
  ADD KEY `language_id` (`language_id`);

--
-- Indexes for table `hcp_license_dea`
--
ALTER TABLE `hcp_license_dea`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_id` (`hcp_id`);

--
-- Indexes for table `hcp_license_state`
--
ALTER TABLE `hcp_license_state`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_id` (`hcp_id`);

--
-- Indexes for table `hcp_patients`
--
ALTER TABLE `hcp_patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_patients_hcp` (`hcp_id`),
  ADD KEY `hcp_patients_patient` (`patient_id`);

--
-- Indexes for table `hcp_patients_drop_reasons`
--
ALTER TABLE `hcp_patients_drop_reasons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_id` (`hcp_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `hcp_preferred_medicines`
--
ALTER TABLE `hcp_preferred_medicines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_preferred_medicines_hcp` (`hcp_id`);

--
-- Indexes for table `hcp_specialties`
--
ALTER TABLE `hcp_specialties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hcp_id` (`hcp_id`),
  ADD KEY `specialty_id` (`specialty_id`);

--
-- Indexes for table `hcp_types`
--
ALTER TABLE `hcp_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_public` (`is_public`);

--
-- Indexes for table `healthcare_facilities`
--
ALTER TABLE `healthcare_facilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dates` (`created_at`,`updated_at`),
  ADD KEY `locations` (`city`(191),`state`(191),`zip`),
  ADD KEY `deleted_at` (`deleted_at`),
  ADD KEY `is_public` (`is_public`);

--
-- Indexes for table `medical_histories`
--
ALTER TABLE `medical_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `medical_histories_files`
--
ALTER TABLE `medical_histories_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_medical_histories_files_medical_history_id_and_file_id` (`medical_history_id`,`file_id`);

--
-- Indexes for table `on_call`
--
ALTER TABLE `on_call`
  ADD PRIMARY KEY (`id`),
  ADD KEY `on_call_hcp` (`hcp_id`),
  ADD KEY `on_call_healthcare_facility` (`healthcare_facility_id`),
  ADD KEY `day` (`day`),
  ADD KEY `date_string` (`date_string`,`is_date`);

--
-- Indexes for table `on_call_slots`
--
ALTER TABLE `on_call_slots`
  ADD PRIMARY KEY (`id`),
  ADD KEY `on_call_slot_on_call` (`on_call_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stripe_customer_id` (`stripe_customer_id`),
  ADD KEY `type` (`type`),
  ADD KEY `eazyscript_id` (`eazyscript_id`),
  ADD KEY `sync_with_eazyscripts` (`sync_with_eazyscripts`),
  ADD KEY `deleted_at` (`deleted_at`),
  ADD KEY `signed_terms_id` (`signed_terms_id`),
  ADD KEY `firebase_notification_key` (`device_group`);

--
-- Indexes for table `patient_envelopes`
--
ALTER TABLE `patient_envelopes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_envelopes_patient` (`patient_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `docusign_template` (`docusign_template`);

--
-- Indexes for table `patient_notes`
--
ALTER TABLE `patient_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_notes_hcp` (`hcp_id`),
  ADD KEY `patient_notes_patient` (`patient_id`);

--
-- Indexes for table `patient_uploads`
--
ALTER TABLE `patient_uploads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category`),
  ADD KEY `patient_uploads_patient` (`patient_id`),
  ADD KEY `patient_uploads_file` (`file_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`(191)),
  ADD KEY `currency` (`currency`),
  ADD KEY `interval_type` (`interval_type`),
  ADD KEY `visible` (`visible`);

--
-- Indexes for table `policies`
--
ALTER TABLE `policies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `policies_files`
--
ALTER TABLE `policies_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_policies_files_policy_id_and_file_id` (`policy_id`,`file_id`);

--
-- Indexes for table `providers`
--
ALTER TABLE `providers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `value` (`value`(191));

--
-- Indexes for table `schema_migrations`
--
ALTER TABLE `schema_migrations`
  ADD UNIQUE KEY `idx_schema_migrations_version` (`version`);

--
-- Indexes for table `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stripe_id` (`stripe_id`(191),`stripe_customer_id`(191),`stripe_status`(191),`canceled_at`),
  ADD KEY `idx_subscriptions_patient_id` (`patient_id`),
  ADD KEY `expires_at` (`expires_at`),
  ADD KEY `subscription_parent_subscription` (`parent_subscription_id`);

--
-- Indexes for table `subscription_invites`
--
ALTER TABLE `subscription_invites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subscription_invites_subscription` (`subscription_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `terms`
--
ALTER TABLE `terms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `state` (`state`,`published_at`),
  ADD KEY `deleted_at` (`deleted_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `video_sessions`
--
ALTER TABLE `video_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `archive_id` (`archive_id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `video_session_tags`
--
ALTER TABLE `video_session_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `timestamp` (`timestamp`,`video_session_id`,`hcp_id`),
  ADD KEY `video_session_video_session_tag` (`video_session_id`),
  ADD KEY `hcp_video_session_tag` (`hcp_id`),
  ADD KEY `notes` (`notes`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `video_session_users`
--
ALTER TABLE `video_session_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state` (`state`),
  ADD KEY `is_caller` (`is_caller`),
  ADD KEY `uid` (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointment_members`
--
ALTER TABLE `appointment_members`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointment_reservations`
--
ALTER TABLE `appointment_reservations`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointment_reservation_members`
--
ALTER TABLE `appointment_reservation_members`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `associative_languages`
--
ALTER TABLE `associative_languages`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blood_pressure_alerts`
--
ALTER TABLE `blood_pressure_alerts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blood_pressure_entries`
--
ALTER TABLE `blood_pressure_entries`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blood_pressure_entry_queue`
--
ALTER TABLE `blood_pressure_entry_queue`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blood_pressure_thresholds`
--
ALTER TABLE `blood_pressure_thresholds`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_message_read_states`
--
ALTER TABLE `chat_message_read_states`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_rooms`
--
ALTER TABLE `chat_rooms`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_room_users`
--
ALTER TABLE `chat_room_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `device_tokens`
--
ALTER TABLE `device_tokens`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `docusign_templates`
--
ALTER TABLE `docusign_templates`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp`
--
ALTER TABLE `hcp`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_availability`
--
ALTER TABLE `hcp_availability`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_availability_slots`
--
ALTER TABLE `hcp_availability_slots`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `hcp_healthcare_facilities`
--
ALTER TABLE `hcp_healthcare_facilities`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_language`
--
ALTER TABLE `hcp_language`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_license_dea`
--
ALTER TABLE `hcp_license_dea`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_license_state`
--
ALTER TABLE `hcp_license_state`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_patients`
--
ALTER TABLE `hcp_patients`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_patients_drop_reasons`
--
ALTER TABLE `hcp_patients_drop_reasons`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_preferred_medicines`
--
ALTER TABLE `hcp_preferred_medicines`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_specialties`
--
ALTER TABLE `hcp_specialties`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hcp_types`
--
ALTER TABLE `hcp_types`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `healthcare_facilities`
--
ALTER TABLE `healthcare_facilities`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medical_histories`
--
ALTER TABLE `medical_histories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medical_histories_files`
--
ALTER TABLE `medical_histories_files`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `on_call`
--
ALTER TABLE `on_call`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `on_call_slots`
--
ALTER TABLE `on_call_slots`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_envelopes`
--
ALTER TABLE `patient_envelopes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_notes`
--
ALTER TABLE `patient_notes`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient_uploads`
--
ALTER TABLE `patient_uploads`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `policies`
--
ALTER TABLE `policies`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `policies_files`
--
ALTER TABLE `policies_files`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `providers`
--
ALTER TABLE `providers`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_invites`
--
ALTER TABLE `subscription_invites`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `terms`
--
ALTER TABLE `terms`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_sessions`
--
ALTER TABLE `video_sessions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_session_tags`
--
ALTER TABLE `video_session_tags`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_session_users`
--
ALTER TABLE `video_session_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment_members`
--
ALTER TABLE `appointment_members`
  ADD CONSTRAINT `appointment_members_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `appointment_reservation_members`
--
ALTER TABLE `appointment_reservation_members`
  ADD CONSTRAINT `appointment_reservation_members_ibfk_1` FOREIGN KEY (`appointment_reservation_id`) REFERENCES `appointment_reservations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blood_pressure_alerts`
--
ALTER TABLE `blood_pressure_alerts`
  ADD CONSTRAINT `blood_pressure_alerts_blood_pressure_entry` FOREIGN KEY (`blood_pressure_entry_id`) REFERENCES `blood_pressure_entries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blood_pressure_alerts_blood_pressure_threshold` FOREIGN KEY (`blood_pressure_threshold_id`) REFERENCES `blood_pressure_thresholds` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blood_pressure_alerts_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blood_pressure_entries`
--
ALTER TABLE `blood_pressure_entries`
  ADD CONSTRAINT `blood_pressure_entries_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blood_pressure_thresholds`
--
ALTER TABLE `blood_pressure_thresholds`
  ADD CONSTRAINT `blood_pressure_thresholds_hcp` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blood_pressure_thresholds_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_message_read_states`
--
ALTER TABLE `chat_message_read_states`
  ADD CONSTRAINT `chat_message_chat_message_read_state` FOREIGN KEY (`chat_message_id`) REFERENCES `chat_messages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_room_users`
--
ALTER TABLE `chat_room_users`
  ADD CONSTRAINT `chat_room_user_chat_room` FOREIGN KEY (`chat_room_id`) REFERENCES `chat_rooms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp`
--
ALTER TABLE `hcp`
  ADD CONSTRAINT `hcp_hcp_type` FOREIGN KEY (`hcp_type_id`) REFERENCES `hcp_types` (`id`),
  ADD CONSTRAINT `hcp_healthcare_facility` FOREIGN KEY (`healthcare_facility_id`) REFERENCES `healthcare_facilities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `hcp_availability`
--
ALTER TABLE `hcp_availability`
  ADD CONSTRAINT `hcp_availability_hcp` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_availability_slots`
--
ALTER TABLE `hcp_availability_slots`
  ADD CONSTRAINT `hcp_availability_slot_hcp_availability` FOREIGN KEY (`hcp_availability_id`) REFERENCES `hcp_availability` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_healthcare_facilities`
--
ALTER TABLE `hcp_healthcare_facilities`
  ADD CONSTRAINT `hcp_facilities_ibfk_1` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hcp_facilities_ibfk_2` FOREIGN KEY (`healthcare_facility_id`) REFERENCES `healthcare_facilities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_language`
--
ALTER TABLE `hcp_language`
  ADD CONSTRAINT `hcp_language_ibfk_1` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hcp_language_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `associative_languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_license_dea`
--
ALTER TABLE `hcp_license_dea`
  ADD CONSTRAINT `hcp_license_dea_ibfk_1` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_license_state`
--
ALTER TABLE `hcp_license_state`
  ADD CONSTRAINT `hcp_license_state_ibfk_1` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_patients`
--
ALTER TABLE `hcp_patients`
  ADD CONSTRAINT `hcp_patients_hcp` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hcp_patients_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_preferred_medicines`
--
ALTER TABLE `hcp_preferred_medicines`
  ADD CONSTRAINT `hcp_preferred_medicines_hcp` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `hcp_specialties`
--
ALTER TABLE `hcp_specialties`
  ADD CONSTRAINT `hcp_specialties_ibfk_1` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `hcp_specialties_ibfk_2` FOREIGN KEY (`specialty_id`) REFERENCES `specialties` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medical_histories`
--
ALTER TABLE `medical_histories`
  ADD CONSTRAINT `medical_histories_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `on_call`
--
ALTER TABLE `on_call`
  ADD CONSTRAINT `on_call_hcp` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `on_call_healthcare_facility` FOREIGN KEY (`healthcare_facility_id`) REFERENCES `healthcare_facilities` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `on_call_slots`
--
ALTER TABLE `on_call_slots`
  ADD CONSTRAINT `on_call_slot_on_call` FOREIGN KEY (`on_call_id`) REFERENCES `on_call` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `patient_envelopes`
--
ALTER TABLE `patient_envelopes`
  ADD CONSTRAINT `patient_envelopes_docusign_template` FOREIGN KEY (`docusign_template`) REFERENCES `docusign_templates` (`uid`) ON DELETE CASCADE,
  ADD CONSTRAINT `patient_envelopes_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `patient_notes`
--
ALTER TABLE `patient_notes`
  ADD CONSTRAINT `patient_notes_hcp` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patient_notes_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `patient_uploads`
--
ALTER TABLE `patient_uploads`
  ADD CONSTRAINT `patient_uploads_file` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `patient_uploads_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `policies`
--
ALTER TABLE `policies`
  ADD CONSTRAINT `policies_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subscription_invites`
--
ALTER TABLE `subscription_invites`
  ADD CONSTRAINT `subscription_invites_subscription` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `video_session_tags`
--
ALTER TABLE `video_session_tags`
  ADD CONSTRAINT `hcp_video_session_tag` FOREIGN KEY (`hcp_id`) REFERENCES `hcp` (`id`),
  ADD CONSTRAINT `video_session_video_session_tag` FOREIGN KEY (`video_session_id`) REFERENCES `video_sessions` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
