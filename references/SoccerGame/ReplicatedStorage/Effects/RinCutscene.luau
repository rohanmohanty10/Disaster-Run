  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local LightingStorage = require(ReplicatedStorage.Shared.LightingStorage);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

local function Emit(u1: userdata) -- Line: 18
    if u1:IsA("Beam") or u1:IsA("Trail") then
        local Attribute = u1:GetAttribute("EmitDelay");
        local Attribute2 = u1:GetAttribute("EmitDuration");
        task.delay(tonumber(Attribute) or 0, function() -- Line: 21
            -- upvalues: Attribute2 (copy), u1 (copy)
            if tonumber(Attribute2) and Attribute2 ~= 0 then
                u1.Enabled = true;

                if not u1:GetAttribute("pr3") then
                    u1:SetAttribute("pr3", 0);
                end;

                local v2 = (u1:GetAttribute("pr3") + 1) % 1000;
                u1:SetAttribute("pr3", v2);
                task.wait(Attribute2);

                if v2 == u1:GetAttribute("pr3") then
                    u1.Enabled = false;
                end;
            end;
        end);

        return;
    end;

    local Attribute = u1:GetAttribute("EmitCount");
    local Attribute2 = u1:GetAttribute("EmitDelay");
    local Attribute3 = u1:GetAttribute("EmitDuration");
    task.delay(tonumber(Attribute2) or 0, function() -- Line: 37
        -- upvalues: u1 (copy), Attribute (copy), Attribute3 (copy)
        u1:Emit(Attribute or 0);

        if tonumber(Attribute3) and Attribute3 ~= 0 then
            u1.Enabled = true;

            if not u1:GetAttribute("pr3") then
                u1:SetAttribute("pr3", 0);
            end;

            local v3 = (u1:GetAttribute("pr3") + 1) % 1000;
            u1:SetAttribute("pr3", v3);
            task.wait(Attribute3);

            if v3 == u1:GetAttribute("pr3") then
                u1.Enabled = false;
            end;
        end;
    end);
end;

