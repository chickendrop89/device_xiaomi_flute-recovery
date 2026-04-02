#!/system/bin/sh

# Copyright (C) 2026 chickendrop89
# SPDX-License-Identifier: GPL-3.0-only

LOGMSG() {
	echo "I:$1" >> /tmp/recovery.log;
}

do_prop_cleanup() {
    LOGMSG "Resetting SPL date back to original value..."

    resetprop ro.build.version.security_patch $(resetprop twrp.temp.security_patch)
    resetprop ro.vendor.build.security_patch $(resetprop twrp.temp.security_patch)

    resetprop -d twrp.temp.security_patch 
}

do_prop_cleanup;
exit 0;
