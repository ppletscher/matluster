function idx = matluster_findIndex(table, name)

for i=1:numel(table.param_name)
    if (isequal(table.param_name{i}, name))
        idx = i;
        break;
    end
end

