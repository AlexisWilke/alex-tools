# Copyright (C) 2001-2022 by Alexis Wilke
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
### vim addons             ###
##############################

project(vim-addons)

install(
    FILES
        vimrc

    DESTINATION
        share/alex-tools/skel
)

install(
    DIRECTORY
        plugin

    DESTINATION
        share/vim/addons
)

install(
    DIRECTORY
        syntax

    DESTINATION
        share/vim/addons
)


# vim: ts=4 sw=4 et nocindent
