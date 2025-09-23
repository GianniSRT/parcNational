<?php
function createReservation($mysqli, $idUser, $idCamping /*, $nbPersonnes */) {
    $stmt = $mysqli->prepare("INSERT INTO Reservation (id_utilisateur, id_camping, date) VALUES (?, ?, NOW())");
    $stmt->bind_param("ii", $idUser, $idCamping);
    return $stmt->execute();
}