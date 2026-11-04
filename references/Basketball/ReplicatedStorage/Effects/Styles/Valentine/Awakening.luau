 
 

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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
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
    Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 34
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Careful.", 1.5 },
            { u6, "I can end you whenever I wish.", 2 }
        });
    end);
    task.delay(4.5 - u3, function() -- Line: 49
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "If <animation style=\"glitch\"><font color=\"#417aff\">D4C</font></animation> has the ability...", 2.5 }
        });
    end);
    task.delay(7 - u3, function() -- Line: 59
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "There are <animation style=\"glitch\"><font color=\"#417aff\">infinite</font></animation> of me.", 2 },
            { u6, "There is only one of you!", 2 }
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
    task.delay(13.9 - u3, function() -- Line: 99
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
    task.delay(13.9 - u3, function() -- Line: 112
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Valentine Awakening",
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
    Highlight.FillTransparency = 0.5;

    for i = 1, 5 do
        local v14 = Character:FindFirstChild(script.Parent.Name .. "D4C" .. i);
        local v15;

        if v14 then
            v15 = i;

            for _, descendant in v14:GetDescendants() do
                if descendant:IsA("MeshPart") then
                    descendant.Transparency = 1;
                    task.delay(4.45, function() -- Line: 152
                        -- upvalues: descendant (copy)
                        descendant.Transparency = 0;
                    end);
                end;
            end;

            local Highlight2 = Instance.new("Highlight", v14);
            Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight2.OutlineColor = Color3.fromRGB(65, 122, 255);
            Highlight2.OutlineTransparency = 0.95;
            Highlight2.FillTransparency = 0.5;
            task.delay(9.783333333333333, function() -- Line: 165
                -- upvalues: Highlight2 (copy)
                Highlight2:Destroy();
            end);
        else
            v15 = i;
        end;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u16 = ColorCorrection:Clone();
    u16.Name = "CC";
    u16.Parent = Lighting;
    u16.Enabled = true;
    u16.Saturation = 0.5;
    task.delay(13.9, function() -- Line: 180
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
    u17.Intensity = 6;
    u17.Size = 100;
    u17.Threshold = 35;
    task.delay(13.9, function() -- Line: 198
        -- upvalues: u17 (copy), Lighting (ref), Bloom (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(13.9 - u3, function() -- Line: 208
            -- upvalues: Folder (copy), MapFolder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    task.spawn(function() -- Line: 217
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u12 (copy), Lighting (ref), TweenService (ref), u16 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Main);
        VfxManager.BetterEmit(u12.CamScene);
        VfxManager.BetterEmit(u12.CamGlare1);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.TintColor = Color3.fromRGB(65, 122, 255);
        TweenService:Create(u16, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u16, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(2.2666666666666666 - u3, function() -- Line: 236
        -- upvalues: Folder (copy), u16 (copy), Lighting (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v18 = u16:Clone();
        v18.Name = "BlackCC";
        v18.Parent = Lighting;
        v18.TintColor = Color3.fromRGB(0, 0, 0);
        VfxManager.DestroyEffect(v18, 2.183333333333333);
    end);
    task.delay(3.933333333333333 - u3, function() -- Line: 246
        -- upvalues: Folder (copy), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u17.Intensity = 1.35;
        u17.Size = 24;
        u17.Threshold = 2;
    end);
    task.delay(4.383333333333334 - u3, function() -- Line: 254
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u12 (copy), Lighting (ref), TweenService (ref), u16 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.D4C1);
        VfxManager.BetterEmit(u12.CamAtmo);
        u11.D4C1.SurfaceLight.Enabled = true;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.TintColor = Color3.fromRGB(65, 122, 255);
        TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(8.25 - u3, function() -- Line: 274
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u16 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.TintColor = Color3.fromRGB(65, 122, 255);
        TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(9.75 - u3, function() -- Line: 289
        -- upvalues: Folder (copy), u11 (copy), Lighting (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.D4C1.SurfaceLight.Enabled = false;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 15;
        BlurEffect.Parent = Lighting;
        VfxManager.DestroyEffect(BlurEffect, 1.6666666666666667);
    end);
    task.delay(9.783333333333333 - u3, function() -- Line: 300
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CamSpeed);
    end);
    task.delay(11.833333333333334 - u3, function() -- Line: 306
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.75), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(12.466666666666667 - u3, function() -- Line: 312
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.D4C2);
        VfxManager.BetterEmit(u12.CamGlare2);
    end);
    local u19 = {};

    local function v20() -- Line: 320
        -- upvalues: u19 (ref), Folder (copy), u13 (copy), u16 (copy), Lighting (ref), ColorCorrection (copy), u17 (copy), Bloom (copy), Highlight (copy), MapFolder (copy)
        for _, v in pairs(u19) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
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

        if Highlight then
            Highlight:Destroy();
        end;

        if MapFolder and not workspace:FindFirstChild("MapFolder") then
            MapFolder.Parent = workspace;
        end;

        u19 = nil;
    end;

    table.insert(u19, Folder.AttributeChanged:Connect(v20));
    table.insert(u19, Folder.Destroying:Connect(v20));
end;