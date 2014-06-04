MEDDATA_path = 'F:\MED_DATA\ldc_intranet\LDC2014E27-V2';

input_meta = '';
output_meta = 'Event-BG';
csv_file = 'test.csv';

metadata_store = fullfile(MEDDATA_path,output_meta);
if(~exist(metadata_store,'dir'))
    mkdir(metadata_store);
end
dic_path = 'data/dictionary.mat';
load(dic_path);
addpath('./pca');

[video_id,video_path] = readMGCsv(csv_file);
video_num = size(video_id,1);
tic
for i = 1:video_num
    v_path = fullfile(MEDDATA_path,video_path{i});
    [path,name,ext] = fileparts(v_path);
    tmp_data_dir = fullfile(path,name);
    v_sig = computeOneVideo(v_path,tmp_data_dir,dictionary,options);
    sig_path = [metadata_store '\' name '_sig.mat'];
    save(sig_path,'v_sig');
end
toc

