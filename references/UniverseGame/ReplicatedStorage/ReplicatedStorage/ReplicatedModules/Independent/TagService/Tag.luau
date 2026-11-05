  

 

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
local v3 = {};

for i, v in pairs(u1) do
    u2[v] = i;
end;

local function GetType(p4, p5) -- Line: 22
    -- upvalues: u1 (copy), u2 (copy)
    local v6 = p5 or typeof(p4);

    return u1[u2[v6] or v6:lower()] or "StringValue";
end;

function v3.new(p7, p8, p9, p10, p11) -- Line: 29
    -- upvalues: u1 (copy), u2 (copy)
    local v12 = p11 or {};
    local new = Instance.new;
    local v13 = p9 or typeof(p8);
    local v14 = new(u1[u2[v13] or v13:lower()] or "StringValue");
    v14.Name = p7 or "Tag";

    if p8 ~= nil then
        v14.Value = p8;
    end;

    for i, v in v12 do
        v14:SetAttribute(i, v);
    end;

    if p10 then
        v14.Parent = p10;
    end;

    return v14;
end;

return v3;