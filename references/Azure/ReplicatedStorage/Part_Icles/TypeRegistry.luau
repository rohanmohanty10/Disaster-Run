 

 

local u1 = {
    CONFIG_NAME = "PartIcleProperties",
    Types = require(script.TypeData).Types
};

function u1.getTypeFor(p2) -- Line: 26
    -- upvalues: u1 (copy)
    for i, v in pairs(u1.Types) do
        if v.classCheck(p2) then
            return v, i;
        end;
    end;

    return nil, nil;
end;

function u1.getTypeName(p3) -- Line: 35
    -- upvalues: u1 (copy)
    local _, v4 = u1.getTypeFor(p3);

    return v4;
end;

function u1.getConfig(p5) -- Line: 40
    -- upvalues: u1 (copy)
    return p5:FindFirstChild(u1.CONFIG_NAME);
end;

function u1.getAttrName(p6, p7) -- Line: 45
    local v8 = p6.properties[p7];

    if v8 and v8.attrName then
        return v8.attrName;
    end;

    return p7;
end;

local function promoteScalar(p9, p10) -- Line: 55
    if type(p10) ~= "number" then
        return p10;
    end;

    if p9.type == "NumberSequence" then
        return NumberSequence.new(p10);
    end;

    if p9.type == "NumberRange" then
        return NumberRange.new(p10);
    end;

    return p10;
end;

function u1.read(u11, u12) -- Line: 62
    -- upvalues: u1 (copy)
    local TypeFor = u1.getTypeFor(u11);

    if not TypeFor then
        return nil;
    end;

    local u13 = TypeFor.properties[u12];

    if not u13 then
        return nil;
    end;

    if TypeFor.directAccess then
        if u13.attribute then
            local Attribute = u11:GetAttribute(u13.attrName or u12);

            if Attribute == nil then
                return u13.default;
            end;

            return Attribute;
        end;

        local success, result = pcall(function() -- Line: 76
            -- upvalues: u11 (copy), u12 (copy)
            return u11[u12];
        end);

        if success and result ~= nil then
            return result;
        end;

        return u13.default;
    end;

    local Config = u1.getConfig(u11);

    if not Config then
        return nil;
    end;

    local Attribute = Config:GetAttribute((u1.getAttrName(TypeFor, u12)));

    if Attribute == nil then
        return u13.default;
    end;

    local u14 = Attribute;

    if type(u14) == "number" then
        if u13.type == "NumberSequence" then
            u14 = NumberSequence.new(u14);
        elseif u13.type == "NumberRange" then
            u14 = NumberRange.new(u14);
        end;
    end;

    if u13.type ~= "enum" or type(u14) ~= "string" then
        return u14;
    end;

    local success, result = pcall(function() -- Line: 92
        -- upvalues: u13 (copy), u14 (ref)
        return Enum[u13.enumType][u14];
    end);

    return success and result and result or u13.default;
end;

local function _bumpPoolGen(p15) -- Line: 102
    local RenderTemplate = p15:FindFirstChild("RenderTemplate");

    if not RenderTemplate then
        return;
    end;

    local u16 = RenderTemplate:GetAttribute("_PoolGen") or 0;
    pcall(function() -- Line: 106
        -- upvalues: RenderTemplate (copy), u16 (copy)
        RenderTemplate:SetAttribute("_PoolGen", u16 + 1);
    end);
end;

function u1.bumpPoolGen(p17) -- Line: 111
    if not p17 then
        return;
    end;

    local RenderTemplate = p17:FindFirstChild("RenderTemplate");

    if not RenderTemplate then
        return;
    end;

    local u18 = RenderTemplate:GetAttribute("_PoolGen") or 0;
    pcall(function() -- Line: 106
        -- upvalues: RenderTemplate (copy), u18 (copy)
        RenderTemplate:SetAttribute("_PoolGen", u18 + 1);
    end);
end;

