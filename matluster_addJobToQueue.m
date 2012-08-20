function matluster_addJobToQueue(fid, options, run_idx, command, time_limit)

% TODO: documentation

log_filename = sprintf('log_%s.out', matluster_generateStringFromOptions(options));
out_filename = sprintf('output/%s.mat', matluster_generateStringFromOptions(options));

% only bsub supported for now
fprintf(fid, 'if [ ! -f %s ]\nthen\nbsub -o %s -W %s %s %d\nfi\n', ...
    out_filename, log_filename, time_limit, command, run_idx);
