#!/system/bin/sh

# Copyright (C) 2026 chickendrop89
# SPDX-License-Identifier: GPL-3.0-only

# The problem is that OrangeFox doesn't understand that every time that 
# the switch brightness is set to 0 (when flashlight is turned off via button),
# the torch brightness is reset to 0 as well.
#
# And if the switch brightness is set to maximum (on flashlight button click),
# but the torch brightness is reset to 0 = nothing wil happen.
#
# This workaround creates a virtual torch brightness control node that 
# handles this extra step for OrangeFox, and makes the flashlight feature work.

BRIGHTNESS_LEVEL=430
VIRTUAL_TORCH_DIR=/tmp/of_torch
CONTROL_NODE=$VIRTUAL_TORCH_DIR/brightness
PREVIOUS_VAL=-1

rm -rf $VIRTUAL_TORCH_DIR
mkdir -p $VIRTUAL_TORCH_DIR
echo 0 > $CONTROL_NODE

chmod 666 $CONTROL_NODE
echo $BRIGHTNESS_LEVEL > $VIRTUAL_TORCH_DIR/max_brightness

while usleep 100000; do
    CURRENT_VAL=$(cat $CONTROL_NODE)

    [ -z "$CURRENT_VAL" ] || [ "$CURRENT_VAL" = "$PREVIOUS_VAL" ] && continue
    PREVIOUS_VAL=$CURRENT_VAL

    if [ "$CURRENT_VAL" -eq 0 ]; then
        echo 0 > /sys/class/leds/led:switch_0/brightness
    else
        echo $BRIGHTNESS_LEVEL > /sys/class/leds/led:torch_0/brightness
        echo 1 > /sys/class/leds/led:switch_0/brightness
    fi
done
