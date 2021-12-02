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
### atype                  ###
##############################

project(atype)

add_executable(${PROJECT_NAME}
    atype.c
)

install(
    TARGETS
        ${PROJECT_NAME}

    RUNTIME DESTINATION
        bin
)


##############################
### cleanrc                ###
##############################

project(cleanrc)

add_executable(${PROJECT_NAME}
    cleanrc.c
)

install(
    TARGETS
        ${PROJECT_NAME}

    RUNTIME DESTINATION
        bin
)


##############################
### hex                    ###
##############################

project(hex)

add_executable(${PROJECT_NAME}
    hex.c
)

install(
    TARGETS
        ${PROJECT_NAME}

    RUNTIME DESTINATION
        bin
)


##############################
### poke                   ###
##############################

project(poke)

add_executable(${PROJECT_NAME}
    poke.c
)

install(
    TARGETS
        ${PROJECT_NAME}

    RUNTIME DESTINATION
        bin
)




# vim: ts=4 sw=4 et nocindent
