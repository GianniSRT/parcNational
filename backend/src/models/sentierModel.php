<?php
function getAllSentiers($mysqli) {
    $result = $mysqli->query("SELECT * FROM Sentier");
    return $result->fetch_all(MYSQLI_ASSOC);
}