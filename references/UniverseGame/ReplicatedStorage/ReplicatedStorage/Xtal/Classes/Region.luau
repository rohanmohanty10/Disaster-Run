  

 

local u1 = {};

local function ResolveParams(...) -- Line: 66
    if ... then
        local v2 = ...;

        if typeof(v2) == "OverlapParams" then
            return v2;
        end;

        if type(v2) == "table" then
            local v3 = OverlapParams.new();
            local v4 = v2.Instances or v2.FilterDescendantsInstances;
            local v5 = type(v4) ~= "table" and { v4 } or v4;
            v3.FilterType = v2.Type or (v2.FilterType or Enum.RaycastFilterType.Blacklist);
            v3.FilterDescendantsInstances = v5 or {};
            v3.MaxParts = v2.Max or (v2.MaxParts or 0);
            v3.CollisionGroup = v2.CollisionGroup or (v2.Group or "Default");

            return v3;
        end;

        local v6, v7, v8, v9 = ...;
        local v10 = type(v7) ~= "table" and { v7 } or v7;
        local v11 = OverlapParams.new();
        v11.FilterType = v6 or Enum.RaycastFilterType.Blacklist;
        v11.FilterDescendantsInstances = v10 or {};
        v11.MaxParts = v8 or 0;
        v11.CollisionGroup = v9 or "Default";

        return v11;
    end;
end;

function u1.__index(p12, p13) -- Line: 97
    -- upvalues: u1 (copy)
    if rawget(p12, "Type") == "Part" then
        if p13 == "CFrame" then
            return rawget(p12, "Part").CFrame;
        end;

        if p13 == "Size" then
            return rawget(p12, "Part").Size;
        end;
    end;

    if u1[p13] then
        return u1[p13];
    end;
end;

function u1.new(...) -- Line: 111
    -- upvalues: u1 (copy)
    local v14, v15 = ...;

    if typeof(v14) == "Instance" then
        return u1.Part(...);
    end;

    if type(v15) == "number" then
        return u1.Ball(...);
    end;

    return u1.Block(...);
end;

function u1.Block(p16, p17, ...) -- Line: 122
    -- upvalues: u1 (copy), ResolveParams (copy)
    local v18 = setmetatable({}, u1);
    v18.CFrame = p16;
    v18.Size = p17;
    v18.OverlapParams = ResolveParams(...);
    v18.Type = "Block";
    v18.WorldModel = game.Workspace;

    return v18;
end;

function u1.Ball(p19, p20, ...) -- Line: 134
    -- upvalues: u1 (copy), ResolveParams (copy)
    local v21 = setmetatable({}, u1);
    v21.CFrame = p19;
    v21.Size = p20;
    v21.OverlapParams = ResolveParams(...);
    v21.Type = "Ball";
    v21.WorldModel = game.Workspace;

    return v21;
end;

function u1.Part(p22, ...) -- Line: 146
    -- upvalues: u1 (copy), ResolveParams (copy)
    local v23 = setmetatable({}, u1);
    v23.Part = p22;
    v23.OverlapParams = ResolveParams(...);
    v23.Type = "Part";
    v23.WorldModel = game.Workspace;

    return v23;
end;

function u1.FromPart(p24, ...) -- Line: 157
    -- upvalues: u1 (copy)
    return u1.Block(p24.CFrame, p24.Size, ...);
end;

function u1.GetPartsInWorldModel(p25, p26, ...) -- Line: 161
    -- upvalues: ResolveParams (copy)
    local v27 = ... and ResolveParams(...) or p25.OverlapParams;

    if p25.Type == "Block" then
        return p26:GetPartBoundsInBox(p25.CFrame, p25.Size, v27);
    end;

    if p25.Type == "Ball" then
        return p26:GetPartBoundsInRadius(p25.CFrame, p25.Size, v27);
    end;

    if p25.Type == "Part" then
        return p26:GetPartsInPart(p25.Part, v27);
    end;
end;

function u1.GetParts(p28, ...) -- Line: 172
    return p28:GetPartsInWorldModel(p28.WorldModel, ...);
end;

function u1.CastPoint(p29, p30) -- Line: 176
    if p29.Type == "Block" then
        local v31 = p29.CFrame:PointToObjectSpace(p30);
        local v32;

        if math.abs(v31.X) <= p29.Size.X / 2 and math.abs(v31.Y) <= p29.Size.Y / 2 then
            v32 = math.abs(v31.Z) <= p29.Size.Z / 2;
        else
            v32 = false;
        end;

        return v32;
    end;

    if p29.Type == "Sphere" then
        return (p29.CFrame.p - p30).Magnitude <= p29.Size;
    end;

    if p29.Type == "Part" then
        local v33 = p29.Part.CFrame:PointToObjectSpace(p30);
        local v34;

        if math.abs(v33.X) <= p29.Part.Size.X / 2 and math.abs(v33.Y) <= p29.Part.Size.Y / 2 then
            v34 = math.abs(v33.Z) <= p29.Part.Size.Z / 2;
        else
            v34 = false;
        end;

        return v34;
    end;
end;

function u1.CastPart(p35, ...) -- Line: 188
    local v36 = OverlapParams.new();
    v36.FilterType = Enum.RaycastFilterType.Whitelist;
    v36.FilterDescendantsInstances = { ... };
    v36.MaxParts = #v36.FilterDescendantsInstances;
    local v37 = p35:GetParts(v36);

    if #v37 == 0 then
        v37 = nil;
    end;

    return v37;
end;

function u1.GetPartsWithIgnoreList(p38, ...) -- Line: 200
    return p38:GetParts(Enum.RaycastFilterType.Blacklist, ...);
end;

function u1.GetPartsWithWhiteList(p39, ...) -- Line: 204
    return p39:GetParts(Enum.RaycastFilterType.Whitelist, ...);
end;

function u1.Destroy(p40) -- Line: 208
    setmetatable(p40, nil);
end;

u1.Sphere = u1.Ball;
u1.Radius = u1.Ball;
u1.GetPartsWithBlackList = u1.GetPartsWithIgnoreList;
u1.FindPartsInRegion3 = u1.GetPartsWithIgnoreList;
u1.FindPartsInRegion3WithIgnoreList = u1.GetPartsWithIgnoreList;
u1.FindPartsInRegion3WithWhiteList = u1.GetPartsWithWhiteList;
u1.Cast = u1.GetPartsWithIgnoreList;

return u1;