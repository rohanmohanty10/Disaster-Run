  

 

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 13
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.KnitPath.Trove);
end);

return function(u2) -- Line: 17
    -- upvalues: Lighting (copy), Players (copy), u1 (ref), AssetHandler (copy), LocalPlayer (copy)
    if not u2 then
        return;
    end;

    local UberOni_Container = Lighting:FindFirstChild("UberOni_Container");

    if UberOni_Container then
        UberOni_Container:SetAttribute("Removal", true);
    end;

    if u2 == true or u2.Remove then
        return;
    end;

    Players:GetPlayerFromCharacter(u2.Host);
    local v3 = Lighting:FindFirstChildOfClass("Atmosphere");
    local u4 = Lighting:FindFirstChildOfClass("Sky");
    local v5 = workspace.Terrain:FindFirstChildOfClass("Clouds");
    local u6 = nil;
    local u7 = nil;
    local u8 = {};
    local u9 = u1.new();
    local u10 = u9:Construct(Instance, "Folder");
    u10.Name = "UberOni_Container";
    u10.Parent = Lighting;
    local v11;

    if Lighting.Brightness == 0 then
        v11 = Lighting.ClockTime == 0;
    else
        v11 = false;
    end;

    u10:SetAttribute("IsNightTime", v11);
    u10:SetAttribute("Latitude", Lighting.GeographicLatitude);

    if v3 then
        u6 = Instance.fromExisting(v3);
        v3:Destroy();
    end;

    if u4 then
        u10:SetAttribute("HasBodiesShown", u4.CelestialBodiesShown);
        u4.CelestialBodiesShown = false;
    end;

    if v5 then
        u7 = Instance.fromExisting(v5);
        v5:Destroy();
    end;

    local v12 = u9:Construct(Instance, "Clouds");
    v12.Cover = 0.65;
    v12.Density = 0.3;
    v12.Color = Color3.fromRGB(50, 50, 50);
    v12.Parent = workspace.Terrain;
    local v13 = u9:Construct(Instance, "ColorCorrectionEffect");
    v13.Brightness = -0.015;
    v13.Contrast = 0.025;
    v13.Saturation = -0.85;
    v13.Parent = Lighting;
    local v14 = u9:Construct(Instance, "Atmosphere");
    v14.Density = 0.75;
    v14.Offset = 0;
    v14.Color = Color3.new();
    v14.Decay = Color3.new(1, 1, 1);
    v14.Glare = 0.015;
    v14.Haze = 2.5;
    v14.Parent = Lighting;
    Lighting.ClockTime = u2.Time or 12.4;
    Lighting.GeographicLatitude = 60;
    Lighting.Brightness = 2;

    if u2.Arena then
        local v15 = u2.Host:FindFirstChild("HumanoidRootPart") or u2.Host:FindFirstChildWhichIsA("BasePart");
        local v16 = AssetHandler.CloneAsset("Models/SGSArena", {
            AbilityName = "Uber Oni"
        });
        v16.Parent = workspace.Effects;
        local ThousandDeathsGround = v16.ThousandDeathsGround;
        ThousandDeathsGround.CFrame = v15.CFrame * CFrame.new(0, -3.5, 0);
        ThousandDeathsGround.Anchored = false;
        ThousandDeathsGround.Weld.Part0 = v15;
        u9:Add(v16);

        for _, descendant in workspace.Map:GetDescendants() do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                u8[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end;

    local function Clear() -- Line: 94
        -- upvalues: u9 (copy)
        u9:Destroy();
    end;

    u9:Add(function() -- Line: 97
        -- upvalues: u10 (copy), Lighting (ref), u4 (copy), u6 (ref), u7 (ref), u2 (copy), u8 (copy)
        local v17 = u10:GetAttribute("IsNightTime");
        Lighting.Brightness = v17 and 0 or 2;
        Lighting.ClockTime = v17 and 0 or 12;
        Lighting.GeographicLatitude = u10:GetAttribute("Latitude") or 12;

        if u4 then
            u4.CelestialBodiesShown = u10:GetAttribute("HasBodiesShown");
        end;

        if u6 then
            u6.Parent = Lighting;
        end;

        if u7 then
            u7.Parent = workspace.Terrain;
        end;

        if u2.Arena then
            for i, v in u8 do
                if i then
                    i.Transparency = v;
                end;
            end;

            table.clear(u8);
        end;
    end);
    u9:Add(u2.Host.AncestryChanged:Connect(function(p18, p19) -- Line: 120
        -- upvalues: u9 (copy)
        if not (p19 and p19:IsDescendantOf(game)) then
            u9:Destroy();
        end;
    end));
    u9:Add(u10:GetAttributeChangedSignal("Removal"):Once(Clear));

    if u2.Hook then
        u9:Add(u2.Host:GetAttributeChangedSignal(u2.Hook):Once(Clear));
    end;

    u9:Add(LocalPlayer.CharacterAdded:Once(Clear));
end;