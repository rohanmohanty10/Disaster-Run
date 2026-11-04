 
 

local Graph = require(script.Parent.Parent.Graph);
local Events = require(script.Parent.Parent.Events);
local u1 = {};
local Color3_new_ret = Color3.new(1, 1, 1);

local function buildRayFn(u2, p3) -- Line: 29
    -- upvalues: Events (copy)
    local u4 = Events.makeHitParams(p3);
    u4.RespectCanCollide = true;
    pcall(function() -- Line: 32
        -- upvalues: u4 (copy), u2 (copy)
        u4:AddToFilter(u2:GetFolder());
        u4:AddToFilter(u2:GetPoolFolder());
    end);

    function p3._diskRayFn(p5, p6) -- Line: 36
        -- upvalues: u4 (copy)
        return workspace:Raycast(p5, p6, u4);
    end;
end;

local function resolveSurface(p7, p8, p9) -- Line: 42
    if p7._endpointMode == "Seek" then
        local _seekHit = p7._seekHit;

        if _seekHit then
            return _seekHit.Normal, p9;
        end;

        return nil;
    end;

    local _diskRayPos = p7._diskRayPos;

    if _diskRayPos and (p9 - _diskRayPos).Magnitude < 0.5 then
        return p7._diskNormal, p7._diskHitPos;
    end;

    p7._diskRayPos = p9;
    local v10 = p9 - p8;
    local v11 = p7._seekRayFn or p7._diskRayFn;
    local v12 = v11 and (v10.Magnitude > 0.0001 and v11(p8, v10 * 1.05)) or nil;
    local v13;

    if v12 then
        v13 = v12.Normal or nil;
    else
        v13 = nil;
    end;

    p7._diskNormal = v13;
    p7._diskHitPos = v12 and v12.Position or nil;

    return p7._diskNormal, p7._diskHitPos;
end;

local function surfaceOf(p14) -- Line: 62
    return p14._impactDecal or p14._impactDisk;
end;

function u1.place(p15, p16, p17) -- Line: 67
    -- upvalues: resolveSurface (copy), u1 (copy)
    local _impactDisk = p15._impactDisk;

    if not (_impactDisk and (p16 and p17)) then
        return;
    end;

    local v18, v19 = resolveSurface(p15, p16, p17);

    if not v18 then
        if not p15._diskHidden then
            p15._diskHidden = true;
            (p15._impactDecal or p15._impactDisk).Transparency = 1;
        end;

        return;
    end;

    local v20 = v19 + v18 * (p15._diskOffset or 0.05);
    _impactDisk.CFrame = CFrame.lookAt(v20, v20 + v18) * CFrame.Angles(0, 1.5707963267948966, 0);

    if p15._diskHidden then
        p15._diskHidden = false;
        u1.write(p15, p15._diskLastT or 0);
    end;
end;

function u1.write(p21, p22) -- Line: 87
    -- upvalues: Graph (copy), Color3_new_ret (copy)
    local _impactDisk = p21._impactDisk;

    if not _impactDisk then
        return;
    end;

    p21._diskLastT = p22;

    if p21._diskHidden then
        return;
    end;

    local Graphs = p21.Graphs;
    local Seeds = p21.Seeds;
    local v23 = Graphs.DiskSize and (Graph.QueryPointsWithTime(p22, Graphs.DiskSize, Seeds.DiskSize) or 2) or 2;
    local v24, v25;

    if p21._diskMode == "Manual" then
        v24 = Graphs.DiskTransparency and (Graph.QueryPointsWithTime(p22, Graphs.DiskTransparency, Seeds.DiskTransparency) or 0) or 0;
        v25 = Graphs.DiskBrightness and (Graph.QueryPointsWithTime(p22, Graphs.DiskBrightness, Seeds.DiskBrightness) or 1) or 1;
    else
        v24 = p21._curTrans or 0;
        v25 = p21._curBright or 1;
        local v26 = p21._diskThick0 or 0;
        v23 = v23 * (v26 > 0.0001 and ((p21._curThick or v26) / v26 or 1) or 1) * math.clamp(1 - v24, 0, 1);
    end;

    local math_max_ret = math.max(0.05, v23);
    local math_max_ret2 = math.max(0.05, v23);
    _impactDisk.Size = Vector3.new(0.05, math_max_ret, math_max_ret2);
    local v27 = Graphs.Color and Graph.QueryColorPointWithTime(p22, Graphs.Color) or (p21._diskBaseColor or Color3_new_ret);
    local _diskTipTint = p21._diskTipTint;
    local v28 = v27.R * v25;
    local v29 = v27.G * v25;
    local v30 = v27.B * v25;

    if _diskTipTint then
        v28 = v28 * _diskTipTint.R;
        v29 = v29 * _diskTipTint.G;
        v30 = v30 * _diskTipTint.B;
    end;

    local Color3_new_ret2 = Color3.new(math.min(v28, 1), math.min(v29, 1), (math.min(v30, 1)));
    local _impactDecal = p21._impactDecal;

    if _impactDecal then
        _impactDecal.Transparency = v24;
        _impactDecal.Color3 = Color3_new_ret2;

        return;
    end;

    _impactDisk.Transparency = v24;
    _impactDisk.Color = Color3_new_ret2;
