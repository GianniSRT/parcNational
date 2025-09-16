async function login(email, mot_de_passe) {
    const response = await fetch('http://localhost/parcNational/backend/src/routes/auth.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ email, mot_de_passe })
    });

    const result = await response.json();
    if (response.ok) {
        alert(result.message + "\nBienvenue " + result.user.nom + " " + result.user.prenom);
        // Ici tu peux stocker l'utilisateur ou rediriger
        window.location.href = 'index.html'; // Exemple de redirection
    } else {
        alert(result.message);
    }
}

// Exemple d’utilisation avec un formulaire :
document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const mot_de_passe = document.getElementById('mot_de_passe').value;
    login(email, mot_de_passe);
});