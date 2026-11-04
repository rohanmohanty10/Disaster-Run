 
 

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
    local u4 = Players:FindFirstChild(Character.Name);
    local v5 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(4.5 - u3, function() -- Line: 36
        -- upvalues: Effects (ref), u4 (copy)
        Effects:SubtitleV2({
            { u4, "One <animation style=\"glitch\">shadow</animation>... three forms.", 2 }
        });
    end);
    task.delay(9 - u3, function() -- Line: 46
        -- upvalues: Effects (ref), u4 (copy)
        Effects:SubtitleV2({
            { u4, "I\'ll be taking this ball.", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 59
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
    task.delay(11.1 - u3, function() -- Line: 81
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(11.1, function() -- Line: 94
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Eclipse Clone Steal",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Ball:Clone();
    u12.CFrame = BALL.CFrame;
    u12.Parent = Folder;
    Essentials:Weld(u12, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v13 = Character:FindFirstChild(child.Name);

        if v13 then
            local v14 = child:Clone();
            v14.CFrame = v13.CFrame;
            v14.Parent = Model;
            Essentials:Weld(v14, v13);
        end;
    end;

    for _, _ in pairs(p2.Clones) do
        local Model2 = Instance.new("Model");
        Model2.Parent = Folder;

        for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
            local v15 = child:FindFirstChild(child.Name);

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
    local Vignette1 = u17.Vignette1;
    u17.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(11.1 - u3, function() -- Line: 156
        -- upvalues: u18 (copy), Lighting (ref), ColorCorrection (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u19 = DepthOfField:Clone();
    u19.Name = "D";
    u19.Parent = Lighting;
    u19.Enabled = true;
    local u20 = nil;
    local ClockTime = Lighting.ClockTime;
    task.delay(11.1, function() -- Line: 173
        -- upvalues: u19 (copy), Lighting (ref), DepthOfField (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(0.55 - u3, function() -- Line: 180
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
    task.delay(1.2166666666666666 - u3, function() -- Line: 190
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
    task.delay(1.9 - u3, function() -- Line: 200
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
    task.delay(2.4833333333333334 - u3, function() -- Line: 210
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
    task.delay(3.0833333333333335 - u3, function() -- Line: 220
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u18.Brightness = 0.65;
        u18.Saturation = 1;
        u18.TintColor = Color3.fromRGB(120, 0, 0);
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(120, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Brightness = -0.1
        }):Play();
    end);
    task.delay(4.616666666666666 - u3, function() -- Line: 242
        -- upvalues: Folder (copy), u11 (copy), VfxManager (ref), Lighting (ref), u20 (ref), TweenService (ref), u18 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Sphere.Sphere.Transparency = 0;
        VfxManager.Enable(u11.Sphere, true);
        VfxManager.Enable(u11.Map, true);
        Lighting.ClockTime = 0;
        u20 = script.FakeAtmo:Clone();
        u20.Parent = Lighting;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u18.Brightness = 0.65;
        u18.TintColor = Color3.fromRGB(120, 0, 0);
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(120, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(5.233333333333333 - u3, function() -- Line: 272
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u18 (copy), Vignette1 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.35);
        TweenService:Create(u18, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        task.wait(0.082);
        TweenService:Create(u18, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            Brightness = 0.4
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        task.wait(0.067);
        TweenService:Create(u18, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
            Brightness = 0.05,
            Saturation = 5,
            TintColor = Color3.fromRGB(120, 0, 0)
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(120, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        task.wait(0.055);
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        TweenService:Create(u18, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(5.266666666666667 - u3, function() -- Line: 312
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Jump);
    end);
    task.delay(6.866666666666666 - u3, function() -- Line: 318
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Sphere:Destroy();
    end);
    task.delay(8.8 - u3, function() -- Line: 324
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u18 (copy), Vignette1 (copy), u19 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(u19, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 30
        }):Play();
        task.wait(0.25);
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        Vignette1.ImageColor3 = Color3.fromRGB(120, 0, 0);
        u18.TintColor = Color3.fromRGB(120, 0, 0);
        u18.Brightness = 0.65;
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(8.916666666666666 - u3, function() -- Line: 355
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(Model.Torso, true);
    end);
    task.delay(9.05 - u3, function() -- Line: 361
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Take);
    end);
    task.delay(9.1 - u3, function() -- Line: 367
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(Model.Torso, false);
    end);
    local u25 = {};

    local function v26() -- Line: 374
        -- upvalues: u25 (ref), Folder (copy), u17 (copy), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), DepthOfField (copy), ClockTime (copy), u20 (ref)
        for _, v in pairs(u25) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u19 then
            u19:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        if ClockTime ~= 0 then
            Lighting.ClockTime = ClockTime;
        end;

        if u20 then
            u20:Destroy();
        end;

        u25 = nil;
    end;

    table.insert(u25, Folder.AttributeChanged:Connect(v26));
    table.insert(u25, Folder.Destroying:Connect(v26));
end;