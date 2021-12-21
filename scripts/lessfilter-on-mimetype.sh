#!/bin/bash -e

MIME=`file --brief --mime-type "${1}"`
case "${MIME}" in
"application/x-sharedlib")
        objdump -x "${1}"
        exit 0
        ;;

esac

exit 1
