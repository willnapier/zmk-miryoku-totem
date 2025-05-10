#!/bin/bash
# Build script for Totem keyboard with fixed overlay files
# This solves the side detection issue by properly setting the column offset

# Set up environment
cd "$(dirname "$0")"

# Define paths
ZMK_CONFIG_DIR="$(pwd)/config"
ZMK_APP_DIR="$(pwd)/zmk/app"
BUILD_DIR="$(pwd)/build"

# Clear previous builds
rm -rf $BUILD_DIR/left_fixed_overlay
rm -rf $BUILD_DIR/right_fixed_overlay
mkdir -p $BUILD_DIR/left_fixed_overlay
mkdir -p $BUILD_DIR/right_fixed_overlay

# Build left half with the standard Miryoku layout
echo "Building left half firmware with fixed overlay..."
west build -p -b seeeduino_xiao_ble -d "$BUILD_DIR/left_fixed_overlay" --source="$ZMK_APP_DIR" -- \
  -DSHIELD=totem_left \
  -DZMK_CONFIG="$ZMK_CONFIG_DIR" \
  -DKEYMAP_FILE="$ZMK_CONFIG_DIR/totem_miryoku.keymap" \
  -DCONFIG_BT_CTLR_TX_PWR_PLUS_2=y

if [ $? -eq 0 ]; then
  cp "$BUILD_DIR/left_fixed_overlay/zephyr/zmk.uf2" ~/Desktop/totem_left_fixed_overlay.uf2
  echo "✓ Left half firmware built successfully"
else
  echo "✗ Error building left half firmware"
  exit 1
fi

# Build right half with the standard Miryoku layout (overlay is now fixed)
echo "Building right half firmware with fixed overlay..."
west build -p -b seeeduino_xiao_ble -d "$BUILD_DIR/right_fixed_overlay" --source="$ZMK_APP_DIR" -- \
  -DSHIELD=totem_right \
  -DZMK_CONFIG="$ZMK_CONFIG_DIR" \
  -DKEYMAP_FILE="$ZMK_CONFIG_DIR/totem_miryoku.keymap" \
  -DCONFIG_BT_CTLR_TX_PWR_PLUS_2=y

if [ $? -eq 0 ]; then
  cp "$BUILD_DIR/right_fixed_overlay/zephyr/zmk.uf2" ~/Desktop/totem_right_fixed_overlay.uf2
  echo "✓ Right half firmware built successfully"
else
  echo "✗ Error building right half firmware"
  exit 1
fi

echo ""
echo "Build complete! Firmware files ready for flashing:"
echo "~/Desktop/totem_left_fixed_overlay.uf2  - For the LEFT half"
echo "~/Desktop/totem_right_fixed_overlay.uf2 - For the RIGHT half"
echo ""
echo "Installation Instructions:"
echo "1. Connect the left half to your computer"
echo "2. Enter bootloader mode by double-tapping reset button (press and hold for 5 seconds first if needed)"
echo "3. Flash totem_left_fixed_overlay.uf2 to the left half"
echo "4. Disconnect the left half"
echo ""
echo "5. Connect the right half to your computer" 
echo "6. Enter bootloader mode by double-tapping reset button (press and hold for 5 seconds first if needed)"
echo "7. Flash totem_right_fixed_overlay.uf2 to the right half"
echo "8. Disconnect the right half"
echo ""
echo "9. Power on both halves - they should pair automatically"
echo "10. If necessary, perform a reset as described in reset-instructions.md"