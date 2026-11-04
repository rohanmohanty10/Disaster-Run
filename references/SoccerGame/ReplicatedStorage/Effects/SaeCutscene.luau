  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local u1 = { { 30, 0.43 }, { 25, 1.783 }, { 38, 1.8 }, { 30, 3.7 }, { 35, 5.26 }, { 40, 5.55 }, { 50, 7.35 } };

return function(p2) -- Line: 23
    -- upvalues: SoundService (copy), SoundManager (copy), Popup (copy), u1 (copy), TweenService (copy), Lighting (copy), Essentials (copy), VfxManager (copy)
    local Volume = SoundService.SoundGroup.Volume;
    SoundService.SoundGroup.Volume = 0;
    SoundManager.SpawnSound("SaeCutsceneNew", 0.7, workspace, 150);
    task.delay(0.3, function() -- Line: 28
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "I\'m taking this game to the next level");
    end);
    task.delay(3.8, function() -- Line: 32
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Only the fools who can keep up with me");
    end);
    task.delay(5.6, function() -- Line: 36
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Will get to see what comes next");
    end);
    local Character = p2.Plr.Character;

    if not Character then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local AwakeningCam = workspace:FindFirstChild("AwakeningCam");
    workspace_CurrentCamera.FieldOfView = 40;
    task.spawn(function() -- Line: 51
        -- upvalues: u1 (ref), TweenService (ref), workspace_CurrentCamera (copy)
        local v3 = 0;

        for _, v in u1 do
            local v4 = v[2];
            local v5 = v[1];
            local v6 = v4 - v3;
            TweenService:Create(workspace_CurrentCamera, TweenInfo.new(v6), {
                FieldOfView = v5
            }):Play();
            task.wait(v6);
            v3 = v4;
        end;
    end);
    local Atmosphere = Lighting.Atmosphere;
    local InitialData = Essentials:GetInitialData(Atmosphere);
    local Density = InitialData.Density;
    local Offset = InitialData.Offset;
    local Color = InitialData.Color;
    local Decay = InitialData.Decay;
    local Glare = InitialData.Glare;
    local Haze = InitialData.Haze;
    TweenService:Create(Atmosphere, TweenInfo.new(1.36), {
        Density = 0.7,
        Offset = 0,
        Glare = 1,
        Haze = 1,
        Color = Color3.fromRGB(255, 22, 96),
        Decay = Color3.fromRGB(255, 90, 203)
    }):Play();
    task.delay(8.1, function() -- Line: 86
        -- upvalues: TweenService (ref), Atmosphere (copy), Density (copy), Offset (copy), Color (copy), Decay (copy), Glare (copy), Haze (copy)
        TweenService:Create(Atmosphere, TweenInfo.new(1), {
            Density = Density,
            Offset = Offset,
            Color = Color,
            Decay = Decay,
            Glare = Glare,
            Haze = Haze
        }):Play();
    end);
    local u7 = {};

    if AwakeningCam then
        local camera = AwakeningCam:FindFirstChild("camera");
        local v8 = script.camera.Beams:Clone();
        v8.Parent = camera;
        u7[v8] = v8;
    end;

    local OutlineHighlight = Character:FindFirstChild("OutlineHighlight");

    if OutlineHighlight then
        OutlineHighlight.Enabled = false;
    end;

    local u9 = nil;

    for _, child in script.EmitRoot:GetChildren() do
        local u10 = child:Clone();
        u10.Parent = HumanoidRootPart;
        u7[u10] = u10;

        if u10.Name == "Emit 2" then
            u9 = u10;
        else
            task.delay(0.45, function() -- Line: 124
                -- upvalues: VfxManager (ref), u10 (ref)
                VfxManager.Emit(u10);
            end);
        end;
    end;

    local u11 = script.RootVFX.floor:Clone();
    u11.Parent = HumanoidRootPart;
    u7[u11] = u11;
    local u12 = script.RootVFX.Beams:Clone();
    u12.Parent = HumanoidRootPart;
    u7[u12] = u12;
    local u13 = script.Head.Eye:Clone();
    u7[u13] = u13;
    local u14 = script.Background:Clone();
    u14.Parent = workspace.Debris;
    u14.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.224, -0.449, 0.463);
    u7[u14] = u14;
    task.delay(1.9, function() -- Line: 145
        -- upvalues: u9 (ref), VfxManager (ref), u11 (copy), u14 (copy), u12 (copy), TweenService (ref)
        if u9 then
            VfxManager.Emit(u9);
        end;

        VfxManager.Enable(u11, true);
        VfxManager.Enable(u14, true);

        for _, descendant in u12:GetDescendants() do
            if descendant:IsA("Beam") then
                local v15 = script.RootVFX.EndBeam:FindFirstChild(descendant.Name, true);

                if v15 then
                    descendant.Enabled = true;
                    TweenService:Create(descendant, TweenInfo.new(1), {
                        Width0 = v15.Width0,
                        Width1 = v15.Width1
                    }):Play();
                end;
            end;
        end;
    end);
    task.delay(2.21, function() -- Line: 166
        -- upvalues: u13 (copy), Character (copy)
        u13.Parent = Character:FindFirstChild("Head");
    end);
    task.delay(3, function() -- Line: 170
        -- upvalues: u14 (copy), TweenService (ref)
        for _, child in u14:GetChildren() do
            TweenService:Create(child, TweenInfo.new(0.1), {
                TimeScale = 0
            }):Play();
        end;
    end);
    task.delay(8.2, function() -- Line: 177
        -- upvalues: u7 (copy), OutlineHighlight (copy), SoundService (ref), Volume (copy)
        for _, v in u7 do
            v:Destroy();
        end;

        if OutlineHighlight then
            OutlineHighlight.Enabled = true;
        end;

        SoundService.SoundGroup.Volume = Volume;
    end);
end;