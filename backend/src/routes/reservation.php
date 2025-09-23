<?php
session_start();
header('Content-Type: application/json');
require_once '../models/reservationModel.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_SESSION['user'])) {
    $data = json_decode(file_get_contents('php://input'), true);
    $idCamping = $data['id_camping'];
    $idUser = $_SESSION['user']['id_utilisateur'];
    // $nbPersonnes = $data['nb_personnes'] ?? 1;
    $success = createReservation($mysqli, $idUser, $idCamping /*, $nbPersonnes */);
    if ($success) {
        echo json_encode(['message' => 'Réservation enregistrée']);
    } else {
        http_response_code(400);
        echo json_encode(['message' => 'Erreur lors de la réservation']);
    }
} else {
    http_response_code(401);
    echo json_encode(['message' => 'Non connecté']);
}
?>