 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u4 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;
    local u6 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);

    if p2.Task ~= "Cutscene" then
        local v7 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v7 then
            v7:SetAttribute("Active", nil);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "CopycatAwaken",
        Parent = HumanoidRootPart
    });
    task.delay(1, function() -- Line: 37
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            {
                u3,
                "Hah...",
                1,
                0.3
            },
            { u3, "<animation style=\"appear\" timeBetweenStep=\"0.1\">All of your moves <animation style=\"glitch\" timeBetweenStep=\"0.1\">belong to me.</animation></animation>", 3.5 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 56
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u4 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u4;
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
    task.delay(8, function() -- Line: 75
        -- upvalues: u9 (ref)
        if u9 then
            u9:Disconnect();
        end;
    end);

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local _ = workspace.Courts2.Court;
    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8, function() -- Line: 90
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u12.Parent = Folder;
    u12.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u12.PrimaryPart);
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = false;
    local Vignette = u13.Vignette;
    local Vignette1 = u13.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u14 = {};

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v15 = child:Clone();
            v15.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v15, false);
        end;
    end;

    local u16 = script.Cutscene_VFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;
    u16.BreatheEmit.CFrame = Head.CFrame;
    Essentials:Weld(u16.BreatheEmit, Head);
    local Sphere = u16.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = u6 or Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    TweenService:Create(Highlight, TweenInfo.new(1.967, Enum.EasingStyle.Linear), {
        OutlineTransparency = 0
    }):Play();
    task.delay(3.517 - u4, function() -- Line: 143
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            FillTransparency = 0
        }):Play();
        task.wait(0.1);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
    end);
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    u16.BreatheEmit.Sweat.Enabled = true;
    u16.BreatheEmit.Sweat2.Enabled = true;
    u16.BreatheEmit.Sweat3.Enabled = true;
    local u17 = nil;
    local u18 = nil;

    for _, descendant in u16.Void:GetDescendants() do
        if descendant:IsA("MeshPart") then
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    local u19 = TweenService:Create(DepthOfField, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
        FarIntensity = 0.1,
        FocusDistance = 49.12
    });
    u19:Play();
    task.delay(0.867 - u4, function() -- Line: 203
        -- upvalues: Folder (copy), u13 (copy), VfxManager (ref), u16 (copy), TweenService (ref), Vignette (copy), Vignette1 (copy), Highlight (copy), u19 (ref), DepthOfField (copy), Sphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13.Enabled = true;
        VfxManager.Emit(u16.BreatheEmit.EmitBreath);
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        u19 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 49.12
        });
        u19:Play();
        TweenService:Create(Sphere, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
    end);
    task.delay(2.683 - u4, function() -- Line: 221
        -- upvalues: Folder (copy), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u16.Void:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 0;
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.633 - u4, function() -- Line: 233
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), Vignette (copy), u6 (copy), Vignette1 (copy), TweenService (ref), u19 (ref), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.BreatheEmit.Emit);
        VfxManager.Enable(u16.BreatheEmit.Enabling, true);
        Vignette.ImageTransparency = 0;
        Vignette.ImageColor3 = u6 or Color3.fromRGB(35, 39, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.325, Enum.EasingStyle.Sine), {
            ImageTransparency = 0,
            ImageColor3 = u6 or Color3.fromRGB(255, 160, 52)
        }):Play();
        task.delay(0.325, function() -- Line: 244
            -- upvalues: TweenService (ref), Vignette (ref), u6 (ref)
            TweenService:Create(Vignette, TweenInfo.new(0.625, Enum.EasingStyle.Sine), {
                ImageTransparency = 0,
                ImageColor3 = u6 or Color3.fromRGB(255, 160, 52)
            }):Play();
        end);
        task.delay(0.6, function() -- Line: 247
            -- upvalues: TweenService (ref), Vignette (ref)
            TweenService:Create(Vignette, TweenInfo.new(0.625, Enum.EasingStyle.Sine), {
                ImageTransparency = 0.5,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
        end);
        u19 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FarIntensity = FarIntensity,
            FocusDistance = FocusDistance
        });
        u19:Play();
    end);
    task.delay(3.683 - u4, function() -- Line: 256
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 24;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);

        for _, descendant in workspace.Courts2.Court:GetDescendants() do
            if descendant:IsA("MeshPart") then
                TweenService:Create(descendant, TweenInfo.new(0.3), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
    task.delay(5.333 - u4, function() -- Line: 276
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u12 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 24;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        VfxManager.Emit(u12.CamImpact);
    end);
    task.delay(5.4 - u4, function() -- Line: 289
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u16 (copy), Bloom (copy), u18 (ref), Threshold (copy), u12 (copy), Model (copy), ColorCorrection (copy), u6 (copy), u17 (ref), Color3_fromRGB_ret (copy), Vignette (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        VfxManager.Enable(u16.LineGroundFlame, true);
        Bloom.Threshold = 0.5;
        u18 = TweenService:Create(Bloom, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            Threshold = Threshold
        });
        u18:Play();
        VfxManager.Enable(u16.RootEmit, true);
        VfxManager.Enable(u12.DunkCameraSparks, true);
        VfxManager.Enable(Model, true);
        ColorCorrection.TintColor = u6 or Color3.fromRGB(255, 176, 39);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = u6 or Color3.fromRGB(53, 83, 255)
        });
        u17:Play();
        task.delay(0.05, function() -- Line: 310
            -- upvalues: u17 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref)
            u17 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u17:Play();
        end);
        TweenService:Create(Vignette, TweenInfo.new(0.325, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.25,
            ImageColor3 = u6 or Color3.fromRGB(28, 96, 255)
        }):Play();
    end);
    task.delay(6 - u4, function() -- Line: 320
        -- upvalues: Folder (copy), TweenService (ref), Sphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Sphere, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
    end);

    local function v20() -- Line: 327
        -- upvalues: u14 (ref), Folder (copy), VfxManager (ref), u17 (ref), u19 (ref), u13 (copy), Highlight (copy), u18 (ref), Sphere (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        if u17 then
            u17:Pause();
        end;

        if u19 then
            u19:Pause();
        end;

        if u13 then
            u13:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u18 then
            u18:Pause();
        end;

        for _, child in workspace.Courts2.Court:GetChildren() do
            if child:IsA("MeshPart") then
                child.Transparency = 0;

                if child.Name == "Stripes" then
                    child.Transparency = 0.984;
                end;
            end;
        end;

        if Sphere then
            Sphere.Transparency = 1;
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        Atmosphere.Density = Density;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        Bloom.Intensity = Intensity;
        Bloom.Size = Size;
        Bloom.Threshold = Threshold;
        u14 = nil;
    end;

    table.insert(u14, Folder.AttributeChanged:Connect(v20));
    table.insert(u14, Folder.Destroying:Connect(v20));
end;