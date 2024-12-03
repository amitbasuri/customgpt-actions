import express from 'express';
import { discordRoutes } from './routes/discordRoutes';

const app = express();

// Middleware
app.use(express.json());

// Routes
app.use('/api', discordRoutes);

export { app };
