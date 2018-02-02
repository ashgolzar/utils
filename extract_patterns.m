function [stimulus_patterns spike_patterns] = extract_patterns(dataset, num_pulse_, neural_latency, time_window)
% extracts all combinations of stimulus patterns of length = num-pulse
% dataset: a session from from "EPC_TOP80_MU.mat"
% num_pulse: int, defines pattern length, 1 pulse = 18.75 msec
% neural_latency: int, extracting spikes witha latency relative to stimuls
% in miliseconds
% time_window: [start end] relative to neural_latency (responses onset) in miliseconds

% #0 define outputs
resample_ufactor=19;
detect_threhsold=0.95;
max_patterns_perstimlus = 100;


% #1 calculate stimulus permutaions
stimulus_perms = compute_stimlus_combinations(num_pulse_);
stim_perms_streched=imresize(stimulus_perms, [size(stimulus_perms,1), size(stimulus_perms,2)*resample_ufactor], 'box');

stimulus_patterns = cell(size(stimulus_perms,1));
spike_patterns = stimulus_patterns;
% #2 resample
for i1 = 1 : size(stim_perms_streched, 1)
    display(['Extracting pattern #', num2str(i1)])
    [stimulus_patterns{i1}, spike_patterns{i1}] = ...
        extract_subpattern(dataset, stim_perms_streched(i1, :), detect_threhsold, ...
            max_patterns_perstimlus, neural_latency, time_window);
end 


        
        

% #4 extract correponding patterns













end
