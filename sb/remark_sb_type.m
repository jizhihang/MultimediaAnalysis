function shotBoundary = remark_sb_type(shotBoundary)
% remark the cut with its' type ,employing the forward max matching algrothm
% the hard cut is mark as 1
% the dissolve start and end is marked as 3
% the dissolve post frame between start and end is marked as 2
% param cut : the initial cut with its' value below the continuity threshhold
spacing = 3;
groupInCount = 5;       % this means how many times the inner loop has been executed(the frames in group is groupInCount+1)
cutFrames = find(shotBoundary==1);
length = numel(cutFrames);
i = 1;
% disp(shotBoundary);
while i<=(length-1)
    endIdx = i;
    nextIdx = endIdx+1;
    flagGroup = 0;      % this is the flag to judge whether the while has been exeecuted
    while((cutFrames(nextIdx)-cutFrames(endIdx))<spacing)
        flagGroup = flagGroup+1;
        endIdx = nextIdx;
        nextIdx = endIdx+1;
        if(nextIdx>length)  % to avoid index out of bounds
            break;
        end
    end
    if(flagGroup>=groupInCount)
        shotBoundary(cutFrames(i)) = 3;      % this means it is the dissolve start frame
        shotBoundary(cutFrames(endIdx)) = 3; % this is the end of the dissolve
        for j = cutFrames(i)+1:cutFrames(endIdx)-1
            shotBoundary(j) = 2;  % the frames between is the dissolve post frames
        end
        i = endIdx+1;
        flagGroup = 0;
    else
        flagGroup = 0;
        i = i+1;
    end
end
% disp(shotBoundary);
end
