 
 

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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy), ReplicatedStorage (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Teammate;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    task.spawn(function() -- Line: 34
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Domain Expansion:", 2 }
        });
    end);
    task.delay(2 - u3, function() -- Line: 44
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "<animation style=\"glitch\">Infinite Void</animation>.", 3 }
        });
    end);
    task.delay(6 - u3, function() -- Line: 54
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "I\'m sorry...", 1 }
        });
    end);
    task.delay(7 - u3, function() -- Line: 64
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "It\'s over for you.", 1 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 77
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
    task.delay(13.333 - u3, function() -- Line: 99
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
    task.delay(13.333 - u3, function() -- Line: 112
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Honored One Infinity Dunk",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local _ = u13.Vignette1;
    u13.Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(13.333, function() -- Line: 154
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
    u15.Intensity = 1.35;
    u15.Threshold = 2;
    task.delay(13.333, function() -- Line: 171
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
    u16.FarIntensity = 1;
    u16.FocusDistance = 35;
    task.delay(13.333, function() -- Line: 188
        -- upvalues: u16 (copy), Lighting (ref), DepthOfField (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;
    task.delay(0.95 - u3, function() -- Line: 197
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Throw);
    end);
    task.delay(1.1833333333333333 - u3, function() -- Line: 203
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u14 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Start);
        u14.Brightness = 2;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(255, 255, 255);
        TweenService:Create(u14, TweenInfo.new(1.3, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(2.966666666666667 - u3, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u14 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Emit);
        u14.Brightness = 2;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(255, 255, 255);
        TweenService:Create(u14, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(2.9833333333333334 - u3, function() -- Line: 227
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Lines);
        VfxManager.BetterEmit(u11.Black);
        VfxManager.BetterEmit(u12.CamAtmo1);
    end);
    task.delay(3.1166666666666667 - u3, function() -- Line: 235
        -- upvalues: Folder (copy), ClockTime (copy), Lighting (ref), u11 (copy), ReplicatedStorage (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if ClockTime ~= 0 then
            Lighting.ClockTime = 0;
            task.delay(7.616666666666666, function() -- Line: 240
                -- upvalues: ClockTime (ref), Lighting (ref)
                if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
                    Lighting.ClockTime = ClockTime;
                end;
            end);
        end;

        u11.Black.Transparency = 0;
        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder then
            MapFolder.Parent = ReplicatedStorage;
            task.delay(7.616666666666666, function() -- Line: 252
                -- upvalues: MapFolder (copy)
                if not workspace:FindFirstChild("MapFolder") then
                    MapFolder.Parent = workspace;
                end;
            end);
        end;

        local Court = workspace:FindFirstChild("Court");

        if Court then
            for _, descendant in Court:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                    local Transparency = descendant.Transparency;

                    if Transparency ~= 1 then
                        descendant.Transparency = 1;
                        task.delay(7.616666666666666, function() -- Line: 266
                            -- upvalues: descendant (copy), Transparency (copy)
                            descendant.Transparency = Transparency;
                        end);
                    end;
                end;
            end;
        end;

        local Courts2 = workspace:FindFirstChild("Courts2");

        if Courts2 then
            for _, descendant in Courts2:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                    local Transparency = descendant.Transparency;

                    if Transparency ~= 1 then
                        descendant.Transparency = 1;
                        task.delay(7.616666666666666, function() -- Line: 281
                            -- upvalues: descendant (copy), Transparency (copy)
                            descendant.Transparency = Transparency;
                        end);
                    end;
                end;
            end;
        end;

        local AnimatedHome = workspace:FindFirstChild("AnimatedHome");

        if AnimatedHome then
            AnimatedHome.Net.Net.Transparency = 1;
            task.delay(7.616666666666666, function() -- Line: 292
                -- upvalues: AnimatedHome (copy)
                AnimatedHome.Net.Net.Transparency = 0;
            end);
        end;

        local AnimatedAway = workspace:FindFirstChild("AnimatedAway");

        if AnimatedAway then
            AnimatedAway.Net.Net.Transparency = 1;
            task.delay(7.616666666666666, function() -- Line: 300
                -- upvalues: AnimatedAway (copy)
                AnimatedAway.Net.Net.Transparency = 0;
            end);
        end;
    end);
    task.delay(6.016666666666667 - u3, function() -- Line: 306
        -- upvalues: Folder (copy), u11 (copy), HumanoidRootPart (copy), VfxManager (ref), u12 (copy), u14 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Domain:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-16.732, -24.99, -3.92) * CFrame.fromEulerAngles(0, -2.9610557957635, 0));
        VfxManager.BetterEmit(u12.CamAtmo2);
        u14.Brightness = 2;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(255, 255, 255);
        TweenService:Create(u14, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(6.866666666666666 - u3, function() -- Line: 320
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u14 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Grab);
        u14.Brightness = 1;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(55, 92, 255);
        TweenService:Create(u14, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(8.1 - u3, function() -- Line: 332
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble1);
    end);
    task.delay(8.666666666666666 - u3, function() -- Line: 338
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble2);
    end);
    task.delay(9.55 - u3, function() -- Line: 344
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Jump);
    end);
    task.delay(10.733333333333333 - u3, function() -- Line: 350
        -- upvalues: Folder (copy), u11 (copy), VfxManager (ref), u14 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Black.Transparency = 1;
        u11.Domain:Destroy();
        VfxManager.BetterEmit(u11.DomainEnd);
        u14.Brightness = 2;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(255, 255, 255);
        TweenService:Create(u14, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(10.85 - u3, function() -- Line: 365
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Score);
    end);
    local u17 = {};

    local function v18() -- Line: 372
        -- upvalues: u17 (ref), Folder (copy), u13 (copy), Highlight (copy), u14 (copy), Lighting (ref), ColorCorrection (copy), u15 (copy), Bloom (copy), u16 (copy), DepthOfField (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
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

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;