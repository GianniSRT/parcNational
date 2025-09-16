document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('registerForm');

    form.addEventListener('submit', async function(e) {
        e.preventDefault();
        const nom = document.getElementById('nom').value;
        const prenom = document.getElementById('prenom').value;
        const email = document.getElementById('email').value;
        const mot_de_passe = document.getElementById('mot_de_passe').value;

        try {
            const response = await fetch('http://localhost/parcNational/backend/src/routes/users.php', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ nom, prenom, email, mot_de_passe })
            });
            const result = await response.json();
            if (response.ok) {
                alert(result.message + "\nBienvenue " + nom + " " + prenom);
                window.location.href = 'index.html'; // Redirection après inscription
            } else {
                alert(result.message || "Erreur lors de l'inscription.");
            }
        } catch (error) {
            alert("Erreur de connexion au serveur.");
        }
    });
});