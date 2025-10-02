function getSentiers() {
  return JSON.parse(localStorage.getItem('sentiers') || '[]');
}

function saveSentiers(sentiers) {
  localStorage.setItem('sentiers', JSON.stringify(sentiers));
}

function renderSentiers() {
  const sentiers = getSentiers();
  const tbody = document.querySelector('#sentiersTable tbody');
  tbody.innerHTML = '';
  sentiers.forEach((s, i) => {
    tbody.innerHTML += `
      <tr>
        <td>${s.nom}</td>
        <td>${s.description}</td>
        <td>
          <button class="btn btn-warning btn-sm" onclick="editSentier(${i})">Modifier</button>
          <button class="btn btn-danger btn-sm" onclick="deleteSentier(${i})">Supprimer</button>
        </td>
      </tr>
    `;
  });
}

document.getElementById('addSentierForm').addEventListener('submit', function(e) {
  e.preventDefault();
  const nom = document.getElementById('nomSentier').value;
  const description = document.getElementById('descriptionSentier').value;
  const sentiers = getSentiers();
  sentiers.push({ nom, description });
  saveSentiers(sentiers);
  renderSentiers();
  this.reset();
});

// Modifier un sentier
window.editSentier = function(index) {
  const sentiers = getSentiers();
  const s = sentiers[index];
  document.getElementById('nomSentier').value = s.nom;
  document.getElementById('descriptionSentier').value = s.description;
  deleteSentier(index);
}

// Supprimer un sentier
window.deleteSentier = function(index) {
  const sentiers = getSentiers();
  sentiers.splice(index, 1);
  saveSentiers(sentiers);
  renderSentiers();
}

// Initialisation
document.addEventListener('DOMContentLoaded', renderSentiers);