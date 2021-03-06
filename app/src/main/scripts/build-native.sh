#!/bin/bash

# Exit on errors
set -e

export NDK_ROOT="/mnt/325E8FF25E8FACE3/install/LSofts/android-sdk-linux/ndk-bundle"
export NDK_PATH="/mnt/325E8FF25E8FACE3/install/LSofts/android-sdk-linux/ndk-bundle"
export PATH=$PATH:"/mnt/325E8FF25E8FACE3/install/LSofts/android-sdk-linux/ndk-bundle"

ndk-build NDK_LOG=1 $@
#NDK_DEBUG=1

if [ $? = 0 ]; then
	rm -rf openssllibs/

	cd libs
	mkdir -p ../openssllibs/assets
	for i in *
	do
		cp -v $i/gapps_exec ../openssllibs/assets/gapps_exec.$i
	done
    cp ../openssl/apps/openssl.cnf ../openssllibs/assets/openssl.cnf 

  	for arch in *
  	do
  	    builddir=../openssllibs/jniLibs/$arch
  	    mkdir -p $builddir
  		cp -v $arch/*.so  $builddir
  	done
else
    exit $?
fi
