<?php
header('Content-Type: application/json');
require_once '../config/database.php';
require_once '../models/campingModel.php';

$campings = getAllCampings($mysqli); // Fonction qui retourne tous les campings
echo json_encode(['campings' => $campings]);
?>