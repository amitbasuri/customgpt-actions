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
