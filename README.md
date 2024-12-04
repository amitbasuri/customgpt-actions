# customgpt-actions

### README: CustomGPT Actions - Discord Bot Integration

---

#### Overview
This repository demonstrates a backend implementation for integrating a Discord bot that sends messages to specific channels. It also includes an OpenAPI schema to enable CustomGPT actions.

---

### Setup

#### Prerequisites
- [Node.js](https://nodejs.org/)
- A [Discord Bot Token](https://discord.com/developers/applications)

#### Steps
1. **Clone and Install**:
   ```bash
   git clone <repository-url>
   cd customgpt-actions
   npm install
   ```

2. **Configure Environment**:
   Create a `.env` file:
   ```env
   PORT=3000
   DISCORD_BOT_TOKEN=your_discord_bot_token
   ```

3. **Run the Server**:
   ```bash
   npm run dev
   ```

4. **Invite Bot to Discord Server**:
   - Use the generated invite link:
     ```plaintext
     https://discord.com/oauth2/authorize?client_id=YOUR_CLIENT_ID&scope=bot&permissions=2048
     ```
   - Add the bot to your server.

5. **Test the API**:
   Use `curl` to send a message:
   ```bash
   curl -X POST http://localhost:3000/api/discord/message \
   -H "Content-Type: application/json" \
   -d '{
     "channelId": "YOUR_CHANNEL_ID",
     "message": "Hello, Discord!"
   }'
   ```

---

### OpenAPI Schema
The OpenAPI schema for the Discord bot is available at `openapi/discord-bot.yaml`.  
It enables tools like CustomGPT to utilize the API.

---

### Project Structure
```
customgpt-actions/
├── openapi/
│   └── discord-bot.yaml     # OpenAPI schema for Discord bot
├── src/
│   ├── app.ts               # Express app setup
│   ├── config/env.ts        # Environment variable loader
│   ├── index.ts             # Entry point
│   ├── integrations/discord # Discord integration logic
│   ├── routes/discordRoutes.ts # API routes
├── .env                     # Environment variables
├── package.json             # Dependencies and scripts
├── tsconfig.json            # TypeScript configuration
└── README.md                # Project instructions
```

