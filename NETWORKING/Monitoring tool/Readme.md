
# Network Monitoring & Alert System 🚀

This project monitors network devices using Python and sends real-time alerts via Telegram when a device goes DOWN.

## Features
- Ping-based monitoring
- Real-time Telegram alerts
- Logging system
- Automated with cron job

## Tech Used
- Python
- Linux (WSL)
- EVE-NG
- Telegram Bot API

## How to configure telegram bot
- Open Telegram
- Search:
 👉 BotFather
- Send:
 /start
- Then:
 /newbot
- Give:
 Name → anything
  Username → must end with bot like networkbot or monitoringbot
- 👉 You’ll get:

BOT TOKEN
 ⚠️ Save this (very important) donot share !
   Get Chat ID

Open browser:

https://api.telegram.org/bot<TOKEN>/getUpdates

- 👉 Replace <TOKEN>

Send message “hi” to your bot first

- 👉 You’ll see:

"chat":{"id":123456789}

- 👉 Copy that ID

## Use Case
Simulates real-world NOC monitoring system.

## Author
ARUN MAHATO (Network Engineer)
