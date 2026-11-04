 
 

local u1 = {};

local function set(p2, p3, p4) -- Line: 15
    p2[p3] = p4;
end;

function u1.isAnInstance(p5) -- Line: 21
    local _, result = pcall(Game.IsA, p5, "Instance");

    return result == true;
end;

function u1.isALibrary(u6) -- Line: 27
    if not pcall(function() -- Line: 30
        -- upvalues: u6 (copy)
        local v7 = type(u6.GetApi) == "function";
        assert(v7);
    end) then
        return false;
    end;

    local _, result = pcall(string.dump, u6.GetApi);

    return result == "unable to dump given function";
end;

function u1.isAnEnum(p8) -- Line: 37
    return pcall(Enum.Material.GetEnumItems, p8) == true;
end;

function u1.coerceIntoEnum(p9, p10) -- Line: 42
    -- upvalues: u1 (copy)
    if u1.isAnEnum(p10) then
        for _, v in next, p10:GetEnumItems() do
            if p9 == v or (p9 == v.Name or p9 == v.Value) then
                return v;
            end;
        end;
    else
        error("The \'enum\' argument must be an enum.", 2);
    end;

    error("The value cannot be coerced into a enum item of the specified type.", 2);
end;

function u1.isOfEnumType(p11, p12) -- Line: 54
    -- upvalues: u1 (copy)
    if u1.isAnEnum(p12) then
        return pcall(u1.coerceIntoEnum, p11, p12) == true;
    end;

    error("The \'enum\' argument must be an enum.", 2);
end;

local Color3Value = Instance.new("Color3Value");

function u1.isAColor3(p13) -- Line: 64
    -- upvalues: set (copy), Color3Value (copy)
    return pcall(set, Color3Value, "Value", p13) == true;
end;

local CFrameValue = Instance.new("CFrameValue");

function u1.isACoordinateFrame(p14) -- Line: 70
    -- upvalues: set (copy), CFrameValue (copy)
    return pcall(set, CFrameValue, "Value", p14) == true;
end;

local BrickColorValue = Instance.new("BrickColorValue");

function u1.isABrickColor(p15) -- Line: 76
    -- upvalues: set (copy), BrickColorValue (copy)
    return pcall(set, BrickColorValue, "Value", p15) == true;
end;

local RayValue = Instance.new("RayValue");

function u1.isARay(p16) -- Line: 82
    -- upvalues: set (copy), RayValue (copy)
    return pcall(set, RayValue, "Value", p16) == true;
end;

local Vector3Value = Instance.new("Vector3Value");

function u1.isAVector3(p17) -- Line: 88
    -- upvalues: set (copy), Vector3Value (copy)
    return pcall(set, Vector3Value, "Value", p17) == true;
end;

function u1.isAVector2(u18) -- Line: 93
    return pcall(function() -- Line: 95
        -- upvalues: u18 (copy)
        return Vector2.new() + u18;
    end) == true;
end;

local Frame = Instance.new("Frame");

function u1.isAUdim2(p19) -- Line: 99
    -- upvalues: set (copy), Frame (copy)
    return pcall(set, Frame, "Position", p19) == true;
end;

function u1.isAUDim(u20) -- Line: 104
    return pcall(function() -- Line: 106
        -- upvalues: u20 (copy)
        return UDim.new() + u20;
    end) == true;
end;

local ArcHandles = Instance.new("ArcHandles");

function u1.isAAxis(p21) -- Line: 110
    -- upvalues: set (copy), ArcHandles (copy)
    return pcall(set, ArcHandles, "Axes", p21) == true;
end;

local Handles = Instance.new("Handles");

function u1.isAFace(p22) -- Line: 116
    -- upvalues: set (copy), Handles (copy)
    return pcall(set, Handles, "Faces", p22) == true;
end;

function u1.isASignal(u23) -- Line: 121
    local success, result = pcall(function() -- Line: 123
        -- upvalues: u23 (copy)
        return Game.AllowedGearTypeChanged.connect(u23);
    end);

    if success and result then
        result:disconnect();

        return true;
    end;
end;

function u1.getArchetype(p24) -- Line: 130
    return p24:gsub(".", function(p25) -- Line: 132
        return p25:byte();
    end);
end;

function u1.getSignal(p26) -- Line: 137
    return p26.MarketplaceService, p26.MarketplaceService.GetProductInfo;
end;

function u1.checkChild(p27) -- Line: 142
    return p27.JobId ~= "";
end;

function u1.getType(p28) -- Line: 147
    -- upvalues: u1 (copy)
    local v29 = type(p28);

    if v29 ~= "userdata" then
        return v29;
    end;

    if u1.isAnInstance(p28) then
        return p28.ClassName;
    end;

    if u1.isAColor3(p28) then
        return "Color3";
    end;

    if u1.isACoordinateFrame(p28) then
        return "CFrame";
    end;

    if u1.isABrickColor(p28) then
        return "BrickColor";
    end;

    if u1.isAUDim2(p28) then
        return "UDim2";
    end;

    if u1.isAUDim(p28) then
        return "UDim";
    end;

    if u1.isAVector3(p28) then
        return "Vector3";
    end;

    if u1.isAVector2(p28) then
        return "Vector2";
    end;

    if u1.isARay(p28) then
        return "Ray";
    end;

    if u1.isAnEnum(p28) then
        return "Enum";
    end;

    if u1.isASignal(p28) then
        return "RBXScriptSignal";
    end;

    if u1.isALibrary(p28) then
        return "RbxLibrary";
    end;

    if u1.isAAxis(p28) then
        return "Axes";
    end;

    if u1.isAFace(p28) then
        return "Faces";
    end;
end;

function u1.isAnInt(p30) -- Line: 174
    local v31;

    if type(p30) == "number" then
        v31 = p30 % 1 == 1;
    else
        v31 = false;
    end;

    return v31;
end;

function u1.isPositiveInt(p32) -- Line: 180
    local v33;

    if type(value) == "number" and p32 > 0 then
        v33 = math.floor(p32) == p32;
    else
        v33 = false;
    end;

    return v33;
end;

function u1.isAnArray(p34) -- Line: 187
    -- upvalues: u1 (copy)
    if type(p34) ~= "table" then
        return false;
    end;

    local v35 = 0;
    local v36 = 0;

    for i, _ in next, p34 do
        if not u1.isPositiveInt(i) then
            return false;
        end;

        v35 = math.max(v35, i);
        v36 = v36 + 1;
    end;

    return v35 == v36;
end;

return u1;