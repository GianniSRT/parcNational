document.addEventListener('DOMContentLoaded', async () => {
    const response = await fetch('http://localhost/parcNational/backend/src/routes/sentiers.php');
    if (response.ok) {
        const result = await response.json();
        const sentiers = result.sentiers;
        const container = document.getElementById('sentierMosaic');
        container.innerHTML = '';

        // Crée la grille 4x4
        let row;
        sentiers.forEach((sentier, i) => {
            if (i % 4 === 0) {
                row = document.createElement('div');
                row.className = 'row mb-4';
                container.appendChild(row);
            }
            const col = document.createElement('div');
            col.className = 'col-md-3';
            col.innerHTML = `
                <div class="card h-100">
                    <img src="${sentier.image || 'src/images/landing_page.jpg'}" class="card-img-top" alt="${sentier.nom}">
                    <div class="card-body">
                        <h5 class="card-title">${sentier.nom}</h5>
                        <p class="card-text">${sentier.description}</p>
                    </div>
                </div>
            `;
            row.appendChild(col);
        });
    } else {
        document.getElementById('sentierMosaic').textContent = "Aucun sentier trouvé.";
    }
});