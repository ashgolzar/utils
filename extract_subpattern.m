function [stimulus_patterns, spike_patterns] = ...
    extract_subpattern(dataset, stim_perms_streched, detect_threhsold, max_patterns_perstimlus)

pulse_length = 19
num_trials = length(dataset.t);
stimulus_patterns = nan(num_trials, 2);
spike_patterns = stimulus_patterns;
trial_fields = fields(dataset.t)
% 1 : s1, 2 : s2, 3 : n1, 4 : n2

for electrode = [1, 2]
    for t1 = 1 : num_trials
        % #1 find pattern in stimlus trains
        trial_stim = dataset.t(t1).(trial_fields{0+electrode});
        trial_spike = dataset.t(t1).(trial_fields{2+electrode});
        
        s_conved = conv(double(trial_stim), stim_perms_streched);
        s_mask_peaks = s_conved > (max(s_conved) * detect_threhsold);
        s_conv_peaks = s_conved .* s_mask_peaks;
        plot(s_conv_peaks)
        % TODO: MOVEMAX
        %s_movmax = movmax(s_conv_peaks, pulse_length);
        %s_movmax == s_conv_peaks)
        peak_nonmax = non_max_suppression(s_conv_peaks, pulse_length);
        peak_ix = find(peak_nonmax)
        
        % #2 extract patterns
        patterns_s= nan(max_patterns_perstimlus, diff(time_window) + 1)
        patterns_n= pattern_seed_s
        c1 = 0;
        for i1 = 1:length(peaks_ix)
            if peak_ix(i1) + neural_latency + time_windows(1) > 0 & ...
                    peak_ix(i1) + neural_latency + time_windows(1) < length(s1) + 1
                c1 = c1 + 1;
                patterns_s(c1, :) = trial_stim([time_windows(1):time_windows(2)] + peak_ix(i1))
                patterns_n(c1, :) = trial_spike([time_windows(1):time_windows(2)] + peak_ix(i1) + neural_latency)
                
            end
        end
    end
    
    stimulus_patterns{1, electrode} = patterns_s
    spike_patterns{1, electrode} = patterns_n
end

end
