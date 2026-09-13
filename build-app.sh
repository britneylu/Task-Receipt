#!/bin/bash

set -e

APP_NAME="TaskReceipt"
BUILD_DIR=".build/release"
DIST_APP="dist/$APP_NAME.app"
CONTENTS_DIR="$DIST_APP/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"
APPLICATIONS_APP="/Applications/$APP_NAME.app"

echo "Building $APP_NAME..."

swift build -c release

echo "Creating app bundle..."

rm -rf "$DIST_APP"

mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

cp "$BUILD_DIR/$APP_NAME" "$MACOS_DIR/$APP_NAME"
cp "ReceiptIcon.icns" "$RESOURCES_DIR/ReceiptIcon.icns"

cat > "$CONTENTS_DIR/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">

<plist version="1.0">
<dict>

    <key>CFBundleName</key>
    <string>TaskReceipt</string>

    <key>CFBundleDisplayName</key>
    <string>TaskReceipt</string>

    <key>CFBundleExecutable</key>
    <string>TaskReceipt</string>

    <key>CFBundleIdentifier</key>
    <string>com.britney.taskreceipt</string>

    <key>CFBundlePackageType</key>
    <string>APPL</string>

    <key>CFBundleVersion</key>
    <string>1.0</string>

    <key>CFBundleShortVersionString</key>
    <string>1.0</string>

    <key>LSMinimumSystemVersion</key>
    <string>14.0</string>

    <key>CFBundleIconFile</key>
    <string>ReceiptIcon</string>

</dict>
</plist>
EOF

echo "Closing old version if it is running..."

osascript -e "tell application \"$APP_NAME\" to quit" 2>/dev/null || true

sleep 1

echo "Installing updated app..."

rm -rf "$APPLICATIONS_APP"

cp -R "$DIST_APP" "/Applications/"

echo "Launching updated app..."

open "$APPLICATIONS_APP"

echo ""
echo "Done!"
echo "$APP_NAME has been updated in Applications."