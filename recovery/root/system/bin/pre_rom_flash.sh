#!/system/bin/sh

# Copyright (C) 2024 The OrangeFox Recovery Project
# Copyright (C) 2026 chickendrop89
# SPDX-License-Identifier: GPL-3.0-only

LOGMSG() {
	echo "I:$1" >> /tmp/recovery.log;
}

do_prep() {
	directory=/data/cache/recovery/;

	if [ ! -d $directory ]; then
		LOGMSG "Creating $directory ...";
		mkdir -p $directory;
	fi

	mount /metadata 2>/dev/null;

	metadata_ota=/metadata/ota;
	if [ ! -d $metadata_ota ]; then
		LOGMSG "Creating $metadata_ota ...";
		mkdir -p $metadata_ota;
	fi
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
do_prep;
backup_fox "$@";
exit 0;
