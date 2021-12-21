#!/bin/sh -e
#
# Build the debian package
#
# This is very messy, so I run it in a separate folder named BUILD/Packages


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

rm -rf BUILD/Packages

VERSION=`dpkg-parsechangelog --show-field Version`
echo "Building alex-tools v${VERSION}"
mkdir -p BUILD/Packages/alex-tools_${VERSION}
cp -r *.* debian tools scripts BUILD/Packages/alex-tools_${VERSION}
cd BUILD/Packages/alex-tools_${VERSION}
dpkg-buildpackage -us -uc

# vim: ts=4 sw=4 et
