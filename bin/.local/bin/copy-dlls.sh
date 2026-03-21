#!/bin/bash

read -p 'Copy Dlls From (TeamCity Build Folder e.g, Folder/Service: ' sourceDir
read -p 'Copy Dlls To (Local Folder e.g, Provider/Shared: ' currentDir

sourceDir=${sourceDir/#~/$HOME}
currentDir=${currentDir/#~/$HOME}

if ! cd $sourceDir; then
  echo "sourceDir ($sourceDir) not found" >&2
  exit 1
fi

if ! cd $currentDir; then
  echo "currentDir not found" >&2
  exit 1
fi

mkdir -p "$currentDir/CopiedDlls"

for file in "$currentDir"/*; do
  fileName=${file##*/}
  if [ "$fileName" == "CopiedDlls" ]; then
    continue
  fi
  if [ -f $sourceDir/$fileName ]; then
    cp -v "$sourceDir/$fileName" "$currentDir/CopiedDlls/"
    echo "Copied $fileName from $sourceDir to $currentDir"
  else
    echo "Unable to find and copy $fileName in $sourceDir"
  fi
done

#find "$currentDir/" "$sourceDir/" -printf '%P\n' | sort | cp uniq -d
