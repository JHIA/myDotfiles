#!/bin/sh

# Cek apakah bluetooth dalam keadaan mati (Soft blocked)
if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
    echo "%{T2}󰂲%{T-}"
else
    # Jika nyala, cek apakah ada perangkat yang terhubung
    if bluetoothctl info | grep -q "Connected: yes"; then
        # Mengambil nama perangkat yang terhubung (opsional)
        device_name=$(bluetoothctl info | grep "Name" | cut -d ' ' -f 2-)
        echo "%{T2}󰂰%"
    else
        echo "%{T2}󰂯"
    fi
fi
