#!/bin/bash -e

MIME=`file --brief --mime-type --dereference "${1}"`
case "${MIME}" in
"application/x-sharedlib"|"application/x-pie-executable"|"application/x-object")
        objdump -x "${1}"
        exit 0
        ;;

esac

exit 1
