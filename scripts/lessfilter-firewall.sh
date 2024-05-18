#!/bin/bash -e

# This is a cool feature but at this point I'd rather use my showfw script
# See: https://github.com/m2osw/iplock/blob/main/scripts/showfw
#
# Also this extension requires us to have an actual file named "firewall"
#
#     sudo touch /etc/network/firewall
#     less /etc/network/firewall
#
#if test "`basename $1`" = "firewall"
#then
#        sudo iptables -L -nvx
#        exit 0
#fi

exit 1
