import os
import requests
from datetime import datetime

ip_list = ["192.168.220.100", "8.8.8.8"]
BOT_TOKEN = "your token"
CHAT_ID = "chat id"

def send_alert(message):
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    data = {"chat_id": CHAT_ID, "text": message}
    requests.post(url, data=data)

for ip in ip_list:
    response = os.system(f"ping -c 1 {ip} > /dev/null 2>&1")
    time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    if response == 0:
        print(f"{ip} is UP")
        msg = f"🚨 ALERT: {ip} is UP at {time}"
        send_alert(msg)
    else:
        msg = f"🚨 ALERT: {ip} is DOWN at {time}"
        print(msg)
        send_alert(msg)
