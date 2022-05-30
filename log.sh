#!/bin/sh

xcrun notarytool log "$1" --keychain-profile AC_PASSWORD
