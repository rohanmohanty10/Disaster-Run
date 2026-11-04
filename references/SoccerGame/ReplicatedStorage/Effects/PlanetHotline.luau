  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
local _ = game.Lighting;
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage.Assets.Animations);
local Debris = workspace:FindFirstChild("Debris");

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3)
    local function emit(u4) -- Line: 29
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDelay");
            local Attribute2 = u4:GetAttribute("EmitCount");

            if Attribute2 and Attribute2 ~= 0 then
                if Attribute and Attribute ~= 0 then
                    task.delay(Attribute, function() -- Line: 36
                        -- upvalues: u4 (copy), Attribute2 (copy)
                        u4:Emit(Attribute2);
                    end);

                    return;
                end;

                u4:Emit(Attribute2);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 67
    task.delay(p6, function() -- Line: 69
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

local function Weld(p7, p8) -- Line: 85
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p7;
    WeldConstraint.Part1 = p8;
    WeldConstraint.Parent = p7;

    return WeldConstraint;
end;

return function(p9) -- Line: 92
    -- upvalues: SpectatorController (copy), Debris (copy), ReplicatedStorage (copy), SoundManager (copy), Players (copy), TweenService (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Character = p9.Character;

    if not Character then
        for _, child in Debris:GetChildren() do
            if child:GetAttribute("PlanetHotline") then
                child:Destroy();
            end;
        end;

        local v10 = ReplicatedStorage.Maps:FindFirstChildOfClass("Model");

        if v10 then
            v10.Parent = workspace.Maps;
        end;

        return;
    end;

    local BALL = Character:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local u11 = script.Name .. " VFX FOLDER " .. Character.Name;

    if p9.Task ~= "Cutscene" then
        if p9.Task ~= "Cleanup" then
            return;
        end;

        local v12 = workspace.Debris:FindFirstChild(u11);

        if v12 then
            game:GetService("Debris"):AddItem(v12);
            print("This should work!");
        end;

        local v13 = ReplicatedStorage.Maps:FindFirstChildOfClass("Model");

        if v13 then
            v13.Parent = workspace.Maps;
        end;

        return;
    end;

    local v14 = workspace.Maps:FindFirstChildOfClass("Model");

    if v14 then
        v14.Parent = ReplicatedStorage.Maps;
    end;

    local NagiCam = workspace:WaitForChild("NagiCam", 3);

    if not NagiCam then
        return;
    end;

    if not NagiCam then
        warn("Planet Hotline Problem, contact HanmaDev");

        return;
    end;

    local Character2 = p9.Character;
    local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart");
    local Victim = p9.Victim;
    SoundManager.SpawnSound("PlanetHotline", 0.6, workspace, 130, false);
    local u15 = {};
    local u16 = {};
    local u17 = {};
    local u18 = {};

    for _, child in workspace:GetChildren() do
        if child.Name ~= p9.Character.Name and (child.Name ~= Victim.Name and child.Name ~= "Ball") then
            for _, descendant in child:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")))) then
                    table.insert(u15, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                    table.insert(u15, { descendant, descendant.Transparency });
                    descendant.Transparency = NumberSequence.new(1, 1);
                end;
            end;
        end;
    end;

    for _, child in game.Lighting:GetChildren() do
        table.insert(u16, child);
        child.Parent = ReplicatedStorage;
    end;

    for _, child in script.stuff:GetChildren() do
        child:Clone().Parent = game.Lighting;
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
    game.Lighting.ClockTime = 14.5;
    game.Lighting.GeographicLatitude = 0;
    local Folder = Instance.new("Folder");
    Folder.Name = u11;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    Folder:SetAttribute("PlanetHotline", true);
    task.delay(5, function() -- Line: 190
        -- upvalues: Folder (copy)
        if Folder and Folder:GetAttribute("Active") then
            Folder:SetAttribute("Active", nil);
        end;
    end);
    local Vignette = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");

    if Vignette then
        for _, v in {
            Vignette.Vignette,
            Vignette.Vignette.LL,
            Vignette.Vignette.UR,
            Vignette.Vignette.LL.LR
        } do
            v.ImageColor3 = Color3.fromRGB(255, 224, 47);
            v.ImageTransparency = 1;
            task.delay(0.8333333333333334, function() -- Line: 206
                -- upvalues: Folder (copy), Debris (ref), u11 (copy), TweenService (ref), v (copy), u17 (copy)
                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
                    return;
                end;

                local v19 = TweenService:Create(v, TweenInfo.new(0.48333333333333334, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0
                });
                v19:Play();
                table.insert(u17, v19);
                task.wait(0.25);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
                    return;
                end;

                local v20 = TweenService:Create(v, TweenInfo.new(0.4666666666666667, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(255, 100, 152)
                });
                v20:Play();
                table.insert(u17, v20);
                task.wait(0.8);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
                    return;
                end;

                local v21 = TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                    ImageColor3 = Color3.fromRGB(255, 201, 53)
                });
                v21:Play();
                table.insert(u17, v21);
                task.wait(0.7166666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
                    return;
                end;

                local v22 = TweenService:Create(v, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                    ImageTransparency = 1,
                    ImageColor3 = Color3.fromRGB(255, 255, 255)
                });
                v22:Play();
                table.insert(u17, v22);
            end);
        end;
    end;

    local u23 = script.UserVFX:Clone();
    u23.Parent = Folder;

    for _, child in u23:GetChildren() do
        local v24 = Character2:FindFirstChild(child.Name);

        if v24 then
            child.CFrame = v24.CFrame;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = child;
            WeldConstraint.Part1 = v24;
            WeldConstraint.Parent = child;
        end;
    end;

    local u25 = script.PasserVFX:Clone();
    u25.Parent = Folder;

    for _, child in u25:GetChildren() do
        local v26 = Victim:FindFirstChild(child.Name);

        if v26 then
            child.CFrame = v26.CFrame;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = child;
            WeldConstraint.Part1 = v26;
            WeldConstraint.Parent = child;
        end;
    end;

    local camera = NagiCam:FindFirstChild("camera");
    local u27 = script.camera:Clone();
    u27.CFrame = camera.CFrame;
    u27.Parent = Folder;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u27;
    WeldConstraint.Part1 = camera;
    WeldConstraint.Parent = u27;
    task.delay(5, function() -- Line: 69
        -- upvalues: u27 (copy)
        if typeof(u27) == "table" then
            for _, v in u27 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u27 then
            u27:Destroy();
        end;
    end);
    local v28 = script.CutsceneVFX:Clone();
    v28:PivotTo(HumanoidRootPart.CFrame);
    v28.Parent = Folder;
    EnableVFX(v28, true);
    local u29 = script.Ball:Clone();
    u29.CFrame = BALL.CFrame;
    u29.Parent = Folder;
    local WeldConstraint2 = Instance.new("WeldConstraint");
    WeldConstraint2.Part0 = u29;
    WeldConstraint2.Part1 = BALL;
    WeldConstraint2.Parent = u29;
    task.delay(0.7, function() -- Line: 278
        -- upvalues: Folder (copy), Debris (ref), u11 (copy), u23 (copy), u25 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
            return;
        end;

        EnableVFX(u23, true);
        EnableVFX(u25, true);
    end);
    task.delay(3.55, function() -- Line: 287
        -- upvalues: Folder (copy), Debris (ref), u11 (copy), u27 (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
            return;
        end;

        EnableVFX(u27.beam1, true);
        EnableVFX(u27.beam2, true);
        EnableVFX(u27.beamend1, true);
        EnableVFX(u27.beamend2, true);
        TweenService:Create(u27.beam1, TweenInfo.new(1.45, Enum.EasingStyle.Linear), {
            Position = Vector3.new(-0.047, -0.408, -1.1)
        }):Play();
        TweenService:Create(u27.beam2, TweenInfo.new(1.45, Enum.EasingStyle.Linear), {
            Position = Vector3.new(1, 0.146, -1.542)
        }):Play();

        for _, child in u27.beamend1:GetChildren() do
            child.Width0 = 0;
            child.Width1 = 0;
            TweenService:Create(child, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
                Width0 = 0.1,
                Width1 = 2
            });
        end;

        u27.beamend2["1"].Width0 = 0;
        u27.beamend2["1"].Width1 = 0;
        TweenService:Create(u27.beamend2["1"], TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            Width0 = 0.1,
            Width1 = 2
        });
    end);
    task.delay(1.5, function() -- Line: 309
        -- upvalues: Folder (copy), Debris (ref), u11 (copy), u29 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
            return;
        end;

        EmitAll(u29["Ball emit"]);
        task.wait(0.55);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
            return;
        end;

        EmitAll(u29["Ball emit"]);
        task.wait(0.95);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
            return;
        end;

        EmitAll(u29["Ball emit"]);
    end);
    task.delay(1.1, function() -- Line: 326
        -- upvalues: Folder (copy), Debris (ref), u11 (copy), u27 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
            return;
        end;

        for i = 1, 8 do
            local v30;

            if u27:FindFirstChild((tostring(i))) then
                local u31 = u27:FindFirstChild((tostring(i)));
                u31.Enabled = true;
                task.delay(2.216666666666667, function() -- Line: 336
                    -- upvalues: Folder (ref), Debris (ref), u11 (ref), u31 (copy)
                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u11) == nil then
                        return;
                    end;

                    u31.Enabled = false;
                end);
                v30 = i;
            else
                v30 = i;
            end;
        end;
    end);
    local u32 = false;

    local function v36() -- Line: 347
        -- upvalues: u32 (ref), u18 (ref), Folder (copy), Ambient (copy), Brightness (copy), ColorShift_Bottom (copy), ColorShift_Top (copy), EnvironmentDiffuseScale (copy), EnvironmentSpecularScale (copy), OutdoorAmbient (copy), ShadowSoftness (copy), ClockTime (copy), GeographicLatitude (copy), u16 (ref), u15 (copy), Vignette (copy)
        if u32 then
            return;
        end;

        u32 = true;

        for _, v in u18 do
            v:Disconnect();
        end;

        if Folder then
            Folder:SetAttribute("Active", false);
            EnableVFX(Folder, false);
            task.delay(3, function() -- Line: 358
                -- upvalues: Folder (ref)
                if Folder then
                    Folder:Destroy();
                end;
            end);
        end;

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

        for _, v in u16 do
            v.Parent = game.Lighting;
        end;

        for _, v in u15 do
            local v33, v34 = unpack(v);
            v33.Transparency = v34;
        end;

        task.spawn(function() -- Line: 390
            -- upvalues: Vignette (ref)
            for i = 1, 4 do
                local v35;

                if Vignette then
                    v35 = i;

                    for _, v in {
                        Vignette.Vignette,
                        Vignette.Vignette.LL,
                        Vignette.Vignette.UR,
                        Vignette.Vignette.LL.LR
                    } do
                        v.ImageTransparency = 1;
                    end;
                else
                    v35 = i;
                end;

                task.wait(0.05);
            end;
        end);
        table.clear(u18);
        table.clear(u16);
        u18 = nil;
        u16 = nil;
    end;

    task.delay(6, v36);
    table.insert(u18, Folder.Destroying:Connect(v36));
    table.insert(u18, Folder.AttributeChanged:Connect(v36));
end;