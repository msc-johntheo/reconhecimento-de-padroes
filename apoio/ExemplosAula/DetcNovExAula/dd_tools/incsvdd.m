%INCSVDD Incremental Support Vector Data Description
%
%    W = INCSVDD(A,FRACREJ,KTPYE,KPAR)
%
% Train an incremental support vector data description on dataset A.
% The kernel (and its parameters) are defined by kernel type KTYPE and
% parameter(s) KPAR. For possible definitions of the kernel, see DD_KERNEL.
%
% See also: DD_KERNEL, INC_ADD, INC_SETUP, INC_STORE
function W = incsvdd(a,fracrej,ktype,kpar)

if nargin<4
    kpar = 1;
end
if nargin<3
	ktype = 'r';
end
if nargin<2
	fracrej = 0.1;
end
if nargin<1 || isempty(a)
	W = mapping(mfilename,{fracrej,ktype,kpar});
	W = setname(W,'IncSVDD (%s)',getname(dd_proxm([],ktype,kpar)));
	return
end

if ~ismapping(fracrej)

	% remove double objects...
	[B,I] = unique(+a,'rows');
    a = a(I,:);
	dim = size(a,2);
	%define C:
	It = find_target(a);
	if fracrej<0
		C = -fracrej;
	else
		C = 1/(length(It)*fracrej);
	end
	% do the adding:
	W = inc_setup('svdd',ktype,kpar,C,+a,getoclab(a));
	% store:
	w = inc_store(W);
	W = setname(w,'IncSVDD (%s)',getname(dd_proxm([],ktype,kpar)));

else
	% Now evaluate new objects:
	W = getdata(fracrej); % unpack
	[n,dim] = size(a);
	out = repmat(W.offs,n,1);
	for i=1:n
		wa = dd_kernel(+a(i,:),W.sv,W.ktype,W.kpar);
		out(i) = out(i) - 2*wa*W.alf + dd_kernel(+a(i,:),+a(i,:),W.ktype,W.kpar);
	end
	newout = [out repmat(W.threshold,n,1)];
	% store:
	W = setdat(a,-newout,fracrej);
	W = setfeatdom(W,{[-inf 0;-inf 0] [-inf 0;-inf 0]});

end

