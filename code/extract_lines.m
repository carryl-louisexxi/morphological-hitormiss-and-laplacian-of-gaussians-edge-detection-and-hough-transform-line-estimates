function RT = extract_lines(H,rhos,thetas,N)
%% maxima container
RT = zeros(N,2);

%% size of hough space
[r, c] = size(H);

%% index : used for counting 
ind = 1;

%% getting the maxima
for i=1:r-6
    for j=1:c-6
        block = H(i:i+6, j:j+6); % get the block
        maxval = max(block(:)); % get the maximum value in the 7 x 7 block
        [locx, locy] = find(block == maxval); % get the location of the max val
        
        if (length(locx) == 1) && (maxval == block(4,4)) % if the maximum is in the mid,
            maxima(1, ind) = maxval; % put in array
            ind = ind + 1;
        end
    end
end

%% sorting maxima
maxima = unique(sort(maxima));

%% index : used for counting
cn = 0;

%% get the peaks in line with the number of the N
for i=1:N
    indmax = maxima(end-(i-1)); % individual max
    [locx, locy] = find(H == indmax); % points where the certain maxima lies
    
    for j=1:length(locx)
        if cn == N
            break;
        end
  
        cn = cn + 1; % increment index 
        RT(cn,1) = locx(j);
        RT(cn,2) = locy(j);
    end
end

binr = rhos(RT(:, 1));
bint = thetas(RT(:, 2));

RT = [binr(:), bint(:)];

figure;

imagesc(thetas,rhos,H); %axis equal tight;
colormap(gray);
title('Hough Transform - Detected Maximas');
xlabel('Theta');
ylabel('Rho');
hold on;
plot(RT(:,2),RT(:,1),'bo');
hold off;
drawnow;

return
