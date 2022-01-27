function Imatch = hitormiss_3x3(I,M)

if (ndims(I)==3)
  I=I(:,:,2);
end
if (isa(I,'uint8'))
  I=double(I)/255;
end

%% set
set = M;
set(set < 0) = 0;

%% erosion 1
erosion1 = erode_3x3(I, set);

%% image complement
IC = I;
IC = IC * -1;
IC(IC > -1) = 1;
IC(IC < 0) =  0;

%% unset
unset = M;
unset =  unset * -1;
unset(unset > -1) = 1;
unset(unset < 0) = 0;

%% erosion 2
erosion2 = erode_3x3(IC, unset);

%% intersection

Imatch = erosion1 & erosion2;
return

function E = erode_3x3(I,S)
%% size of se
[P, Q]=size(S); 
  
%% create a zero matrix of size I.        
E=zeros(size(I, 1), size(I, 2)); 
  
for i=ceil(P/2):size(I, 1)-floor(P/2)
    for j=ceil(Q/2):size(I, 2)-floor(Q/2)
  
        % take all the neighbourhoods.
        on=I(i-floor(P/2):i+floor(P/2), j-floor(Q/2):j+floor(Q/2)); 
  
        % take logical set
        nh=on(logical(S)); 
        
        % compare and take minimum value of the neighbor 
        % and set the pixel value to that minimum value. 
        E(i, j)=min(nh(:));      
    end
end
return