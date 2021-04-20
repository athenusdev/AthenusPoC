#!/bin/bash

xcodebuild build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
mkdir Payload
mv build/Release-iphoneos/Athenus.app Payload/
zip -r Payload.ipa Payload
rm -rf Payload
xcodebuild clean
