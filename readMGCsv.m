function [video_id,video_path] =  readMGCsv(csv_path)
% readCsv : read the file video_set.csv for metadata
% the csv file is the format like this video_id,filename\n including the
% first line is text 'VideoID,Filename'
% @param video_id : an int array
% @param video_path : an cell array of the path,mind use {} to get it's
%                     elements of the path

fid = fopen(csv_path);
video_id_path = textscan(fid,'%6d,%s','HeaderLines',1);
video_id = video_id_path{1};
video_path = video_id_path{2};
fclose(fid);
end
