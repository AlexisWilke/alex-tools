#!/bin/sh -e
#
# Build the debian package
#
# This is very messy, so I run it in a separate folder named BUILD/Packages


if ! test -f debian/changelog
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

PROJECT=alex-tools
VERSION=`dpkg-parsechangelog --show-field Version`
echo "Building ${PROJECT} v${VERSION}"

# Prepare source with correct directory name
mkdir -p BUILD/Packages/${PROJECT}_${VERSION}
tar --create --exclude-vcs-ignores --file=- . | tar --directory="BUILD/Packages/${PROJECT}_${VERSION}" --extract --file=-

# Actually run a build
cd BUILD/Packages/${PROJECT}_${VERSION}
dpkg-buildpackage -us -uc

# vim: ts=4 sw=4 et
