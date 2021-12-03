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
make install
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
make install
)

echo
echo "info: *** build package ***"
echo
(
VERSION=`dpkg-parsechangelog --show-field Version`
echo "Building alex-tools v${VERSION}"
mkdir -p BUILD/Packages/alex-tools_${VERSION}
cp -r *.* debian BUILD/Packages/alex-tools_${VERSION}
cd BUILD/Packages/alex-tools_${VERSION}
dpkg-buildpackage -us -uc

)
