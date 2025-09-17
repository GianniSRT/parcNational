document.addEventListener('DOMContentLoaded', async () => {
    const response = await fetch('http://localhost/parcNational/backend/src/routes/profile.php', {
        credentials: 'include'
    });
    if (response.ok) {
        const result = await response.json();
        const user = result.user;
        // Affiche les infos du profil
        document.getElementById('profileNom').textContent = user.nom;
        document.getElementById('profilePrenom').textContent = user.prenom;
        document.getElementById('profileEmail').textContent = user.email;
        document.getElementById('profileDate').textContent = user.date_inscription;
        document.getElementById('profileType').textContent = user.type_utilisateur;
    }
});

document.getElementById('logoutBtn').addEventListener('click', async () => {
    await fetch('http://localhost/parcNational/backend/src/routes/logout.php');
    window.location.href = "auth.html";
});