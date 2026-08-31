-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 10 jan. 2026 à 12:38
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `fsd_batiment`
--

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('fsd-batiment-cache-admin@fsd-baiment.fr|127.0.0.1', 'i:1;', 1767967133),
('fsd-batiment-cache-admin@fsd-baiment.fr|127.0.0.1:timer', 'i:1767967133;', 1767967133),
('fsd-batiment-cache-contact@fsd-baiment.fr|127.0.0.1', 'i:1;', 1767967149),
('fsd-batiment-cache-contact@fsd-baiment.fr|127.0.0.1:timer', 'i:1767967149;', 1767967149);

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `home_page_section`
--

CREATE TABLE `home_page_section` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section_key` varchar(255) NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`content`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `home_page_section`
--

INSERT INTO `home_page_section` (`id`, `section_key`, `content`, `created_at`, `updated_at`) VALUES
(1, 'hero', '\"{\\\"slides\\\":[{\\\"title\\\":\\\"Your Perfect Escape\\\",\\\"subtitle\\\":\\\"From luxury rooms to unforgettable experiences, we have it all.\\\",\\\"button_text\\\":\\\"Check Offers\\\",\\\"background_image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/Hq5a5J9XI5dI93n3c0Ti4Kk7FvFt4khh6ZgTRIh4.jpg\\\"}]}\"', NULL, '2026-01-09 13:54:46'),
(2, 'services', '\"{\\\"title\\\":\\\"ce que nous faisons\\\",\\\"subtitle\\\":\\\"nos services\\\",\\\"description\\\":\\\"D\\u00e9couvrez comment nous pouvons vous accompagner efficacement.\\\",\\\"services_ids\\\":[\\\"5\\\",\\\"6\\\",\\\"7\\\",\\\"8\\\",\\\"9\\\",\\\"10\\\"]}\"', NULL, '2026-01-09 13:36:55'),
(3, 'whyChooseUs', '\"{\\\"image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/kHSI1viHxhqJDI3y6n4isalCuB1htcflfq09uJKT.webp\\\",\\\"title\\\":\\\"Notre engagement d\\u2019excellence\\\",\\\"description\\\":\\\"null\\\",\\\"items\\\":[{\\\"text\\\":\\\"Expertise ma\\u00eetris\\u00e9e\\\"},{\\\"text\\\":\\\"Qualit\\u00e9 durable\\\"},{\\\"text\\\":\\\"Respect des d\\u00e9lais\\\"},{\\\"text\\\":\\\"S\\u00e9curit\\u00e9 et conformit\\u00e9\\\"}]}\"', NULL, '2025-11-20 13:53:03'),
(5, 'testimonials', '\"{\\\"title\\\":\\\"Ce que disent nos clients\\\",\\\"items\\\":[{\\\"name\\\":\\\"Nadia L.\\\",\\\"role\\\":\\\"Entrepreneure\\\",\\\"message\\\":\\\"Service rapide et professionnel. Je recommande vivement pour tout besoin administratif.\\\"},{\\\"name\\\":\\\"Marc D.\\\",\\\"role\\\":\\\"Consultant\\\",\\\"message\\\":\\\"Une \\u00e9quipe \\u00e0 l\\u2019\\u00e9coute et tr\\u00e8s r\\u00e9active. Mon entreprise a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e sans souci.\\\"},{\\\"name\\\":\\\"Yacine T.\\\",\\\"role\\\":\\\"Ind\\u00e9pendant\\\",\\\"message\\\":\\\"Professionnalisme, clart\\u00e9 et efficacit\\u00e9. Tr\\u00e8s satisfait de l\\u2019accompagnement re\\u00e7u.\\\"},{\\\"name\\\":\\\"Mahmoud B\\\",\\\"role\\\":\\\"G\\u00e9rant\\\",\\\"message\\\":\\\"Professionnalisme, clart\\u00e9 et efficacit\\u00e9. Tr\\u00e8s satisfait de l\\u2019accompagnement re\\u00e7u.\\\"}]}\"', NULL, '2025-08-07 04:03:28'),
(6, 'footer', '\"{\\\"entreprise\\\":\\\"ADMINISTRA\\\",\\\"email\\\":\\\"contact@administra.fr\\\",\\\"phone\\\":\\\"+33 6 12 34 56 79\\\",\\\"adress\\\":\\\"123 rue Exemple, 75000 Paris\\\",\\\"title\\\":\\\"Nos coordonn\\u00e9es\\\",\\\"description\\\":\\\"Nous vous r\\u00e9pondrons dans les meilleurs d\\u00e9lais.\\\",\\\"socials\\\":{\\\"facebook\\\":\\\"https:\\/\\/facebook.com\\/administra\\\",\\\"linkedin\\\":\\\"https:\\/\\/linkedin.com\\/company\\/administra\\\",\\\"instagram\\\":\\\"https:\\/\\/instagram.com\\/administra\\\"}}\"', NULL, '2025-08-06 15:47:58'),
(7, 'aboutus', '\"{\\\"title\\\":\\\"\\u00c0 propos de nous\\\",\\\"subtitle\\\":\\\"Nous sommes une entreprise sp\\u00e9cialis\\u00e9e dans la ma\\u00e7onnerie et la construction durable, au service de nos clients depuis plus de 15 ans.\\\",\\\"long_description\\\":\\\"<p><p><\\/p><p>\\u00a0Notre entreprise sp\\u00e9cialis\\u00e9e dans la ma\\u00e7onnerie et la construction durable accompagne ses clients avec passion et expertise. Nous allions savoir-faire traditionnel et innovation technique pour garantir la qualit\\u00e9, la fiabilit\\u00e9 et la p\\u00e9rennit\\u00e9 de chaque projet.<\\/p><p><\\/p><\\/p><p><p><\\/p><p>\\u00a0Notre \\u00e9quipe d\\u2019artisans qualifi\\u00e9s et d\\u2019ing\\u00e9nieurs exp\\u00e9riment\\u00e9s offre un accompagnement personnalis\\u00e9, adapt\\u00e9 \\u00e0 vos besoins, de la conception \\u00e0 la livraison finale.<\\/p><p><\\/p><\\/p><p><br><\\/p>\\\"}\"', NULL, '2025-08-21 15:20:06'),
(8, 'ParallaxStats', '\"{\\\"title\\\":\\\"Welcome to LuxeVista Hotel\\\",\\\"description\\\":\\\"At LuxeVista Hotel, we offer an unparalleled experience of luxury and comfort. Nestled in the heart of the city, our elegantly designed rooms and suites, world-class dining, and exceptional services ensure that every stay is unforgettable. Whether you are traveling for business or leisure, LuxeVista Hotel combines sophistication, serenity, and personalized attention to create a perfect getaway.\\\",\\\"badge\\\":\\\"+500 chantiers livr\\u00e9s\\\",\\\"image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/VD06GRJGrgMuAh1EFQVPXzqc5I5qCZpD3K3onUsg.png\\\",\\\"stats\\\":[{\\\"value\\\":\\\"+15\\\",\\\"label\\\":\\\"Ann\\u00e9es d\\u2019exp\\u00e9rience\\\"},{\\\"value\\\":\\\"98%\\\",\\\"label\\\":\\\"Clients satisfaits\\\"},{\\\"value\\\":\\\"24\\/7\\\",\\\"label\\\":\\\"Assistance chantier\\\"}]}\"', NULL, '2026-01-09 13:51:32'),
(9, 'projects', '\"{\\\"title\\\":\\\"Projets accomplis avec succ\\u00e8s\\\",\\\"subtitle\\\":\\\"Expertise\\\",\\\"description\\\":\\\"Plongez dans notre univers cr\\u00e9atif \\u00e0 travers une s\\u00e9lection de projets r\\u00e9cents. Chaque r\\u00e9alisation t\\u00e9moigne de notre expertise et de notre passion pour le design moderne.\\\\r\\\\n\\\\r\\\\nFaites d\\u00e9filer pour explorer nos r\\u00e9alisations les plus marquantes.\\\",\\\"project_ids\\\":[\\\"15\\\",\\\"14\\\",\\\"6\\\",\\\"5\\\",\\\"2\\\",\\\"3\\\"]}\"', NULL, '2025-10-16 18:28:06');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_07_30_225132_create_home_page_section', 2),
(5, '2025_08_18_234634_create_settings_table', 3),
(7, '2025_08_19_210648_create_projects_table', 3),
(8, '2025_08_19_210837_create_project_images_table', 3),
(9, '2025_08_19_210608_create_services_table', 1),
(10, '2025_09_15_121743_create-pages-table', 4),
(11, '2025_09_15_124809_alter_projects_content_column', 4),
(12, '2025_09_23_150016_alter_table_service', 1),
(13, '2025_09_23_150106_alter_table_project', 1),
(14, '2025_09_23_150233_alter_table_page', 5),
(15, '2025_12_31_231639_create_reservations_table', 6);

-- --------------------------------------------------------

--
-- Structure de la table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `pages`
--

INSERT INTO `pages` (`id`, `title`, `content`, `slug`, `created_at`, `updated_at`, `meta_title`, `meta_description`, `meta_keywords`) VALUES
(1, 'Mentions légales', '<p><br></p><p><br></p><p><br></p><p><strong>Éditeur du site :</strong></p><p><br></p><p><br></p><p>Administra</p><p>N° SIREN : 983 535 3861</p><p>Email : <a href=\"mailto:contact@administra.site\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 102, 204);\">contact@administra.site</a></p><p>Whatsapp : +33 7 82 70 14 57</p><p><br></p><p><br></p><p><br></p><p><strong>Hébergement :</strong></p><p><br></p><p><br></p><p>Le site Administra est hébergé par Hostinger International Ltd.</p><p>Adresse : 61 Lordou Vironos Street, 6023 Larnaca, Chypre</p><p>Site web : <a href=\"https://www.hostinger.fr/\" rel=\"noopener noreferrer\" target=\"_blank\">https://www.hostinger.fr</a></p><p>Email : support@hostinger.com</p><p><br></p><p><br></p><p><br></p><p><strong>Propriété intellectuelle :</strong></p><p><br></p><p><br></p><p>Tout le contenu présent sur ce site (textes, images, vidéos, logos) est la propriété exclusive d\'Administra ou de ses partenaires. Toute reproduction totale ou partielle est interdite sans autorisation préalable.</p><p><br></p><p><br></p><p><br></p><p><strong>Protection des données personnelles :</strong></p><p><br></p><p><br></p><p>Les informations collectées via le site sont utilisées uniquement pour répondre aux demandes des utilisateurs. Conformément au RGPD, vous disposez d’un droit d’accès, de modification et de suppression de vos données en contactant <a href=\"mailto:contact@administra.site\" rel=\"noopener noreferrer\" target=\"_blank\">contact@administra.site</a>.</p><p><br></p><p><br></p><p><br></p><p><strong>Cookies :</strong></p><p><br></p><p><br></p><p>Le site peut utiliser des cookies pour améliorer l’expérience utilisateur. Vous pouvez gérer les cookies via les paramètres de votre navigateur.</p><p><br></p><p><br></p><p><br></p><p><strong>Responsabilité :</strong></p><p><br></p><p><br></p><p>Administra ne peut être tenu responsable des dommages directs ou indirects liés à l’utilisation de ce site.</p><p><br></p><p><br></p>', 'mentions-l-gales', '2025-10-01 10:14:38', '2025-11-10 18:20:32', 'Mentions légales', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `projects`
--

INSERT INTO `projects` (`id`, `title`, `slug`, `description`, `content`, `location`, `date`, `created_at`, `updated_at`, `meta_title`, `meta_description`, `meta_keywords`) VALUES
(2, 'Construction Villa Moderne', 'construction-villa-moderne', 'Villa haut standing avec design contemporain et finitions de luxe.', NULL, 'Paris, France', '2025-04-10', '2025-08-22 08:44:03', '2025-10-01 09:33:25', 'Construction Villa Moderne', NULL, NULL),
(3, 'Immeuble Résidentiel', 'immeuble-residentiel', 'Un projet immobilier de 20 appartements avec parking et espaces verts.', NULL, 'Lyon, France', '2025-01-10', '2025-08-22 08:44:51', '2025-10-01 09:33:05', NULL, NULL, NULL),
(5, 'Rénovation Bureau', 'renovation-bureau', 'Transformation d\'un ancien entrepôt en bureaux modernes et lumineux.', '<h2>Rénovation d’un ancien entrepôt en bureaux modernes</h2><p>\r\n\r\n</p><p>\r\nÀ Marseille, nous avons transformé un ancien entrepôt de 1 200 m² en un espace de bureaux lumineux et fonctionnel.\r\nL’objectif était de créer un lieu de travail moderne, confortable et économe en énergie.\r\n</p><p>\r\n\r\n</p><p>\r\nLe projet a inclus l’isolation thermique, la pose de grandes verrières pour maximiser la lumière naturelle, \r\nla rénovation complète des réseaux (électricité, plomberie, ventilation) ainsi que l’aménagement d’espaces collaboratifs et salles de réunion.\r\n</p><p>\r\n\r\n</p><p>\r\nRésultat : des bureaux design, modulables et adaptés aux besoins d’une équipe de 120 personnes, livrés dans le respect des délais.\r\n</p>', 'Marseille, France', '2025-05-07', '2025-08-22 10:41:35', '2025-10-01 09:32:49', NULL, NULL, NULL),
(6, 'Ravalement de Façade Immeuble Haussmannien', 'ravalement-de-facade-immeuble-haussmannien', 'Ce projet concernait un immeuble du XIXe siècle situé au cœur de Paris.', '<p>&lt;h2&gt;Ravalement et rénovation d’un immeuble haussmannien&lt;/h2&gt;</p><p>&lt;p&gt;</p><p>Ce projet concernait un immeuble du XIXe siècle situé au cœur de Paris.&nbsp;</p><p>Nous avons procédé au &lt;strong&gt;nettoyage haute pression&lt;/strong&gt;, à la réparation des fissures,&nbsp;</p><p>et à l’application d’un enduit respirant respectant l’architecture d’origine.</p><p>&lt;/p&gt;</p><p>&lt;p&gt;</p><p>Les balcons en fer forgé ont été restaurés et repeints, et les moulures décoratives en pierre ont été rénovées avec soin.&nbsp;</p><p>Cette intervention a redonné à la façade tout son charme d’époque, tout en respectant les normes de sécurité et d’urbanisme.</p><p>&lt;/p&gt;</p><p><br></p>', 'Paris, France', '2025-08-01', '2025-08-26 16:25:38', '2025-10-01 09:32:30', 'Ravalement de Façade Immeuble Haussmannien', 'Ravalement de Façade Immeuble', NULL),
(14, 'Installation Salle de Bain', 'installation-salle-de-bain', 'Installation complète d’une salle de bain moderne avec douche à l’italienne, meubles suspendus et carrelage mural design.', '<p>&lt;h2&gt;Installation complète d’une salle de bain moderne&lt;/h2&gt;</p><p>&lt;p&gt;</p><p>Nous avons transformé une ancienne salle de bain en un espace moderne et fonctionnel de 12 m².&nbsp;</p><p>Le projet a inclus la &lt;strong&gt;pose d’une douche à l’italienne&lt;/strong&gt; avec paroi en verre,&nbsp;</p><p>un &lt;strong&gt;meuble double vasque suspendu&lt;/strong&gt;, ainsi que l’installation d’un WC encastré.</p><p>&lt;/p&gt;</p><p>&lt;p&gt;</p><p>Un carrelage mural design effet marbre a été choisi pour donner une touche élégante,&nbsp;</p><p>accompagné d’un éclairage LED intégré pour créer une ambiance chaleureuse.&nbsp;</p><p>Toute la plomberie a été refaite aux normes, assurant une parfaite étanchéité et durabilité.</p><p>&lt;/p&gt;</p><p><br></p>', 'Boulogne-Billancourt, France', '2025-12-03', '2025-09-29 12:48:01', '2025-09-29 12:48:01', NULL, NULL, NULL),
(15, 'Terrassement & VRD – Terrain constructible', 'terrassement-vrd-terrain-constructible', 'Terrassement complet et viabilisation d’un terrain de 800 m² destiné à accueillir une construction résidentielle.', '<p>&lt;h2&gt;Terrassement et viabilisation d’un terrain constructible&lt;/h2&gt;</p><p>&lt;p&gt;</p><p>Notre équipe est intervenue pour préparer un terrain de 800 m² en vue de la construction d’une maison individuelle.&nbsp;</p><p>Le chantier a débuté par le &lt;strong&gt;décapage de la terre végétale&lt;/strong&gt; et le &lt;strong&gt;nivellement du terrain&lt;/strong&gt;.</p><p>&lt;/p&gt;</p><p>&lt;p&gt;</p><p>Nous avons réalisé les &lt;strong&gt;tranchées&lt;/strong&gt; pour l’alimentation en eau, électricité et assainissement (VRD).&nbsp;</p><p>Une plateforme stabilisée a été mise en place pour accueillir les futures fondations.&nbsp;</p><p>Le terrain est désormais prêt à recevoir la construction dans les meilleures conditions.</p><p>&lt;/p&gt;</p><p><br></p>', 'Saint-Denis, France', '2024-06-29', '2025-09-29 12:49:29', '2025-10-01 09:29:20', 'Terrassement & VRD – Terrain constructible', 'Terrassement complet et viabilisation d’un terrain de 800 m² destiné à accueillir une construction résidentielle.', 'Terrassement');

-- --------------------------------------------------------

--
-- Structure de la table `project_images`
--

CREATE TABLE `project_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `project_images`
--

