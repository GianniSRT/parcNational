<?php
require __DIR__ . '/../vendor/autoload.php';

use Firebase\JWT\JWT;

$secret_key = "MA_CLE_SECRETE"; // ⚠️ stocker ailleurs
$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';

// Exemple utilisateur en dur (à remplacer par une DB)
if ($username === "admin" && $password === "1234") {
    $payload = [
        "iss" => "http://localhost",  // émetteur
        "aud" => "http://localhost",  // audience
        "iat" => time(),              // émis à
        "exp" => time() + 3600,       // expire dans 1h
        "data" => [
            "id" => 1,
            "username" => $username,
            "role" => "admin"
        ]
    ];

    $jwt = JWT::encode($payload, $secret_key, 'HS256');
    echo json_encode(["token" => $jwt]);
} else {
    http_response_code(401);
    echo json_encode(["message" => "Identifiants invalides"]);
}
