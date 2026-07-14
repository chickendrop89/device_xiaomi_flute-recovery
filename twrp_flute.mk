# Copyright (C) 2025-2026 OrangeFox Recovery Project
# Copyright (C) 2026 chkndrp
# SPDX-License-Identifier: GPL-3.0-only

# Inherit from these configurations
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from device configuration
$(call inherit-product, device/xiaomi/flute/device.mk)

# Inherit from TWRP common configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Import OrangeFox specifics
$(call inherit-product, device/xiaomi/flute/fox_flute.mk)

## Device identifier
PRODUCT_DEVICE := flute
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Pad 2 Pro / Poco Pad M1
PRODUCT_MANUFACTURER := $(PRODUCT_BRAND)
PRODUCT_NAME := twrp_${PRODUCT_DEVICE}
