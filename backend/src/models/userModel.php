<?php
<?php
function getAllUsers($mysqli) {
    $result = $mysqli->query("SELECT * FROM Utilisateur");
    return $result->fetch_all(MYSQLI_ASSOC);
}

function getUserById($mysqli, $id) {
    $stmt = $mysqli->prepare("SELECT * FROM Utilisateur WHERE id_utilisateur = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

function createUser($mysqli, $data) {
    $stmt = $mysqli->prepare("INSERT INTO Utilisateur (nom, prenom, email, mot_de_passe) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $data['nom'], $data['prenom'], $data['email'], $data['mot_de_passe']);
    $stmt->execute();
    return $stmt->insert_id;
}

function updateUser($mysqli, $id, $data) {
    $stmt = $mysqli->prepare("UPDATE Utilisateur SET nom = ?, prenom = ?, email = ?, mot_de_passe = ? WHERE id_utilisateur = ?");
    $stmt->bind_param("ssssi", $data['nom'], $data['prenom'], $data['email'], $data['mot_de_passe'], $id);
    $stmt->execute();
    return $stmt->affected_rows;
}

function deleteUser($mysqli, $id) {
    $stmt = $mysqli->prepare("DELETE FROM Utilisateur WHERE id_utilisateur = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    return $stmt->affected_rows;
}
?>