INSERT INTO `project_images` (`id`, `project_id`, `path`, `created_at`, `updated_at`) VALUES
(3, 5, 'projects/vNWs8m2HLetXohKIEATRL2j6U6B5Wlx0tzF60KdA.avif', '2025-08-22 10:41:36', '2025-08-22 10:41:36'),
(11, 5, 'projects/hKmdYzBnKPoAqiTI3h2CYpPiYV9ftQS1oSGHl7Jq.jpg', '2025-09-28 10:36:22', '2025-09-28 10:36:22'),
(12, 5, 'projects/k5jMpctocOvTumxgX0MALP2etTfk4DkTpHW0Yq4h.jpg', '2025-09-28 14:24:48', '2025-09-28 14:24:48'),
(13, 5, 'projects/pshXE7SPC9On7DjWorgt7nthFxCDhXj53RnM858y.jpg', '2025-09-28 14:24:49', '2025-09-28 14:24:49'),
(15, 14, 'projects/g2EXqObJpskpLmMUYfdXVUkTNh06BAElpNBhDdU3.jpg', '2025-09-29 12:48:01', '2025-09-29 12:48:01'),
(16, 15, 'projects/vdH8XQTUitg02HBrmjA4CPToKJIN6qzfQfsClrmY.jpg', '2025-10-03 22:24:06', '2025-10-03 22:24:06'),
(17, 14, 'projects/pFEBktFlFYMllT05KMV7HY2yukmAaXmPMfEs8SxD.jpg', '2025-10-03 22:25:49', '2025-10-03 22:25:49'),
(18, 2, 'projects/EqYVHIEURs9kTOfJBX0q2KkgiJ9oaArThWuWNyIq.jpg', '2025-10-03 22:28:17', '2025-10-03 22:28:17'),
(19, 2, 'projects/bk5vC0I6X6UlME3o3HCis1j1sN2yLWQbGz9f82Dc.jpg', '2025-10-03 22:29:12', '2025-10-03 22:29:12'),
(22, 6, 'projects/Ur6qIlMq1DEo2WzPG5gGGFNcq3ygrpvu22AsPsiQ.jpg', '2025-10-03 22:33:15', '2025-10-03 22:33:15'),
(23, 6, 'projects/EuBycLU2ucIsM3AlXC5H6S33HGIjsoeETW1eZ03f.jpg', '2025-10-03 22:33:15', '2025-10-03 22:33:15');

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

