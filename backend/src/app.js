const express = require('express');
const db = require('./config/database');

const app = express();
app.use(express.json());

// import des routes utilisateurs
const utilisateursRoutes = require('./routes/userRoutes');
app.use('/utilisateurs', utilisateursRoutes);

app.listen(3000, () => {
  console.log("🚀 Serveur Node lancé sur http://localhost:3000");
});
