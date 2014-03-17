nFrames = 5;
neighbors = 3;

features = 1:5;

frameFeature = [ 1 2 2 3 1];

similarityMat = zeros(nFrames+2*neighbors,nFrames+2*neighbors);
for i = 1:nFrames
    for j = i-d:i
        if(i-d<0)
            continue;
        else
            similarityMat(i,j) = calculateSim(i,j);
        end
    end
end