local function _clampNonNegativeSeq(p19) -- Line: 117
    if typeof(p19) ~= "NumberSequence" then
        return p19;
    end;

    local Keypoints = p19.Keypoints;
    local v20 = false;

    for _, v in ipairs(Keypoints) do
        if v.Value < 0 or v.Envelope > v.Value then
            v20 = true;
            break;
        end;
    end;

    if not v20 then
        return p19;
    end;

    local v21 = {};

    for _, v in ipairs(Keypoints) do
        local math_max_ret = math.max(0, v.Value);
        local math_min_ret = math.min(v.Envelope, math_max_ret);
        local math_max_ret2 = math.max(0, math_min_ret);
        table.insert(v21, NumberSequenceKeypoint.new(v.Time, math_max_ret, math_max_ret2));
    end;

    return NumberSequence.new(v21);
end;

local function _isInvalidNumber(p22) -- Line: 138
    local v23;

    if type(p22) == "number" then
        v23 = (p22 ~= p22 or p22 == (1 / 0)) and true or p22 == (-1 / 0);
    else
        v23 = false;
    end;

    return v23;
end;

local function _isInvalidValue(p24) -- Line: 141
    if type(p24) == "number" then
        local v25;

        if type(p24) == "number" then
            v25 = (p24 ~= p24 or p24 == (1 / 0)) and true or p24 == (-1 / 0);
        else
            v25 = false;
        end;

        return v25;
    end;

    if typeof(p24) == "NumberRange" then
        local Min = p24.Min;
        local v26;

        if type(Min) == "number" then
            v26 = (Min ~= Min or Min == (1 / 0)) and true or Min == (-1 / 0);
        else
            v26 = false;
        end;

        if not v26 then
            local Max = p24.Max;

            if type(Max) == "number" then
                v26 = (Max ~= Max or Max == (1 / 0)) and true or Max == (-1 / 0);
            else
                v26 = false;
            end;
        end;

        return v26;
    end;

    if typeof(p24) ~= "NumberSequence" then
        return false;
    end;

    for _, v in ipairs(p24.Keypoints) do
        local Time = v.Time;
        local v27;

        if type(Time) == "number" then
            v27 = (Time ~= Time or Time == (1 / 0)) and true or Time == (-1 / 0);
        else
            v27 = false;
        end;

        if v27 then
            return true;
        end;

        local Value = v.Value;
        local v28;

        if type(Value) == "number" then
            v28 = (Value ~= Value or Value == (1 / 0)) and true or Value == (-1 / 0);
        else
            v28 = false;
        end;

        if v28 then
            return true;
        end;

        local Envelope = v.Envelope;
        local v29;

        if type(Envelope) == "number" then
            v29 = (Envelope ~= Envelope or Envelope == (1 / 0)) and true or Envelope == (-1 / 0);
        else
            v29 = false;
        end;

        if v29 then
            return true;
        end;

        if v.Time < 0 or v.Time > 1 then
            return true;
        end;
    end;

    return false;
end;

function u1.write(u30, u31, u32) -- Line: 156
    -- upvalues: _isInvalidValue (copy), u1 (copy), _clampNonNegativeSeq (copy)
    if _isInvalidValue(u32) then
        warn("[Part-Icles] TypeRegistry.write rejected invalid value for " .. tostring(u31));

        return;
    end;

    local TypeFor = u1.getTypeFor(u30);

    if not TypeFor then
        return;
    end;

    local v33 = TypeFor.properties[u31];

    if not v33 then
        return;
    end;

    if TypeFor.directAccess then
        if v33.nonNegative then
            u32 = _clampNonNegativeSeq(u32);
        end;

        if v33.attribute then
            u30:SetAttribute(v33.attrName or u31, u32);
        else
            pcall(function() -- Line: 174
                -- upvalues: u30 (copy), u31 (copy), u32 (ref)
                u30[u31] = u32;
            end);
        end;

        local RenderTemplate = u30:FindFirstChild("RenderTemplate");

        if RenderTemplate then
            local u34 = RenderTemplate:GetAttribute("_PoolGen") or 0;
            pcall(function() -- Line: 106
                -- upvalues: RenderTemplate (copy), u34 (copy)
                RenderTemplate:SetAttribute("_PoolGen", u34 + 1);
            end);
        end;

        return;
    end;

    local Config = u1.getConfig(u30);

    if not Config then
        return;
    end;

    local AttrName = u1.getAttrName(TypeFor, u31);

    if v33.type == "enum" then
        if typeof(u32) == "EnumItem" then
            Config:SetAttribute(AttrName, u32.Name);
        else
            Config:SetAttribute(AttrName, (tostring(u32)));
        end;
    else
        if v33.nonNegative and typeof(u32) == "NumberSequence" then
            local Keypoints = u32.Keypoints;
            local v35 = false;

            for _, v in ipairs(Keypoints) do
                if v.Value < 0 or v.Envelope > v.Value then
                    v35 = true;
                    break;
                end;
            end;

            if v35 then
                local v36 = {};

                for _, v in ipairs(Keypoints) do
                    local math_max_ret = math.max(0, v.Value);
                    local math_min_ret = math.min(v.Envelope, math_max_ret);
                    local math_max_ret2 = math.max(0, math_min_ret);
                    table.insert(v36, NumberSequenceKeypoint.new(v.Time, math_max_ret, math_max_ret2));
                end;

                u32 = NumberSequence.new(v36);
            end;
        end;

        Config:SetAttribute(AttrName, u32);
    end;

    local RenderTemplate = u30:FindFirstChild("RenderTemplate");

    if RenderTemplate then
        local u37 = RenderTemplate:GetAttribute("_PoolGen") or 0;
        pcall(function() -- Line: 106
            -- upvalues: RenderTemplate (copy), u37 (copy)
            RenderTemplate:SetAttribute("_PoolGen", u37 + 1);
        end);
    end;
