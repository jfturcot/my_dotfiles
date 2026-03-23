#!/bin/bash
# Reset WiFi module on suspend/resume to fix connectivity issues

case $1 in
    pre)
        logger "Reset-WiFi-Module-Script: Unloading ath11k_pci before suspend"
        modprobe -r ath11k_pci
        ;;
    post)
        logger "Reset-WiFi-Module-Script: Reloading ath11k_pci after resume"
        modprobe ath11k_pci
        ;;
esac
