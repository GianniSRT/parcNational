<?php
require_once '../models/userModel.php';

function loginController($mysqli, $data) {
    // Recherche l'utilisateur par email
    $stmt = $mysqli->prepare("SELECT * FROM Utilisateur WHERE email = ?");
    $stmt->bind_param("s", $data['email']);
    $stmt->execute();
    $user = $stmt->get_result()->fetch_assoc();

    if ($user && $user['mot_de_passe'] === $data['mot_de_passe']) {
        // Authentification réussie
        echo json_encode([
            'message' => '✅ Connexion réussie',
            'user' => [
                'id_utilisateur' => $user['id_utilisateur'],
                'nom' => $user['nom'],
                'prenom' => $user['prenom'],
                'email' => $user['email']
            ]
        ]);
    } else {
        // Échec de l'authentification
        http_response_code(401);
        echo json_encode(['message' => '❌ Email ou mot de passe incorrect']);
    }
}
?>