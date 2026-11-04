 
 

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

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "CopycatAwaken",
        Parent = HumanoidRootPart
    });
    task.delay(1, function() -- Line: 35
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
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 54
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u4 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u4;
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
    task.delay(8, function() -- Line: 73
        -- upvalues: u8 (ref)
        if u8 then
            u8:Disconnect();
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
    task.delay(8, function() -- Line: 88
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u11.Parent = Folder;
    u11.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u11.PrimaryPart);
    local u12 = script.Vignette:Clone();
    u12.Parent = PlayerGui;
    u12.Enabled = false;
    local Vignette = u12.Vignette;
    local Vignette1 = u12.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u13 = {};

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v14 = child:Clone();
            v14.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v14.Parent = Model;
            Essentials:Weld(v14, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v14, false);
        end;
    end;

    local u15 = script.Cutscene_VFX:Clone();
    u15:PivotTo(HumanoidRootPart.CFrame);
    u15.Parent = Folder;
    u15.BreatheEmit.CFrame = Head.CFrame;
    Essentials:Weld(u15.BreatheEmit, Head);
    local Sphere = u15.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    TweenService:Create(Highlight, TweenInfo.new(1.967, Enum.EasingStyle.Linear), {
        OutlineTransparency = 0
    }):Play();
    task.delay(3.517 - u4, function() -- Line: 141
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
    u15.BreatheEmit.Sweat.Enabled = true;
    u15.BreatheEmit.Sweat2.Enabled = true;
    u15.BreatheEmit.Sweat3.Enabled = true;
    local u16 = nil;
    local u17 = nil;

    for _, descendant in u15.Void:GetDescendants() do
        if descendant:IsA("MeshPart") then
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    local u18 = TweenService:Create(DepthOfField, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
        FarIntensity = 0.1,
        FocusDistance = 49.12
    });
    u18:Play();
    task.delay(0.867 - u4, function() -- Line: 201
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), u15 (copy), TweenService (ref), Vignette (copy), Vignette1 (copy), Highlight (copy), u18 (ref), DepthOfField (copy), Sphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u12.Enabled = true;
        VfxManager.Emit(u15.BreatheEmit.EmitBreath);
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        u18 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 49.12
        });
        u18:Play();
        TweenService:Create(Sphere, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
    end);
    task.delay(2.683 - u4, function() -- Line: 219
        -- upvalues: Folder (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u15.Void:GetDescendants() do
            if descendant:IsA("MeshPart") then
                descendant.Transparency = 0;
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.633 - u4, function() -- Line: 231
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy), Vignette (copy), Vignette1 (copy), TweenService (ref), u18 (ref), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.BreatheEmit.Emit);
        VfxManager.Enable(u15.BreatheEmit.Enabling, true);
        Vignette.ImageTransparency = 0;
        Vignette.ImageColor3 = Color3.fromRGB(35, 39, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.325, Enum.EasingStyle.Sine), {
            ImageTransparency = 0,
            ImageColor3 = Color3.fromRGB(255, 160, 52)
        }):Play();
        task.delay(0.325, function() -- Line: 242
            -- upvalues: TweenService (ref), Vignette (ref)
            TweenService:Create(Vignette, TweenInfo.new(0.625, Enum.EasingStyle.Sine), {
                ImageTransparency = 0,
                ImageColor3 = Color3.fromRGB(255, 160, 52)
            }):Play();
        end);
        task.delay(0.6, function() -- Line: 245
            -- upvalues: TweenService (ref), Vignette (ref)
            TweenService:Create(Vignette, TweenInfo.new(0.625, Enum.EasingStyle.Sine), {
                ImageTransparency = 0.5,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
        end);
        u18 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FarIntensity = FarIntensity,
            FocusDistance = FocusDistance
        });
        u18:Play();
    end);
    task.delay(3.683 - u4, function() -- Line: 254
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
    task.delay(5.333 - u4, function() -- Line: 274
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u11 (copy)
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
        VfxManager.Emit(u11.CamImpact);
    end);
    task.delay(5.4 - u4, function() -- Line: 287
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u15 (copy), Bloom (copy), u17 (ref), Threshold (copy), u11 (copy), Model (copy), ColorCorrection (copy), u16 (ref), Color3_fromRGB_ret (copy), Vignette (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        VfxManager.Enable(u15.LineGroundFlame, true);
        Bloom.Threshold = 0.5;
        u17 = TweenService:Create(Bloom, TweenInfo.new(2, Enum.EasingStyle.Sine), {
            Threshold = Threshold
        });
        u17:Play();
        VfxManager.Enable(u15.RootEmit, true);
        VfxManager.Enable(u11.DunkCameraSparks, true);
        VfxManager.Enable(Model, true);
        ColorCorrection.TintColor = Color3.fromRGB(255, 176, 39);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u16 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(53, 83, 255)
        });
        u16:Play();
        task.delay(0.05, function() -- Line: 308
            -- upvalues: u16 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref)
            u16 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u16:Play();
        end);
        TweenService:Create(Vignette, TweenInfo.new(0.325, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.25,
            ImageColor3 = Color3.fromRGB(28, 96, 255)
        }):Play();
    end);
    task.delay(6 - u4, function() -- Line: 318
        -- upvalues: Folder (copy), TweenService (ref), Sphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Sphere, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
    end);

    local function v19() -- Line: 325
        -- upvalues: u13 (ref), Folder (copy), VfxManager (ref), u16 (ref), u18 (ref), u12 (copy), Highlight (copy), u17 (ref), Sphere (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
        for _, v in u13 do
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

        if u16 then
            u16:Pause();
        end;

        if u18 then
            u18:Pause();
        end;

        if u12 then
            u12:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u17 then
            u17:Pause();
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
        u13 = nil;
    end;

    table.insert(u13, Folder.AttributeChanged:Connect(v19));
    table.insert(u13, Folder.Destroying:Connect(v19));
end;