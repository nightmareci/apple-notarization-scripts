#!/bin/sh

xcrun notarytool submit "$1" --keychain-profile AC_PASSWORD --wait
