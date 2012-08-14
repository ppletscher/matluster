function res = matluster_reshapeResults(table, result_fieldname)
% MATLUSTER_RESHAPERESULTS converts a matluster datastructure
%   RES = MATLUSTER_RESHAPERESULTS(TABLE, RESULT_FIELDNAME) converts the
%   matluster datastructure TABLE to a struct containing an actual table showing
%   a specific result field determined by RESULT_FIELDNAME.

res = [];
res.results = [];
res.param_name = {};
res.param_values = {};

% figure out the dimensionality of the table
for i=1:numel(table.report)
    % add the param_name
    if (i==1)
        for p_idx=1:numel(table.report{i}.params)
            n = table.report{i}.params{p_idx}.name;
            res.param_name{end+1} = n;
            res.param_values{end+1} = [];
        end
    end
    % add to the param_values
    for p_idx=1:numel(table.report{i}.params)
        v = table.report{i}.params{p_idx}.value;
        res.param_values{p_idx}(end+1) = v;
    end
end
for p_idx=1:numel(res.param_values)
    res.param_values{p_idx} = unique(res.param_values{p_idx});
end

% initialize the table
dims = [];
for p_idx=1:numel(res.param_values)
    dims = [dims, numel(res.param_values{p_idx})];
end
res.results = zeros(dims);

% copy the results
for i=1:numel(table.report)
    v = getfield(table.report{i}.result, result_fieldname);
    idx = [];
    for p_idx=1:numel(table.report{i}.params)
        ind = find(res.param_values{p_idx} == table.report{i}.params{p_idx}.value);
        idx = [idx, ind]; 
    end
    idx = mat2cell(idx, 1, ones(1,numel(idx)));
    idx = sub2ind(dims, idx{:});
    res.results(idx) = v;
end
