#!/bin/sh

rm -rf build output
mkdir build output

sh ./AppAuth-iOS/universal_build.sh 
sh ./gtm-session-fetcher/GTMSessionFetcher/universal_build.sh 
sh ./GTMAppAuth/universal_build.sh

echo "Fat Framework Built All: ./output"

open output