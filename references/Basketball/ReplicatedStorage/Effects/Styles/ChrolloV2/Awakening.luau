 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local u7 = Players:FindFirstChild(Other.Name) or "Tatlis";
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(3.5 - u3, function() -- Line: 36
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Is that...", 1 }
        });
    end);
    task.delay(5.5 - u3, function() -- Line: 46
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "This is a test.", 1 }
        });
    end);
    task.delay(7.75 - u3, function() -- Line: 56
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "I\'ve accepted this test to stand victorious against my past.", 1.5 }
        });
    end);
    task.delay(14 - u3, function() -- Line: 66
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "A person grows once they are able to defeat their weaker self.", 6.5 }
        });
    end);
    task.delay(22 - u3, function() -- Line: 76
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Wouldn\'t you agree...", 1 },
            { u6, "Hoopers.", 1 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 94
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u3;
        end;

        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 6);
        end;
    end);
    task.delay(25.1 - u3, function() -- Line: 116
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(25.1 - u3, function() -- Line: 129
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Chrollo V2 Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig.camera.CFrame);
    u13.Parent = Folder;
    Essentials:Weld(u13.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v14 = Character:FindFirstChild(child.Name);

        if v14 then
            local v15 = child:Clone();
            v15.CFrame = v14.CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, v14);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in pairs(script.SmokeLegs:GetChildren()) do
        local v16 = Character:FindFirstChild(child.Name);

        if v16 then
            local v17 = child:Clone();
            v17.CFrame = v16.CFrame;
            v17.Parent = Model2;
            Essentials:Weld(v17, v16);
        end;
    end;

    local Model3 = Instance.new("Model");
    Model3.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v18 = Other:FindFirstChild(child.Name);

            if v18 then
                local v19 = child:Clone();
                v19.CFrame = v18.CFrame;
                v19.Parent = Model3;
                Essentials:Weld(v19, v18);
            end;
        end;
    end;

    local Model4 = Instance.new("Model");
    Model4.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v20 = Other:FindFirstChild(child.Name);

            if v20 then
                local v21 = child:Clone();
                v21.CFrame = v20.CFrame;
                v21.Parent = Model4;
                Essentials:Weld(v21, v20);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u22 = script.Vignette:Clone();
    u22.Parent = PlayerGui;
    u22.Enabled = true;
    local Vignette = u22.Vignette;
    local Vignette1 = u22.Vignette1;
    Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u23 = ColorCorrection:Clone();
    u23.Name = "CC";
    u23.Parent = Lighting;
    u23.Enabled = true;
    task.delay(25.1, function() -- Line: 227
        -- upvalues: u23 (copy), Lighting (ref), ColorCorrection (copy)
        u23:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u24 = Bloom:Clone();
    u24.Name = "B";
    u24.Parent = Lighting;
    u24.Enabled = true;
    task.delay(25.1, function() -- Line: 242
        -- upvalues: u24 (copy), Lighting (ref), Bloom (copy)
        u24:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u25 = DepthOfField:Clone();
    u25.Name = "D";
    u25.Parent = Lighting;
    u25.Enabled = true;
    task.delay(25.1, function() -- Line: 257
        -- upvalues: u25 (copy), Lighting (ref), DepthOfField (copy)
        u25:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    task.spawn(function() -- Line: 269
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), Model2 (copy), Model3 (copy), Model4 (copy), u13 (copy), TweenService (ref), Lighting (ref), Vignette1 (copy), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u12.Background1.Sphere.Transparency = 0.65;
        u12.Background1.Part.Transparency = 0.65;
        VfxManager.Enable(Model2, true);
        VfxManager.Enable(Model3, true);
        VfxManager.Enable(Model4, true);
        VfxManager.Enable(u12.SmokeAura, true);
        VfxManager.Enable(u13.SmokeAura, true);

        for _, child in u12.SmokeAura:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.TimeScale = 1;
                TweenService:Create(child, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    TimeScale = 0.001
                }):Play();
            end;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 2.5);
        Vignette1.ImageColor3 = Color3.fromRGB(168, 110, 255);
        TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 0.9
        }):Play();
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(0.7166666666666667 - u3, function() -- Line: 301
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.StompEffect1);
    end);
    task.delay(1.4666666666666666 - u3, function() -- Line: 307
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.StompEffect2);
    end);
    task.delay(2.283333333333333 - u3, function() -- Line: 313
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.StompEffect3);
    end);
    task.delay(2.5 - u3, function() -- Line: 319
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), Model2 (copy), u13 (copy), u23 (copy), u25 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u12.Background1.Sphere.Transparency = 1;
        u12.Background1.Part.Transparency = 1;
        u12.Background2.Sphere.Transparency = 0.75;
        u12.Background2.Part.Transparency = 0.75;
        VfxManager.Enable(u12.FXAOE, true);
        VfxManager.Enable(u12.Test, true);
        VfxManager.Enable(Model2, false);
        VfxManager.Enable(u12.SmokeAura, false);
        VfxManager.Enable(u13.SmokeAura, false);
        u23.Saturation = -1;
        u25.FarIntensity = 1;
        u25.FocusDistance = 50;
    end);
    task.delay(2.8333333333333335 - u3, function() -- Line: 340
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.BreathingVictim);
    end);
    task.delay(3.6166666666666667 - u3, function() -- Line: 346
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.BreathingVictim);
    end);
    task.delay(4.166666666666667 - u3, function() -- Line: 352
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.BreathingVictim);
    end);
    task.delay(4.8 - u3, function() -- Line: 358
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.BreathingVictim);
    end);
    task.delay(5.2 - u3, function() -- Line: 364
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.BreathingVictim);
    end);
    task.delay(5.55 - u3, function() -- Line: 370
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), u13 (copy), u23 (copy), ColorCorrection (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u12.Background1.Sphere.Transparency = 0;
        u12.Background1.Part.Transparency = 0;
        u12.Background2.Sphere.Transparency = 1;
        u12.Background2.Part.Transparency = 1;
        VfxManager.Enable(u13.CamDark, true);
        VfxManager.Enable(u12.FXAOE, false);
        VfxManager.Enable(u12.Test, false);
        shared.vfx.emit(u13.CamTrans);
        u23.Saturation = ColorCorrection.Saturation;
        local Beam = u13.CamDark.Attachment.Beam;
        local C = u13.CamDark:FindFirstChild("C");
        C.TimeScale = 1;
        Beam.LightEmission = 0;
        task.delay(0.25, function() -- Line: 393
            -- upvalues: TweenService (ref), Beam (copy), C (copy)
            TweenService:Create(Beam, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                LightEmission = 1
            }):Play();
            TweenService:Create(C, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                TimeScale = 0.1
            }):Play();
        end);
    end);
    task.delay(9.6 - u3, function() -- Line: 399
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(u12.Background1.Sphere, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(u12.Background1.Part, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    task.delay(10.516666666666667 - u3, function() -- Line: 410
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.DiavloTransition);
    end);
    task.delay(11.416666666666666 - u3, function() -- Line: 416
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), u13 (copy), u24 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u12.Background1.Sphere.Transparency = 0;
        u12.Background1.Part.Transparency = 0;
        u12.Space1.Part.Core.SurfaceLight.Enabled = true;
        VfxManager.Enable(u12.Space1, true);
        VfxManager.Enable(u13.CamSpace, true);
        VfxManager.Enable(u13.CamDark, false);
        u24.Intensity = 0.25;
        u24.Size = 24;
        u24.Threshold = 0;
    end);
    task.delay(15 - u3, function() -- Line: 433
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(Model, true);

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local Brightness = descendant.Brightness;
                local LightEmission = descendant.LightEmission;
                descendant.Brightness = 0;
                descendant.LightEmission = 1;
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Brightness = Brightness,
                    LightEmission = LightEmission
                }):Play();
                task.delay(3, function() -- Line: 448
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = 0
        }):Play();
    end);
    task.delay(17.416666666666668 - u3, function() -- Line: 457
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(19.783333333333335 - u3, function() -- Line: 463
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.Space2, true);
    end);
    task.delay(20.116666666666667 - u3, function() -- Line: 469
        -- upvalues: Folder (copy), Vignette1 (copy), u12 (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 1;
        u12.Space1.Part.Core.SurfaceLight.Enabled = true;
        u12.Space1.Part.Core.SurfaceLight.Enabled = true;
        VfxManager.Enable(u12.BookAura, true);
        VfxManager.Enable(u13.CamSpace1V2, false);
        VfxManager.Enable(u13.CamSpace, false);
    end);
    local u26 = {};

    local function v27() -- Line: 483
        -- upvalues: u26 (ref), Folder (copy), u22 (copy), Highlight (copy), u23 (copy), Lighting (ref), ColorCorrection (copy), u24 (copy), Bloom (copy), u25 (copy), DepthOfField (copy), ClockTime (copy)
        for _, v in pairs(u26) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u22 then
            u22:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u23 then
            u23:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u24 then
            u24:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u25 then
            u25:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        u26 = nil;
    end;

    table.insert(u26, Folder.AttributeChanged:Connect(v27));
    table.insert(u26, Folder.Destroying:Connect(v27));
end;