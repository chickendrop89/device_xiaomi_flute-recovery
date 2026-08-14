# device_xiaomi_flute-recovery

Recovery tree for this Xiaomi device
- Xiaomi Redmi Pad 2 Pro / Poco Pad M1 (codename: `flute`) (Late 2025)

## Device specifications
Device                  | Redmi Pad 2 Pro / Poco Pad M1
:-----------------------|:-------------------------------------
SoC                     | Qualcomm Snapdragon® 7s Gen 3 (SM7635-AC)
Board                   | `flute`
CPU                     | Octa-core (1x 2.7 GHz Cortex-A720 & 3x 2.4 GHz Cortex-A720 & 4x 1.8 GHz Cortex-A520)
GPU                     | Adreno 810
Memory                  | 8/12 GB RAM
Shipped Android Version | 15.0 (HyperOS 2)
Storage                 | 128/256 GB (UFS 2.2)
MicroSD                 | Yes
Battery                 | Non-removable Li-Po 12000 mAh
Dimensions              | 279.8 x 181.7 x 7.5 mm
Display                 | 12.1" IPS LCD, 120Hz, 1600x2560 (16:10)

## Checklist
- [x] ADB
- [x] Decryption
- [x] Touchscreen
- [x] FastbootD
- [x] Flashing
- [ ] Correct UI offsets
- [ ] MTP
- [x] Sideload
- [x] Backups
- [x] Filesystems/Mounts
- [x] Slot switch
- [x] Flashlight
- [x] Custom splash

## Notes
This device does not have SIM/eSIM, so TEE is used instead of Secure Element/StrongBox

```
vendor.gatekeeper.disable_spu=true
vendor.gatekeeper.is_security_level_spu=0
```

This may not be true for the 5G variant of Redmi Pad 2 Pro though. Testing is needed.

## How to build
This recovery tree was initially made for `flute`. For historical purposes,
build the `twrp_flute` target

```shell
lunch twrp_flute-ap2a-eng && mka adbd recoveryimage
```
