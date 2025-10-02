document.addEventListener('DOMContentLoaded', async () => {
    console.log('index.js chargé');
    const response = await fetch('http://localhost/parcNational/backend/src/routes/profile.php');
    console.log('Réponse brute :', response);
    if (response.ok) {
        const result = await response.json();
        const user = result.user;
            console.log('Utilisateur connecté sur index :', user);
        console.log('Résultat JSON :', result);
        // document.getElementById('welcome').textContent = `Bienvenue, ${user.prenom} ${user.nom} ${user.email}`;
    } else {
        // Optionnel : redirige vers la connexion si non connecté
        window.location.href = "auth.html";
    }
});