 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function ParticleOnly(p1: userdata, p2: boolean) -- Line: 19
    if p1 == nil then
        return;
    end;

    if p2 == nil then
        p2 = false;
    end;

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p2;
        end;
    end;
end;

local function BeamOnly(p3: userdata, p4: boolean) -- Line: 32
    if p3 == nil then
        return;
    end;

    if p4 == nil then
        p4 = false;
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = p4;
        end;
    end;
end;

return function(u5, p6) -- Line: 46
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), LocalPlayer (copy), Debris (copy), VfxManager (copy), TweenService (copy), ReplicatedStorage (copy), UIController (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;
    local u7 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local v8 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v9 = p6.Task == "Cleanup" and Debris:FindFirstChild(v8);

        if v9 then
            v9:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(6, function() -- Line: 59
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "I feel it, feel it, feel it, feel it, <animation style=\"glitch\">FEEEEEEEL ITTTTTTT!</animation>", 3.5 }
        });
    end);
    task.delay(15.6, function() -- Line: 69
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "<animation style=\"glitch\">LET\'S GO!</animation>", 1.4 }
        });
    end);
    local u10 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 84
        -- upvalues: u5 (copy), u12 (ref), u11 (ref), u10 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u12:Disconnect();

            return;
        end;

        if u11 <= 0 then
            u11 = p13 * 60 * u10;
        end;

        u11 = u11 + p13 * 60;
        local v14 = script_Fov[math.ceil(u11)];

        if v14 ~= nil then
            if math.ceil(u11) >= #script_Fov then
                u12:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v14, p13 * 6);
        end;
    end);
    task.delay(17.333 - u10, function() -- Line: 103
        -- upvalues: u12 (ref)
        u12:Disconnect();
    end);
    local u15 = SfxManager:playSound({
        Sound = "BBZ Rubber Awaken V4",
        Parent = workspace
    });
    u15.TimePosition = u10;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = {};
    local game_Lighting = game.Lighting;
    game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u17 = nil;
    local u18 = nil;
    local u19 = nil;
    local u20 = nil;
    local u21 = nil;
    local u22 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local _ = DepthOfField.FarIntensity;
    local _ = DepthOfField.FocusDistance;
    local _ = DepthOfField.InFocusRadius;
    local _ = DepthOfField.NearIntensity;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local _ = Atmosphere.Color;
    local Offset = Atmosphere.Offset;
    local Haze = Atmosphere.Haze;
    local _ = Atmosphere.Decay;
    local _ = Atmosphere.Glare;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local _ = Bloom.Intensity;
    local _ = Bloom.Size;
    local _ = Bloom.Threshold;
    local _ = game_Lighting.ClockTime;
    local u23 = script.ImpactFrameCC:Clone();
    u23.Parent = game_Lighting;
    local u24 = script.ImpactFrameCC2:Clone();
    u24.Parent = game_Lighting;

    if Debris:FindFirstChild(v8) then
        Debris:FindFirstChild(v8):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(17.333, function() -- Line: 169
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u25 = script.Camera_VFX:Clone();
    u25:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u25.Parent = Folder;
    u25.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u25.PrimaryPart, CamRig.camera);
    local u26 = script.Vignette:Clone();
    u26.Parent = PlayerGui;
    u26.Enabled = true;
    local Vignette = u26.Vignette;
    local Vignette1 = u26.Vignette1;
    local BottomFrame = u26.BottomFrame;
    local TopFrame = u26.TopFrame;
    local SolidColor = u26.SolidColor;
    local StarVignette = u26.StarVignette;
    local v27 = script.BALL:Clone();
    v27.CFrame = BALL.CFrame;
    v27.Parent = Folder;
    Essentials:Weld(v27, BALL);
    local u28 = script.DizzyFX:Clone();
    u28:PivotTo(Head.CFrame);
    u28.Parent = Folder;
    VfxManager.Enable(u28, false);
    local v29 = script.phew:Clone();
    v29.CFrame = Head.CFrame;
    v29.Parent = Folder;
    Essentials:Weld(v29, Head);
    local u30 = script.Cutscene_VFX:Clone();
    u30:PivotTo(HumanoidRootPart.CFrame);
    u30.Parent = Folder;
    local Sphere = u30.Sphere;
    local court = u30.court;
    local blmack = u30.blmack;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(3.153010129928589, -41.7786750793457, 6.245913028717041) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6);
    court.CFrame = HumanoidRootPart.CFrame * CFrame.new(4.454038619995117, -6.008606910705566, 54.04753875732422) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6);
    TweenService:Create(court, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(4.454041481018066, -8.917232513427734, 54.047542572021484) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6)
    }):Play();
    task.delay(9.4 - u10, function() -- Line: 247
        -- upvalues: Folder (copy), court (copy), HumanoidRootPart (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        court.CFrame = HumanoidRootPart.CFrame * CFrame.new(4.454041481018066, -8.917232513427734, 54.047542572021484) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6);
        TweenService:Create(court, TweenInfo.new(0.157, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(4.454035758972168, -3.1194231510162354, 54.04753112792969) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6)
        }):Play();
        task.wait(0.157);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(court, TweenInfo.new(3.816, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(4.454044818878174, -12.064133644104004, 54.047550201416016) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6)
        }):Play();
    end);
    task.delay(9.617 - u10, function() -- Line: 267
        -- upvalues: Folder (copy), blmack (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        blmack.CFrame = HumanoidRootPart.CFrame * CFrame.new(3.152966260910034, 1.6241726875305176, 6.245829105377197) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6);
    end);
    task.delay(15.483 - u10, function() -- Line: 274
        -- upvalues: Folder (copy), TweenService (ref), blmack (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(blmack, TweenInfo.new(0.467, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(3.1530187129974365, -50.12919235229492, 6.24592924118042) * CFrame.fromEulerAnglesYXZ(-1.9371500457054935e-6, 2.652403736647102e-6, 1.0132725947187282e-6)
        }):Play();
    end);
    game_Lighting.Bloom.Intensity = 1.35;
    Vignette.ZIndex = 0;
    Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
    TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        ImageColor3 = Color3.fromRGB(124, 101, 74)
    }):Play();
    Sphere.Transparency = 1;
    StarVignette.ImageTransparency = 1;
    TopFrame.Position = UDim2.new(-0.092, 0, -0.05, 0);
    BottomFrame.Position = UDim2.new(-0.087, 0, -0.02, 0);
    local SpinAttribute = u30.SpinAttribute;
    SpinAttribute:SetAttribute("Active", true);
    local u31 = 0;
    task.spawn(function() -- Line: 300
        -- upvalues: SpinAttribute (copy), Folder (copy), HumanoidRootPart (copy), u31 (ref), u28 (copy), Head (copy), u30 (copy)
        while SpinAttribute:GetAttribute("Active") == true and (Folder:GetAttribute("Active") and HumanoidRootPart ~= nil) do
            u31 = u31 + 1;
            u28.DizzyFX.CFrame = Head.CFrame * CFrame.Angles(0, math.rad(u31), 0);
            local SpecsForFirstFrame = u30.SpecsForFirstFrame;
            SpecsForFirstFrame.CFrame = SpecsForFirstFrame.CFrame * CFrame.Angles(0, -0.014835298641951801, 0);
            task.wait();
        end;
    end);
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    TweenService:Create(Highlight, TweenInfo.new(1.45, Enum.EasingStyle.Sine), {
        FillTransparency = 1
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", game_Lighting);
    BlurEffect.Size = 25;
    TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 1);
    SolidColor.ImageTransparency = 0;
    TweenService:Create(SolidColor, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(BottomFrame, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
        Position = UDim2.new(-0.087, 0, 0.99, 0)
    }):Play();
    TweenService:Create(TopFrame, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
        Position = UDim2.new(-0.087, 0, -0.02, 0)
    }):Play();
    TweenService:Create(Sphere, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        Transparency = 0.45
    }):Play();
    local u32 = TweenService:Create(game_Lighting.DepthOfField, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        FarIntensity = 1,
        FocusDistance = 35.62
    });
    u32:Play();
    VfxManager.Enable(u28, true);
    VfxManager.Enable(u30.SpecsForFirstFrame, true);
    task.delay(1.317 - u10, function() -- Line: 331
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), game_Lighting (copy), u17 (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u30.stepemit1);
    end);
    task.delay(2.183 - u10, function() -- Line: 349
        -- upvalues: Folder (copy), VfxManager (ref), u28 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u28, false);
    end);
    task.delay(4.017 - u10, function() -- Line: 356
        -- upvalues: Folder (copy), u30 (copy), VfxManager (ref), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u30.SpinAttribute:SetAttribute("Active", false);
        VfxManager.Enable(u30.SpecsForFirstFrame, false);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v33 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v33.Parent = ScreenGui;
        UIController:PlayFlipbook(v33, "RubberSprite1", 0.03333333333333333);
        task.wait(0.4);
        ScreenGui:Destroy();
    end);
    task.delay(5.85 - u10, function() -- Line: 378
        -- upvalues: Folder (copy), TweenService (ref), u30 (copy), u23 (copy), u24 (copy), VfxManager (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u30.chesthitEnabling.RootEnabling.PointLight, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
            Brightness = 0,
            Range = 25,
            Color = Color3.fromRGB(255, 35, 35)
        }):Play();
        u23.Enabled = true;
        task.delay(0.05, function() -- Line: 387
            -- upvalues: Folder (ref), u23 (ref), u24 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u23.Enabled = false;
            u24.Enabled = true;
            task.wait(0.05);

            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u24.Enabled = false;
        end);
        VfxManager.Emit(u30.HakiStartup);
        VfxManager.Emit(u30.SpaceZone);
    end);
    task.delay(6.367 - u10, function() -- Line: 406
        -- upvalues: Folder (copy), u30 (copy), TweenService (ref), game_Lighting (copy), u17 (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u30.chesthitEnabling.RootEnabling.PointLight.Color = Color3.fromRGB(255, 255, 255);
        u30.chesthitEnabling.RootEnabling.PointLight.Enabled = true;
        TweenService:Create(u30.chesthitEnabling.RootEnabling.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 10,
            Range = 8
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 0.05;
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u17:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
        VfxManager.Enable(u30.chesthitEnabling, true);
        VfxManager.Enable(u25.PassCamera1, true);
    end);
    task.delay(6.55 - u10, function() -- Line: 429
        -- upvalues: Folder (copy), game_Lighting (copy), u18 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u18:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
    end);
    task.delay(6.7 - u10, function() -- Line: 446
        -- upvalues: Folder (copy), game_Lighting (copy), u19 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u19:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
    end);
    task.delay(6.8 - u10, function() -- Line: 463
        -- upvalues: Folder (copy), game_Lighting (copy), u20 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u20:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
    end);
    task.delay(6.983 - u10, function() -- Line: 480
        -- upvalues: Folder (copy), game_Lighting (copy), u21 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u21 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u21:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
    end);
    task.delay(7.117 - u10, function() -- Line: 497
        -- upvalues: Folder (copy), game_Lighting (copy), u22 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u22 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u22:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
    end);
    task.delay(7.283 - u10, function() -- Line: 514
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u17:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
    end);
    task.delay(7.4 - u10, function() -- Line: 531
        -- upvalues: Folder (copy), game_Lighting (copy), u18 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u18:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
    end);
    task.delay(7.533 - u10, function() -- Line: 548
        -- upvalues: Folder (copy), game_Lighting (copy), u19 (ref), TweenService (ref), Sphere (copy), Vignette (copy), VfxManager (ref), u30 (copy), u23 (copy), u24 (copy), u20 (ref), Vignette1 (copy), u25 (copy), TopFrame (copy), BottomFrame (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.05;
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u19:Play();
        Sphere.Transparency = 1;
        TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0.4
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u30.chesthit);
        task.wait(0.03333333333333333);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u30.chesthitEnabling.RootEnabling.PointLight, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
            Brightness = 0,
            Range = 25,
            Color = Color3.fromRGB(255, 35, 35)
        }):Play();
        u23.Enabled = true;
        task.delay(0.05, function() -- Line: 574
            -- upvalues: Folder (ref), u23 (ref), u24 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u23.Enabled = false;
            u24.Enabled = true;
            task.wait(0.05);

            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u24.Enabled = false;
        end);
        local SpinAttribute2 = u30.SpinAttribute;
        SpinAttribute2:SetAttribute("Active", true);
        task.spawn(function() -- Line: 591
            -- upvalues: SpinAttribute2 (copy), u30 (ref)
            while SpinAttribute2:GetAttribute("Active") == true do
                local BeamMesh1 = u30.Clouds.BeamMesh1;
                BeamMesh1.CFrame = BeamMesh1.CFrame * CFrame.Angles(0, -0.008726646259971648, 0);
                local BeamMesh2 = u30.Clouds.BeamMesh2;
                BeamMesh2.CFrame = BeamMesh2.CFrame * CFrame.Angles(0, -0.008726646259971648, 0);
                task.wait();
            end;
        end);
        game_Lighting.Atmosphere.Density = 0.493;
        game_Lighting.Atmosphere.Offset = 0.411;
        game_Lighting.Atmosphere.Haze = 2.04;
        game_Lighting.DepthOfField.FocusDistance = 13.7;

        for _, child in u30.CloudModels:GetChildren() do
            if child:IsA("Part") then
                child.Transparency = 0;
            end;
        end;

        VfxManager.Enable(u30.Clouds, true);
        u30.Clouds.BeamMesh1.Transparency = 0.65;
        u30.Clouds.BeamMesh2.Transparency = 0.65;
        local BlurEffect2 = Instance.new("BlurEffect", game_Lighting);
        BlurEffect2.Size = 15;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.755);
        game_Lighting.ColorCorrection.Brightness = 0.4;
        game_Lighting.ColorCorrection.Contrast = 1;
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u20:Play();
        Sphere.Transparency = 0.9;
        TweenService:Create(Sphere, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(255, 60, 60);
        TweenService:Create(Vignette, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u30.chesthitEnabling, false);
        VfxManager.Enable(u25.PassCamera1, false);
        TweenService:Create(TopFrame, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Position = UDim2.new(-0.087, 0, 0, 0)
        }):Play();
        TweenService:Create(BottomFrame, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Position = UDim2.new(-0.087, 0, 0.97, 0)
        }):Play();
        VfxManager.Emit(u30.EmitTorso);
        VfxManager.Emit(u30.Haki);
        VfxManager.Emit(u25.camstart);
    end);
    task.delay(8.6 - u10, function() -- Line: 643
        -- upvalues: Folder (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref), u30 (copy), VfxManager (ref), game_Lighting (copy), Density (copy), Offset (copy), Haze (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        task.spawn(function() -- Line: 647
            -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
            local ScreenGui = Instance.new("ScreenGui");
            ScreenGui.Parent = LocalPlayer.PlayerGui;
            ScreenGui.IgnoreGuiInset = true;
            local v34 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
            v34.Parent = ScreenGui;
            UIController:PlayFlipbook(v34, "RubberSprite2", 0.03333333333333333);
            task.wait(0.23333333333333334);
            ScreenGui:Destroy();
        end);
        u30.SpinAttribute:SetAttribute("Active", false);
        u30.chesthitEnabling.RootEnabling.PointLight.Enabled = false;
        VfxManager.Enable(u30.Clouds, false);
        u30.Clouds.BeamMesh1.Transparency = 1;
        u30.Clouds.BeamMesh2.Transparency = 1;
        game_Lighting.DepthOfField.FocusDistance = 36;
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, child in u30.CloudModels:GetChildren() do
            if child:IsA("Part") then
                child.Transparency = 1;
            end;
        end;

        game_Lighting.Atmosphere.Density = Density;
        game_Lighting.Atmosphere.Offset = Offset;
        game_Lighting.Atmosphere.Haze = Haze;
    end);
    task.delay(9.683 - u10, function() -- Line: 689
        -- upvalues: Folder (copy), VfxManager (ref), u25 (copy), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u25.Atmosphere);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.court);
    end);
    task.delay(9.767 - u10, function() -- Line: 704
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), game_Lighting (copy), u17 (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u30.slide);
    end);
    task.delay(9.9 - u10, function() -- Line: 723
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.laugh);
    end);
    task.delay(10 - u10, function() -- Line: 730
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.redemit);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.clouds);
    end);
    task.delay(12.25 - u10, function() -- Line: 744
        -- upvalues: Folder (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u25.CameraTransition2);
    end);
    task.delay(12.833 - u10, function() -- Line: 751
        -- upvalues: Folder (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v35 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v35.Parent = ScreenGui;
        UIController:PlayFlipbook(v35, "RubberSprite3", 0.03333333333333333);
        task.wait(0.4);
        ScreenGui:Destroy();
    end);
    task.delay(13.217 - u10, function() -- Line: 769
        -- upvalues: Folder (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.enabledhakilast);
    end);
    task.delay(14.017 - u10, function() -- Line: 776
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u25.DunkCameraVertical);
    end);
    task.delay(15.6 - u10, function() -- Line: 792
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u30 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u30.slide);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u30.bglightning);
    end);

    local function v36() -- Line: 815
        -- upvalues: u16 (ref), Folder (copy), VfxManager (ref), u24 (copy), u23 (copy), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u32 (ref), u26 (copy), Highlight (copy), u15 (copy), LightingController (ref)
        for _, v in u16 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                elseif descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight")) then
                    descendant:Destroy();
                end;
            end;
        end;

        if u24 then
            u24:Destroy();
        end;

        if u23 then
            u23:Destroy();
        end;

        if u17 then
            u17:Pause();
        end;

        if u18 then
            u18:Pause();
        end;

        if u19 then
            u19:Pause();
        end;

        if u20 then
            u20:Pause();
        end;

        if u21 then
            u21:Pause();
        end;

        if u22 then
            u22:Pause();
        end;

        if u32 then
            u32:Pause();
        end;

        if u26 then
            u26:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u15 then
            VfxManager.DestroyEffect(u15, 2);
        end;

        LightingController:ResetLighting(0.001);
        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v36));
    table.insert(u16, Folder.Destroying:Connect(v36));
end;