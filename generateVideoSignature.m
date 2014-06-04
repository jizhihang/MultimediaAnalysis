function v_sig = generateVideoSignature(key_frame_signature_path,kf_sig_suffix)
% generateVideoSignature : compute the signature for the video
% @param key_frame_signaturee_path : the path store the key frame signature
% @param kf_sig_suffix : the key frame signature suffix

frame_sigs = dir(fullfile(key_frame_signature_path,kf_sig_suffix));
load(fullfile(key_frame_signature_path,frame_sigs(1).name));
[dim,m] = size(signature);
v_sig = zeros(dim,m);
for f = 1:length(frame_sigs)
    f_path = fullfile(key_frame_signature_path,frame_sigs(f).name);
    load(f_path);
    v_sig = v_sig+signature;
end

v_sig = v_sig/length(frame_sigs);

end