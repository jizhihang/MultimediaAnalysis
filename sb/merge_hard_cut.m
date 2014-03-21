function [ shotBoundary ] = merge_hard_cut( shotBoundary,continuitySignal )
%MERGE_HARD_CUT merge the cut that is in the five step 
% param shotBoundary : shotboundary that need to merge 
% param continuitySignal : the continuity signal between frame
index = find(shotBoundary==1);
neighborsRadius = 10;
length = numel(index);
i = 1;
while i <=length-1
   startIdx = i;
   if(length-i<4)
       endIdx = length;
   else
       endIdx = i+4;
   end
   fStart = index(startIdx);
   while(endIdx>startIdx)
        fEnd = index(endIdx);
        if(fEnd-fStart<=neighborsRadius)
            break;
        else
            endIdx = endIdx -1;
        end
   end
   if(endIdx>startIdx)
       fEnd = index(endIdx);
       frameInCons = fStart:fEnd;
%        disp(frameInCons);
       minCon = min(continuitySignal(frameInCons));
%        disp(minCon);
       for fIdx = 1:numel(frameInCons)
           frameIdx = frameInCons(fIdx);
           if(continuitySignal(frameIdx)>minCon)
               shotBoundary(frameIdx) = 0;
           end
       end
   end
   i = endIdx+1;
end
end

