import { discordClient } from './discordClient';

export const sendDiscordMessage = async (channelId: string, message: string): Promise<void> => {
    const channel = await discordClient.channels.fetch(channelId);
    if (!channel || !channel.isTextBased()) {
        throw new Error('Channel not found or is not a text channel.');
    }

    await (channel as any).send(message);
};
