#!/bin/bash -e

# This is a cool feature but at this point I'd rather use my showfw script
# (i.e. less /etc/network/firewall would output iptables -L ...)
# Also this requires us to have an actual file named "firewall" somewhere
#
#if test "`basename $1`" = "firewall"
#then
#        sudo iptables -L -nvx
#        exit 0
#fi

exit 1
