-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 02 oct. 2025 à 11:41
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `parc_national`
--

-- --------------------------------------------------------

--
-- Structure de la table `administrateur`
--

DROP TABLE IF EXISTS `administrateur`;
CREATE TABLE IF NOT EXISTS `administrateur` (
  `id_administrateur` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `niveau_acces` enum('Admin','Superadmin') NOT NULL,
  PRIMARY KEY (`id_administrateur`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `annonce`
--

DROP TABLE IF EXISTS `annonce`;
CREATE TABLE IF NOT EXISTS `annonce` (
  `id_annonce` int NOT NULL AUTO_INCREMENT,
  `id_administrateur` int NOT NULL,
  `id_camping` int DEFAULT NULL,
  `titre` varchar(150) NOT NULL,
  `contenu` text,
  `date_publication` datetime DEFAULT CURRENT_TIMESTAMP,
  `type` enum('Information','Alerte','Evenement') DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_annonce`),
  KEY `id_administrateur` (`id_administrateur`),
  KEY `id_camping` (`id_camping`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `camping`
--

DROP TABLE IF EXISTS `camping`;
CREATE TABLE IF NOT EXISTS `camping` (
  `id_camping` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `localisation` varchar(255) DEFAULT NULL,
  `capacite_totale` int NOT NULL,
  `capacite_disponible` int NOT NULL,
  `disponible` tinyint(1) DEFAULT '1',
  `tarif_nuit` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_camping`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `camping`
--

INSERT INTO `camping` (`id_camping`, `nom`, `localisation`, `capacite_totale`, `capacite_disponible`, `disponible`, `tarif_nuit`, `image`) VALUES
(2, 'Camping des Calanques', '12 rue du Littoral, Marseille', 120, 45, 1, 32.50, 'src/images/camping1.avif'),
(3, 'Camping du Cap', '45 avenue du Cap, Cassis', 80, 20, 1, 40.00, 'src/images/camping2.jpg'),
(4, 'Camping du Belvédère', '1 chemin du Belvédère, La Ciotat', 60, 10, 1, 28.00, 'src/images/camping3.avif'),
(5, 'Camping du Port', '8 quai du Port, Marseille', 100, 0, 0, 35.00, 'src/images/camping4.avif'),
(6, 'Camping du Mont Puget', 'Route du Mont Puget, Marseille', 50, 50, 1, 25.00, 'src/images/camping5.webp');

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id_reservation` int NOT NULL AUTO_INCREMENT,
  `id_visiteur` varchar(100) NOT NULL,
  `id_camping` int NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `statut` enum('En attente','Confirmee','Annulee') DEFAULT 'En attente',
  `prix_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_reservation`),
  KEY `id_visiteur` (`id_visiteur`),
  KEY `id_camping` (`id_camping`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ressource_naturelle`
--

DROP TABLE IF EXISTS `ressource_naturelle`;
CREATE TABLE IF NOT EXISTS `ressource_naturelle` (
  `id_ressource` int NOT NULL AUTO_INCREMENT,
  `id_administrateur` int NOT NULL,
  `type` varchar(50) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text,
  `etat_conservation` enum('Bon','Moyen','Mauvais') NOT NULL,
  PRIMARY KEY (`id_ressource`),
  KEY `id_administrateur` (`id_administrateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sentier`
--

DROP TABLE IF EXISTS `sentier`;
CREATE TABLE IF NOT EXISTS `sentier` (
  `id_sentier` int NOT NULL AUTO_INCREMENT,
  `id_administrateur` int NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text,
  `niveau_difficulte` enum('Facile','Moyen','Difficile') DEFAULT NULL,
  `distance_km` decimal(5,2) DEFAULT NULL,
  `point_interet` varchar(255) DEFAULT NULL,
  `statut` enum('Ouvert','Ferme') DEFAULT 'Ouvert',
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_sentier`),
  KEY `id_administrateur` (`id_administrateur`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `sentier`
--

INSERT INTO `sentier` (`id_sentier`, `id_administrateur`, `nom`, `description`, `niveau_difficulte`, `distance_km`, `point_interet`, `statut`, `image`) VALUES
(1, 0, 'Calanque d\'En-Vau', 'Sentier spectaculaire menant à une crique turquoise entourée de falaises.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier1.jpg'),
(2, 0, 'Sentier du Cap Canaille', 'Randonnée sur les plus hautes falaises maritimes d\'Europe avec vue panoramique.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier2.jpg'),
(3, 0, 'Calanque de Sormiou', 'Sentier facile vers une calanque familiale et son port pittoresque.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier3.jpg'),
(4, 0, 'Calanque de Morgiou', 'Chemin escarpé menant à une calanque sauvage et préservée.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier4.jpg'),
(5, 0, 'Sentier du Belvédère', 'Balade offrant un panorama sur tout le parc national.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier5.jpg'),
(6, 0, 'Calanque de Port-Pin', 'Petite calanque accessible à pied, idéale pour la baignade.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier6.jpg'),
(7, 0, 'Sentier du Mont Puget', 'Randonnée sportive vers le sommet du parc avec vue sur Marseille.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier7.jpg'),
(8, 0, 'Calanque de Callelongue', 'Sentier côtier vers une calanque authentique et son village.', NULL, NULL, NULL, 'Ouvert', 'src/images/sentier8.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `date_inscription` datetime DEFAULT CURRENT_TIMESTAMP,
  `type_utilisateur` enum('Visiteur','Admin') NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `nom`, `prenom`, `email`, `mot_de_passe`, `date_inscription`, `type_utilisateur`) VALUES
(2, 'Smith', 'janet', 'janet.smith@example.com', 'janet123', '2025-09-16 11:03:09', 'Visiteur'),
(3, 'Doe', 'John', 'john.doe@example.com', 'john123', '2025-09-16 12:46:42', 'Visiteur'),
(4, 'heureux', 'axel', 'axel.heureux@laplateforme.io', 'Heureux13500.', '2025-09-16 13:26:09', 'Admin'),
(5, 'mogrovejo', 'justin', 'mogrovejo.justin@laplateforme.io', 'justin123', '2025-09-16 13:29:15', 'Visiteur'),
(7, 'maxime', 'cuadro', 'maxime.cuadro@laplateforme.io', 'maxime123', '2025-09-16 14:01:42', 'Visiteur'),
(9, 'test', 'test', 'test@test.fr', '$2y$10$09EOoOeIuGJKl2jnJmDuLeKalM1hZvHd6DI4QziIa84czJfeS4J8m', '2025-09-19 14:05:34', 'Visiteur');

-- --------------------------------------------------------

--
-- Structure de la table `visiteur`
--

DROP TABLE IF EXISTS `visiteur`;
CREATE TABLE IF NOT EXISTS `visiteur` (
  `id_visiteur` varchar(100) NOT NULL,
  `id_utilisateur` int NOT NULL,
  `abonnement` enum('Oui','Non') DEFAULT 'Non',
  `carte_membre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_visiteur`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