end;

function u1.attach(p31, p32, u33) -- Line: 123
    -- upvalues: Color3_new_ret (copy), Graph (copy), buildRayFn (copy), u1 (copy)
    if not u33.DiskEnabled or p32._impactDisk then
        return;
    end;

    local VisualPart = p32.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "ImpactDisk";
    Part.Shape = Enum.PartType.Cylinder;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = true;
    Part.CastShadow = false;
    Part.Locked = true;
    Part.Archivable = false;
    Part.Size = Vector3.new(0.05, 1, 1);
    local u34 = Color3_new_ret;
    pcall(function() -- Line: 140
        -- upvalues: Part (copy), u33 (copy), u34 (ref)
        Part.Material = u33.RenderTemplate.Material;
        u34 = u33.RenderTemplate.Color;
    end);
    local DiskTexture = u33.DiskTexture;

    if type(DiskTexture) == "string" and DiskTexture ~= "" then
        local Decal = Instance.new("Decal");
        Decal.Name = "Face";
        Decal.Face = Enum.NormalId.Right;
        Decal.Texture = DiskTexture;
        Decal.Parent = Part;
        Part.Transparency = 1;
        p32._impactDecal = Decal;
    end;

    if p32._matteCarried then
        Part.LocalTransparencyModifier = 1;

        if p32._impactDecal then
            p32._impactDecal.LocalTransparencyModifier = 1;
        end;
    end;

    p32._impactDisk = Part;
    p32._diskMode = u33.DiskMode or "Follow";
    p32._diskOffset = u33.DiskOffset or 0.05;
    p32._diskThick0 = p32._curThick or 0.15;
    p32._diskBaseColor = u34;
    local Gradient = p32.Graphs.Gradient;
    p32._diskTipTint = Gradient and Graph.QueryColorPointWithTime(1, Gradient) or nil;
    p32._diskHidden = false;
    p32._diskLastT = 0;
    p32._diskRayPos = nil;
    p32._diskNormal = nil;
    p32._diskHitPos = nil;
    p32.Graphs.DiskSize = u33.DiskSize;
    p32.Graphs.DiskTransparency = u33.DiskTransparency;
    p32.Graphs.DiskBrightness = u33.DiskBrightness;
    p32.Seeds.DiskSize = u33.DiskSize and (Graph.GenerateSeed(u33.DiskSize) or {}) or {};
    p32.Seeds.DiskTransparency = u33.DiskTransparency and (Graph.GenerateSeed(u33.DiskTransparency) or {}) or {};
    p32.Seeds.DiskBrightness = u33.DiskBrightness and Graph.GenerateSeed(u33.DiskBrightness) or {};

    if p32._endpointMode ~= "Seek" then
        buildRayFn(p31, p32);
    end;

    Part.Parent = VisualPart.Parent;
    u1.place(p32, p32._lastStartPos, p32._lastEndPos);
    u1.write(p32, 0);
end;

function u1.detach(p35) -- Line: 186
    local _impactDisk = p35._impactDisk;

    if _impactDisk then
        pcall(function() -- Line: 188
            -- upvalues: _impactDisk (copy)
            _impactDisk:Destroy();
        end);
    end;

    p35._impactDisk = nil;
    p35._impactDecal = nil;
    p35._diskRayFn = nil;
    p35._diskTipTint = nil;
end;

function u1.refresh(p36, p37, p38) -- Line: 196
    -- upvalues: u1 (copy)
    u1.detach(p37);
    u1.attach(p36, p37, p38);
end;

return u1;