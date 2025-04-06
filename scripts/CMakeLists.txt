# Copyright (C) 2001-2021 by Alexis Wilke
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.


##############################
### scripts                ###
##############################

project(scripts)

install(
    PROGRAMS
        concat.sh
        extend-gpg-duration
        promote-vim-editor
        reset-hotkeys
        restart-pulseaudio
        restart-system-monitor-extension
        sane-tty

    DESTINATION
        bin
)

install(
    PROGRAMS
        lessfilter
        lessfilter-firewall.sh
        lessfilter-on-mimetype.sh

    DESTINATION
        share/alex-tools/skel
)


# vim: ts=4 sw=4 et nocindent
