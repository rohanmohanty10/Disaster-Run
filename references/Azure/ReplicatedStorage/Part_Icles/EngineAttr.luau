 

 

local v1 = {};
local u2 = {};
local u3 = setmetatable({}, {
    __mode = "k"
});

local function remember(p4, p5, p6) -- Line: 18
    -- upvalues: u3 (copy), u2 (copy)
    local v7 = u3[p4];

    if not v7 then
        v7 = {};
        u3[p4] = v7;
    end;

    if p6 == nil then
        p6 = u2;
    end;

    v7[p5] = p6;
end;

function v1.write(p8, p9, p10) -- Line: 29
    -- upvalues: u3 (copy), u2 (copy)
    local v11 = u3[p8];

    if not v11 then
        v11 = {};
        u3[p8] = v11;
    end;

    local v12;

    if p10 == nil then
        v12 = u2;
    else
        v12 = p10;
    end;

    v11[p9] = v12;

    return pcall(p8.SetAttribute, p8, p9, p10);
end;

function v1.writeProp(u13, u14, u15) -- Line: 35
    -- upvalues: u3 (copy), u2 (copy)
    local v16 = u3[u13];

    if not v16 then
        v16 = {};
        u3[u13] = v16;
    end;

    local v17;

    if u15 == nil then
        v17 = u2;
    else
        v17 = u15;
    end;

    v16[u14] = v17;

    return pcall(function() -- Line: 37
        -- upvalues: u13 (copy), u14 (copy), u15 (copy)
        u13[u14] = u15;
    end);
end;

function v1.isEngineWrite(p18, p19) -- Line: 41
    -- upvalues: u3 (copy), u2 (copy)
    local v20 = u3[p18];

    if not v20 then
        return false;
    end;

    local v21 = v20[p19];

    if v21 == nil then
        return false;
    end;

    local Attribute = p18:GetAttribute(p19);

    if Attribute == nil then
        return v21 == u2;
    end;

    return Attribute == v21;
end;

function v1.isEngineProp(u22, u23) -- Line: 52
    -- upvalues: u3 (copy)
    local v24 = u3[u22];

    if not v24 then
        return false;
    end;

    local v25 = v24[u23];

    if v25 == nil then
        return false;
    end;

    local success, result = pcall(function() -- Line: 57
        -- upvalues: u22 (copy), u23 (copy)
        return u22[u23];
    end);

    if success then
        success = result == v25;
    end;

    return success;
end;

return v1;