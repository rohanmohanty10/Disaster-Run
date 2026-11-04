  

local VRService = game:GetService("VRService");
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 16
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.transparencyDirty = false;
    v2.enabled = false;
    v2.lastTransparency = nil;
    v2.descendantAddedConn = nil;
    v2.descendantRemovingConn = nil;
    v2.toolDescendantAddedConns = {};
    v2.toolDescendantRemovingConns = {};
    v2.cachedParts = {};

    return v2;
end;

function u1.HasToolAncestor(p3: table, p4: userdata) -- Line: 32
    if p4.Parent == nil then
        return false;
    end;

    assert(p4.Parent, "");

    return p4.Parent:IsA("Tool") or p3:HasToolAncestor(p4.Parent);
end;

function u1.IsValidPartToModify(p5: table, p6: userdata) -- Line: 38
    if p6:GetAttribute("Invis") then
        return false;
    end;

    if p6:IsA("BasePart") or p6:IsA("Decal") then
        return not p5:HasToolAncestor(p6);
    end;

    return false;
end;

function u1.CachePartsRecursive(p7, p8) -- Line: 48
    if p8 then
        if p7:IsValidPartToModify(p8) then
            p7.cachedParts[p8] = true;
            p7.transparencyDirty = true;
        end;

        for _, child in pairs(p8:GetChildren()) do
            p7:CachePartsRecursive(child);
        end;
    end;
end;

function u1.TeardownTransparency(p9) -- Line: 60
    for i, _ in pairs(p9.cachedParts) do
        i.LocalTransparencyModifier = 0;
    end;

    p9.cachedParts = {};
    p9.transparencyDirty = true;
    p9.lastTransparency = nil;

    if p9.descendantAddedConn then
        p9.descendantAddedConn:disconnect();
        p9.descendantAddedConn = nil;
    end;

    if p9.descendantRemovingConn then
        p9.descendantRemovingConn:disconnect();
        p9.descendantRemovingConn = nil;
    end;

    for i, v in pairs(p9.toolDescendantAddedConns) do
        v:Disconnect();
        p9.toolDescendantAddedConns[i] = nil;
    end;

    for i, v in pairs(p9.toolDescendantRemovingConns) do
        v:Disconnect();
        p9.toolDescendantRemovingConns[i] = nil;
    end;
end;

function u1.SetupTransparency(u10, u11) -- Line: 86
    u10:TeardownTransparency();

    if u10.descendantAddedConn then
        u10.descendantAddedConn:disconnect();
    end;

    u10.descendantAddedConn = u11.DescendantAdded:Connect(function(p12) -- Line: 90
        -- upvalues: u10 (copy), u11 (copy)
        if not u10:IsValidPartToModify(p12) then
            if p12:IsA("Tool") then
                if u10.toolDescendantAddedConns[p12] then
                    u10.toolDescendantAddedConns[p12]:Disconnect();
                end;

                u10.toolDescendantAddedConns[p12] = p12.DescendantAdded:Connect(function(p13) -- Line: 98
                    -- upvalues: u10 (ref)
                    u10.cachedParts[p13] = nil;

                    if p13:IsA("BasePart") or p13:IsA("Decal") then
                        p13.LocalTransparencyModifier = 0;
                    end;
                end);

                if u10.toolDescendantRemovingConns[p12] then
                    u10.toolDescendantRemovingConns[p12]:disconnect();
                end;

                u10.toolDescendantRemovingConns[p12] = p12.DescendantRemoving:Connect(function(p14) -- Line: 106
                    -- upvalues: u11 (ref), u10 (ref)
                    wait();

                    if u11 and (p14 and (p14:IsDescendantOf(u11) and u10:IsValidPartToModify(p14))) then
                        u10.cachedParts[p14] = true;
                        u10.transparencyDirty = true;
                    end;
                end);
            end;

            return;
        end;

        u10.cachedParts[p12] = true;
        u10.transparencyDirty = true;
    end);

    if u10.descendantRemovingConn then
        u10.descendantRemovingConn:disconnect();
    end;

    u10.descendantRemovingConn = u11.DescendantRemoving:connect(function(p15) -- Line: 118
        -- upvalues: u10 (copy)
        if u10.cachedParts[p15] then
            u10.cachedParts[p15] = nil;
            p15.LocalTransparencyModifier = 0;
        end;
    end);
    u10:CachePartsRecursive(u11);
end;

function u1.Enable(p16: table, p17: boolean) -- Line: 129
    if p16.enabled ~= p17 then
        p16.enabled = p17;
    end;
end;

function u1.SetSubject(p18, p19) -- Line: 135
    local v20;

    if p19 and p19:IsA("Humanoid") then
        v20 = p19.Parent;
    else
        v20 = nil;
    end;

    if p19 and (p19:IsA("VehicleSeat") and p19.Occupant) then
        v20 = p19.Occupant.Parent;
    end;

    if v20 then
        p18:SetupTransparency(v20);

        return;
    end;

    p18:TeardownTransparency();
end;

function u1.Update(p21, p22) -- Line: 150
    -- upvalues: CameraUtils (copy), VRService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera and p21.enabled then
        local magnitude = (workspace_CurrentCamera.Focus.p - workspace_CurrentCamera.CoordinateFrame.p).magnitude;
        local v23 = magnitude < 2 and 1 - (magnitude - 0.5) / 1.5 or 0;
        local v24 = v23 < 0.5 and 0 or v23;

        if p21.lastTransparency and (v24 < 1 and p21.lastTransparency < 0.95) then
            local v25 = 2.8 * p22;
            local math_clamp_ret = math.clamp(v24 - p21.lastTransparency, -v25, v25);
            v24 = p21.lastTransparency + math_clamp_ret;
        else
            p21.transparencyDirty = true;
        end;

        local v26 = CameraUtils.Round(v24, 2);
        local math_clamp_ret = math.clamp(v26, 0, 1);

        if p21.transparencyDirty or p21.lastTransparency ~= math_clamp_ret then
            for i, _ in pairs(p21.cachedParts) do
                if VRService.VREnabled and VRService.AvatarGestures then
                    local v27 = {
                        [Enum.AccessoryType.Hat] = true,
                        [Enum.AccessoryType.Hair] = true,
                        [Enum.AccessoryType.Face] = true,
                        [Enum.AccessoryType.Eyebrow] = true,
                        [Enum.AccessoryType.Eyelash] = true
                    };

                    if i.Parent:IsA("Accessory") and v27[i.Parent.AccessoryType] or i.Name == "Head" then
                        i.LocalTransparencyModifier = math_clamp_ret;
                    else
                        i.LocalTransparencyModifier = 0;
                    end;
                else
                    i.LocalTransparencyModifier = math_clamp_ret;
                end;
            end;

            p21.transparencyDirty = false;
            p21.lastTransparency = math_clamp_ret;
        end;
    end;
end;

return u1;