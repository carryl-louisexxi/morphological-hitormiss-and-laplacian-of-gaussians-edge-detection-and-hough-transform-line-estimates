function Imatch = hitormiss_3x3(I,M)

if (ndims(I)==3)
  I=I(:,:,2);
end
if (isa(I,'uint8'))
  I=double(I)/255;
end

%% set
SET = M;
SET(SET < 0) = 0;

%% image complement
IC = I;
ICLOC1 = IC == 0;
ICLOC2 = IC == 1;

IC(ICLOC1) = 1;
IC(ICLOC2) = 0;

%% unset 
UNSET = M;
UNSETLOC1 = M ~= -1;
UNSETLOC2 = M == -1;

UNSET(UNSETLOC1) = 0;
UNSET(UNSETLOC2) = 1;

%% erosion 
EROSION1 = erode_3x3(I, SET);
EROSION2 = erode_3x3(IC, UNSET);

%% intersection
Imatch = EROSION1 & EROSION2;
return

function E = erode_3x3(I,S)
%% size of structural element
[M, N]=size(S); 

%% create a zero matrix of size I.        
E=zeros(size(I, 1), size(I, 2)); 
  
for i=ceil(M/2):size(I, 1)-floor(M/2)
    for j=ceil(N/2):size(I, 2)-floor(N/2)
  
        % take all the neighbourhoods.
        MASKS=I(i-floor(M/2):i+floor(M/2), j-floor(N/2):j+floor(N/2)); 
  
        % take logical set
        x = MASKS(logical(S)); 
        
        % set the pixel to the min val of the masks
        E(i, j) = min(x(:));   
    end
end
return