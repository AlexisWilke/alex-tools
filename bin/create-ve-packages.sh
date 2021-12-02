#!/bin/sh -e
#
# Build the debian package
#
# This is very messy, so I run it in a separate folder named BUILD/packages


if test ! -d BUILD
then
    echo "error: run this script from the top git folder (within it)"
    echo "warning: you must run a bin/build <type> at least once"
    exit 1
fi

if test "`whoami`" = "root"
then
    echo "error: you can't run the build as root. When root is required, the scripts asks you your password."
    exit 1
fi

# Make sure all files are commited
#
if ! git diff-index --quiet HEAD --
then
    git status
    echo "***"
    echo "*** error: you have uncommited changes."
    echo "*** error: this could cause installation problems."
    echo "***"
    exit 1
fi

# Make sure all commits are pushed
#
if test "`git rev-parse @{u}`" != "`git rev-parse HEAD`"
then
    git status
    echo "***"
    echo "*** error: you have unpushed changes."
    echo "*** error: this could cause installation problems."
    echo "***"
    exit 1
fi

# Make sure we're up to date before building
#
echo "running \"git pull origin master\", it will ask you for your git key passphrase..."
git pull origin master



VE_PATH=`pwd`

# Restart from scratch
#
rm -rf ../BUILD/packages
mkdir ../BUILD/packages

# Next we update the movies in our local cache, if necessary.
#
# For now, I moved this to the ve-base.postinst, that way it also happens
# at the time we first install the controller files on a computer.
#bin/setup-movie-cache.sh

build() {
    NAME="$1"
    PACKAGE="$2"

    cd "${NAME}"
    VERSION=`dpkg-parsechangelog --show-field Version`
    echo "Building ${NAME} v${VERSION}"
    cd ..

    # Copy the source code
    cp -r ${NAME} ../BUILD/packages/${PACKAGE}-${VERSION}

    # Run the build
    cd ../BUILD/packages/${PACKAGE}-${VERSION}
    dpkg-buildpackage -us -uc

    # Restore the source folder
    cd ${VE_PATH}
}

# Build vecmakemodules
build cmake vecmakemodules

VECMAKE_VERSION=${VERSION}

# TODO: Look at using package registry instead, if that can be made to work here
#       See: https://docs.w3cub.com/cmake~3.15/manual/cmake-packages.7/#package-registry
echo
echo "warning: we have to install vecmakemodules_${VECMAKE_VERSION}_<ARCH>.deb"
echo "         However, if you are having trouble with a package, this will fail"
read -p "         again and again. Do you want to run this install? ([Y]/n) " run_install
if test "${run_install}" != "n" -a "${run_install}" != "N"
then
    echo
    echo "sudo will ask you for your password."
    echo
    sudo apt-get install ../BUILD/packages/vecmakemodules_${VECMAKE_VERSION}_*.deb
fi
echo
echo

# Build ve
build ve ve

VE_VERSION=${VERSION}

# Install the libve for ve-panel
# Note: the ve-config package is a pre-requisite so it has to be installed
#       before the ve-base package, on its own
#
echo
echo "warning: we have to install ve-config, ve-base & libve[-dev] packages"
echo "         to continue and dpkg may ask you for your password"
echo
sudo apt-get install ../BUILD/packages/ve-config_${VE_VERSION}_*.deb
sudo apt-get install ../BUILD/packages/ve-base_${VE_VERSION}_*.deb \
             ../BUILD/packages/libve_${VE_VERSION}_*.deb \
             ../BUILD/packages/libve-dev_${VE_VERSION}_*.deb
echo
echo

# Build ve-panel
build panel-ve panel-ve

# Now we can remove the packages from the dev. computer
echo
read -p "Do you want to remove the packages we just installed for the build? WARNING: THIS DELETES ALL YOUR LOCAL SETTINGS (y/[N]) " purge
if test "$purge" = "y" -o "$purge" = "Y"
then
    echo
    echo "warning: dpkg may ask you for your password"
    echo
    sudo dpkg -P vecmakemodules ve-base libve libve-dev
    sudo dpkg -P ve-config
fi

# As a developer you want to keep the system booting to your account
echo
read -p "Restore autologin to programmer's account (may ask for your sudo password)? (y/[N]) " restore_user
if test "$restore_user" = "y" -o "$restore_user" = "Y"
then
    sudo git config --file=/etc/gdm3/custom.conf daemon.AutomaticLogin $USER
fi

# vim: ts=4 sw=4 et
