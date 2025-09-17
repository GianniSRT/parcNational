<?php
require_once '../models/userModel.php';

function loginController($mysqli, $data) {
    $stmt = $mysqli->prepare("SELECT * FROM Utilisateur WHERE email = ?");
    $stmt->bind_param("s", $data['email']);
    $stmt->execute();
    $user = $stmt->get_result()->fetch_assoc();

    if ($user && $user['mot_de_passe'] === $data['mot_de_passe']) {
        $_SESSION['user'] = [
            'id_utilisateur' => $user['id_utilisateur'],
            'nom' => $user['nom'],
            'prenom' => $user['prenom'],
            'email' => $user['email'],
            'date_inscription' => $user['date_inscription'], // <-- ajoute cette ligne
            'type_utilisateur' => $user['type_utilisateur']
        ];
        echo json_encode([
            'message' => '✅ Connexion réussie',
            'user' => $_SESSION['user']
        ]);
    } else {
        http_response_code(401);
        echo json_encode(['message' => '❌ Email ou mot de passe incorrect']);
    }
}
?>