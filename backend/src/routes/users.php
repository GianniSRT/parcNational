<?php
<?php
header('Content-Type: application/json');
$mysqli = new mysqli('localhost', 'root', '', 'parc_national');
require_once '../controllers/userController.php';

$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
$id = isset($request[1]) ? intval($request[1]) : null;

switch ($method) {
    case 'GET':
        if ($id) getUserByIdController($mysqli, $id);
        else getAllUsersController($mysqli);
        break;
    case 'POST':
        $data = json_decode(file_get_contents('php://input'), true);
        createUserController($mysqli, $data);
        break;
    case 'PUT':
        if (!$id) { http_response_code(400); exit; }
        $data = json_decode(file_get_contents('php://input'), true);
        updateUserController($mysqli, $id, $data);
        break;
    case 'DELETE':
        if (!$id) { http_response_code(400); exit; }
        deleteUserController($mysqli, $id);
        break;
    default:
        http_response_code(405);
        break;
}
?>