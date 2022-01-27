
I = imread('hitmiss_image.tif');
I = double(I(:,:,1))/255;


T1 = [ -1 1 -1 ; 1 1 1 ; -1 1 -1 ]; % simple cross template
B1 = hitormiss_3x3(I,T1);


T2 = [ -1 0 -1 ; 0 1 0 ; -1 0 -1 ]; % centre set & zero diagonals
B2 = hitormiss_3x3(I,T2);

subplot(2,3,1); imagesc(I); colormap(gray); title('Input Image');

subplot(2,3,2); imagesc(T1); title('Template 1'); caxis([-1 1]);
subplot(2,3,3); imagesc(B1); title('Match 1');

subplot(2,3,5); imagesc(T2); title('Template 2'); caxis([-1 1]);
subplot(2,3,6); imagesc(B2); title('Match 2');

drawnow;



% HAND_EXTRACT - auto extract the "hand" region of interest from the training
% image using thresholding, morphological cleaning etc.
%
% B = hand_extract(I);
%
% I = an NxM gresyscale image (values range 0..1)
% B = Binary mask of extracted region

function B = hand_extract(I)

if (nargin<1)
  error('This function requires an image as input');
end
if (isa(I,'uint8'))
  I = double(I(:,:,1))/255;
end

% estimate a threshold using the isothresh function you have created.
    threshold = hand_threshold(I); 

% 1. Threshold the image based on the isothresh estimate. Given that the
%    hand contains significant shadowing uou may need to scale up/down the
%    threshold estimate given by image_thresh(). 

    threshK = 0.20;
    thresh = threshK * threshold;
    
     B = I > thresh;
    
 
% 2. Clean up the thresholded image. Remove isolated points, fill holes
%    in the etc... You can use any of the function in the image processing
%    toolbox to do this such as imerode,imdilate,imopen,imclose,imfill etc.
%    Make sure you test this on serval images from the dataset to be sure it works.
%    Again shadowing across the hand is likely to be an issue.
    
    se = strel('disk', 6); % 20 thresh
    
    %se = strel('rectangle', [10 20]);
   
  
    B = imopen(B, se);
    
    B = imclose(B, se);
    
    B = imfill(B, 'holes');

% 3. Return a binary image containing only the "hand", preferably as a single region. 
%    If you have multiple regions in the output (caused by fragmentation of the hand or
%    from noise not removed during the clean up stage) some of the feature estimation 
%    functions which you will use later on may return odd results. 
%
% IMPORTANT - the better this section is at cleaning up the imagery the better the 
% feature estimates are likely to be and hence the performance of the classifier. Also
% make sure you discuss how you came up with these steps in your report and include
% examples etc.
return


%% bwlabel
[labeledImg, numOfObjects] = bwlabel(I);

%% get size
for blobNumber=1: numOfObjects
    if length(labeledImg) > 100
        B = I;
        break;
    end
end
