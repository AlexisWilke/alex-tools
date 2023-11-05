#!/bin/sh -e
#
# Quick rebuild

BUILD=false
PROCESSORS=`nproc`
TARGET=
TYPE=Debug
while test -n "$1"
do
	case "$1" in
	"--debug"|"-d")
		shift
		TYPE=Debug
		;;

	"--help"|"-h")
		echo "Usage: `basename $0` [--opts]"
		echo "  -d | --debug       build Debug version"
		echo "  -h | --help        print out this help screen"
		echo "  -i | --install     build & install"
		echo "  -b | --packages    build packages"
		echo "  -p | --processors  set the number used to compile in parallel"
		echo "  -r | --release     build the release version"
		exit 1
		;;

	"--install"|"-i")
		shift
		TARGET=install
		;;

	"--packages"|"-b")
		shift
		BUILD=true
		;;

	"--processors"|"-p")
		shift
		PROCESSORS="${1}"
		shift
		;;

	"--release"|"-r")
		shift
		TYPE=Release
		;;

	*)
		echo "error: unknown command line option: \"${1}\"."
		exit 1
		;;

	esac
done

make -j${PROCESSORS} -C BUILD/${TYPE} ${TARGET}

if $BUILD
then
	bin/create-packages.sh
fi

