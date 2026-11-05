  

 

local u1 = {
    number = "NumberValue",
    integer = "IntValue",
    int = "IntValue",
    string = "StringValue",
    instance = "ObjectValue",
    boolean = "BoolValue",
    color3 = "Color3Value",
    brickcolor = "BrickColorValue",
    ray = "RayValue",
    vector3 = "Vector3Value",
    cframe = "CFrameValue"
};
local u2 = {};
local u3 = {
    Templates = {}
};

for i, v in pairs(u1) do
    u2[v] = i;
end;

local function GetType(p4, p5) -- Line: 23
    -- upvalues: u1 (copy), u2 (copy)
    local v6 = p5 or typeof(p4);

    return u1[u2[v6] or v6:lower()] or "StringValue";
end;

function u3.Create(p7, p8, p9, p10) -- Line: 30
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    local v11 = u3.Templates[p7];
    local new = Instance.new;
    local v12 = p9 or typeof(p8);
    local v13 = new(u1[u2[v12] or v12:lower()] or "StringValue");
    v13.Name = p7 or "Tag";
    v13.Value = p8 or (v11 and v11.Value or v13.Value);
    v13.Parent = p10 or nil;

    return v13;
end;

function u3.CreateFromTemplate(p14, p15, p16) -- Line: 41
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    local v17 = u3.Templates[p14];

    if v17 then
        local new = Instance.new;
        local v18;

        if v17.Value then
            v18 = v17.Value;
        else
            v18 = p15;
        end;

        local v19 = v17.Type or typeof(v18);
        local v20 = new(u1[u2[v19] or v19:lower()] or "StringValue");
        v20.Name = p14;
        v20.Value = p15 or (v17.Value or v20.Value);
        v20.Parent = p16 or nil;

        return v20;
    end;
end;

function u3.CreateTemplate(...) -- Line: 53
    -- upvalues: u3 (copy)
    local v21, v22, v23;

    if typeof(...) == "table" then
        local v24 = ...;
        v21 = v24.Name;
        v22 = v24.Type;
        v23 = v24.Value;
    else
        v21, v22, v23 = ...;
    end;

    if not v21 then
        return;
    end;

    u3.Templates[v21] = {
        Name = v21,
        Type = v22,
        Value = v23
    };
end;

return u3;