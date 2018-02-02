function outmat = non_max_suppression(s_conv_peaks, pulse_length)
% TODO: MOVEMAX
%s_movmax = movmax(s_conv_peaks, pulse_length);
%s_movmax == s_conv_peaks)
s_conv_peaks_nmx = s_conv_peaks;

while true 
    display('While loop running')   
    positive_shoulder = diff(s_conv_peaks) > 0;
    positive_trigerred = diff(positive_shoulder) > 0;
    nmx_mask = imdilate(positive_trigerred, ones(1,pulse_length)) - positive_trigerred ;
    nmx_mask = round([0, 0, nmx_mask]);
    s_conv_peaks_nmx = s_conv_peaks .* ~nmx_mask;
    if s_conv_peaks == s_conv_peaks_nmx, break, end
    s_conv_peaks = s_conv_peaks_nmx;
end

outmat = s_conv_peaks_nmx;

end
