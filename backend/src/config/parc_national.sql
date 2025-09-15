-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 15 sep. 2025 à 13:12
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
  PRIMARY KEY (`id_camping`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  PRIMARY KEY (`id_sentier`),
  KEY `id_administrateur` (`id_administrateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
