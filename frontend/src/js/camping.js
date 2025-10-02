document.addEventListener('DOMContentLoaded', async () => {
    // Vérifie la connexion
    const response = await fetch('http://localhost/parcNational/backend/src/routes/profile.php', {
        credentials: 'include'
    });
    const result = await response.json();
    if (!response.ok || !result.user) {
        // Redirige vers la page de connexion si non connecté
        window.location.href = 'auth.html';
        return;
    }

    const responseCampings = await fetch('http://localhost/parcNational/backend/src/routes/campings.php');
    if (responseCampings.ok) {
        const resultCampings = await responseCampings.json();
        const campings = resultCampings.campings;
        const container = document.getElementById('campingMosaic');
        container.innerHTML = '';

        let row;
        campings.forEach((camping, i) => {
            if (i % 4 === 0) {
                row = document.createElement('div');
                row.className = 'row mb-4';
                container.appendChild(row);
            }
            const col = document.createElement('div');
            col.className = 'col-md-3';
            col.innerHTML = `
                <div class="card h-100 shadow-sm">
                    <img src="${camping.image || 'src/images/landing_page.jpg'}" class="card-img-top" alt="${camping.nom}">
                    <div class="card-body">
                        <h5 class="card-title">${camping.nom}</h5>
                        <p class="card-text">${camping.localisation}</p>
                        <p class="card-text">Capacité totale : ${camping.capacite_totale}</p>
                        <p class="card-text">Places dispo : ${camping.capacite_disponible}</p>
                        <p class="card-text">Tarif/nuit : ${camping.tarif_nuit} €</p>
                        <span class="badge ${camping.disponible ? 'bg-success' : 'bg-danger'}">
                            ${camping.disponible ? 'Disponible' : 'Complet'}
                        </span>
                        <br>
                        <button class="btn btn-primary mt-3" data-id="${camping.id_camping}" ${camping.disponible ? '' : 'disabled'}>
                            Réserver
                        </button>
                    </div>
                </div>
            `;
            row.appendChild(col);
        });

        container.querySelectorAll('button[data-id]').forEach(btn => {
            btn.addEventListener('click', async () => {
                const idCamping = btn.getAttribute('data-id');
                const response = await fetch('http://localhost/parcNational/backend/src/routes/reservation.php', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    credentials: 'include',
                    body: JSON.stringify({ id_camping: idCamping })
                });
                const result = await response.json();
                if (response.ok) {
                    alert('Réservation enregistrée !');
                } else {
                    alert(result.message || 'Erreur lors de la réservation.');
                }
            });
        });
    } else {
        document.getElementById('campingMosaic').textContent = "Aucun camping trouvé.";
    }
});