#!/bin/bash

RELEASE=v19.07.6
SOURCES=./openwrt-src


CORE_COUNT=$(nproc)
PADHDR_PATH=/usr/bin/uimage_padhdr

if [ ! -f $PADHDR_PATH ]; then
	echo "Copying padhdr executable..."
	sudo cp ./files/uimage_padhdr $PADHDR_PATH
	sudo chmod +x $PADHDR_PATH
else
	echo "Found padhdr in system"
fi


if [ -d $SOURCES ]; then
	echo "Deleting sources directory"
	rm -rf $SOURCES
fi

echo "Getting OpenWRT sources..."
mkdir $SOURCES
cd $SOURCES
git init
git remote add origin https://github.com/openwrt/openwrt
git fetch --tags
git checkout $RELEASE

echo "Applying patches..."
git apply ../files/dir-2660.patch

echo "Applying config..."
cp ../files/diffconfig .config
make defconfig

echo "Starting the build process with $CORE_COUNT threads..."
make -j$CORE_COUNT

if [ -d ./bin/targets/ramips/mt7621 ]; then
	cd ./bin/targets/ramips/mt7621
	if [ -f openwrt-ramips-mt7621-dir-2660-a1-squashfs-factory.bin ]; then
		echo "Copying factory file..."
		cp openwrt-ramips-mt7621-dir-2660-a1-squashfs-factory.bin ../../../../..
	else
		echo "Factory file does not exist, probably build process failed"
	fi

	if [ -f openwrt-ramips-mt7621-dir-2660-a1-squashfs-sysupgrade.bin ]; then
                echo "Copying sysupgrade file..."
		cp openwrt-ramips-mt7621-dir-2660-a1-squashfs-sysupgrade.bin ../../../../..
        else
                echo "Sysupgrade file does not exist, probably build process failed"
        fi
else
	echo "Bin directory does not exist, probably build process failed"
fi

