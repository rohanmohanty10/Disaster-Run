 
 

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
    -- upvalues: Players (copy), LocalPlayer (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    Players:FindFirstChild(Character.Name);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u6 = workspace:FindFirstChild(script.Name .. "Trophy");
    local BALL = Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 37
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "Player bring the ball up.", 1 } });
    end);
    task.delay(1.5 - u3, function() -- Line: 47
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "Slew his handle.", 0.5 }, { "Commentator", "Controlling the tempo.", 0.75 }, { "Commentator", "Uh. Hold on. Wait a second.", 0.75 }, { "Commentator", "The defender is reaching into his back?", 1 }, { "Commentator", "W-what is that?!", 1 }, { "Commentator", "Is that <font color=\"#ffcd00\">THE BASKETBALL TROPHY</font>?!", 1 }, { "Commentator", "He\'s loosening his grip.", 0.75 }, { "Commentator", "He\'s actually staring at the trophy?!", 1.25 }, { "Commentator", "He\'s reaching for it!", 1 }, { "Commentator", "<animation timeBetweenStep=\"0.01\">What is happening?!</animation>", 0.25 }, { "Commentator", "And the defender strikes!", 1 }, { "Commentator", "He jumps the moment and snatches the ball clean!", 2 }, { "Commentator", "Unbelivable trick play!", 1.5 } });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 120
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u3;
        end;

        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 6);
        end;
    end);
    local u11 = nil;
    u11 = RunService.RenderStepped:Connect(function() -- Line: 143
        -- upvalues: u6 (copy), u11 (ref)
        if u6 and u6:FindFirstChild("Cylinder0011") then
            u6.Trophy.CFrame = u6.Cylinder0011.Bone.Connector.WorldCFrame;

            return;
        end;

        u11:Disconnect();
    end);
    task.delay(15.833 - u3, function() -- Line: 151
        -- upvalues: u8 (ref), u11 (ref)
        u8:Disconnect();
        u11:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(15.833, function() -- Line: 165
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Air Trophy",
        Parent = workspace
    }).TimePosition = u3;
    local v12 = script.Ball:Clone();
    v12.CFrame = BALL.CFrame;
    v12.Parent = Folder;
    Essentials:Weld(v12, BALL);
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local _ = u13.Vignette;
    local Vignette1 = u13.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(15.833 - u3, function() -- Line: 194
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u15 = Bloom:Clone();
    u15.Name = "B";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(15.833 - u3, function() -- Line: 209
        -- upvalues: u15 (copy), Lighting (ref), Bloom (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u16 = DepthOfField:Clone();
    u16.Name = "D";
    u16.Parent = Lighting;
    u16.Enabled = true;
    task.delay(15.833, function() -- Line: 224
        -- upvalues: u16 (copy), Lighting (ref), DepthOfField (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 231
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v17 = script.Bounce:Clone();
        v17.Parent = Folder;
        v17.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v17);
        VfxManager.DestroyEffect(v17, 2);
    end);
    task.delay(0.48333333333333334 - u3, function() -- Line: 241
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v18 = script.Bounce:Clone();
        v18.Parent = Folder;
        v18.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v18);
        VfxManager.DestroyEffect(v18, 2);
    end);
    task.delay(0.95 - u3, function() -- Line: 251
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v19 = script.Bounce:Clone();
        v19.Parent = Folder;
        v19.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v19);
        VfxManager.DestroyEffect(v19, 2);
    end);
    task.delay(1.3666666666666667 - u3, function() -- Line: 261
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 0.65;
        u14.TintColor = Color3.fromRGB(155, 32, 32);
        TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(2.466666666666667 - u3, function() -- Line: 274
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), BALL (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.CameraPart.Model);
        end;

        local v20 = script.Bounce:Clone();
        v20.Parent = Folder;
        v20.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v20);
        VfxManager.DestroyEffect(v20, 2);
    end);
    task.delay(2.8666666666666667 - u3, function() -- Line: 288
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v21 = script.Bounce:Clone();
        v21.Parent = Folder;
        v21.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v21);
        VfxManager.DestroyEffect(v21, 2);
    end);
    task.delay(3.316666666666667 - u3, function() -- Line: 298
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v22 = script.Bounce:Clone();
        v22.Parent = Folder;
        v22.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v22);
        VfxManager.DestroyEffect(v22, 2);
    end);
    task.delay(3.85 - u3, function() -- Line: 308
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
    task.delay(5.766666666666667 - u3, function() -- Line: 318
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref), Vignette1 (copy), TweenService (ref), Lighting (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 and u6:FindFirstChild("Cylinder0011") then
            VfxManager.Emit(u6.Cylinder0011.Bone.Attachment2);
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 234, 76);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        u14.Brightness = 0.65;
        u14.TintColor = Color3.fromRGB(255, 234, 76);
        TweenService:Create(u14, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(7.75 - u3, function() -- Line: 341
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u16 (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        TweenService:Create(u16, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 30
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
    end);
    task.delay(9.333333333333334 - u3, function() -- Line: 357
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u15 (copy), Bloom (copy), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(229, 48, 48);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u15.Intensity = 20;
        u15.Threshold = 0.5;
        TweenService:Create(u15, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u14.Brightness = 1;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(229, 48, 48);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(10.5 - u3, function() -- Line: 382
        -- upvalues: Folder (copy), TweenService (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u16, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FocusDistance = 200
        }):Play();
    end);
    task.delay(12.166666666666666 - u3, function() -- Line: 388
        -- upvalues: Folder (copy), TweenService (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u16, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FocusDistance = 30
        }):Play();
    end);
    task.delay(13.666666666666666 - u3, function() -- Line: 394
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u14 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 0.65;
        u14.TintColor = Color3.fromRGB(155, 32, 32);
        TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 32, 32);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Brightness = -0.1
        }):Play();
    end);
    task.delay(15.25 - u3, function() -- Line: 415
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u14 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 0.65;
        u14.TintColor = Color3.fromRGB(155, 32, 32);
        TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 32, 32);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    local u24 = {};

    local function v25() -- Line: 437
        -- upvalues: u24 (ref), Folder (copy), u13 (copy), u6 (copy), u14 (copy), Lighting (ref), ColorCorrection (copy), u15 (copy), Bloom (copy), u16 (copy), DepthOfField (copy)
        for _, v in pairs(u24) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u24 = nil;
    end;

    table.insert(u24, Folder.AttributeChanged:Connect(v25));
    table.insert(u24, Folder.Destroying:Connect(v25));
end;