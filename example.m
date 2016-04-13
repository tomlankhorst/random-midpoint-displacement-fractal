%% Random Midpoint Displacement Fractal
% T.J.W. Lankhorst <t.j.w.lankhorst@student.utwente.nl>
% Original: Solution to the Advanced Programming in Engineering Random Numbers assignment

tic;

steps       = 18;       % How many iterations to do
height      = 3e3;      % Height coefficient at start (meter)
mapsize     = 1e4;      % Map size edge (meter)

roughness   = 0.76;     % Roughness
seed 		= 9133759;  % randi(10^7);

rng         = rng_init( seed, 171, 2^31-1 );
S           = 1:steps;

% Fill the corners of the image using RNG
[R,rng]     = rng_rand( rng, 4 );
R           = (-1+2.*R);
F           = height.*reshape( R, 2, 2 );
L           = 2;
height      = height .* roughness;

% We determine the midpoint value by 2D image filtering with two kernels. 
% This is fast and allows for parallelization and GPU usage.
Kcross = [0 1 0; 1 0 1; 0 1 0]./4;
Kdiag  = [1 0 1; 0 0 0; 1 0 1]./4;

% For every step...
for s = 1:steps
    
    % Either:
    if( mod(s,2) )
       % Expand the image and find center points
       % x.x      x.x   ...
       % ... conv ... = .x.
       % x.x      x.x   ...
       
       % The new size is 2L-1
       L  = 2*L-1; 
       % Store the current image
       F_ = F;
       % Resize the image to the new size to have nice interpolation
       F  = imresize(F,[L L]);
       
       % Set the original values to the upscaled image
       F(1:2:end,1:2:end) = F_;
       % Filter the image with the diagonal kernel
       F_ = imfilter(F,Kdiag);
       % Only keep the center part
       F_ = F_(2:2:end,2:2:end);
       
       % Calculate a set of numel(F_) random values
       [R, rng] = rng_rand( rng, numel(F_) );
       % Scale to [-height height]
       R = height.*(-1 + 2.*R);
       % Reshape to square
       R = reshape( R, length(F_), length(F_));
       F_ = F_ + R;
       
       F(2:2:(end-1),2:2:(end-1)) = F_; 
           
    else
       % Or find the X-points
       % .x.      .x.   x.x
       % x.x conv x.x = .x.
       % .x.      .x.   x.x
        
       % Filter the current image, replace the border to have nice interp.
       F_ = imfilter(F,Kcross,'replicate');
       % Only use the center
       F_ = F_(2:2:end);
       
       % Generate random [-height height] array
       [R,rng] = rng_rand( rng, length(F_));
       R = height.*(-1 + 2.*R.');
       
       F_ = F_ + R;
       
       % Store the image
       F(2:2:end-1) = F_;
        
    end
    
    height = height .* roughness;
        
end

toc

rmdf_show( F, mapsize );
