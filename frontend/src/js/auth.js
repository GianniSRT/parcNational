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
    // Redirection vers la page d'accueil
    window.location.href = 'index.html';
    } else {
        alert(result.message);
    }
}

// Vérification de l'état de la connexion de l'utilisateur
fetch('http://localhost/parcNational/backend/src/routes/profile.php', {
    credentials: 'include'
})
.then(response => response.json())
.then(result => {
    if (result.user) {
        console.log('Utilisateur connecté :', result.user);
    } else {
        console.log('Utilisateur non connecté');
    }
});

// Exemple d’utilisation avec un formulaire :
document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const mot_de_passe = document.getElementById('mot_de_passe').value;
    login(email, mot_de_passe);
});