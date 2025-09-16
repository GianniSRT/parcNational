<?php
$mysqli = new mysqli('localhost', 'root', '', 'parc_national');
if ($mysqli->connect_errno) {
    http_response_code(500);
    echo json_encode(['error' => $mysqli->connect_error]);
    exit;
}
?>