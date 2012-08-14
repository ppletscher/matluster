function idx = matluster_findIndex(table, name)
% MATLUSTER_FINDINDEX find parameter index in a matluster table.
%   IDX = MATLUSTER_FINDINDEX(TABLE, NAME) returns the index of the parameter
%   with name NAME in the matluster table TABLE.

for i=1:numel(table.param_name)
    if (isequal(table.param_name{i}, name))
        idx = i;
        break;
    end
end

error('Could not find a parameter with this name!');
