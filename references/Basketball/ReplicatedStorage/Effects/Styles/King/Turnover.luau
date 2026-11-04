 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: LocalPlayer (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Teammate1 = p2.Teammate1;
    local Teammate2 = p2.Teammate2;
    local Enemy1 = p2.Enemy1;
    local v4 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(2 - u3, function() -- Line: 38
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "Pass to his teammate.", 1 }, { "Commentator", "Teammate bubbles it.", 1 }, { "Commentator", "Ohh, intercepted by the defense!", 2 } });
    end);
    task.delay(8 - u3, function() -- Line: 58
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "Kick out to the King.", 1 }, { "Commentator", "Ohh, he\'s lining it up.", 1.5 } });
    end);
    task.delay(13.5 - u3, function() -- Line: 73
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "And he throws it down with authority!", 3 } });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 86
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u3;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(16 - u3, function() -- Line: 108
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(16, function() -- Line: 121
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u10 = SfxManager:playSound({
        Sound = "BBZ King Turnover",
        Parent = workspace
    });
    u10.TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Ball:Clone();
    u12.CFrame = BALL.CFrame;
    u12.Parent = Folder;
    Essentials:Weld(u12, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    if Teammate1 then
        for _, child in pairs(script.AuraBodyPartsToWeld.Teammate1:GetChildren()) do
            local v13 = Teammate1:FindFirstChild(child.Name);

            if v13 then
                local v14 = child:Clone();
                v14.CFrame = v13.CFrame;
                v14.Parent = Model;
                Essentials:Weld(v14, v13);
            end;
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    if Teammate2 then
        for _, child in pairs(script.AuraBodyPartsToWeld.Teammate2:GetChildren()) do
            local v15 = Teammate2:FindFirstChild(child.Name);

            if v15 then
                local v16 = child:Clone();
                v16.CFrame = v15.CFrame;
                v16.Parent = Model2;
                Essentials:Weld(v16, v15);
            end;
        end;
    end;

    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(228, 255, 130);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(16 - u3, function() -- Line: 191
        -- upvalues: u18 (copy), Lighting (ref), ColorCorrection (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u19 = Bloom:Clone();
    u19.Name = "B";
    u19.Parent = Lighting;
    u19.Enabled = true;
    task.delay(16 - u3, function() -- Line: 206
        -- upvalues: u19 (copy), Lighting (ref), Bloom (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u20 = DepthOfField:Clone();
    u20.Name = "D";
    u20.Parent = Lighting;
    u20.Enabled = true;
    task.delay(16, function() -- Line: 221
        -- upvalues: u20 (copy), Lighting (ref), DepthOfField (copy)
        u20:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(0.06666666666666667 - u3, function() -- Line: 228
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Slam1);
    end);
    task.delay(0.26666666666666666 - u3, function() -- Line: 234
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Slam2);
    end);
    task.delay(2.0833333333333335 - u3, function() -- Line: 240
        -- upvalues: Folder (copy), Enemy1 (copy), VfxManager (ref), u12 (copy), Lighting (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Enemy1 and Enemy1:FindFirstChild("Right Arm") then
            local v21 = script.Throw:Clone();
            v21.Parent = Folder;
            v21.CFrame = Enemy1["Right Arm"].CFrame;
            VfxManager.Emit(v21);
            VfxManager.DestroyEffect(v21, 2);
        end;

        VfxManager.Enable(u12, true);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
    end);
    task.delay(2.966666666666667 - u3, function() -- Line: 259
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), Vignette1 (copy), TweenService (ref), Vignette (copy), Lighting (ref), u18 (copy), u20 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Impact);
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        TweenService:Create(u18, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
        TweenService:Create(u20, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
    end);
    task.delay(4.383333333333334 - u3, function() -- Line: 278
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), Lighting (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12, false);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Name = script.Parent.Name .. "Blur";
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 8
        }):Play();
    end);
    task.delay(5.05 - u3, function() -- Line: 289
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u20 (copy), DepthOfField (copy), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(99, 39, 229);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local v22 = Lighting:FindFirstChild(script.Parent.Name .. "Blur");
        v22.Size = 35;
        TweenService:Create(v22, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(v22, 0.455);
        TweenService:Create(u20, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
            FarIntensity = DepthOfField.FarIntensity,
            FocusDistance = DepthOfField.FocusDistance
        }):Play();
        u18.Brightness = 1;
        u18.Saturation = -1;
        u18.TintColor = Color3.fromRGB(99, 39, 229);
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(6.116666666666666 - u3, function() -- Line: 310
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v23 = script.Bounce:Clone();
        v23.Parent = Folder;
        v23.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v23);
        VfxManager.DestroyEffect(v23, 2);
    end);
    task.delay(6.816666666666666 - u3, function() -- Line: 320
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v24 = script.Bounce:Clone();
        v24.Parent = Folder;
        v24.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v24);
        VfxManager.DestroyEffect(v24, 2);
    end);
    task.delay(7.8 - u3, function() -- Line: 330
        -- upvalues: Folder (copy), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Highlight.OutlineTransparency = 0;
    end);
    task.delay(8.633333333333333 - u3, function() -- Line: 336
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Throw);
        VfxManager.Enable(u12, true);
    end);
    task.delay(9.066666666666666 - u3, function() -- Line: 343
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Impact);
    end);
    task.delay(9.416666666666666 - u3, function() -- Line: 349
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v25 = script.Bounce:Clone();
        v25.Parent = Folder;
        v25.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v25);
        VfxManager.DestroyEffect(v25, 2);
    end);
    task.delay(9.85 - u3, function() -- Line: 359
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v26 = script.Bounce:Clone();
        v26.Parent = Folder;
        v26.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v26);
        VfxManager.DestroyEffect(v26, 2);
    end);
    task.delay(10.283333333333333 - u3, function() -- Line: 369
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v27 = script.Bounce:Clone();
        v27.Parent = Folder;
        v27.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v27);
        VfxManager.DestroyEffect(v27, 2);
    end);
    task.delay(10.833333333333334 - u3, function() -- Line: 379
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u11 (copy), BALL (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.CameraPart.nr2, true);
        end;

        VfxManager.Emit(u11.Jump);
        local v28 = script.Bounce:Clone();
        v28.Parent = Folder;
        v28.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v28);
        VfxManager.DestroyEffect(v28, 2);
    end);
    task.delay(14.183333333333334 - u3, function() -- Line: 395
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.CameraPart.nr2, false);
        end;
    end);
    task.delay(14.65 - u3, function() -- Line: 403
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u11 (copy), Lighting (ref), u19 (copy), Bloom (copy), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 234, 76);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u11.Score);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u19.Intensity = 20;
        u19.Threshold = 0.5;
        TweenService:Create(u19, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u18.Brightness = 1;
        u18.Saturation = -1;
        u18.TintColor = Color3.fromRGB(255, 234, 76);
        TweenService:Create(u18, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    local u29 = {};

    local function v30() -- Line: 430
        -- upvalues: u29 (ref), Folder (copy), u17 (copy), Highlight (copy), u10 (copy), TweenService (ref), VfxManager (ref), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), Bloom (copy), u20 (copy), DepthOfField (copy)
        for _, v in pairs(u29) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u10 then
            task.delay(1, function() -- Line: 448
                -- upvalues: TweenService (ref), u10 (ref)
                TweenService:Create(u10, TweenInfo.new(1), {
                    Volume = 0
                }):Play();
            end);
            VfxManager.DestroyEffect(u10, 10);
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u19 then
            u19:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u20 then
            u20:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u29 = nil;
    end;

    table.insert(u29, Folder.AttributeChanged:Connect(v30));
    table.insert(u29, Folder.Destroying:Connect(v30));
end;