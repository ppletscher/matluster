function collection = matluster_collect(num_runs)

% TODO: documentation

collection = {};

% collect all the results
for run_idx=0:(num_runs-1)
    % options
    load(sprintf('local/options_%d.mat', run_idx));

    % results
    conf_str = matluster_generateStringFromOptions(options);
    filename = sprintf('output/%s.mat', conf_str);
    load(filename);

    collection = matluster_insertResult(collection, options, result);
end
