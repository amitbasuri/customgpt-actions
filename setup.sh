#!/bin/bash

# Directory structure
echo "Creating directory structure..."
mkdir -p src/integrations/discord
mkdir -p src/routes
mkdir -p src/config

# Boilerplate files
echo "Creating boilerplate files..."

# Environment variables
cat <<EOL > .env
PORT=3000
BOT_TOKEN=your_discord_bot_token
EOL

# .gitignore
cat <<EOL > .gitignore
node_modules
dist
.env
EOL

# Package.json
cat <<EOL > package.json
{
  "name": "customgpt-actions",
  "version": "1.0.0",
  "description": "CustomGPT actions backend",
  "main": "dist/index.js",
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "dev": "ts-node-dev src/index.ts"
  },
  "dependencies": {
    "discord.js": "^14.0.0",
    "dotenv": "^16.0.0",
    "express": "^4.18.0"
  },
  "devDependencies": {
    "@types/express": "^4.17.0",
    "@types/node": "^18.0.0",
    "ts-node-dev": "^2.0.0",
    "typescript": "^4.8.0"
  }
}
EOL

# TypeScript config
cat <<EOL > tsconfig.json
{
  "compilerOptions": {
    "target": "ES6",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true
  },
  "exclude": ["node_modules"]
}
EOL

# Config: env.ts
cat <<EOL > src/config/env.ts
import dotenv from 'dotenv';
dotenv.config();

export const config = {
    port: process.env.PORT || 3000,
    discord: {
        token: process.env.BOT_TOKEN,
    },
};
EOL

# Discord Integration: discordClient.ts
cat <<EOL > src/integrations/discord/discordClient.ts
import { Client, GatewayIntentBits } from 'discord.js';
import { config } from '../../config/env';

const discordClient = new Client({
    intents: [GatewayIntentBits.Guilds, GatewayIntentBits.GuildMessages],
});

discordClient.once('ready', () => {
    console.log('Discord bot is online!');
});

if (!config.discord.token) {
    throw new Error('Discord BOT_TOKEN is missing in the .env file.');
}

// Log in to Discord
discordClient.login(config.discord.token);

export { discordClient };
EOL

# Discord Integration: discordService.ts
cat <<EOL > src/integrations/discord/discordService.ts
import { discordClient } from './discordClient';

export const sendDiscordMessage = async (channelId: string, message: string): Promise<void> => {
    const channel = await discordClient.channels.fetch(channelId);
    if (!channel || !channel.isTextBased()) {
        throw new Error('Channel not found or is not a text channel.');
    }

    await (channel as any).send(message);
};
EOL

# Discord Routes: discordRoutes.ts
cat <<EOL > src/routes/discordRoutes.ts
import { Router } from 'express';
import { sendDiscordMessage } from '../integrations/discord/discordService';

const router = Router();

router.post('/discord/message', async (req, res) => {
    const { channelId, message } = req.body;

    if (!channelId || !message) {
        return res.status(400).json({ error: 'channelId and message are required.' });
    }

    try {
        await sendDiscordMessage(channelId, message);
        res.status(200).json({ success: true, message: 'Message sent successfully!' });
    } catch (error) {
        console.error('Error posting message:', error);
        res.status(500).json({ error: 'Failed to send the message. Check server logs for details.' });
    }
});

export { router as discordRoutes };
EOL

# App Entry: app.ts
cat <<EOL > src/app.ts
import express from 'express';
import { discordRoutes } from './routes/discordRoutes';

const app = express();

// Middleware
app.use(express.json());

// Routes
app.use('/api', discordRoutes);

export { app };
EOL

# Server Entry: index.ts
cat <<EOL > src/index.ts
import { app } from './app';
import { config } from './config/env';

const port = config.port;

app.listen(port, () => {
    console.log(\`Server is running at http://localhost:\${port}\`);
});
EOL

# Final steps
echo "Initializing npm and installing dependencies..."
npm install

echo "Setup completed! Your customgpt-actions repo is ready."
