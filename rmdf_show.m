function [ ] = rmdf_show( F, mapsize )
%RMDF_SHOW Shows a nice map of a generated RMDF

	% Colormap size
	n = 100;

	% Colormap of deep sea, shallow water, beach, forrest, rock and snow
	C_RGB = [
		64   112 202;   % Deep sea
		172  199 211;   % Shallow water
		255  199   0;   % Beach
		 61  144  59;   % Forrest
		126   94  49;   % Sand
		242  250 255;   % Rock
		255  255 255    % Snow
	]./255;

	% Relative heights
	N_RGB = [ 0, 0.2, 0.25, 0.3, 0.8, 0.84, 1 ];

	% Show the surface
	L = linspace(0,mapsize,length(F));

	h = surf( L,L,F );
	daspect([1 1 1]);
	xlabel('X (m)');
	ylabel('Y (m)');
	zlabel('Height (m)');

	C = interp1(N_RGB.*n, C_RGB, 1:n);
	colormap(C);

	% Set some nice view and lighting properties
	view(45,45)
	shading interp
	lightangle(45,-10)
	h.FaceLighting = 'gouraud';
	h.AmbientStrength = 0.6;
	h.DiffuseStrength = 0.5;
	h.SpecularStrength = 0.04;
	h.SpecularExponent = 100;
	h.BackFaceLighting = 'unlit';

end

