  

 

return function(p1) -- Line: 7
    local v2 = next;
    local v3, v4 = script:GetChildren();
    local v5 = {};

    for _, v in v2, v3, v4 do
        table.insert(v5, require(v));
    end;

    table.sort(v5, function(p6, p7) -- Line: 13
        return p6._loadOrder < p7._loadOrder;
    end);

    return unpack(v5);
end;