// src/index.ts
import express, { Express } from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import { todoRouter } from './routes/todo.route';

dotenv.config();

const app: Express = express();
const port = process.env.PORT || 3000;

app.use(cors());

app.use(express.json()); // Permet de lire les données JSON dans les requêtes POST

// Utiliser les routes définies dans le fichier todo.routes.ts
app.use('/', todoRouter);

// Point d'entrée de base pour tester que le serveur fonctionne
// app.get('/', (req, res) => {
//   res.send('Welcome to the TODO API');
// });

// Démarrer le serveur sur le port spécifié
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});


