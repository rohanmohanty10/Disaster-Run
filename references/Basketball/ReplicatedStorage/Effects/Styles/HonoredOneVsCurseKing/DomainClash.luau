 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local script_Fov = require(script.Fov);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local OtherRig = p2.OtherRig;
    local v4 = Character and (Character.Name .. script.Parent.Name .. script.Name or "") or "";

    if p2.Task ~= "Cutscene" then
        if p2.Task == "Cleanup" then
            local v5 = Debris:FindFirstChild(v4);

            if v5 then
                v5:SetAttribute("Active", nil);

                return;
            end;
        elseif p2.Task == "Map" then
            local v6 = script.FakeAtmo:Clone();
            v6.Parent = Lighting.Atmosphere;
            local ClockTime = Lighting.ClockTime;

            if ClockTime ~= 0 then
                Lighting.ClockTime = 0;
            end;

            local v7 = script.Map:Clone();
            v7.Parent = Debris;

            if p2.InfinityVisionSide == "Away" then
                v7:PivotTo(v7:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0));
            end;

            task.wait(30 - u3);
            v6:Destroy();

            if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
                Lighting.ClockTime = ClockTime;
            end;

            VfxManager.Enable(v7, false);
            VfxManager.DestroyEffect(v7, 8);
        end;

        return;
    end;

    local u8 = Players:FindFirstChild(Character.Name);
    local u9 = Players:FindFirstChild(OtherRig.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:WaitForChild("CamRig", 5);
    task.spawn(function() -- Line: 37
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "You really think that shrine of yours can reach me?", 2 }
        });
    end);
    task.delay(2 - u3, function() -- Line: 47
        -- upvalues: Effects (ref), u9 (copy)
        Effects:SubtitleV2({
            { u9, "Reach you?", 1 },
            { u9, "Fool... it will carve the world around you.", 3 }
        });
    end);
    task.delay(6.5 - u3, function() -- Line: 62
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "Oh? Then let\'s see whose infinity wins.", 3 }
        });
    end);
    task.delay(9.5 - u3, function() -- Line: 72
        -- upvalues: Effects (ref), u8 (copy), u9 (copy)
        Effects:SubtitleV2({
            { `{u8.DisplayName} & {u9.DisplayName}`, "<animation style=\"glitch\">Domain Expansion</animation>!", 2 }
        });
    end);
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 85
        -- upvalues: u1 (copy), u11 (ref), u10 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * u3;
        end;

        u10 = u10 + p12 * 60;
        local v13 = script_Fov[math.ceil(u10)];

        if v13 ~= nil then
            if math.ceil(u10) >= #script_Fov then
                u11:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v13, p12 * 6);
        end;
    end);
    task.delay(9.533 - u3, function() -- Line: 107
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.533 - u3, function() -- Line: 120
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Honored One Vs Curse King Domain Clash",
        Parent = workspace
    }).TimePosition = u3;
    local v14 = script.Cutscene_VFX:Clone();
    v14:PivotTo(HumanoidRootPart.CFrame);
    v14.Parent = Folder;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = true;
    local Vignette1 = u15.Vignette1;
    u15.Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u16 = ColorCorrection:Clone();
    u16.Name = "CC";
    u16.Parent = Lighting;
    u16.Enabled = true;
    task.delay(9.533, function() -- Line: 157
        -- upvalues: u16 (copy), Lighting (ref), ColorCorrection (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u17 = Bloom:Clone();
    u17.Name = "B";
    u17.Parent = Lighting;
    u17.Enabled = true;
    u17.Intensity = 1.35;
    u17.Threshold = 2;
    task.delay(9.533, function() -- Line: 174
        -- upvalues: u17 (copy), Lighting (ref), Bloom (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u18 = DepthOfField:Clone();
    u18.Name = "D";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(9.533, function() -- Line: 189
        -- upvalues: u18 (copy), Lighting (ref), DepthOfField (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(1.6833333333333333 - u3, function() -- Line: 196
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), u16 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(73, 152, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.255);
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
        u16.TintColor = Color3.fromRGB(73, 152, 255);
        u16.Brightness = 0.25;
        u16.Saturation = -1;
        TweenService:Create(u16, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = 1
        }):Play();
        task.delay(0.05, function() -- Line: 218
            -- upvalues: Folder (ref), TweenService (ref), u16 (ref), ColorCorrection (ref)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness
            }):Play();
        end);
    end);
    task.delay(3.8666666666666667 - u3, function() -- Line: 224
        -- upvalues: Folder (copy), TweenService (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u16, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = 0.25
        }):Play();
    end);
    task.delay(4 - u3, function() -- Line: 230
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), u16 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(182, 52, 52);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.255);
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
        u16.TintColor = Color3.fromRGB(182, 52, 52);
        u16.Brightness = 0.65;
        u16.Saturation = -1;
        TweenService:Create(u16, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = 1
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Saturation = ColorCorrection.Saturation
        }):Play();
        task.delay(0.05, function() -- Line: 253
            -- upvalues: Folder (ref), TweenService (ref), u16 (ref), ColorCorrection (ref)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness
            }):Play();
        end);
    end);
    task.delay(6 - u3, function() -- Line: 259
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), u16 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(182, 52, 52);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.255);
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
        u16.TintColor = Color3.fromRGB(182, 52, 52);
        u16.Brightness = 0.25;
        u16.Saturation = -1;
        TweenService:Create(u16, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = 1
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Saturation = ColorCorrection.Saturation
        }):Play();
        task.delay(0.05, function() -- Line: 282
            -- upvalues: Folder (ref), TweenService (ref), u16 (ref), ColorCorrection (ref)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness
            }):Play();
        end);
    end);
    task.delay(7.266666666666667 - u3, function() -- Line: 288
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), u16 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(73, 152, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.255);
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
        u16.TintColor = Color3.fromRGB(73, 152, 255);
        u16.Brightness = 0.25;
        u16.Saturation = -1;
        TweenService:Create(u16, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = 1
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Saturation = ColorCorrection.Saturation
        }):Play();
        task.delay(0.05, function() -- Line: 311
            -- upvalues: Folder (ref), TweenService (ref), u16 (ref), ColorCorrection (ref)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            TweenService:Create(u16, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness
            }):Play();
        end);
    end);
    local u19 = {};

    local function v20() -- Line: 318
        -- upvalues: u19 (ref), Folder (copy), u15 (copy), Highlight (copy), u16 (copy), Lighting (ref), ColorCorrection (copy), u17 (copy), Bloom (copy), u18 (copy), DepthOfField (copy)
        for _, v in pairs(u19) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u19 = nil;
    end;

    table.insert(u19, Folder.AttributeChanged:Connect(v20));
    table.insert(u19, Folder.Destroying:Connect(v20));
end;