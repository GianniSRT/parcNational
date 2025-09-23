<?php
function getAllCampings($mysqli) {
    $result = $mysqli->query("SELECT * FROM Camping");
    return $result->fetch_all(MYSQLI_ASSOC);
}