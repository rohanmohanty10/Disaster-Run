 
 

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
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: LocalPlayer (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        if p2.Task == "Cleanup" then
            local v5 = Debris:FindFirstChild(v4);

            if v5 then
                v5:SetAttribute("Active", nil);

                return;
            end;
        else
            local v6 = p2.Task == "Luka Vision Off" and Debris:FindFirstChild(v4 .. "Aura");

            if v6 then
                VfxManager.Enable(v6, false);
                VfxManager.DestroyEffect(v6, 4);
            end;
        end;

        return;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 38
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
    task.delay(12.967 - u3, function() -- Line: 60
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.967, function() -- Line: 73
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ LukaDoncic Luka Vision",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.camera, CamRig.camera);
    local u13 = script.Ball:Clone();
    u13.CFrame = BALL.CFrame;
    u13.Parent = Folder;
    Essentials:Weld(u13, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld.Cutscene:GetChildren()) do
        local v14 = Character:FindFirstChild(child.Name);

        if v14 then
            local v15 = child:Clone();
            v15.CFrame = v14.CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, v14);
        end;
    end;

    if p2.RealCharacter then
        local Model2 = Instance.new("Model");
        Model2.Name = v4 .. "Aura";
        Model2.Parent = Debris;

        for _, child in pairs(script.AuraBodyPartsToWeld["Luka Vision"]:GetChildren()) do
            local v16 = p2.RealCharacter:FindFirstChild(child.Name);

            if v16 then
                local v17 = child:Clone();
                v17.CFrame = v16.CFrame;
                v17.Parent = Model2;
                Essentials:Weld(v17, v16);
            end;
        end;
    end;

    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = true;
    local Vignette1 = u18.Vignette1;
    u18.Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u19 = ColorCorrection:Clone();
    u19.Name = "CC";
    u19.Parent = Lighting;
    u19.Enabled = true;
    task.delay(12.967 - u3, function() -- Line: 148
        -- upvalues: u19 (copy), Lighting (ref), ColorCorrection (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u20 = Bloom:Clone();
    u20.Name = "B";
    u20.Parent = Lighting;
    u20.Enabled = true;
    task.delay(12.967 - u3, function() -- Line: 163
        -- upvalues: u20 (copy), Lighting (ref), Bloom (copy)
        u20:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 170
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), u11 (copy), TweenService (ref), u19 (copy), Vignette1 (copy), Essentials (ref), Character (copy), BALL (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local DepthOfFieldEffect = Instance.new("DepthOfFieldEffect", Lighting);
        VfxManager.DestroyEffect(DepthOfFieldEffect, 2.27);
        u11.Sphere.Transparency = 0;
        TweenService:Create(u11.Sphere, TweenInfo.new(1.5, Enum.EasingStyle.Exponential), {
            Transparency = 0.65
        }):Play();
        u19.Saturation = -1;
        Vignette1.BackgroundTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 1
        }):Play();
        Essentials:HideCharacter(Character, { BALL });
    end);
    task.delay(2.45 - u3, function() -- Line: 187
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u11 (copy), u13 (copy), Model (copy), Lighting (ref), TweenService (ref), Vignette1 (copy), u19 (copy), u20 (copy), Bloom (copy), ColorCorrection (copy), Essentials (ref), Character (copy), BALL (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CamTrans);
        VfxManager.Enable(u12["ON24/7"], true);
        VfxManager.Enable(u11.Aura, true);
        VfxManager.Enable(u13, true);
        VfxManager.Enable(Model, true);
        u11.Sphere.Transparency = 1;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 174, 33);
        u19.TintColor = Color3.fromRGB(255, 174, 33);
        u20.Intensity = 15;
        u20.Threshold = 0.5;
        TweenService:Create(u20, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u19.Brightness = 0.65;
        TweenService:Create(u19, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        Essentials:UnhideCharacter(Character, { BALL });
    end);
    task.delay(3.7 - u3, function() -- Line: 218
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble);
    end);
    task.delay(4.183333333333334 - u3, function() -- Line: 224
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble2);
    end);
    task.delay(4.683333333333334 - u3, function() -- Line: 230
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble3);
    end);
    task.delay(5.366666666666666 - u3, function() -- Line: 236
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CamTrans2);
        VfxManager.Enable(u11.Aura.Beams, false);
        VfxManager.Enable(u11.Aura.Beams2, false);
    end);
    task.delay(6.266666666666667 - u3, function() -- Line: 244
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble4);
    end);
    task.delay(7.483333333333333 - u3, function() -- Line: 250
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble5);
    end);
    task.delay(7.983333333333333 - u3, function() -- Line: 256
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Pass);
    end);
    task.delay(8.85 - u3, function() -- Line: 262
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.AirSpecs, true);
    end);
    task.delay(9.05 - u3, function() -- Line: 268
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u19 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Teamate_Grab);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 174, 33);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u19.Brightness = 1;
        u19.Saturation = -1;
        u19.TintColor = Color3.fromRGB(255, 174, 33);
        TweenService:Create(u19, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(9.55 - u3, function() -- Line: 289
        -- upvalues: Folder (copy), TweenService (ref), u19 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u19, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            Brightness = -0.1,
            Saturation = -1
        }):Play();
    end);
    task.delay(10.05 - u3, function() -- Line: 295
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.DunkCamera, true);
    end);
    task.delay(11.083333333333334 - u3, function() -- Line: 301
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u12 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u20 (copy), Bloom (copy), u19 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dunk);
        VfxManager.Enable(u12.DunkCamera, false);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 174, 33);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u20.Intensity = 20;
        u20.Threshold = 0.5;
        TweenService:Create(u20, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u19.Brightness = 1;
        u19.Saturation = -1;
        u19.TintColor = Color3.fromRGB(255, 174, 33);
        TweenService:Create(u19, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u19, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(12.383333333333333 - u3, function() -- Line: 328
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.AirSpecs, false);
    end);
    local u21 = {};

    local function v22() -- Line: 335
        -- upvalues: u21 (ref), Folder (copy), u18 (copy), Highlight (copy), u19 (copy), Lighting (ref), ColorCorrection (copy), u20 (copy), Bloom (copy)
        for _, v in pairs(u21) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u18 then
            u18:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u19 then
            u19:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u20 then
            u20:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u21 = nil;
    end;

    table.insert(u21, Folder.AttributeChanged:Connect(v22));
    table.insert(u21, Folder.Destroying:Connect(v22));
end;