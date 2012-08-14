function str = matluster_generateStringFromOptions(options)
% TODO: document!

if (~isfield(options, 'format'))
    error('You need to specify a formatting for all the fields!');
end

str = '';

if (isstruct(options))
    fields = fieldnames(options);
    for i=1:length(fields)
        % skip the special fields used for formatting and reporting
        if (isequal(fields{i}, 'format') || isequal(fields{i}, 'reporting'))
            continue;
        end

        % process a field
        if (~isstruct(getfield(options, fields{i})))
            format = getfield(options.format, fields{i});
            if (numel(str) > 0)
                str = sprintf('%s_', str);
            end
            temp = sprintf('%%s%%s=%s', format);
            str = sprintf(temp, str, fields{i}, getfield(options, fields{i}));
        else
            error('do not support structs!');
        end
    end
end
