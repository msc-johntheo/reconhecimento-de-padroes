%PLOTG Plot the function values z on a 2D grid
%
%    H = PLOTG(GRID,Z)
%
% Plot the function values given in Z on the 2D grid. The GRID is a
% 2xN dataset, where N is nxn. Vector Z has therefore also length N.
%
%    H = PLOTG(GRID,Z,HGT)
%
% By setting HGT one contour at height HGT can be plotted.
%
% When you already have a PRTools mapping w, please use plotw(w).
%
% see also: makegriddat, gendatgrid, plotw

% Copyright: D.M.J. Tax, D.M.J.Tax@prtools.org
% Faculty EWI, Delft University of Technology
% P.O. Box 5031, 2600 GA Delft, The Netherlands
function h = plotg(grid,z,nrc)

if nargin<3
	nrc = [];
end

% I want to be able to handle datasets, but don't have the burden:
if isdataset(grid)
	grid = +grid;
end
if isdataset(z)
	z = +z;
end

% First determine the sizes of the grid:
lx = length(find(grid(:,2)==grid(1,2)));
ly = size(grid,1)/lx;
% and extract the exact x and y positions:
x = grid(1:ly:end,1);
y = grid(1:ly,2)';

% See if z has the right size
if (size(z,2)>1)
	error('Data z does not have appropriate size');
end
hold on;
%h = surface(x,y',reshape(+z,ly,lx));
h = mesh(x,y',reshape(+z,ly,lx));
hold on;
if ~isempty(nrc)
	[c,h] = contour3(x,y,reshape(+z,ly,lx),[nrc nrc],'r');
end

view(3);
if nargout==0
	clear h;
end

return
