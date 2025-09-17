document.addEventListener('DOMContentLoaded', async () => {
    const response = await fetch('http://localhost/parcNational/backend/src/routes/profile.php');
    if (response.ok) {
        const result = await response.json();
        const user = result.user;
        // // Affiche le nom ou un message de bienvenue
        // document.getElementById('welcome').textContent = `Bienvenue, ${user.prenom} ${user.nom} ${user.email}`;
    } else {
        // Optionnel : redirige vers la connexion si non connecté
        window.location.href = "auth.html";
    }
});