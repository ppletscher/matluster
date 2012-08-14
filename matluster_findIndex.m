function idx = matluster_findIndex(table, name)
% matluster_findIndex find parameter index in a matluster table.
%   idx = matluster_findIndex(table, name) returns the idx of the parameter
%   name in the matluster table table.

for i=1:numel(table.param_name)
    if (isequal(table.param_name{i}, name))
        idx = i;
        break;
    end
end

error('Could not find a parameter with this name!');
