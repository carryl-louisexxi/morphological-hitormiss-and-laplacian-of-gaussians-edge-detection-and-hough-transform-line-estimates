function [E,F,G] = log_edge(I,N)
if (nargin<2)
  N=5;
end

%% image grayscale
I=double(I(:,:,1));

%% force I to be a NxN real number array, and create the laplacian of gaussians filter. 
if (N<=3)
  F=[0 1 0; 1 -4 1; 0 1 0]/8;
else
  F = fspecial('log',N,floor((N-1)/3)/2);
end

%% multiply threshold by this factor to avoid low threshold for small filters
threshK=max(1,-0.5*N+7.5); 

%% convolve the filter with the image
G = conv2(I, F,'same');

%% threshold
t = (0.75*mean(G)) * threshK;

%% size of the convolve image
[r, c] = size(G);

%% creating padded image : convolve image
paddedLOG = zeros(r+1, c+1);

for i=1:r
    for j=1:c
        paddedLOG(i+1, j+1) = G(i, j);
    end
end

%% array of preserve values from padded convolve image
E = zeros(size(paddedLOG));

%% identifying zero crossing and preserving the point where the sum of the magnitudes of G accross the zero crossing is > t
for i=2:size(I, 1)
    for j=2:size(I, 2)
        
        mid = paddedLOG(i, j);
        right = paddedLOG(i, j-1);
        left = paddedLOG(i, j+1);
        up = paddedLOG(i+1, j);
        down = paddedLOG(i-1, j);
        
        if mid > 0
            if left < 0
                res = abs(mid) + abs(left);
                if res > t
                    E(i, j) = 1;
                end
            end

            if right < 0
                res = abs(mid) + abs(right);
                if res > t
                    E(i, j) = 1;
                end
            end
            
            if up < 0
                res = abs(mid) + abs(up);
                if res > t
                    E(i, j) = 1;
                end
            end        
            
            if down < 0
                res = abs(mid) + abs(down);
                if res > t
                    E(i, j) = 1;
                end
            end  
         
        end
    end
end

E = E(2:end-1, 2:end-1);

%% THINGS TO DO!
% 1. Create and emtpy array E and and an array G containing the filtered
%    image (use conv2 with the 'same' option to do this).
% 2. compute threshold t (0.75*mean(G)) of the LoG image stored in
%    G (and multiply by threshK)
% 3. identify the zero crossing points 
% 4. preserve those zero crossing points where the sum of the
%    magnitudes of G accross the zero crossing is > t
return
