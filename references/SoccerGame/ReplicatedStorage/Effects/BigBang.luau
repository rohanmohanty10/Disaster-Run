  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local u1 = { { 30, 1.4 }, { 35, 2.88 }, { 28, 5.43 }, { 35, 5.45 }, { 30, 5.9 }, { 29.4, 6.1 }, { 20, 6.98 }, { 20, 6.883 }, { 28, 7.08 }, { 22, 8.16 }, { 21.9, 8.18 }, { 13, 9.267 }, { 45, 9.283 }, { 30, 9.4 }, { 35, 10.18 }, { 45, 10.2 }, { 35, 10.31 }, { 30, 11.13 }, { 30, 11.73 }, { 60, 11.75 }, { 80, 11.933 }, { 70, 12 }, { 75, 12.367 }, { 60, 13.86 } };

return function(p2) -- Line: 43
    -- upvalues: SpectatorController (copy), u1 (copy), TweenService (copy), Popup (copy), VfxManager (copy), LocalPlayer (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Values = game:GetService("Players").LocalPlayer.Character.Values;

    if not (Values.Goalie.Value or Values.IsInPenalty.Value) then
        workspace_CurrentCamera.FieldOfView = 20;
        task.spawn(function() -- Line: 52
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
    end;

    task.delay(0.4, function() -- Line: 69
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "My soccer cells...");
    end);
    task.delay(3.5, function() -- Line: 73
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "are tingling and stirring to spark.");
    end);
    task.delay(8.5, function() -- Line: 77
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "BIG BANG DRIVE");
    end);
    task.delay(11.5, function() -- Line: 81
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "IN THE WOMB");
    end);
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local BALL = Char:FindFirstChild("BALL", true);
    local u7 = {};

    for _, child in script.rootAttachments:GetChildren() do
        local v8 = child:Clone();
        v8.Parent = HumanoidRootPart;
        u7[v8.Name] = v8;
    end;

    local u9 = nil;
    local u10 = nil;
    local u11 = nil;
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local u16 = script.BANG:Clone();
    u16.Parent = game.Lighting;
    local u17 = script.drive:Clone();
    u17.Parent = game.Lighting;
    local u18 = script.HARAMEEEE:Clone();
    u18.Parent = game.Lighting;
    task.delay(0.1, function() -- Line: 114
        -- upvalues: u9 (ref), HumanoidRootPart (copy), u10 (ref), u7 (copy), u11 (ref), u12 (ref), u13 (ref), VfxManager (ref), u14 (ref), u15 (ref)
        u9 = script.ShidouBall:Clone();
        u9.Parent = workspace.Debris;
        u9.PrimaryPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.new(4.1, 18.3, -0.2) * CFrame.Angles(0, -1.5707963267948966, 0);
        u10 = script.Stars:Clone();
        u10.Parent = workspace.Debris;
        u10.CFrame = u7.Stars.WorldCFrame;
        u11 = script.impactFraming:Clone();
        u11.Parent = workspace.Debris;
        u11.CFrame = u7.impactFraming.WorldCFrame;
        u12 = script.shot:Clone();
        u12.Parent = workspace.Debris;
        u12.CFrame = u7.impactFraming.WorldCFrame;
        u13 = script.purpleBeam:Clone();
        u13.Parent = workspace.Debris;
        u13.CFrame = u7.impactFraming.WorldCFrame;
        u10.starrr.Enabled = true;
        VfxManager.Enable(u9, true);
        VfxManager.Emit(u9.Effects);
        u14 = script.RedVFX:Clone();
        u14.Parent = workspace.Debris;
        u14.CFrame = u7.RedVFX.WorldCFrame;
        u15 = script.Jump:Clone();
        u15.Parent = workspace.Debris;
        u15.CFrame = u7.Jump.WorldCFrame;
    end);
    task.delay(0.35, function() -- Line: 148
        -- upvalues: u9 (ref), TweenService (ref), u10 (ref)
        for _, child in u9.Effects:GetChildren() do
            if child:IsA("ParticleEmitter") then
                TweenService:Create(child, TweenInfo.new(0.45), {
                    TimeScale = 0
                }):Play();
            end;
        end;

        task.wait(1);
        TweenService:Create(u10.starrr, TweenInfo.new(1), {
            TimeScale = 0
        }):Play();
    end);
    local u19 = script.BALLVFX.att:Clone();
    u19.Parent = BALL;
    local NagiCam = workspace:FindFirstChild("NagiCam");
    local script_TorsoBeams = script.TorsoBeams;
    local u20 = nil;

    for _, child in script.TorsoVFX:GetChildren() do
        local u21 = child:Clone();
        u21.Parent = Char:FindFirstChild("Torso");
        task.delay(5.96, function() -- Line: 171
            -- upvalues: u21 (ref), VfxManager (ref)
            if u21:IsA("Attachment") then
                VfxManager.Enable(u21, true);
            else
                u21.Enabled = true;
            end;

            task.wait(1.1);
            u21:Destroy();
        end);
    end;

    for _, child in script_TorsoBeams:GetChildren() do
        local u22 = child:Clone();
        u22.Parent = Char:FindFirstChild("Torso");
        task.delay(7.06, function() -- Line: 185
            -- upvalues: u22 (ref), VfxManager (ref), u20 (ref)
            if u22.Name == "emit" then
                VfxManager.Emit(u22);

                return;
            end;

            u20 = u22;
            VfxManager.Enable(u22, true);
        end);
    end;

    local ImpactFramesShidou = LocalPlayer.PlayerGui.ImpactFramesShidou;
    task.spawn(function() -- Line: 197
        -- upvalues: ImpactFramesShidou (copy)
        game.ContentProvider:PreloadAsync({ ImpactFramesShidou });
    end);
    task.delay(6.9, function() -- Line: 201
        -- upvalues: ImpactFramesShidou (copy)
        for i = 1, 7 do
            if i > 1 then
                ImpactFramesShidou[`Frame{i - 1}`].Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            ImpactFramesShidou["Frame" .. i].Position = UDim2.new(0.5, 0, 0.5, 0);
            task.wait(0.022222222222222223);
            local _ = i;
        end;

        for i = 1, 7 do
            ImpactFramesShidou["Frame" .. i].Position = UDim2.new(0.5, 0, 1.5, 0);
            local _ = i;
        end;
    end);
    task.delay(2.4, function() -- Line: 217
        -- upvalues: BALL (copy), VfxManager (ref), u19 (copy)
        if BALL then
            VfxManager.Enable(u19, true);
            task.wait(1.45);
            VfxManager.Enable(u19, false);
        end;
    end);
    task.delay(5.5, function() -- Line: 225
        -- upvalues: VfxManager (ref), u19 (copy)
        VfxManager.Enable(u19, true);
    end);
    task.delay(9.23, function() -- Line: 229
        -- upvalues: VfxManager (ref), u19 (copy)
        VfxManager.Enable(u19, false);
        task.wait(2);
        u19:Destroy();
    end);
    local u23 = {};
    task.delay(9.36, function() -- Line: 237
        -- upvalues: NagiCam (copy), u23 (copy), VfxManager (ref)
        if NagiCam then
            local camera = NagiCam:FindFirstChild("camera");

            if not camera then
                return;
            end;

            for _, child in script.camera:GetChildren() do
                local v24 = child:Clone();
                v24.Parent = camera;
                u23[v24] = v24;
            end;

            VfxManager.Enable(camera, true);
        end;
    end);
    task.delay(10.2, function() -- Line: 252
        -- upvalues: NagiCam (copy), VfxManager (ref), u23 (copy)
        if NagiCam then
            local camera = NagiCam:FindFirstChild("camera");

            if not camera then
                return;
            end;

            VfxManager.Enable(camera, false);
            task.wait(2);

            for _, v in u23 do
                v:Destroy();
            end;
        end;
    end);
    task.delay(9.2, function() -- Line: 266
        -- upvalues: TweenService (ref), u16 (copy)
        game.Lighting.ColorCorrection.Enabled = false;
        TweenService:Create(u16, TweenInfo.new(0.2), {
            Brightness = -0.5,
            Contrast = 1,
            Saturation = 2,
            TintColor = Color3.fromRGB(245, 245, 245)
        }):Play();
        task.wait(0.2);
        TweenService:Create(u16, TweenInfo.new(0.17), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(245, 245, 245)
        }):Play();
        task.wait(0.17);
        u16:Destroy();
    end);
    task.delay(9.61, function() -- Line: 287
        -- upvalues: TweenService (ref), u17 (copy)
        TweenService:Create(u17, TweenInfo.new(0.15), {
            Brightness = 0,
            Contrast = 1,
            Saturation = -22,
            TintColor = Color3.fromRGB(231, 208, 245)
        }):Play();
        task.wait(0.15);
        TweenService:Create(u17, TweenInfo.new(0.05), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(245, 245, 245)
        }):Play();
        task.wait(0.05);
        u17:Destroy();
    end);
    task.delay(11, function() -- Line: 305
        -- upvalues: u18 (copy), TweenService (ref)
        local ColorCorrection = game.Lighting.ColorCorrection;
        u18.Enabled = true;
        TweenService:Create(u18, TweenInfo.new(1), {
            Brightness = 0,
            Contrast = -4,
            Saturation = -1,
            TintColor = Color3.fromRGB(243, 81, 167)
        }):Play();
        task.wait(1);
        TweenService:Create(u18, TweenInfo.new(0.3), {
            Brightness = 0,
            Contrast = -4,
            Saturation = -1,
            TintColor = Color3.fromRGB(206, 91, 152)
        }):Play();
        task.wait(0.5);
        TweenService:Create(u18, TweenInfo.new(0.2), {
            Brightness = 0,
            Contrast = -4,
            Saturation = -1,
            TintColor = Color3.fromRGB(52, 52, 52)
        }):Play();
        task.wait(1.4);
        ColorCorrection.Enabled = true;
        u18:Destroy();
    end);
    task.delay(10.5, function() -- Line: 334
        -- upvalues: VfxManager (ref), u12 (ref), TweenService (ref)
        VfxManager.Emit(u12);
        task.wait(0.1);

        for _, descendant in u12:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "PurpleBOom" then
                TweenService:Create(descendant, TweenInfo.new(0.3), {
                    TimeScale = 0
                }):Play();
            end;
        end;
    end);
    task.delay(11.6, function() -- Line: 349
        -- upvalues: VfxManager (ref), u13 (ref)
        VfxManager.Enable(u13, true);
    end);
    task.delay(9.38, function() -- Line: 353
        -- upvalues: VfxManager (ref), u11 (ref)
        VfxManager.Enable(u11, true);
        task.wait(0.8);
        VfxManager.Enable(u11, false);
    end);
    task.delay(2.9, function() -- Line: 359
        -- upvalues: VfxManager (ref), u14 (ref)
        VfxManager.Enable(u14, true);
    end);
    task.delay(5.4, function() -- Line: 363
        -- upvalues: VfxManager (ref), u14 (ref)
        VfxManager.Enable(u14, false);
        task.wait(2);
        u14:Destroy();
    end);
    task.delay(1.8, function() -- Line: 369
        -- upvalues: Char (copy), VfxManager (ref)
        for _, child in script.QuestionMark:GetChildren() do
            local u25 = child:Clone();
            u25.Parent = Char:FindFirstChild("Head");
            VfxManager.Emit(u25);
            task.delay(1, function() -- Line: 375
                -- upvalues: u25 (ref)
                u25:Destroy();
            end);
        end;
    end);
    task.delay(5.91, function() -- Line: 381
        -- upvalues: VfxManager (ref), u15 (ref)
        VfxManager.Emit(u15);
        task.wait(2);
        u15:Destroy();
    end);
    task.delay(10, function() -- Line: 387
        -- upvalues: TweenService (ref), u9 (ref), u20 (ref), VfxManager (ref), u13 (ref), u11 (ref), u12 (ref), u7 (copy), u10 (ref)
        TweenService:Create(u9.Vision, TweenInfo.new(1), {
            Transparency = 1
        }):Play();
        TweenService:Create(u9.tta, TweenInfo.new(1), {
            Transparency = 1
        }):Play();
        task.wait(3.9);

        if u20 then
            u20:Destroy();
        end;

        VfxManager.Enable(u13, false);
        u13:Destroy();
        u11:Destroy();
        u12:Destroy();

        for _, v in u7 do
            v:Destroy();
        end;

        u10:Destroy();
        u9:Destroy();
    end);
end;