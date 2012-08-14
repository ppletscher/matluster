function str = matluster_generateStringFromOptions(options)
% matluster_generateStringFromOptions generates a string based on options
%   str = matluster_generateStringFromOptions(options) returns a string based
%   on the fields of the options struct. For the formatting the special field
%   options.format is used. It is expected that for each field of the options
%   struct, there is also an entry in the options.format struct, which
%   specifies a C style formating string, such as '%d' or '%f'.

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
            if (~isfield(options.format, fields{i}))
                error(['You did not specify a formatting option for field ', fields{i}, '!' ]);
            end
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
