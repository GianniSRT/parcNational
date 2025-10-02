<?php
require __DIR__ . '/../vendor/autoload.php';

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

session_start();

function authMiddleware() {
    $secret_key = "MA_CLE_SECRETE"; // ⚠️ mettre dans un .env en vrai projet

    // Récupérer le header Authorization
    $headers = getallheaders();
    if (!isset($headers['Authorization'])) {
        http_response_code(401);
        echo json_encode(["message" => "Token manquant"]);
        exit;
    }

    $authHeader = $headers['Authorization'];
    $arr = explode(" ", $authHeader);
    $token = $arr[1] ?? null;

    if (!$token) {
        http_response_code(401);
        echo json_encode(["message" => "Format du token invalide"]);
        exit;
    }

    try {
        $decoded = JWT::decode($token, new Key($secret_key, 'HS256'));
        return $decoded->data; // infos user
    } catch (Exception $e) {
        http_response_code(403);
        echo json_encode(["message" => "Accès refusé", "error" => $e->getMessage()]);
        exit;
    }
}

function verifyAuth() {
    if (!isset($_SESSION['token']) || !isset($_SESSION['user'])) {
        http_response_code(401);
        echo json_encode(['message' => 'Non autorisé']);
        exit;
    }
    
    // Vérifie si le token est valide
    try {
        require_once 'generateToken.php';
        $decoded = verifyToken($_SESSION['token']);
        if (!$decoded || $decoded->data->id_utilisateur !== $_SESSION['user']['id_utilisateur']) {
            session_destroy();
            http_response_code(401);
            echo json_encode(['message' => 'Token invalide']);
            exit;
        }
    } catch (Exception $e) {
        session_destroy();
        http_response_code(401);
        echo json_encode(['message' => 'Token invalide']);
        exit;
    }
}
