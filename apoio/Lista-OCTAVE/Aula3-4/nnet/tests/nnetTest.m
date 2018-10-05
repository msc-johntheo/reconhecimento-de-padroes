## Copyright (C) 2008 Michel D. Schmid <michaelschmid@users.sourceforge.net>
##
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## Running this file will test all function files and tests which are
## available in the nnet package

# change to directory where the function files are
cd ../inst

# now run the function files in functional order if needed
test __analyzerows
test __copycoltopos1

test isposint
test min_max
test newff


# go back to the test directory
cd ../tests


