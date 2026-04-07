#!/data/data/com.termux/files/usr/bin/bash
# ================================================
# Termux Headless Setup Script (No sudo needed)
# ================================================

set -e

echo "🔄 Updating packages..."
pkg update -y && pkg upgrade -y

echo "📦 Installing basic tools..."
pkg install -y \
  curl \
  wget \
  git \
  net-tools \
  openssh

# ---------------------------------------------
# SSH Setup (Termux style)
# ---------------------------------------------
echo "🔐 Setting up SSH..."

# Start SSH server
sshd

echo "🚀 SSH started on port 8022"

# Show IP
echo "📡 Your IP address:"
ip a

# ---------------------------------------------
# Install Tailscale (Termux method)
# ---------------------------------------------
echo "🌐 Installing Tailscale..."

pkg install -y tailscale

echo "🚀 Starting Tailscale..."
tailscaled &

echo "👉 Login Tailscale manually:"
echo "tailscale up"

# ---------------------------------------------
# Keep Termux Awake (Headless-like)
# ---------------------------------------------
echo "🛑 Preventing sleep..."

termux-wake-lock

echo "🔋 Wake lock enabled (device won't sleep)"

# ---------------------------------------------
# Final Status
# ---------------------------------------------
echo "--------------------------------------"
echo " INSTALLATION COMPLETE (TERMUX)"
echo "--------------------------------------"

echo "🔐 SSH:"
echo "Use: ssh user@<phone-ip> -p 8022"

echo "🌐 Tailscale:"
echo "Run: tailscale up"

echo ""
echo "🚀 Your Termux environment is:"
echo "✔ Updated"
echo "✔ SSH running (port 8022)"
echo "✔ Tailscale ready"
echo "✔ No sleep (wakelock enabled)"
echo "✔ Headless-friendly (mobile server)"
