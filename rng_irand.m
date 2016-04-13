function [ R, rng ] = rng_irand( rng, n )
%RNG_IRAND(rng,n) Generates random numbers between 1 and m

    % rng = [Xi, c, m]
    
    R = zeros( n, 1 );
    
    for i = 1:n
       
        rng(1) = mod( rng(1) .* rng(2), rng(3) );
        R(i)   = rng(1);
        
    end

end

