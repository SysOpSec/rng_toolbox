function [d] = rng_reference(samples, func, type)
% Return reference datasets
%   Syntax:   [d] = rng_reference(samples, func)
%   Input:    samples  - additive constant
%             func     - multiplicator
%             type     - what int type to return
%   Output:   d - random number datavector with sample length
%                   return only positive integers of given type
%   Defined references
%       ref0        sinewave
%       ref1        overlapping sines with trend
%       ref2        cirp, increasing freq
%       ref3        sine with spikes and dropouots
%       ref10       random numbers (white noise)
%       ref11       random data with spikes and dropouts
%       ref12       random data, normal distributed
%       ref13       random data modulated
%       ref14       random data with series of montone in- or decrease
%       ref15       random data with short period (samplesize/4)
%
% ------------------------------------------------------------------------
% (c) 2021 Andreas Huemmer <andreas.huemmer@sysopsec.de>
%   v 1.0     initial version 
% ------------------------------------------------------------------------
    t  = 1:samples;
    ls = length(t);
    fc = 10/samples;
    delta = samples/(2^8);
    slice = 255;
    
    switch func
        case "ref0"
            ref = 1+sin(10*fc*t);
            ref = ref / max(ref)* double(intmax(type));
        case "ref1"
            ref = (t/max(t(:)).*(1.75 + (cos(2*pi*fc*t)+sin(2*pi*fc*t*3).*cos(2*pi*fc*t*2))));
            ref = ref / max(ref)* double(intmax(type));
        case "ref2"
            gausmod = exp((-t*fc*0.5).^2) * 0.5 + 0;
            ref = 1 + sin(10*fc*t.*gausmod);
            ref = ref / max(ref)* double(intmax(type));
        case "ref3"
            ref = 1+sin(10*fc*t);
            p1 = randi(max(t(:)));
            p2 = randi(max(t(:)));
            z1 = randi(max(t(:)));
            z2 = randi(max(t(:)));
            ref(p1-4:p1+5) = 2; 
            ref(p2-2:p2+5) = 2; 
            ref(z1-5:z1+5) = 0; 
            ref(z2-5:z2+5) = 0;
            ref = ref / max(ref)* double(intmax(type));
        case "ref10"
            ref = genrand(type, ls);
        case "ref11"
            ref = genrand(type, ls);
            p1 = randi(ls);
            p2 = randi(ls);
            z1 = randi(ls);
            z2 = randi(ls);
            ref(p1-delta:p1+delta) = 2; 
            ref(p2-delta:p2+delta) = 2; 
            ref(z1-5:z1+delta) = 0; 
            ref(z2-5:z2+delta) = 0;
        case "ref12"
            raw = abs(randn(1,samples+1));
            ref = raw / max(raw) * double(intmax(type));
        case "ref13"
            raw = genrand(type, ls);
            ref = double(raw).*double((sin(t/samples*15)+10));
            ref = ref / max(ref)* double(intmax(type));
        case "ref14"
            ref  = genrand(type, ls);
            p1   = randi(ls);
            xval = 1;                   % ref(p1);
            tx   = xval:xval+slice;
            ref(p1:p1+slice) = tx;
        case "ref15"
            per    = genrand(type, ls/4);
            ref = [per per per per];
        otherwise
            ref = 0;
            disp('Requested referencefunction not supported');
    end
    
    % Normalize the date
    %ref = ref ; 
    
    switch type
        case 'uint8'
            d = uint8(ref);    
        case 'uint16'
            d = uint16(ref);    
        case 'uint32'
            d = uint32(ref);    
        otherwise
            d = 0;
            disp('Requested integertype not supported');
    end
end

function r = genrand(ty, le)
    r = randi(intmax(ty),[1 le], ty);
end

        


