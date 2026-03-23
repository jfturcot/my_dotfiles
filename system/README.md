# System Configuration Backups

These are system-level configuration files that require `sudo` to install.

## WiFi Fix (Qualcomm QCNFA765 / ath11k)

Fixes for unreliable WiFi and post-suspend connectivity issues on ThinkPad T14 AMD and similar devices.

### Install

```bash
# NetworkManager power save (disables power save for better latency)
sudo cp ~/.dotfiles/system/etc/NetworkManager/conf.d/wifi-powersave.conf /etc/NetworkManager/conf.d/

# Suspend/resume WiFi module reset
sudo mkdir -p /etc/systemd/system-sleep
sudo cp ~/.dotfiles/system/etc/systemd/system-sleep/reset-wifi-module.sh /etc/systemd/system-sleep/
sudo chmod +x /etc/systemd/system-sleep/reset-wifi-module.sh

# Apply changes
sudo systemctl restart NetworkManager
```

### Verify

```bash
# Check power save is off
iw dev wlp2s0 get power_save

# After suspend/resume, check logs
journalctl | grep "Reset-WiFi-Module-Script"
```
