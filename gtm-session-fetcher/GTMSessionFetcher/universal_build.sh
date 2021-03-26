#!/bin/sh

set -e

SUPPORTED_PLATFORMS="iphoneos iphonesimulator"
PROJECT_NAME="GTMSessionFetcher"
CONFIGURATION="Release"
CURRENT_WORKING_DIR=$( cd "$(dirname "$0")" ; pwd )
BUILD_DIR="${CURRENT_WORKING_DIR}/../../build"
OUTPUT_DIR="${CURRENT_WORKING_DIR}/../../output"

cd ${CURRENT_WORKING_DIR}
 
xcodebuild -target "${PROJECT_NAME}" -configuration "${CONFIGURATION}" -sdk "iphoneos" \
  ENABLE_BITCODE=YES ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" SYMROOT="${BUILD_DIR}" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO build

xcodebuild -target "${PROJECT_NAME}" -configuration "${CONFIGURATION}" -sdk "iphonesimulator" \
  ARCHS="i386 x86_64" ENABLE_BITCODE=YES ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" SYMROOT="${BUILD_DIR}" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO build
 
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${BUILD_DIR}/"
 
lipo -create -output "${BUILD_DIR}/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
  "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}" \
  "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}"

cp -R "${BUILD_DIR}/${PROJECT_NAME}.framework" "${OUTPUT_DIR}/"

echo "Fat Framework Built : ${OUTPUT_DIR}/${PROJECT_NAME}.framework"
