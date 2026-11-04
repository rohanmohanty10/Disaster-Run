 
 

return function(p1, p2) -- Line: 1, Name: merge
    local table_clone_ret = table.clone(p1);

    for i, v in pairs(p2) do
        table_clone_ret[i] = v;
    end;

    return table_clone_ret;
end;