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

