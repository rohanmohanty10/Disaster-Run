 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
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

return function(u1, p2) -- Line: 18
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 33
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Miss me, sunshine?", 1.5 },
            { u5, "<animation style=\"glitch\">AHAHAHAHA</animation>", 1 },
            { u5, "Of course you do!", 1.5 }
        });
    end);
    task.delay(5.5 - PassedTime, function() -- Line: 53
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "And now... for my favorite <animation style=\"glitch\">trick.</animation>", 2 }
        });
    end);
    task.delay(8.5 - PassedTime, function() -- Line: 63
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Well, well, looks like the <animation style=\"glitch\">circus</animation> came to town.", 2 },
            { u5, "Hope you bought tickets.", 1.5 }
        });
    end);
    task.delay(12 - PassedTime, function() -- Line: 78
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "You ever play with toys?", 1.5 },
            { u5, "<animation style=\"glitch\">AHAHAHAHA</animation>", 0.5 },
            { u5, " <animation style=\"glitch\">Showtime.</animation>", 1.5 }
        });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 101
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * PassedTime;
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
    task.delay(16.216 - PassedTime, function() -- Line: 123
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(16.216 - PassedTime, function() -- Line: 136
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Joker Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local u11 = script.Ball:Clone();
    u11.CFrame = BALL.CFrame;
    u11.Parent = Folder;
    Essentials:Weld(u11, BALL);
    local u12;

    if Head then
        u12 = script.Head:Clone();
        u12.CFrame = Head.CFrame;
        u12.Parent = Folder;
        Essentials:Weld(u12, Head);
    else
        u12 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local Vignette1 = u13.Vignette1;
    u13.Vignette.ImageTransparency = 0;
    Vignette1.ImageColor3 = Color3.fromRGB(103, 65, 255);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(16.216, function() -- Line: 180
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u15 = DepthOfField:Clone();
    u15.Name = "D";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(16.216, function() -- Line: 195
        -- upvalues: u15 (copy), Lighting (ref), DepthOfField (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(1.7166666666666666 - PassedTime, function() -- Line: 202
        -- upvalues: Folder (copy), VfxManager (ref), u12 (ref), u10 (copy), TweenService (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.Enable, true);
        VfxManager.Enable(u10.Aura, true);
        TweenService:Create(Vignette1, TweenInfo.new(1.7166666666666666), {
            ImageTransparency = 0
        }):Play();
        task.wait(1.7166666666666666);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(3.433333333333333 - PassedTime, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u12 (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.Enable, false);
        VfxManager.Enable(u10.Aura, false);
    end);
    task.delay(4.333333333333333 - PassedTime, function() -- Line: 222
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Enable(CamRig.CameraPart.LeftCinematicBars, true);
            VfxManager.Enable(CamRig.CameraPart.RightCinematicBars, true);
        end;
    end);
    task.delay(4.85 - PassedTime, function() -- Line: 231
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Enable(CamRig.CameraPart.LeftCinematicBars, false);
            VfxManager.Enable(CamRig.CameraPart.RightCinematicBars, false);
        end;
    end);
    task.delay(5.133333333333334 - PassedTime, function() -- Line: 240
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Enable(CamRig.CameraPart.LeftCinematicBars, true);
            VfxManager.Enable(CamRig.CameraPart.RightCinematicBars, true);
        end;
    end);
    task.delay(5.85 - PassedTime, function() -- Line: 249
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Enable(CamRig.CameraPart.LeftCinematicBars, false);
            VfxManager.Enable(CamRig.CameraPart.RightCinematicBars, false);
        end;
    end);
    task.delay(6.766666666666667 - PassedTime, function() -- Line: 258
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u10 (copy), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(103, 65, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u10.JokerStart);
        u14.Brightness = 0.65;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(103, 65, 255);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(6.883333333333334 - PassedTime, function() -- Line: 275
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Explode1);
    end);
    task.delay(7.05 - PassedTime, function() -- Line: 281
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Explode2);
    end);
    task.delay(7.233333333333333 - PassedTime, function() -- Line: 287
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Explode3);
    end);
    task.delay(7.416666666666667 - PassedTime, function() -- Line: 293
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Explode4);
    end);
    task.delay(7.633333333333334 - PassedTime, function() -- Line: 299
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Explode5);
    end);
    task.delay(7.816666666666666 - PassedTime, function() -- Line: 305
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Explode6);
    end);
    task.delay(7.983333333333333 - PassedTime, function() -- Line: 311
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Explode7);
    end);
    task.delay(7.3 - PassedTime, function() -- Line: 317
        -- upvalues: Folder (copy)
        if Folder and Folder:GetAttribute("Active") then
        end;
    end);
    task.delay(8.283333333333333 - PassedTime, function() -- Line: 321
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), u10 (copy), CamRig (copy), VfxManager (ref), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 52, 25);
        Vignette1.ImageTransparency = 0.5;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u10.Room:Destroy();

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Emit(CamRig.CameraPart.ExploSwitch1);
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
    end);
    task.delay(8.9 - PassedTime, function() -- Line: 340
        -- upvalues: Folder (copy), TweenService (ref), u14 (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u14, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Saturation = -1
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
    end);
    task.delay(9.533333333333333 - PassedTime, function() -- Line: 347
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u12 (ref), Lighting (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 80, 80);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Enable(u12.Enable, true);
        VfxManager.Emit(u12.Emit);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 1;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(255, 80, 80);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(10.9 - PassedTime, function() -- Line: 370
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u12 (ref), Lighting (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(103, 65, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u12.Emit);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 1;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(103, 65, 255);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(11.85 - PassedTime, function() -- Line: 392
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), CamRig (copy), VfxManager (ref), u12 (ref), Lighting (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 52, 25);
        Vignette1.ImageTransparency = 0.5;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Emit(CamRig.CameraPart.ExploSwitch1);
            VfxManager.Emit(CamRig.CameraPart.ExploSwitch2);
        end;

        VfxManager.Enable(u12.Enable, false);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 0.45;
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(13.533333333333333 - PassedTime, function() -- Line: 415
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u10 (copy), Lighting (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(120, 255, 131);
        Vignette1.ImageTransparency = 0.5;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u10.DuckSwitch);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 0.45;
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(14.866666666666667 - PassedTime, function() -- Line: 433
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.Enable, true);
        VfxManager.Emit(u11.Emit);
    end);
    task.delay(16.216666666666665 - PassedTime, function() -- Line: 440
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.Enable, false);
    end);
    local u16 = {};

    local function v17() -- Line: 447
        -- upvalues: u16 (ref), Folder (copy), u13 (copy), u14 (copy), Lighting (ref), ColorCorrection (copy), u15 (copy), DepthOfField (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;