function [ R, rng ] = rng_rand( rng, n )
%RNG_RAND(rng,n) Generates decimal numbers between 0 and 1 

    % Uses rng_irand. 
    [ R, rng ] = rng_irand( rng, n );
    
    % Scales 0-m to 0-1
    R = R ./ rng(3);
    

end

