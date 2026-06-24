#!/system/bin/sh

# Copyright (C) 2024 The OrangeFox Recovery Project
# Copyright (C) 2026 chickendrop89
# SPDX-License-Identifier: GPL-3.0-only

LOGMSG() {
	echo "I:$1" >> /tmp/recovery.log;
}

do_prop_prep() {
    LOGMSG "Resetting SPL date to prevent data wipe..."
    resetprop twrp.temp.security_patch "$(resetprop ro.build.version.security_patch)"

    resetprop ro.build.version.security_patch 2025-09-02
    resetprop ro.vendor.build.security_patch 2025-09-02

    LOGMSG "Setting verified boot state to orange to prevent OTA rejection..."
    resetprop ro.boot.verifiedbootstate orange
}

backup_fox() {
	file=$1;

	if [ -f "$file" ]; then
		x=$(unzip -lq "$file" | grep "payload.bin");
		[ -n "$x" ] && return; # standard payload.bin - no need for a backup
	fi

	source="/dev/block/bootdevice/by-name/recovery";
	destination="/tmp/fox_backup.img";

	if [ ! -f $destination ]; then
		LOGMSG "Backing up OrangeFox to \"$destination\"...";
		dd bs=1048576 if=$source of=$destination >/dev/null 2>&1;
	fi
}

LOGMSG "Running pre-ROM-flash script...";
do_prop_prep;
backup_fox "$@";
exit 0;
