%% Random Midpoint Displacement Fractal
% T.J.W. Lankhorst <t.j.w.lankhorst@student.utwente.nl>
% Original: Solution to the Advanced Programming in Engineering Random Numbers assignment

steps       = 18;       % How many iterations to do
height      = 3e3;      % Height coefficient at start (meter)
roughness   = 0.76;     % Roughness
seed 		= 9133759;  % randi(10^7);

tic;
F = rmdf( steps, height, roughness, seed );
toc

mapsize     = 1e4;      % Map size edge (meter)

rmdf_show( F, mapsize );
