# Headless Ubuntu Private Server Setup

A complete setup for running an **Ubuntu server in headless mode** with:

* Automatic WiFi connection
* Secure remote access (SSH)
* Firewall protection
* Tailscale VPN for remote connectivity
* No sleep / always-on system

---

## 📦 Features

* 🔄 Fully updated system (`apt update && upgrade`)
* 🔐 SSH enabled for remote access
* 🔥 Firewall (UFW) configured with essential ports:

  * 22 (SSH)
  * 80 (HTTP)
  * 443 (HTTPS)
* 🌐 Tailscale installed and auto-start enabled
* 📶 WiFi auto-connect (via `headless.sh`)
* 🛑 Sleep / suspend disabled (24/7 uptime)
* 🧠 Works without auto-login (true headless setup)

---

## 🛠️ Setup Files

### 1. `install.sh`

Handles:

* System update & upgrade
* Package installation
* SSH setup
* Firewall configuration
* Tailscale installation
* Disable sleep

### 2. `headless.sh`

Handles:

* WiFi configuration
* Auto-connect setup
* Priority-based network switching

---

## ⚡ Installation Steps

### 1️⃣ Clone or copy scripts

```bash
git clone https://github.com/tecresearch/headless-server
cd headless-server
```

Or manually copy:

* `install.sh`
* `headless.sh`

---

### 2️⃣ Make scripts executable

```bash
chmod +x install.sh
chmod +x headless.sh
```

---

### 3️⃣ Run installation

```bash
sudo ./install.sh
```

---

### 4️⃣ Configure WiFi

```bash
sudo ./headless.sh
```

---

### 5️⃣ Login to Tailscale

```bash
tailscale up
```

* Open the provided URL on your phone/PC
* Authenticate once

---

### 6️⃣ Reboot and test

```bash
sudo reboot
```

---

## Expected Result

After reboot:

* 📶 WiFi connects automatically
* 🌐 Tailscale starts automatically
* 🔐 SSH is accessible
* 🛑 System never sleeps
* 💻 No login required for networking

---

## 🔍 Verification Commands

Check WiFi:

```bash
nmcli device status
```

Check Tailscale:

```bash
tailscale status
```

Check firewall:

```bash
sudo ufw status
```

Check sleep disabled:

```bash
systemctl status sleep.target
```

---

## 🧠 Notes

* WiFi SSIDs with spaces must be quoted:

  ```bash
  "SSID:PASSWORD:PRIORITY" Update in headless.sh file
  ```
* System works **even with auto-login disabled**
* Tailscale requires **one-time login only**

---

## 🔐 Security

* UFW blocks all incoming connections except allowed ports
* SSH enabled for secure remote access
* No GUI auto-login required
* Works safely in headless environments

---

## 🚀 Future Improvements (Optional)

* Docker installation
* Fail2Ban (SSH protection)
* Auto updates
* Monitoring dashboard

---

## 👨‍💻 Author

**Developed by Mr. Brijesh Nishad**

---

## ⭐ Usage

Perfect for:

* Home server
* Remote development machine
* Always-on IoT / lab setup
* Low-power headless systems

---

** Your server is now fully headless, secure, and always online!**
