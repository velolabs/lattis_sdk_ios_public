#!/bin/sh

rm -rf .build/
mkdir -p .build

xcodebuild archive -scheme LattisSDK -archivePath ".build/ios.xcarchive" -sdk iphoneos SKIP_INSTALL=NO

xcodebuild archive -scheme LattisSDK -archivePath ".build/ios_sim.xcarchive" -sdk iphonesimulator SKIP_INSTALL=NO

xcodebuild -create-xcframework \
    -framework ".build/ios.xcarchive/Products/Library/Frameworks/LattisSDK.framework" \
    -framework ".build/ios_sim.xcarchive/Products/Library/Frameworks/LattisSDK.framework" \
    -output ".build/LattisSDK.xcframework"

# rm -rf .build/ios.xcarchive
# rm -rf .build/ios_sim.xcarchive


