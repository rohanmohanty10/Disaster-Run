 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), Debris (copy), SfxManager (copy), Essentials (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local Enemy = p2.Enemy;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v3 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(6 - PassedTime, function() -- Line: 36
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Don\'t scream.", 1 },
            { u5, "It\'s just basketball.", 1 },
            { u5, "I\'m just getting started.", 1.5 }
        });
    end);
    task.delay(14 - PassedTime, function() -- Line: 56
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Let\'s make this court a <animation style=\"glitch\"><font color=\"#ff0000\">CRIME SCENE</font>!</animation>", 2 }
        });
    end);
    local u6;

    if Enemy then
        u6 = Enemy:FindFirstChild(script.Name .. "Cellphone");
    else
        u6 = nil;
    end;

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(20, function() -- Line: 80
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Ghost Incoming Call",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u7 = script.Cutscene_VFX:Clone();
    u7:PivotTo(HumanoidRootPart.CFrame);
    u7.Parent = Folder;
    local u8 = script.Ball:Clone();
    u8.CFrame = BALL.CFrame;
    u8.Parent = Folder;
    Essentials:Weld(u8, BALL);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u9 = script.Vignette:Clone();
    u9.Parent = PlayerGui;
    u9.Enabled = true;
    local Vignette = u9.Vignette;
    local Vignette1 = u9.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u10 = ColorCorrection:Clone();
    u10.Name = "CC";
    u10.Parent = Lighting;
    u10.Enabled = true;
    task.delay(20, function() -- Line: 114
        -- upvalues: u10 (copy), Lighting (ref), ColorCorrection (copy)
        u10:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u11 = DepthOfField:Clone();
    u11.Name = "D";
    u11.Parent = Lighting;
    u11.Enabled = true;
    task.delay(20, function() -- Line: 129
        -- upvalues: u11 (copy), Lighting (ref), DepthOfField (copy)
        u11:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(0.16666666666666666 - PassedTime, function() -- Line: 136
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v12 = script.Bounce:Clone();
        v12.Parent = Folder;
        v12.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v12);
        VfxManager.DestroyEffect(v12, 2);
    end);
    task.delay(0.6666666666666666 - PassedTime, function() -- Line: 146
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v13 = script.Bounce:Clone();
        v13.Parent = Folder;
        v13.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v13);
        VfxManager.DestroyEffect(v13, 2);
    end);
    task.delay(1.1 - PassedTime, function() -- Line: 156
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v14 = script.Bounce:Clone();
        v14.Parent = Folder;
        v14.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 2);
    end);
    task.delay(1.6666666666666667 - PassedTime, function() -- Line: 166
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v15 = script.Bounce:Clone();
        v15.Parent = Folder;
        v15.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v15);
        VfxManager.DestroyEffect(v15, 2);
    end);
    task.delay(2.216666666666667 - PassedTime, function() -- Line: 176
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v16 = script.Bounce:Clone();
        v16.Parent = Folder;
        v16.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v16);
        VfxManager.DestroyEffect(v16, 2);
    end);
    task.delay(2.6 - PassedTime, function() -- Line: 186
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v17 = script.Bounce:Clone();
        v17.Parent = Folder;
        v17.CFrame = CFrame.new(BALL.Position);
        VfxManager.Emit(v17);
        VfxManager.DestroyEffect(v17, 2);
    end);
    task.delay(2.683333333333333 - PassedTime, function() -- Line: 196
        -- upvalues: Folder (copy), u6 (ref), VfxManager (ref), Lighting (ref), TweenService (ref), u10 (copy), ColorCorrection (copy), Vignette1 (copy), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 and u6:FindFirstChild("cell") then
            VfxManager.Enable(u6.cell.Bone["Bone.001"].Attachment, true);
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        u10.Brightness = 0.45;
        TweenService:Create(u10, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = ColorCorrection.Brightness
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
    end);
    task.delay(3.433333333333333 - PassedTime, function() -- Line: 216
        -- upvalues: Folder (copy), TweenService (ref), Vignette1 (copy), Lighting (ref), VfxManager (ref), u10 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        u10.Brightness = 0.45;
        TweenService:Create(u10, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(6.5 - PassedTime, function() -- Line: 230
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), Lighting (ref), TweenService (ref), u10 (copy), ColorCorrection (copy), Vignette1 (copy), Vignette (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.W, true);
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        u10.Brightness = 0.45;
        TweenService:Create(u10, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = ColorCorrection.Brightness
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(u11, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
    end);
    task.delay(8 - PassedTime, function() -- Line: 252
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u10 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        u10.Brightness = 0.45;
        TweenService:Create(u10, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(9.866666666666667 - PassedTime, function() -- Line: 264
        -- upvalues: Folder (copy), VfxManager (ref), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u7.AuraPart, true);
    end);
    task.delay(11.5 - PassedTime, function() -- Line: 270
        -- upvalues: Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u10 (copy), ColorCorrection (copy)
        Vignette1.ImageColor3 = Color3.fromRGB(31, 255, 100);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local v18 = Lighting:FindFirstChild(script.Parent.Name .. "Blur") or Instance.new("BlurEffect", Lighting);
        v18.Size = 35;
        TweenService:Create(v18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(v18, 0.25);
        u10.Brightness = 0.85;
        u10.Saturation = -1;
        u10.TintColor = Color3.fromRGB(31, 255, 100);
        TweenService:Create(u10, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u10, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(11.933333333333334 - PassedTime, function() -- Line: 288
        -- upvalues: Folder (copy), VfxManager (ref), u8 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u8, true);
        VfxManager.Emit(u8.Spawn);
    end);
    task.delay(12.433333333333334 - PassedTime, function() -- Line: 295
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref), CamRig (copy), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u7.Box.Sphere.Transparency = 0;
        VfxManager.Enable(u7.Box, true);

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.W, false);
        end;

        local v19 = script.FakeAtmo:Clone();
        v19.Parent = Lighting;
        task.wait(7.56);
        v19:Destroy();
    end);
    task.delay(18.333333333333332 - PassedTime, function() -- Line: 313
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), u7 (copy), VfxManager (ref), u6 (ref), u8 (copy), Lighting (ref), u10 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(31, 255, 100);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        u7.Box.Sphere.Transparency = 1;
        VfxManager.Enable(u7.Box, false);

        if u6 and u6:FindFirstChild("cell") then
            VfxManager.Enable(u6.cell.Bone["Bone.001"].Attachment, false);
        end;

        VfxManager.Enable(u7.AuraPart, false);
        VfxManager.Enable(u8, false);
        local v20 = Lighting:FindFirstChild(script.Parent.Name .. "Blur") or Instance.new("BlurEffect", Lighting);
        v20.Size = 35;
        TweenService:Create(v20, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(v20, 0.25);
        u10.Brightness = 0.85;
        u10.Saturation = -1;
        u10.TintColor = Color3.fromRGB(31, 255, 100);
        TweenService:Create(u10, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u10, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    local u21 = {};

    local function v22() -- Line: 344
        -- upvalues: u21 (ref), Folder (copy), u6 (ref), u9 (copy), u10 (copy), Lighting (ref), ColorCorrection (copy), u11 (copy), DepthOfField (copy)
        for _, v in pairs(u21) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;

        if u9 then
            u9:Destroy();
        end;

        if u10 then
            u10:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u11 then
            u11:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u21 = nil;
    end;

    table.insert(u21, Folder.AttributeChanged:Connect(v22));
    table.insert(u21, Folder.Destroying:Connect(v22));
end;