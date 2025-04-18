#
# Copyright (C) 2023 LibreMobileOS Foundation
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/daria/zahedan

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_DUP_SYSPROP := true
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_dlkm

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := mt6877
TARGET_NO_BOOTLOADER := true

# Boot Image
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x07c08000
BOARD_RAMDISK_OFFSET := 0x11088000
BOARD_DTB_OFFSET := 0x07c08000

BOARD_BOOT_HEADER_VERSION := 2
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2

BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --board ""

# Display
TARGET_SCREEN_DENSITY := 440
TARGET_HAS_MTK_SURFACEFLINGER := true

# FM Radio
BOARD_HAVE_MTK_FM := true

# Filesystem
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/daria/mt6877
TARGET_KERNEL_CONFIG := k6877v1_64_k419_defconfig
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CLANG_VERSION := r416183b
TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/kernel/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-gnu-
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_CUSTOM_DTBOIMG_MK := $(DEVICE_PATH)/dtbo/dtbo.mk
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_KERNEL_IMAGE_NAME := Image.gz

# Lineage Health
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_PATH := /sys/devices/platform/charger/cmd_charge_disable
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_ENABLED := 0
TARGET_HEALTH_CHARGING_CONTROL_CHARGING_DISABLED := 1

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072                # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 41943040
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SUPER_PARTITION_SIZE := 7516192768
BOARD_USERDATAIMAGE_PARTITION_SIZE := 247027695616
BOARD_USES_METADATA_PARTITION := true

BOARD_SUPER_PARTITION_GROUPS := mtk_dynamic_partitions
BOARD_MTK_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm
BOARD_MTK_DYNAMIC_PARTITIONS_SIZE := 7511998464 # BOARD_SUPER_PARTITION_SIZE - 4MB

# Reserve space for gapps install
-include vendor/lmodroid/config/BoardConfigReservedSize.mk

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# Platform
TARGET_BOARD_PLATFORM := mt6877
BOARD_HAS_MTK_HARDWARE := true

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6877

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Sepolicy
include device/mediatek/sepolicy_vndr/SEPolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private

# SPL
VENDOR_SECURITY_PATCH := 2024-03-05

# Verified Boot
BOARD_AVB_ENABLE := true
ifneq ($(strip $(TARGET_BUILD_VARIANT)), user)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
endif
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := product system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS := --hash_algorithm sha256
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS := --hash_algorithm sha256

BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 4
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS := --hash_algorithm sha256
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS := --hash_algorithm sha256

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
DEVICE_MATRIX_FILE += $(DEVICE_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE := \
    $(DEVICE_PATH)/framework_compatibility_matrix.xml \
    vendor/lmodroid/config/device_framework_matrix.xml

# VNDK
BOARD_VNDK_VERSION := current

# Wifi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_DRIVER_FW_PATH_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA := "STA"
WIFI_DRIVER_FW_PATH_AP := "AP"
WIFI_DRIVER_FW_PATH_P2P := "P2P"
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_STATE_ON := "1"
WIFI_DRIVER_STATE_OFF := "0"
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true

# Inherit the proprietary files
include vendor/daria/zahedan/BoardConfigVendor.mk
