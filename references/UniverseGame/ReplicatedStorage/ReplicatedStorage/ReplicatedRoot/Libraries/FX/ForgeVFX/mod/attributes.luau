  

 

local RunService = game:GetService("RunService");
local u1 = require("./logger");
local u2 = RunService:IsServer();
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = 0;
local u22 = {
    cache = function(p7) -- Line: 34, Name: cache
        -- upvalues: u1 (copy), u6 (ref), u3 (copy)
        local v8 = p7:GetAttribute("U");

        if v8 then
            u1.warn((`{p7} is already cached (id={v8})`));

            return;
        end;

        local v9 = p7:GetAttributes();

        if next(v9) == nil then
            return;
        end;

        u6 = u6 + 1;
        local v10 = u6;
        local v11 = {};

        for i, v in v9 do
            if i ~= "U" then
                v11[i] = v;
                p7:SetAttribute(i, nil);
            end;
        end;

        u3[v10] = v11;
        p7:SetAttribute("U", v10);
    end,

    restore = function(p12) -- Line: 67, Name: restore
        -- upvalues: u3 (copy), u1 (copy)
        local v13 = p12:GetAttribute("U");
        local v14 = u3[v13];

        if not v14 then
            u1.warn((`{p12} with cache id '{v13}' doesn't have any cached attributes`));

            return;
        end;

        for i, v in v14 do
            p12:SetAttribute(i, v);
        end;

        p12:SetAttribute("U", nil);
    end,

    get = function(p15, p16, p17, p18, p19) -- Line: 84, Name: get
        -- upvalues: u3 (copy), u2 (copy)
        local v20 = u3[p15:GetAttribute("U")];

        if v20 then
            v20 = v20[p16];
        end;

        if v20 ~= nil then
            if p19 then
                return p19(v20);
            end;

            if v20 == nil then
                return p17;
            end;

            return v20;
        end;

        local v21 = p15:GetAttribute(p16);

        if p19 then
            p17 = p19(v21);
        elseif v21 ~= nil then
            p17 = v21;
        end;

        if not p18 and u2 then
            p15:SetAttribute(p16, p17);
        end;

        return p17;
    end
};

function u22.getRange(p23, p24, u25, u26, p27) -- Line: 109
    -- upvalues: u22 (copy)
    return u22.get(p23, p24, u25, p27, function(p28) -- Line: 110
        -- upvalues: u25 (copy), u26 (copy)
        if typeof(p28) ~= "NumberRange" then
            return u25;
        end;

        if u26 then
            return NumberRange.new(math.clamp(p28.Min, u26.Min, u26.Max), (math.clamp(p28.Max, u26.Min, u26.Max)));
        end;

        return p28;
    end);
end;

function u22.getEnum(p29, p30, u31, u32, p33) -- Line: 127
    -- upvalues: u22 (copy)
    return u22.get(p29, p30, u31, p33, function(p34) -- Line: 128
        -- upvalues: u32 (copy), u31 (copy)
        if p34 == nil or not table.find(u32, p34) then
            return u31;
        end;

        return p34;
    end);
end;

function u22.set(p35, p36, p37) -- Line: 137
    -- upvalues: u3 (copy)
    local v38 = u3[p35:GetAttribute("U")];

    if v38 then
        v38[p36] = p37;

        return;
    end;

    p35:SetAttribute(p36, p37);
end;

function u22.isCached(p39) -- Line: 149
    return p39:GetAttribute("U") ~= nil;
end;

function u22.getState(p40, p41, p42) -- Line: 153
    -- upvalues: u5 (copy)
    local v43 = u5[p40];

    if v43 then
        v43 = v43[p41];
    end;

    if v43 == nil then
        return p42;
    end;

    return v43;
end;

function u22.setState(p44, p45, p46) -- Line: 160
    -- upvalues: u5 (copy)
    local v47 = u5[p44];

    if not v47 then
        v47 = {};
        u5[p44] = v47;
    end;

    v47[p45] = p46;
end;

function u22.clearState(p48) -- Line: 171
    -- upvalues: u5 (copy)
    u5[p48] = nil;
end;

function u22.trigger(p49, p50, p51) -- Line: 175
    -- upvalues: u4 (copy)
    local v52 = u4[p49];

    if v52 then
        v52 = v52[p50];
    end;

    if not v52 then
        return;
    end;

    for _, v in v52 do
        v(p51);
    end;
end;

function u22.hook(u53, u54, u55) -- Line: 188
    -- upvalues: u4 (copy), u22 (copy)
    local u56 = u4[u53];

    if not u56 then
        u56 = {};
        u4[u53] = u56;
    end;

    local u57 = u56[u54];

    if not u57 then
        u57 = {};
        u56[u54] = u57;
    end;

    table.insert(u57, u55);
    local u58;

    if u22.isCached(u53) then
        u58 = nil;
    else
        u58 = u53:GetAttributeChangedSignal(u54):Connect(function() -- Line: 208
            -- upvalues: u53 (copy), u54 (copy), u55 (copy)
            u55((u53:GetAttribute(u54)));
        end);
    end;

    return function() -- Line: 214
        -- upvalues: u58 (ref), u57 (ref), u55 (copy), u56 (ref), u54 (copy), u4 (ref), u53 (copy)
        if u58 then
            u58:Disconnect();
        end;

        local v59 = table.find(u57, u55);

        if v59 then
            table.remove(u57, v59);
        end;

        if #u57 == 0 then
            u56[u54] = nil;
        end;

        if next(u56) == nil then
            u4[u53] = nil;
        end;
    end;
end;

return u22;