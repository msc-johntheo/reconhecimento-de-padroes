## Copyright (C) 2007 Michel D. Schmid  <michaelschmid@users.sourceforge.net>
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

## author: msd


## This file is used to call all MLP tests, but without
## assert and so on, means if no error occure, everything
## seems to be ok.
## This is only a very basic test which should be run
## from this directory

tic
cd example1;


mlp9_1_1_tansig
mlp9_2_1_tansig
mlp9_2_2_1_tansig
mlp9_2_2_tansig
mlp9_2_3_tansig
mlp9_5_3_tansig

cd ..


cd example2

mlp9_1_1_logsig
mlp9_2_1_logsig
mlp9_2_2_1_logsig
mlp9_2_2_logsig
mlp9_2_3_logsig
mlp9_5_3_logsig

cd ..
elapsed_time = toc;

disp("Running 12 very basic tests successfully!")
disp("Secondes needed to running all the tests: ");
disp(elapsed_time);


