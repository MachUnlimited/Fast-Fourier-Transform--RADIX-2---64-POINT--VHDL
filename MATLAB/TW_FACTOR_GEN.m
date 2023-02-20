clc ,clear all , close all ;

for i = 1:45 
    tw_64(i) = exp(-1i*2*pi*i/64);
end

for i = 1:9 
    tw_16(i) = exp(-1i*2*pi*i/16);
end


 for x = 1:45
 disp("  """ + dec2bin(typecast(single(real(tw_64(x))),'uint32'),32)+""";" );
 disp(x);
 end
 
 %%%%%%% Twiddle factors %%%%%%%