return function(p4) -- Line: 55
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), SoundManager (copy), Debris (copy), Emit (copy), Popup (copy), LightingStorage (copy), Knit (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local CFrame = ReplicatedStorage.Assets.Misc.NelRin.Origin.CFrame;
    local Char = p4.Char;

    if not Char then
        return;
    end;

    local v5 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p4.Task ~= "Cutscene" then
        if p4.Task == "Cleanup" then
            Knit.GetController("CameraController").Cutscene = false;
            local v6 = Debris:FindFirstChild(v5);

            if v6 then
                v6:Destroy();
            end;

            local v7 = ReplicatedStorage.Maps:FindFirstChildOfClass("Model");

            if v7 then
                v7.Parent = workspace.Maps;
            end;
        end;

        return;
    end;

    SoundManager.SpawnSound("RinCutscene", 0.3, workspace, 150);
    local v8 = workspace.Maps:FindFirstChildOfClass("Model");

    if v8 then
        v8.Parent = ReplicatedStorage.Maps;
    end;

    local u9 = {};
    local u10 = {};
    local u11 = {};

    for _, child in workspace:GetChildren() do
        if child.Name ~= Char.Name and (child.Name ~= "Ball" and (not child:IsDescendantOf(workspace.Debris) and child ~= workspace.Debris)) then
            for _, descendant in child:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")))) then
                    table.insert(u9, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    table.insert(u9, { descendant, descendant.Transparency });
                    descendant.Transparency = NumberSequence.new(1, 1);
                end;
            end;
        end;
    end;

    local Ambient = game.Lighting.Ambient;
    local Brightness = game.Lighting.Brightness;
    local ColorShift_Bottom = game.Lighting.ColorShift_Bottom;
    local ColorShift_Top = game.Lighting.ColorShift_Top;
    local EnvironmentDiffuseScale = game.Lighting.EnvironmentDiffuseScale;
    local EnvironmentSpecularScale = game.Lighting.EnvironmentSpecularScale;
    local OutdoorAmbient = game.Lighting.OutdoorAmbient;
    local ShadowSoftness = game.Lighting.ShadowSoftness;
    local ClockTime = game.Lighting.ClockTime;
    local GeographicLatitude = game.Lighting.GeographicLatitude;
    local _ = game.Lighting.ExposureCompensation;
    game.Lighting.Ambient = Color3.fromRGB(70, 70, 70);
    game.Lighting.Brightness = 3;
    game.Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0);
    game.Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
    game.Lighting.EnvironmentDiffuseScale = 1;
    game.Lighting.EnvironmentSpecularScale = 1;
    game.Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    game.Lighting.ShadowSoftness = 0.2;
    game.Lighting.ClockTime = 23.663;
    game.Lighting.GeographicLatitude = 32.815;

    for _, child in game.Lighting:GetChildren() do
        table.insert(u10, child);
        child.Parent = ReplicatedStorage;
    end;

    for _, child in script.Lighting:GetChildren() do
        child:Clone().Parent = game.Lighting;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);

    for _, child in ReplicatedStorage.Assets.Misc.NelRin.Extra:GetChildren() do
        local v12 = child:Clone();
        v12.Parent = Folder;
        local v13 = CFrame:Inverse() * child.CFrame;
        v12:PivotTo(Char.HumanoidRootPart.CFrame * v13);
    end;

    local u14 = ReplicatedStorage.Assets.Misc.NelRin.Face.Main:Clone();
    u14.Parent = Char.Head;
    task.delay(0.5, function() -- Line: 140
        -- upvalues: Folder (copy)
        Folder.SmallSphere.Transparency = 1;
    end);
    task.delay(0.6666666666666666, function() -- Line: 144
        -- upvalues: Folder (copy), Emit (ref)
        for _, descendant in Folder.CrossBeams:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                Emit(descendant);
            end;
        end;
    end);
    task.delay(0.9, function() -- Line: 155
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "I\'m done being Itoshi Sae\'s little brother.", 6);
    end);
    task.delay(3, function() -- Line: 159
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "I\'m not some object in your lives!", 6);
    end);
    task.delay(5.5, function() -- Line: 163
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Believe in this anger..", 6);
    end);
    task.delay(8.5, function() -- Line: 167
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Let go of myself in these destructive impulses!", 7);
    end);
    task.delay(11.2, function() -- Line: 171
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "I am... me!", 7);
    end);
    task.delay(13.8, function() -- Line: 175
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "I\'m an egoist, Itoshi Rin!", 10);
    end);
    task.delay(4.566666666666666, function() -- Line: 179
        -- upvalues: Folder (copy), Emit (ref)
        for _, descendant in Folder.Aura:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                Emit(descendant);
            end;
        end;
    end);
    task.delay(6.366666666666666, function() -- Line: 190
        -- upvalues: Folder (copy), Emit (ref)
        for _, descendant in Folder.Hit1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                Emit(descendant);
            end;
        end;
    end);
    task.delay(7.45, function() -- Line: 202
        -- upvalues: Folder (copy), Emit (ref)
        for _, descendant in Folder.FeetSlide:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                Emit(descendant);
            end;
        end;
    end);
    task.delay(9.933333333333334, function() -- Line: 212
        -- upvalues: Folder (copy), Emit (ref)
        for _, descendant in Folder.SpeedLines:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                Emit(descendant);
            end;
        end;
    end);
    task.delay(11.166666666666666, function() -- Line: 223
        game.Players.LocalPlayer.PlayerGui.RinAwakeningVideo.Enabled = true;
        local RinImpactFrames = game.Players.LocalPlayer.PlayerGui.RinAwakeningVideo.RinImpactFrames;
        RinImpactFrames:Play();
        task.delay(5.6, function() -- Line: 227
            -- upvalues: RinImpactFrames (copy)
            game.Players.LocalPlayer.PlayerGui.RinAwakeningVideo.Enabled = false;
            RinImpactFrames.Playing = false;
            RinImpactFrames.TimePosition = 0;
        end);
    end);
    local u15 = false;

    local function v18() -- Line: 235
        -- upvalues: u15 (ref), u11 (copy), u14 (copy), Ambient (copy), Brightness (copy), ColorShift_Bottom (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), OutdoorAmbient (copy), ShadowSoftness (copy), ClockTime (copy), GeographicLatitude (copy), u10 (copy), u9 (copy), LightingStorage (ref)
        if u15 then
            return;
        end;

        u15 = true;

        for _, v in u11 do
            v:Disconnect();
        end;

        u14:Destroy();
        game.Lighting.Ambient = Ambient;
        game.Lighting.Brightness = Brightness;
        game.Lighting.ColorShift_Bottom = ColorShift_Bottom;
        game.Lighting.ColorShift_Top = ColorShift_Top;
        game.Lighting.EnvironmentDiffuseScale = EnvironmentDiffuseScale;
        game.Lighting.EnvironmentSpecularScale = EnvironmentSpecularScale;
        game.Lighting.OutdoorAmbient = OutdoorAmbient;
        game.Lighting.ShadowSoftness = ShadowSoftness;
        game.Lighting.ClockTime = ClockTime;
        game.Lighting.GeographicLatitude = GeographicLatitude;

        for _, child in game.Lighting:GetChildren() do
            child:Destroy();
        end;

        for _, v in u10 do
            v.Parent = game.Lighting;
        end;

        for _, v in u9 do
            local v16, v17 = unpack(v);
            v16.Transparency = v17;
        end;

        LightingStorage.ResetColors();
    end;

    task.delay(15, v18);
    table.insert(u11, Folder.Destroying:Connect(v18));
    table.insert(u11, Folder.AttributeChanged:Connect(v18));
end;