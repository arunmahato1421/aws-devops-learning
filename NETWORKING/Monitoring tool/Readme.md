
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
- Get Chat ID

Open browser:

https://api.telegram.org/bot<TOKEN>/getUpdates

- 👉 Replace <TOKEN>

Send message “hi” to your bot first

- 👉 You’ll see:

"chat":{"id":123456789}

- 👉 Copy that ID

## Use Case
Simulates real-world NOC monitoring system.

---

<!-- =============================== -->
<!-- 🧊  DIAGRAM -->
<!-- =============================== -->

## 🧊 **TELEGRAM BOT MONITERING Architecture (Practice)**

<p align="center">
  <img src="https://github.com/arunmahato1421/aws-devops-learning/blob/1eabf1728083063606cea4dc58337d9cfa946cba/NETWORKING/Monitoring%20tool/ChatGPT%20Image%20May%203%2C%202026%2C%2011_55_26%20PM.png" width="720" />
</p>

---

---

<!-- =============================== -->
<!-- 🧊 EVE-NG -->
<!-- =============================== -->

## 🧊 **EVE-NG SNAP**

<p align="center">
  <img src="https://github.com/arunmahato1421/aws-devops-learning/blob/fe3b50e515579730f9534ecf8fce34057e705c46/NETWORKING/Monitoring%20tool/Screenshot%202026-05-04%20000014.png" width="720" />
</p>

---

---

<!-- =============================== -->
<!-- 🧊 TELEGRAM DIAGRAM -->
<!-- =============================== -->

## 🧊 **TELEGRAM NOTIFICATION **

<p align="center">
  <img src="https://github.com/arunmahato1421/aws-devops-learning/blob/fe3b50e515579730f9534ecf8fce34057e705c46/NETWORKING/Monitoring%20tool/1000581333.jpg" width="720" />
</p>

---


## Author
ARUN MAHATO (Network Engineer)
