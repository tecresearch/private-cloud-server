#!/bin/bash
# ================================================
# Headless Ubuntu Server WiFi + Tailscale Setup
# ================================================

# USER SETTINGS
USER="tecresearch"  # your Ubuntu username
WIFIS=(
  "Abhishek nishad :67894512:12"
  "TCA_SERVER:12345678@b:10"
  "OPPO A54:YOUR_PASSWORD:8"
)
# Format: SSID:PASSWORD:PRIORITY

# ---------------------------------------------
# Function to create or fix WiFi connection
# ---------------------------------------------
setup_wifi() {
  local ssid="$1"
  local password="$2"
  local priority="$3"

  # Check if a connection already exists
  conn_uuid=$(nmcli -t -f NAME,UUID connection show | grep "^$ssid:" | cut -d':' -f2)

  if [ -z "$conn_uuid" ]; then
    echo "Creating WiFi connection for $ssid..."
    nmcli device wifi connect "$ssid" password "$password" name "$ssid"
    conn_uuid=$(nmcli -t -f NAME,UUID connection show | grep "^$ssid:" | cut -d':' -f2)
  else
    echo "Connection $ssid exists, fixing auto-connect..."
    nmcli connection modify "$conn_uuid" connection.autoconnect yes
  fi

  # Set priority and remove restrictions
  nmcli connection modify "$conn_uuid" connection.autoconnect-priority "$priority"
  nmcli connection modify "$conn_uuid" connection.permissions ""
}

# ---------------------------------------------
# Configure all WiFi networks
# ---------------------------------------------
for entry in "${WIFIS[@]}"; do
  IFS=":" read -r ssid password priority <<< "$entry"
  setup_wifi "$ssid" "$password" "$priority"
done

# ---------------------------------------------
# Enable Tailscale service to start at boot
# ---------------------------------------------
echo "Enabling Tailscale..."
sudo systemctl enable --now tailscaled

# ---------------------------------------------
# Verify status
# ---------------------------------------------
echo "Current WiFi connections and autoconnect:"
nmcli connection show | grep -E "$(IFS='|'; echo "${WIFIS[*]%%:*}")"

echo "Tailscale status:"
tailscale status

echo "Setup complete. Server is headless-ready!"
