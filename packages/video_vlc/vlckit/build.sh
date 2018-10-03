#!/bin/bash

export ANDROID_SDK="/opt/android-sdk-linux"
export ANDROID_NDK="/opt/android-ndk"
export OUTPUT_PATH="/mnt/lib"
export LIBVLC_VERSION="3.0.0"

cd vlc-android

# array=( "armeabi-v7a" "armeabi" "armeabi-nofpu" "armeabi-v5" "x86" "mips" )
array=( "armeabi-v7a" "x86" )

if [ "$1" != " " ]
then
  array=( $1 )
fi  


for element in ${array[@]}
do
  compile.sh -l -a $element -r
  mkdir -p ${OUTPUT_PATH}/$element
  mv /vlc-android/libvlc/build/outputs/aar/libvlc-${LIBVLC_VERSION}.aar ${OUTPUT_PATH}/$element/libvlc.aar
done

echo "Done!"
 


