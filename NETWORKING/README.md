# 📜 DHCP Server Configuration README

## 🎯 Project Overview

Hi Dosto ! this project for how dhcp work how its assign ip to connected device, in this project i use 1 switch and two device with 2 diffrent vlan that helps you to understand vlan and dhcp concept both .This project implements a **Dynamic Host Configuration Protocol (DHCP)** server to automatically assign IP addresses and other network configuration parameters (like subnet mask, default gateway) to client devices for two dipartment. The server is configured to serve clients across a local network segment connected via a switch.Here i created 2 vlan and assign ip to both vlan interface and act like two diffrent network.To learn your self add hub and replace with laptop and chech dhcp work or not.!make sure ip config in dynamic in pc or laptop.



## 📁 Attached File (Packet Tracer Topology)

The network topology and device configurations for this project are saved in the following file:

* **File Name:** `DHCPSERVERSWITCH.pkt`
* **Application:** Cisco Packet Tracer 

---

## 💻 Network Topology Summary

The network consists of the following key components:

1.  **DHCP Server:** A dedicated server with a **static IP address** configured to run the DHCP service.
2.  **Switch(es):** One Layer 3 switches connecting the DHCP server and the client devices.
3.  **Client Devices:** PCs, laptops, or other end devices configured to obtain their network settings automatically via DHCP.

---

## 🛠️ Configuration Details

### 1. DHCP Server Configuration

* **Network Address:** `[192.168.10.0]` #vlan 10 same do with vlan 20
* **Subnet Mask:** `[255.255.255.0]`
* **Default Gateway:** `192.168.10.1]`
* **DHCP Service Status:** **ON**
Running configuration atteched 
***Please Follow***