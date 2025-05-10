# Totem Keyboard with Miryoku Layout

This repository contains a working configuration for the Totem keyboard with the Miryoku layout, with a specific fix for the side detection issue found in ZMK firmware.

## Key Features

- Full Miryoku layout implementation for the Totem keyboard
- Fixed side detection for proper key matrix mapping
- Bluetooth Low Energy (BLE) support
- Simple build script to generate firmware files

## Quick Start

1. Clone this repository
2. Run `./build_fixed_overlay.sh` to build the firmware
3. Flash the generated UF2 files to each half of your Totem keyboard
4. Follow the reset instructions in reset-instructions.md

## Important Files

- `config/boards/shields/totem/`: Shield configuration for the Totem keyboard
  - `totem_left.overlay` and `totem_right.overlay`: Define the hardware pins and matrix configuration
  - `totem.dtsi`: Contains the key matrix transform mapping
- `config/totem_miryoku.keymap`: The main keymap file with the Miryoku layout
- `build_fixed_overlay.sh`: Script to build firmware with the side detection fix

## Side Detection Fix

The key fix in this repository is the `col-offset = <5>;` configuration in the right half overlay file, which ensures that keys from the right half are properly mapped to the correct logical positions in the keymap.