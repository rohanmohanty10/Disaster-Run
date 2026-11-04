  

local u1 = setmetatable({}, {
    __mode = "k"
});

return function(p2, p3) -- Line: 2
    -- upvalues: u1 (copy)
    local v4;

    if typeof(p2) == "Instance" then
        v4 = p2:IsA("Folder");
    else
        v4 = false;
    end;

    assert(v4, "Pass an exported FOV animation folder");
    local v5;

    if type(p3) == "number" then
        v5 = p3 == p3;
    else
        v5 = false;
    end;

    assert(v5, "Time must be in seconds");
    local v6 = u1[p2];

    if not v6 then
        v6 = {};

        for _, child in p2:GetChildren() do
            if child:IsA("NumberValue") and type(child:GetAttribute("Time")) == "number" then
                table.insert(v6, child);
            end;
        end;

        table.sort(v6, function(p7, p8) -- Line: 13
            return p7:GetAttribute("Time") < p8:GetAttribute("Time");
        end);
        u1[p2] = v6;
    end;

    assert(#v6 > 0, "The FOV export is empty");
    local v9 = #v6;
    local v10 = 1;

    while v10 < v9 do
        local math_floor_ret = math.floor((v10 + v9 + 1) / 2);

        if v6[math_floor_ret]:GetAttribute("Time") <= p3 then
            v10 = math_floor_ret;
        else
            v9 = math_floor_ret - 1;
        end;
    end;

    local v11 = v6[v10];
    local v12 = v6[math.min(v10 + 1, #v6)];
    local Attribute = v11:GetAttribute("Time");
    local Attribute2 = v12:GetAttribute("Time");
    local v13 = Attribute < Attribute2 and math.clamp((p3 - Attribute) / (Attribute2 - Attribute), 0, 1) or 0;

    return v11.Value + (v12.Value - v11.Value) * v13;
end;