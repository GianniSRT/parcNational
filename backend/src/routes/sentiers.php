<?php
header('Content-Type: application/json');
require_once '../config/database.php'; // Ajoute cette ligne !
require_once '../models/sentierModel.php';

$sentiers = getAllSentiers($mysqli);
echo json_encode(['sentiers' => $sentiers]);
?>