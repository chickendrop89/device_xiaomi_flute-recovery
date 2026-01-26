#!/system/bin/sh

# Copyright (C) 2026 chickendrop89
# SPDX-License-Identifier: GPL-3.0-only

# Load batterysecret, and touch drivers/services if they didn't load properly

MODULES_DIR="/vendor/lib/modules"
QCOM_BATTERY_DIR="/sys/class/qcom-battery"

DRIVERS="panel_event_notifier xiaomi_touch focaltech_ft8208 nt36532_spi"
TOUCH_SVC_STATUS=$(getprop init.svc.touchfeature-service)

( # For batterysecret (async)
    while [ ! -d "$QCOM_BATTERY_DIR" ]; 
        do sleep 1
    done
    setprop vendor.qcom_battery.initialized true
) &

for d in $DRIVERS;
    do
        lsmod | grep -q "^$d" && continue
        path=$(find "$MODULES_DIR" -name "$d.ko" | head -n 1)
        if [ -f "$path" ]; 
            then 
                insmod "$path"
                echo "Force inserted module: $d" >> /tmp/recovery.log
        fi
done

if [ "$TOUCH_SVC_STATUS" != "running" ]; 
    then 
        setprop ctl.start touchfeature-service
        echo "Forced touchscreen service start" >> /tmp/recovery.log
fi

exit 0
