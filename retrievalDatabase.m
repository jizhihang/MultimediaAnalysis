function database = retrievalDatabase( database_dir,suffix )
%RETREIVAL_DATABASE this retreival the database and load the sift data in
%   Detailed explanation goes here

fprintf('dir the database...\n');
subfolders = dir(database_dir);

database.img_num = 0; % total image number of the database
database.path = {}; % contain the pathes for each image of each class

for i = 1:length(subfolders),
    subname = subfolders(i).name;
    is_folder = subfolders(i).isdir;
    if is_folder && ~strcmp(subname, '.') && ~strcmp(subname, '..'),       
        frames = dir(fullfile(database_dir, subname, suffix));
        f_num = length(frames);                  
        database.img_num = database.img_num + f_num;     
        for f = 1:f_num,
            c_path = fullfile(database_dir, subname, frames(f).name);
            database.path = [database.path, c_path];
        end;    
    end;
end;
fprintf('retrieval %s done!\n',suffix);
end

