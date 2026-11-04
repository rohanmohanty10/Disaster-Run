 

 

local v1 = {};
local u2 = {};

function ReverseTable(p3)
    local v4 = #p3;
    local v5 = {};

    for i, v in ipairs(p3) do
        v5[v4 + 1 - i] = v;
    end;

    return v5;
end;

function v1.AddRichText(p6, p7) -- Line: 14
    -- upvalues: u2 (copy)
    local v8 = "";

    for _, v in p6 do
        v8 = v8 .. u2[v.Name](false, v);
    end;

    local v9 = v8 .. p7;

    for _, v in ReverseTable(p6) do
        v9 = v9 .. u2[v.Name](true);
    end;

    return v9;
end;

for _, child in script:GetChildren() do
    u2[child.Name] = require(child);
end;

return v1;