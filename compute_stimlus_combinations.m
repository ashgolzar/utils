function output = compute_stimlus_combinations(num_pulse)
output=nan(2^num_pulse,num_pulse);
base_m=ones(1,num_pulse)*-1;
output(1,:)=base_m;
row_i = 1;
for i1 = 1 : num_pulse
    base_m(i1)=1;
    perms_c=unique(perms(base_m),'rows');
    output(row_i+1:row_i+size(perms_c,1),:)=perms_c;
    row_i=row_i+size(perms_c,1);
end

end
