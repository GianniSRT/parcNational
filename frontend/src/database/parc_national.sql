-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 09 sep. 2025 à 08:24
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
-- Structure de la table `annonce`
--

DROP TABLE IF EXISTS `annonce`;
CREATE TABLE IF NOT EXISTS `annonce` (
  `id_annonce` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `titre` varchar(150) DEFAULT NULL,
  `contenu` text,
  `date_publication` datetime DEFAULT CURRENT_TIMESTAMP,
  `type` enum('Information','Alerte','Evenement') DEFAULT 'Information',
  PRIMARY KEY (`id_annonce`),
  KEY `id_utilisateur` (`id_utilisateur`)
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
  `capacite_totale` int DEFAULT NULL,
  `disponibilite` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_camping`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE IF NOT EXISTS `reservation` (
  `id_reservation` int NOT NULL AUTO_INCREMENT,
  `id_visiteur` int NOT NULL,
  `id_camping` int NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `statut` enum('En attente','Confirmée','Annulée') DEFAULT 'En attente',
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
  `id_utilisateur` int NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `description` text,
  `etat_conservation` enum('Bon','Moyen','Mauvais') DEFAULT 'Bon',
  PRIMARY KEY (`id_ressource`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sentier`
--

DROP TABLE IF EXISTS `sentier`;
CREATE TABLE IF NOT EXISTS `sentier` (
  `id_sentier` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text,
  `niveau_difficulte` enum('Facile','Moyen','Difficile') DEFAULT 'Facile',
  `distance_km` decimal(5,2) DEFAULT NULL,
  `point_interet` varchar(255) DEFAULT NULL,
  `statut` enum('Ouvert','Fermé') DEFAULT 'Ouvert',
  PRIMARY KEY (`id_sentier`),
  KEY `id_utilisateur` (`id_utilisateur`)
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
  `role` enum('admin','visiteur') DEFAULT 'visiteur',
  `date_creation` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `visiteur`
--

DROP TABLE IF EXISTS `visiteur`;
CREATE TABLE IF NOT EXISTS `visiteur` (
  `id_visiteur` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `abonnement` enum('Oui','Non') DEFAULT 'Non',
  `carte_membre` varchar(50) DEFAULT NULL,
  `date_inscription` date DEFAULT (curdate()),
  PRIMARY KEY (`id_visiteur`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