CREATE TABLE `reservations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `check_in` datetime DEFAULT current_timestamp(),
  `check_out` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`id`, `user_id`, `service_id`, `name`, `email`, `phone`, `check_in`, `check_out`, `status`, `note`, `created_at`, `updated_at`) VALUES
(1, 2, 5, 'Teyeb huda', 'shdhsb@sdj.sdsdsd', '0766212207', '2026-01-08 16:14:29', '2026-01-08 16:15:05', 'pending', 'sdjsdj sbdj sbdb dsjdjs sdjjsjdhsdjsjd', '2025-12-31 23:29:08', '2025-12-31 23:29:08'),
(2, 2, 5, 'qsqnd', 'kjjd@jbdd.sdsd', 'kqndjn', '2026-01-08 16:14:29', '2026-01-08 16:15:05', 'cancelled', 'kjndjb sbdhsbd sbd', '2025-12-31 23:31:07', '2025-12-31 23:32:11'),
(3, NULL, 7, 'Mahmoud BOUSSAA', 'mahmoud_boussaa@hotmail.fr', '0753591878', '2026-01-23 00:00:00', '2026-01-31 00:00:00', 'pending', 'jnjd jsd', '2026-01-08 14:37:54', '2026-01-08 14:37:54'),
(4, NULL, 6, 'Mahmoud BOUSSAA', 'mahmoud_boussaa@hotmail.fr', '0753591878', '2026-01-09 00:00:00', '2026-01-15 00:00:00', 'pending', 'k,k knkn qdddddd ddqqsq', '2026-01-08 14:41:33', '2026-01-08 14:41:33');

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `long_description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `background_image` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `title`, `slug`, `description`, `long_description`, `icon`, `background_image`, `created_at`, `updated_at`, `meta_title`, `meta_description`, `meta_keywords`) VALUES
(5, 'Deluxe Room', 'deluxe-room', '$250.00 USD / Night', '<p><br></p><p><span style=\"color: rgb(115, 115, 115);\">Experience the epitome of comfort and sophistication in our Deluxe Room at </span>LuxeVista <span style=\"color: rgb(115, 115, 115);\">. Designed with your relaxation in mind, these stylishly appointed rooms offer a serene retreat from the hustle and bustle of everyday life.</span></p><p><br></p><p><strong>Modern Elegance</strong>:</p><p>Step into a world of modern elegance as you enter our Deluxe Room, where contemporary design meets timeless charm. From sleek furnishings to tasteful décor accents, every detail has been carefully curated to create a space that exudes style and sophistication. </p><p><br></p><p><strong>Spacious Comfort</strong>:</p><p>Relax and unwind in the spacious comfort of our Deluxe Room, featuring ample living space and plush bedding for a restful night\'s sleep. Whether you\'re traveling for business or leisure, our rooms provide the perfect sanctuary to recharge and rejuvenate. </p><p><br></p><p><strong>Luxurious Amenities</strong>:</p><p>Indulge in luxury with a range of premium amenities, including a comfortable king-sized bed adorned with high-quality linens, a marble bathroom with deluxe toiletries, and a flat-screen TV for entertainment.</p><p><br></p><p><strong>Unwind in Style</strong>:</p><p>After a long day of exploring the city or attending meetings, retreat to your Deluxe Room and unwind in style. Sink into the cozy armchair with a good book, or catch up on your favorite shows on the large-screen TV – the choice is yours. </p><p><br></p><p><strong>Personalized Service</strong>:</p><p>Enjoy personalized service tailored to your every need, with our dedicated staff on hand to ensure a seamless and memorable stay. Whether you require assistance with dinner reservations or recommendations for local attractions, we\'re here to help make your stay truly unforgettable. Your Oasis Awaits: Whether you\'re traveling for business or leisure, our Deluxe Room at LuxeVista offers the perfect blend of comfort, style, and convenience. Experience a world of relaxation and rejuvenation, where every moment is designed to exceed your expectations.</p><p><br></p><p><br></p><p><br></p><p><br></p>', NULL, '/storage/uploads/services/51oAkGn1nGmlpzbCeATQLPFRBYKKvTOedlnIBenf.png', '2025-09-26 19:02:41', '2026-01-09 13:43:37', 'Deluxe Suite – Luxury Hotel Stay', 'Book our Deluxe Suite with city views and premium amenities for an unforgettable stay.', 'deluxe suite, luxury hotel room, city view suite, king-size bed'),
(6, 'Premier Deluxe', 'premier-deluxe', '$350.00 USD / Night', '<p><span style=\"color: rgb(115, 115, 115);\">Step into luxury and sophistication with our Premier Deluxe rooms at </span>LuxeVista <span style=\"color: rgb(115, 115, 115);\">. Designed for discerning travelers seeking an elevated stay experience, these stylishly appointed rooms offer a perfect blend of opulence and comfort, ensuring a memorable retreat from the moment you arrive. </span></p><p> </p><p><strong>Elegant Design</strong>: </p><p>Indulge in the refined elegance of our Premier Deluxe rooms, where modern design meets timeless sophistication. From sleek furnishings to luxurious fabrics and tasteful décor, every detail has been carefully curated to create a space that exudes luxury and style. </p><p><br></p><p><strong>Spacious Comfort</strong>: </p><p>Relax and unwind in the spacious comfort of our Premier Deluxe rooms, featuring ample living space and plush bedding for a restful night\'s sleep. Whether you\'re traveling for business or leisure, our rooms provide the perfect sanctuary to recharge and rejuvenate. </p><p><br></p><p><strong>Luxurious Amenities</strong>: </p><p>Experience true indulgence with a range of premium amenities, including a lavish king-sized bed adorned with high-thread-count linens, a marble bathroom with deluxe toiletries, and a flat-screen TV for entertainment.</p><p><br></p><p><strong>Breathtaking Views</strong>:</p><p>Wake up to stunning views of the city skyline or picturesque landscapes from the large windows of our Premier Deluxe rooms, offering a captivating backdrop to your stay. Personalized Service: Enjoy personalized service tailored to your every need, with our dedicated staff on hand to ensure a seamless and memorable stay. Whether you require assistance with dinner reservations or recommendations for local attractions, we\'re here to help make your stay truly unforgettable.</p><p><br></p><p><strong>Unmatched Convenience</strong>: </p><p>Stay connected and productive with complimentary high-speed Wi-Fi and a well-appointed work area, allowing you to catch up on work or plan your next adventure with ease. Your Premier Escape Awaits: Whether you\'re traveling for business or leisure, our Premier Deluxe rooms at LuxeVista offer the perfect blend of luxury, comfort, and convenience. Experience a world of unparalleled elegance and sophistication, where every moment is designed to exceed your expectations.</p>', NULL, '/storage/uploads/services/lFTdZjhyGqQB7Z0eHmsKlCxTGbqePKuUuXB4Abtr.png', '2025-09-26 19:02:41', '2026-01-09 13:43:37', 'Single Room – Ideal for Solo Travelers', 'Enjoy a comfortable and modern Single Room perfect for your solo travels.', 'single room, solo traveler hotel, private room, comfortable hotel stay'),
(7, 'Presidential Suite', 'presidential-suite', '$900.00 USD / Night', '<p><strong style=\"color: rgb(115, 115, 115);\">LuxeVista\'s Presidential Suite: A Haven of Luxury and Sophistication</strong></p><p><br></p><p>Welcome to <strong style=\"color: rgb(115, 115, 115);\">LuxeVista\'s </strong>Presidential Suite, where we invite you to step into a realm of unparalleled opulence and prestige. Designed for the discerning traveler seeking the epitome of luxury, this expansive suite offers a seamless blend of sophistication and comfort, ensuring an unforgettable stay. </p><p><br></p><p><strong>Spacious Elegance:</strong> Spanning 400 square feet, <strong style=\"color: rgb(115, 115, 115);\">LuxeVista\'s </strong>Presidential Suite exudes an air of grandeur with its meticulously designed layout and exquisite furnishings. From the moment you enter, you\'ll be greeted by a sense of space and refinement that sets the tone for your indulgent retreat. </p><p><br></p><p><strong>Luxurious Amenities:</strong> Indulge in a wealth of luxurious amenities curated to enhance your stay. The Presidential Suite features a lavish king-sized bed adorned with plush linens, ensuring a restful night\'s sleep. Unwind in the separate living area, complete with stylish seating arrangements and a state-of-the-art entertainment system for your relaxation and enjoyment.</p><p><br></p><p><strong>Private Oasis</strong>: Escape to your private sanctuary within the suite – the elegantly appointed bathroom. Featuring marble accents, a deep soaking tub, and a spacious walk-in shower, it\'s a sanctuary where you can pamper yourself in style. Additionally, a separate powder room adds convenience and privacy for you and your guests.</p><p><br></p><p><strong>Spectacular Views</strong>: Admire breathtaking views of [insert notable feature or landmark] from the expansive windows of Twix Hotel\'s Presidential Suite, offering a picturesque backdrop to your luxurious retreat. Whether day or night, the scenery outside adds an extra touch of magic to your experience.</p><p><br></p><p><strong>Personalized Service</strong>: At <strong style=\"color: rgb(115, 115, 115);\">LuxeVista</strong>, we believe in providing personalized service that exceeds expectations. From dedicated concierge assistance to exclusive access to our VIP amenities, every aspect of your stay in the Presidential Suite is tailored to your needs and desires.</p><p><br></p><p><strong>Unforgettable Memories</strong>: Whether you\'re traveling for business or leisure, <strong style=\"color: rgb(115, 115, 115);\">LuxeVista\'s </strong>Presidential Suite promises an unforgettable experience that will leave a lasting impression. Elevate your stay to new heights of luxury and sophistication with a memorable retreat in our distinguished Presidential Suite.</p><p><br></p><p>Experience the pinnacle of hospitality at <strong style=\"color: rgb(115, 115, 115);\">LuxeVista</strong>– where every moment in the Presidential Suite is crafted to perfection, ensuring a truly remarkable stay.</p>', NULL, '/storage/uploads/services/lLdNskOiHASro40al5vmJDdHkMB7VRTnEnVaY4Xn.png', '2025-09-26 19:06:23', '2026-01-09 13:43:37', 'Double Room – Perfect for Couples', 'Stay in our cozy Double Room, designed for two guests with modern amenities.', 'double room, hotel room for two, queen-size bed, cozy hotel room'),
(8, 'Executive Suite', 'executive-suite', '$500.00 USD / Night', '<p><span style=\"color: rgb(115, 115, 115);\">Indulge in the pinnacle of sophistication and comfort with our Executive Suite at VeloriaHotel. Designed for the discerning traveler seeking the ultimate in luxury, this spacious retreat offers a haven of tranquility amidst the bustling energy of the city. </span></p><p><br></p><p><strong>Unparalleled Elegance</strong>: </p><p>Step into a world of refined elegance as you enter our Executive Suite. Every corner is meticulously crafted with upscale furnishings, plush fabrics, and stylish décor, creating an ambiance of timeless sophistication. </p><p><br></p><p><strong>Expansive Space</strong>: </p><p>Spread out and relax in the generous living area, perfect for unwinding after a day of exploration or conducting business meetings in the comfort of your own suite. The separate bedroom provides privacy and serenity, ensuring a restful night\'s sleep. </p><p><br></p><p><strong>Breathtaking Views</strong>: </p><p>Admire panoramic views of the city skyline or tranquil landscapes from the large windows of your Executive Suite, offering a picturesque backdrop to your stay. </p><p><br></p><p><strong>Luxurious Amenities</strong>: </p><p>Experience true indulgence with a range of premium amenities at your disposal. From a lavish king-sized bed adorned with high-thread-count linens to a well-appointed marble bathroom featuring a soaking tub and deluxe toiletries, every detail is designed to exceed your expectations. </p><p><br></p><p><strong>Exclusive Services</strong>: Enjoy personalized service with access to our exclusive Executive Lounge, where you can savor complimentary breakfast, evening cocktails, and hors d\'oeuvres while taking in stunning views of the city. </p><p><br></p><p><strong>Unmatched Convenience</strong>: Stay connected and productive with complimentary high-speed Wi-Fi and a dedicated work area, allowing you to seamlessly blend work and leisure during your stay. Your Retreat Awaits: Whether you\'re traveling for business or leisure, our Executive Suite at TwixHotel offers a sanctuary of luxury and tranquility, ensuring an unforgettable stay that leaves you refreshed, rejuvenated, and inspired. Experience the epitome of refined living with our Executive Suite – where luxury knows no bounds.</p>', NULL, '/storage/uploads/services/wVjOm1iru8JCMMMdxuMQIAF27LBrgpkPRRIPhf6U.png', '2025-09-26 19:06:23', '2026-01-09 13:29:57', 'Family Suite – Perfect for Family Stays', 'Book our Family Suite for a comfortable and spacious stay with your loved ones.', 'family suite, hotel for families, two-bedroom suite, kid-friendly hotel'),
(9, 'Honeymoon Suite', 'honeymoon-suite', '$560.00 USD / Night', '<p><span style=\"color: rgb(115, 115, 115);\">Escape to a haven of romance and intimacy with our Honeymoon Suite at VeloriaHotel. Designed for couples seeking an unforgettable getaway, this luxurious sanctuary offers a blend of elegance, comfort, and seclusion, setting the stage for cherished moments and lifelong memories. </span></p><p><br></p><p><strong>Intimate Ambiance</strong>: </p><p>Step into a world of enchantment as you enter our Honeymoon Suite, where every detail is thoughtfully curated to create a romantic ambiance. From soft lighting to cozy furnishings, immerse yourself in an atmosphere of love and intimacy. </p><p><br></p><p><strong>Luxurious Amenities</strong>: </p><p>Indulge in luxury with a range of premium amenities designed to enhance your stay. Relax in a sumptuous king-sized bed adorned with rose petals, or unwind in the private Jacuzzi while enjoying panoramic views of the city skyline. </p><p><br></p><p><strong>Personalized Service</strong>:</p><p>Experience personalized service tailored to your every need. From arranging romantic dinners under the stars to organizing couples\' spa treatments, our dedicated staff are committed to making your honeymoon truly unforgettable. </p><p><br></p><p><strong>Your Love Story Begins Here</strong>:</p><p>Whether you\'re celebrating your honeymoon or anniversary, or simply enjoying a romantic getaway, our Honeymoon Suite at VeloriaHotel offers the perfect setting for love to blossom. Treat yourself and your loved one to a magical escape where every moment is filled with romance and passion.</p>', NULL, '/storage/uploads/services/KXn5iIlTUezL0l6KDJ4AlDgtANdFeo2CFgRYuphI.png', '2025-09-26 19:06:23', '2026-01-09 13:31:23', 'Honeymoon Suite – Romantic Hotel Escape', 'Celebrate your love in our Honeymoon Suite with a private jacuzzi and luxury amenities.', 'honeymoon suite, romantic hotel room, jacuzzi suite, couple getaway'),
(10, 'Infinity Sea View', 'infinity-sea-view', '$550.00 USD / Night', '<p><span style=\"color: rgb(33, 37, 41);\">Welcome to our Super Deluxe Twin room at VeloriaHotel, where luxury meets </span></p><p>functionality to create the perfect retreat for both leisure and business travelers alike. </p><p><br></p><p><strong>Contemporary Comfort</strong>: </p><p>Step into a modern oasis of comfort and style, where sleek furnishings and tasteful decor combine to create a serene ambiance that feels like home. Spacious Layout: Enjoy ample space to relax and unwind in our Super Deluxe Twin room, featuring two comfortable twin beds adorned with premium linens, ensuring a restful night\'s sleep for you and your companion. </p><p><br></p><p><strong>Work & Leisure</strong>: </p><p>Whether you\'re catching up on work or unwinding after a day of exploration, our Super Deluxe Twin room offers a dedicated workspace and cozy seating area, providing the perfect balance of productivity and relaxation. </p><p><br></p><p><strong>Luxurious Amenities</strong>: </p><p>Indulge in a range of upscale amenities, including a flat-screen TV for entertainment, a mini-fridge stocked with refreshments, and a luxurious marble bathroom with deluxe toiletries, ensuring a comfortable and convenient stay. </p><p><br></p><p><strong>Personalized Service</strong>: </p><p>Experience personalized service tailored to your every need, with our attentive staff always on hand to assist you with any requests or inquiries, ensuring a memorable and enjoyable stay. Your Home Away from Home: Whether you\'re traveling solo, with a friend, or on a business trip, our Super Deluxe Twin room at TwixHotel offers the perfect blend of comfort, convenience, and sophistication, ensuring a memorable and enjoyable stay from start to finish.</p><h3><strong>Cancellation Policy</strong></h3><p><strong>*Cancellation Fee $300.00 USD / Night</strong></p><p><br></p><p>Cancellations made more than 72 hours before the scheduled check-in date will receive a full refund. Cancellations made between 48 and 72 hours before the scheduled check-in date will incur a cancellation fee equivalent to 500 USD of the total booking amount.</p>', NULL, '/storage/uploads/services/I6ATACmX2K4BTGkgYcfo93nhF9eU3fEDwusYb2NT.png', '2026-01-09 13:34:34', '2026-01-09 13:34:34', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('6MhK9RPv4Hf1wgnybNAcscsHZ47RSmmgCQhZIXX1', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMXBuZ1JUWE9oWGd2TmJSNmF0SG9OYmRCNzJMV252Y3hzUkowTHlWQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1767970608),
('KqAMwXXQzEoKhOnRNLyY6Niger2Xr8MBo8AVpvcT', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiQmxCM0ZhS2JEYm44ZWFlQllMdHhPRkE3RTVVU1Y0TUljWlpvd1RHQyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI2OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvaG9tZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1767970857),
('zHMFpYaEYOoOIH5PDsiLpg7TeSn1RjqYrwZrS5TE', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR2VyQ01hbjF2V1NqTUNSY0JlYUtma0JDbmVPQVdUalBhTzlsOTlsbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zZXR0aW5ncyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1767982174),
('zJStChngagpqEsTnrNPfLL53k4qjh0JUNbjPJI4b', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicElXTVJRT3lWY3BzOUJYdEQ2akY2RXhpNHBQTHNiTlFmUXA5eE9rUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1767980404);

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'company_name', 'LUXEVISTA Hotel', '2025-08-20 18:01:03', '2026-01-09 16:58:07'),
(2, 'email', 'contact@luxevista-hotel.com', '2025-08-20 18:01:04', '2026-01-09 16:58:07'),
(3, 'phone', '+1 212-555-0147', '2025-08-20 18:01:04', '2026-01-09 16:58:07'),
(4, 'adress', 'New York, NY 10036, United States', '2025-08-20 18:01:04', '2026-01-09 16:58:07'),
(5, 'meta_title', NULL, '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(6, 'meta_description', NULL, '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(7, 'socials', '{}', '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(8, 'logo', '/storage/uploads/settings/byj6sLTOA0RCXe918DZImuDuQ9l5esUUbWZ7Ad8z.png', '2025-08-20 18:01:04', '2026-01-09 17:09:30'),
(9, 'map_embed', 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3021.905115834648!2d-73.98513068459338!3d40.75889507932637!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25855d4896f7b%3A0x3d1c6c2b5c5e9e2a!2sTimes%20Square!5e0!3m2!1sen!2sus!4v1700000000000', '2026-01-09 08:14:16', '2026-01-09 08:14:16'),
(10, 'meta_keywords', NULL, '2026-01-09 08:14:16', '2026-01-09 08:14:16');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'Admin', 'contact@fsd-batiment.fr', NULL, '$2y$12$uT7TfZxR73nxhaK7jPtJ.ux/X.LdmbcDAV74G1AuKct8ya8FvDcKu', 'PGJe9UunZzWF46WwUMh4p6uMCqdYzcPXnHb2ruM8JblKUvKUrVoPEkSfsIms', '2025-07-30 21:25:39', '2025-09-17 08:30:45');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `home_page_section`
--
ALTER TABLE `home_page_section`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `home_page_section_section_key_unique` (`section_key`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `project_images`
--
ALTER TABLE `project_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_images_project_id_foreign` (`project_id`);

--
-- Index pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reservations_user_id_foreign` (`user_id`),
  ADD KEY `reservations_service_id_foreign` (`service_id`);

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `home_page_section`
--
ALTER TABLE `home_page_section`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `project_images`
--
ALTER TABLE `project_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `project_images`
--
ALTER TABLE `project_images`
  ADD CONSTRAINT `project_images_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reservations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
