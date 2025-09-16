<?php
<?php
require_once '../models/userModel.php';

function getAllUsersController($mysqli) {
    echo json_encode(getAllUsers($mysqli));
}

function getUserByIdController($mysqli, $id) {
    $user = getUserById($mysqli, $id);
    if ($user) {
        echo json_encode($user);
    } else {
        http_response_code(404);
        echo json_encode(['message' => 'Utilisateur non trouvé']);
    }
}

function createUserController($mysqli, $data) {
    $id = createUser($mysqli, $data);
    echo json_encode(['message' => '✅ Utilisateur créé', 'id' => $id]);
}

function updateUserController($mysqli, $id, $data) {
    $affected = updateUser($mysqli, $id, $data);
    if ($affected) {
        echo json_encode(['message' => '✅ Utilisateur modifié']);
    } else {
        http_response_code(404);
        echo json_encode(['message' => 'Utilisateur non trouvé']);
    }
}

function deleteUserController($mysqli, $id) {
    $affected = deleteUser($mysqli, $id);
    if ($affected) {
        echo json_encode(['message' => '✅ Utilisateur supprimé']);
    } else {
        http_response_code(404);
        echo json_encode(['message' => 'Utilisateur non trouvé']);
    }
}
?>