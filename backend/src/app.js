const express = require('express');
const db = require('./config/database');

const app = express();
app.use(express.json());

// Exemple : GET tous les campings
app.get('/campings', (req, res) => {
  db.query('SELECT * FROM Camping', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// Exemple : POST un nouveau camping
app.post('/campings', (req, res) => {
  const { nom, localisation, capacite_totale, capacite_disponible, tarif_nuit } = req.body;
  const sql = "INSERT INTO Camping (nom, localisation, capacite_totale, capacite_disponible, disponible, tarif_nuit) VALUES (?, ?, ?, ?, true, ?)";
  
  db.query(sql, [nom, localisation, capacite_totale, capacite_disponible, tarif_nuit], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: "✅ Camping ajouté", id: result.insertId });
  });
});

app.listen(3000, () => {
  console.log("🚀 Serveur Node lancé sur http://localhost:3000");
});
