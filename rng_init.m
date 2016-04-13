function [ rng ] = rng_init( seed, varargin )
%RNG_INIT( seed ) Initializes random number generator RNG data
%RNG_INIT( seed, c, p ) Initializes random number generator with specific c
%and p.
    
    c = 1103515245;
    p = 2^32;
        
    if nargin >= 2
        c = varargin{1};
    end
    
    if nargin >= 3
        p = varargin{2};
    end
    
    % For non default parameters, check if the parameters are valid
    if nargin >= 2 
        assert( all(rem(c-1,factor(2^32))==0), ... 
           '(c-1) not divisible by all prime factors of p');

        assert( ~( ~rem(p,4) && rem(c-1,4)), ...
            '(c-1) must be multiple of 4 if p is multiple of 4');
    end
    
    rng = [ seed, c, p ]; % x0, c, p

end

