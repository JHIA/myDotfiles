#!/bin/bash

CARD="alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic"

# Mengecek status ketersediaan headset
HEADSET_STATUS=$(pactl list cards | grep -i "Headphones" | grep "available" | head -n 1 | awk '{print $NF}' | tr -d ')')

if [ "$1" == "speaker" ]; then
    pactl set-card-profile "$CARD" "HiFi (HDMI1, HDMI2, HDMI3, Mic1, Mic2, Speaker)"
    # -t 2000 artinya notifikasi akan hilang otomatis setelah 2 detik
    notify-send -t 2000 -i audio-speakers "Audio" "Mode Speaker Aktif"

elif [ "$1" == "headset" ]; then
    if [ "$HEADSET_STATUS" == "yes" ]; then
        pactl set-card-profile "$CARD" "HiFi (HDMI1, HDMI2, HDMI3, Headphones, Mic1, Mic2)"
        notify-send -t 2000 -i audio-headphones "Audio" "Mode Headset Aktif"
    else
        # Notifikasi gagal dengan durasi 2 detik
        notify-send -t 2000 -u critical -i dialog-error "Audio Gagal" "Headset tidak terdeteksi! Silakan colok dulu."
    fi
fi
