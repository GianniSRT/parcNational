<?php
function findUserByEmail($mysqli, $email) {
    $stmt = $mysqli->prepare("SELECT * FROM Utilisateur WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}
?>