end;

function u1.readAll(p38) -- Line: 215
    -- upvalues: u1 (copy)
    local TypeFor = u1.getTypeFor(p38);

    if not TypeFor then
        return nil;
    end;

    local Config = u1.getConfig(p38);

    if not Config then
        return nil;
    end;

    local v39 = {};

    for i, v in pairs(TypeFor.properties) do
        local Attribute = Config:GetAttribute((u1.getAttrName(TypeFor, i)));

        if Attribute == nil then
            v39[i] = v.default;
        elseif v.type == "enum" and type(Attribute) == "string" then
            v39[i] = Enum[v.enumType][Attribute];
        else
            if type(Attribute) == "number" then
                if v.type == "NumberSequence" then
                    Attribute = NumberSequence.new(Attribute);
                elseif v.type == "NumberRange" then
                    Attribute = NumberRange.new(Attribute);
                end;
            end;

            v39[i] = Attribute;
        end;
    end;

    return v39;
end;

function u1.writeDefaults(p40, p41) -- Line: 238
    for i, v in pairs(p41.properties) do
        if not v.optional then
            local v42 = v.attrName or i;
            local default = v.default;

            if v.type == "enum" then
                p40:SetAttribute(v42, default.Name);
            else
                p40:SetAttribute(v42, default);
            end;
        end;
    end;
end;

function u1.createConfig(p43, p44) -- Line: 254
    -- upvalues: u1 (copy)
    local Configuration = Instance.new("Configuration");
    Configuration.Name = u1.CONFIG_NAME;
    u1.writeDefaults(Configuration, p44);
    Configuration.Parent = p43;

    return Configuration;
end;

function u1.isGraph(p45) -- Line: 262
    return p45.type == "NumberSequence" and true or p45.type == "ColorSequence";
end;

function u1.isNonNegative(p46) -- Line: 266
    return p46.nonNegative == true;
end;

function u1.getPropDef(p47, p48) -- Line: 270
    -- upvalues: u1 (copy)
    local v49 = u1.Types[p47];

    if v49 then
        return v49.properties[p48];
    end;

    return nil;
end;

function u1.getDefault(p50, p51) -- Line: 277
    -- upvalues: u1 (copy)
    local v52 = u1.Types[p50];

    if not v52 then
        return nil;
    end;

    local v53 = v52.properties[p51];

    if v53 then
        return v53.default;
    end;

    return nil;
end;

function u1.isInsideRenderTemplate(p54, p55) -- Line: 287
    local Parent = p54.Parent;

    while Parent and Parent ~= p55 do
        if Parent.Name == "RenderTemplate" then
            return true;
        end;

        Parent = Parent.Parent;
    end;

    return false;
end;

return u1;