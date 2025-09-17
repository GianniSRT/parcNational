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
        localStorage.setItem('user', JSON.stringify(result.user));
        // Redirection avec l'id utilisateur dans l'URL
        window.location.href = `profile.html?id=${result.user.id_utilisateur}`;
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