function table = insertResult(table, options, result)

% find correct main index
main_idx = 0;
for idx=1:numel(table)
    % find the one that matches all the groupby names
    found_it = 1;
    for i=1:numel(options.reporting.groupby)
        if (~isequal(table{idx}.name{i}, getfield(options, options.reporting.groupby{i})))
            found_it = 0;
            break;
        end
    end
    if (found_it)
        main_idx = idx;
        break;
    end
end

% not found, so append a new element
if (main_idx == 0)
    % name of the configuration
    n = {};
    for i=1:numel(options.reporting.groupby)
        n = [n, getfield(options, options.reporting.groupby{i})];
    end
    
    new = [];
    new.name = n;
    new.report = [];
    table{end+1} = new;
    main_idx = numel(table);
end

% append to the results (linear array!)
new = [];
new.params = convertOptions2Cell(options);
new.result = result;
table{main_idx}.report{end+1} = new;



function p = convertOptions2Cell(options)

p = [];

fields = fieldnames(options);
for i=1:length(fields)
    % skip the special fields used for formatting and reporting
    if (isequal(fields{i}, 'format') || isequal(fields{i}, 'reporting'))
        continue;
    end

    % skip fields in the groupby
    ignore = 0;
    for j=1:numel(options.reporting.groupby)
        if (isequal(fields{i}, options.reporting.groupby{j}))
            ignore = 1;
            continue;
        end
    end
    if (ignore)
        continue;
    end

    % process a field
    if (~isstruct(getfield(options, fields{i})))
        new = [];
        new.name = fields{i};
        new.value = getfield(options, fields{i});
        p{end+1} = new;
    end
end
