const mysql = require('mysql2');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',   // si tu as mis un mot de passe dans phpMyAdmin, mets-le ici
  database: 'parc_national'
});

db.connect((err) => {
  if (err) {
    console.error('❌ Erreur de connexion MySQL:', err);
    return;
  }
  console.log('✅ Connecté à MySQL via Wamp');
});

module.exports = db;
