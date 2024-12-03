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
