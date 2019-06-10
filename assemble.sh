#!/bin/sh
# Builds the utest script using spp.
# Copyright (C) 2019 Michael Federczuk
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

if \echo "$-" | \grep -E i; then
	\echo "assemble.sh: script was called interactively" >&2
	\return 124
fi

if ! command -v 'spp' 1>/dev/null; then
	echo "$0: program 'spp' is required to call this script" >&2
	exit 48
fi

basefile='src/base.sh'
outfile='test'

echo "Building file '$outfile' ..."
if ! spp "$basefile" 1> "$outfile"; then
	exc=$?
	echo "$0: failed building file" >&2
	return $exc
else
	chmod +x "$outfile"
	echo "Successfully built file"
	return 0
fi