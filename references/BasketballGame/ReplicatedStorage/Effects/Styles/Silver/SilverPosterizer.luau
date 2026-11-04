 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, u2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = u2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local Other = u2.Other;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if u2.Task ~= "Cutscene" then
        local v5 = u2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name) or Character.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(2 - u3, function() -- Line: 38
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Too slow!", 1 }
        });
    end);
    task.delay(3.75 - u3, function() -- Line: 48
        -- upvalues: Effects (ref), u2 (copy)
        Effects:SubtitleV2({
            { u2.Enemy1, "This is bad!", 1 }
        });
    end);
    task.delay(6 - u3, function() -- Line: 58
        -- upvalues: Effects (ref), u2 (copy)
        Effects:SubtitleV2({
            { u2.Enemy2, "Like hell I\'d let you do that!", 1.5 }
        });
    end);
    task.delay(10.5 - u3, function() -- Line: 68
        -- upvalues: Effects (ref), u2 (copy)
        Effects:SubtitleV2({
            { u2.Enemy2, "What the-", 1 }
        });
    end);
    task.delay(12.5 - u3, function() -- Line: 78
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "<animation style=\"glitch\">Game over.</animation>", 1.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 91
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
    task.delay(14.5 - u3, function() -- Line: 113
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
    task.delay(14.5 - u3, function() -- Line: 126
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Silver Silver Posterizer",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld1:GetChildren()) do
        local v13 = Character:FindFirstChild(child.Name);

        if v13 then
            local v14 = child:Clone();
            v14.CFrame = v13.CFrame;
            v14.Parent = Model;
            Essentials:Weld(v14, v13);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld2:GetChildren()) do
        local v15 = Character:FindFirstChild(child.Name);

        if v15 then
            local v16 = child:Clone();
            v16.CFrame = v15.CFrame;
            v16.Parent = Model2;
            Essentials:Weld(v16, v15);
        end;
    end;

    local Model3 = Instance.new("Model");
    Model3.Parent = Folder;

    for _, child in pairs(script.Sweat:GetChildren()) do
        local v17 = Character:FindFirstChild(child.Name);

        if v17 then
            local v18 = child:Clone();
            v18.CFrame = v17.CFrame;
            v18.Parent = Model3;
            Essentials:Weld(v18, v17);
        end;
    end;

    local Model4 = Instance.new("Model");
    Model4.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v19 = Other:FindFirstChild(child.Name);

            if v19 then
                local v20 = child:Clone();
                v20.CFrame = v19.CFrame;
                v20.Parent = Model4;
                Essentials:Weld(v20, v19);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u21 = script.Vignette:Clone();
    u21.Parent = PlayerGui;
    u21.Enabled = true;
    local Vignette = u21.Vignette;
    local _ = u21.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u22 = ColorCorrection:Clone();
    u22.Name = "CC";
    u22.Parent = Lighting;
    u22.Enabled = true;
    task.delay(14.5, function() -- Line: 214
        -- upvalues: u22 (copy), Lighting (ref), ColorCorrection (copy)
        u22:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u23 = Bloom:Clone();
    u23.Name = "B";
    u23.Parent = Lighting;
    u23.Enabled = true;
    u23.Intensity = 3;
    u23.Threshold = 1.5;
    task.delay(14.5 - u3, function() -- Line: 231
        -- upvalues: u23 (copy), Lighting (ref), Bloom (copy)
        u23:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    Lighting:FindFirstChild("DepthOfField").Enabled = false;
    task.spawn(function() -- Line: 241
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u11 (copy), u22 (copy), VfxManager (ref), Model3 (copy), Model4 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u11.Background1.Part.Transparency = 0;
        u11.Background1.Sphere.Transparency = 0;
        u22.Saturation = -1;
        VfxManager.Enable(Model3, true);
        VfxManager.Enable(Model4, true);
        VfxManager.Enable(u12.CamShade, true);
    end);
    task.delay(0.7166666666666667 - u3, function() -- Line: 258
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u11 (copy), Model (copy), u22 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        u11.Background1.Part.Transparency = 1;
        u11.Background1.Sphere.Transparency = 1;
        shared.vfx.emit(u11.Dribble1);
        VfxManager.Enable(Model, true);
        u22.Brightness = 0.75;
        u22.Saturation = ColorCorrection.Saturation;
        TweenService:Create(u22, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(1.1833333333333333 - u3, function() -- Line: 278
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
    end);
    task.delay(1.5166666666666666 - u3, function() -- Line: 284
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.CamTransition);
        VfxManager.Enable(Model, false);

        if Model:FindFirstChild("Head") then
            VfxManager.Enable(Model.Head, true);
        end;
    end);
    task.delay(3 - u3, function() -- Line: 294
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        VfxManager.Enable(u12.CamShade, false);
    end);
    task.delay(4.3 - u3, function() -- Line: 304
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble3);
    end);
    task.delay(4.8 - u3, function() -- Line: 310
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble4);
    end);
    task.delay(5.033333333333333 - u3, function() -- Line: 316
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u11 (copy), u22 (copy), ColorCorrection (copy), Lighting (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u11.Background2.Part.Transparency = 1;
        u11.Background2.Sphere.Transparency = 1;
        TweenService:Create(u11.Background2.Part, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
        TweenService:Create(u11.Background2.Sphere, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
        u22.Saturation = -1;
        TweenService:Create(u22, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Saturation = ColorCorrection.Saturation
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 25;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
    end);
    task.delay(6.216666666666667 - u3, function() -- Line: 338
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Background2.Part.Transparency = 1;
        u11.Background2.Sphere.Transparency = 1;
    end);
    task.delay(6.5 - u3, function() -- Line: 345
        -- upvalues: Folder (copy), u22 (copy), VfxManager (ref), Model2 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u22.Saturation = 1;
        u22.Contrast = 0.5;
        VfxManager.Enable(Model2, true);
        VfxManager.Enable(u11.Test1, true);
        shared.vfx.emit(u11.Jump);
    end);
    task.delay(7.3 - u3, function() -- Line: 357
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u11 (copy), VfxManager (ref), u12 (copy), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        shared.vfx.emit(u11.Clash);
        VfxManager.Enable(u11.Test1, false);
        VfxManager.Enable(u12.CamDunk, true);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
    end);
    task.delay(12.133333333333333 - u3, function() -- Line: 374
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.CamDunk, false);
    end);
    task.delay(12.9 - u3, function() -- Line: 380
        -- upvalues: Folder (copy), u11 (copy), VfxManager (ref), Model2 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dunk);
        VfxManager.Enable(Model2, false);
        VfxManager.Enable(u11.Test2, true);
    end);
    local u24 = {};

    local function v25() -- Line: 390
        -- upvalues: u24 (ref), Folder (copy), u21 (copy), u22 (copy), Lighting (ref), ColorCorrection (copy), u23 (copy), Bloom (copy)
        for _, v in pairs(u24) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u21 then
            u21:Destroy();
        end;

        if u22 then
            u22:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u23 then
            u23:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u24 = nil;
    end;

    table.insert(u24, Folder.AttributeChanged:Connect(v25));
    table.insert(u24, Folder.Destroying:Connect(v25));
end;