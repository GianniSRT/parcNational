<?php
session_start();
header('Content-Type: application/json');
$mysqli = new mysqli('localhost', 'root', '', 'parc_national');
require_once '../controllers/authController.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    loginController($mysqli, $data);
} else {
    http_response_code(405);
    echo json_encode(['message' => 'Méthode non autorisée']);
}
?>