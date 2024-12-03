import * as dotenv from 'dotenv';
dotenv.config();

export const config = {
    port: process.env.PORT || 3000,
    discord: {
        token: process.env.DISCORD_BOT_TOKEN || '',
    },
};

if (!config.discord.token) {
    throw new Error('DISCORD_BOT_TOKEN is missing in the .env file.');
}
