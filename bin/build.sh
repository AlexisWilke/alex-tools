#!/bin/sh
#

if ! test atype.c
then
	echo "error: script must be run from within the alex-tools folder"
	exit 1
fi

if test "`whoami`" = "root"
then
    echo "error: you can't run the build as root. When root is required, the scripts asks you for your password."
    exit 1
fi

rm -rf BUILD

echo "info: *** build Debug ***"
echo
(
	mkdir -p BUILD/Debug/dist
	cd BUILD/Debug
	cmake -DCMAKE_BUILD_TYPE=Debug \
		-DCMAKE_INSTALL_PREFIX:PATH=dist \
		../..
	VERBOSE=1 make install
)

echo
echo "info: *** build Release ***"
echo
(
	mkdir -p BUILD/Release/dist
	cd BUILD/Release
	cmake -DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_INSTALL_PREFIX:PATH=dist \
		../..
	VERBOSE=1 make install
)

echo
echo "info: *** build package ***"
echo
(
	bin/create-packages.sh
)
