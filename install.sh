#!/bin/bash
# ================================================
# FINAL Ubuntu Headless Server Setup Script
# ================================================

set -e

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing basic tools..."
sudo apt install -y \
  curl \
  wget \
  git \
  net-tools \
  ca-certificates \
  gnupg \
  lsb-release

# ---------------------------------------------
# Install and Enable SSH
# ---------------------------------------------
echo "🔐 Installing OpenSSH..."
sudo apt install -y openssh-server

echo "🚀 Enabling SSH..."
sudo systemctl enable --now ssh

# ---------------------------------------------
# Install and Configure Firewall (UFW)
# ---------------------------------------------
echo "🔥 Installing UFW..."
sudo apt install -y ufw

echo "⚙ Configuring firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow required ports
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

sudo ufw --force enable

# ---------------------------------------------
# Install Tailscale
# ---------------------------------------------
echo "🌐 Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo "🚀 Enabling Tailscale..."
sudo systemctl enable --now tailscaled

# ---------------------------------------------
# Disable Sleep / Suspend (Headless Mode)
# ---------------------------------------------
echo "🛑 Disabling sleep and suspend..."

sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

sudo sed -i 's/^#HandleSuspendKey=.*/HandleSuspendKey=ignore/' /etc/systemd/logind.conf
sudo sed -i 's/^#HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sudo sed -i 's/^#HandleHibernateKey=.*/HandleHibernateKey=ignore/' /etc/systemd/logind.conf

sudo systemctl restart systemd-logind

# ---------------------------------------------
# Final Status Check
# ---------------------------------------------
echo "--------------------------------------"
echo "✅ INSTALLATION COMPLETE"
echo "--------------------------------------"

echo "🔐 SSH status:"
systemctl is-active ssh

echo "🔥 Firewall status:"
sudo ufw status

echo "🌐 Tailscale status:"
tailscale status || true

echo ""
echo "👉 NEXT STEPS:"
echo "1. Run WiFi setup: sudo ./headless.sh"
echo "2. Login Tailscale: tailscale up"
echo "3. Reboot test: sudo reboot"

echo ""
echo "🚀 Your server is now:"
echo "✔ Fully updated"
echo "✔ SSH enabled"
echo "✔ Firewall secured"
echo "✔ Tailscale ready"
echo "✔ No sleep (24/7 running)"
echo "✔ Ready for headless operation"
