 
 

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
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 19
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), ReplicatedStorage (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local v4 = p2.passedTime or 0;
    local u5 = workspace:GetServerTimeNow() - p2.TimeSent + v4;
    local v6 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v7 = p2.Task == "Cleanup" and Debris:FindFirstChild(v6);

        if v7 then
            v7:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(8.1, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "Your fries are coming right up!", 1.6 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 48
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u5;
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
    task.delay(12.3 - u5, function() -- Line: 67
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local Color = Atmosphere.Color;
    local Offset = Atmosphere.Offset;
    local Haze = Atmosphere.Haze;
    local Decay = Atmosphere.Decay;
    local Glare = Atmosphere.Glare;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u16 = nil;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v6) then
        Debris:FindFirstChild(v6):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v6;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.3, function() -- Line: 129
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u17 = SfxManager:playSound({
        Sound = "BBZ LazyWorker Fries in the bag Cutscene",
        Duration = 13,
        Parent = workspace
    });
    local u18 = script.Camera_VFX:Clone();
    u18:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u18.Parent = Folder;
    u18.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u18.PrimaryPart, CamRig.camera);
    local v19 = script.BALL:Clone();
    v19.CFrame = BALL.CFrame;
    v19.Parent = Folder;
    Essentials:Weld(v19, BALL);
    VfxManager.Enable(v19, false);
    local u20 = script.Cutscene_VFX:Clone();
    u20:PivotTo(HumanoidRootPart.CFrame);
    u20.Parent = Folder;
    local u21 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u21.Parent = PlayerGui;
    u21.Enabled = true;
    local _ = u21.Vignette;
    local Vignette1 = u21.Vignette1;
    local u22 = script["Screen Cover"]:Clone();
    u22.Parent = u21;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0;
    Highlight.Parent = Char;
    Highlight.Enabled = false;
    local Player1 = workspace:FindFirstChild("Player1");
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(40, 40, 40);
    Highlight2.OutlineColor = Color3.new(255, 255, 255);
    Highlight2.OutlineTransparency = 0;
    Highlight2.FillTransparency = 0.5;
    Highlight2.Parent = Player1;
    Highlight2.Enabled = false;
    local Player2 = workspace:FindFirstChild("Player2");
    local Highlight3 = Instance.new("Highlight");
    Highlight3.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight3.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight3.OutlineColor = Color3.new(255, 255, 255);
    Highlight3.OutlineTransparency = 0;
    Highlight3.FillTransparency = 0.5;
    Highlight3.Parent = Player2;
    Atmosphere.Density = 0.348;
    Atmosphere.Offset = 1;
    Atmosphere.Color = Color3.fromRGB(216, 255, 250);
    Atmosphere.Decay = Color3.fromRGB(92, 60, 13);
    Atmosphere.Glare = 0.63;
    Atmosphere.Haze = 0;
    Bloom.Intensity = 1;
    Bloom.Size = 15;
    Bloom.Threshold = 0.9;
    ColorCorrection.Brightness = 0.01;
    ColorCorrection.Contrast = 0.01;
    ColorCorrection.Saturation = 0.01;
    ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
    DepthOfField.FarIntensity = 0.75;
    DepthOfField.FocusDistance = 0.5;
    DepthOfField.InFocusRadius = 50;
    DepthOfField.NearIntensity = 0.75;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 2;
    BlurEffect.Enabled = true;
    BlurEffect.Parent = game_Lighting;
    VfxManager.DestroyEffect(BlurEffect, 12.3);

    for _, descendant in u18.camera:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(8.55 - u5, function() -- Line: 230
        -- upvalues: Folder (copy), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u18.camera.re.Enabled = true;
        task.wait(0.917);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u18.camera.re.Enabled = false;
    end);
    u22.BackgroundTransparency = 0;
    TweenService:Create(u22, TweenInfo.new(1.017 - u5, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    }):Play();
    task.delay(11.783 - u5, function() -- Line: 246
        -- upvalues: Folder (copy), TweenService (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u22, TweenInfo.new(0.467, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 0
        }):Play();
    end);
    Vignette1.ImageTransparency = 1;
    TweenService:Create(Vignette1, TweenInfo.new(1.1 - u5, Enum.EasingStyle.Linear), {
        ImageTransparency = 0
    }):Play();
    task.delay(4.05 - u5, function() -- Line: 257
        -- upvalues: Folder (copy), TweenService (ref), Vignette1 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette1, TweenInfo.new(3.117, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    local u23 = TweenService:Create(Bloom, TweenInfo.new(1.4 - u5, Enum.EasingStyle.Linear), {
        Size = 1
    });
    u23:Play();
    task.delay(9.867 - u5, function() -- Line: 267
        -- upvalues: Folder (copy), u23 (ref), TweenService (ref), Bloom (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23 = TweenService:Create(Bloom, TweenInfo.new(0.116, Enum.EasingStyle.Linear), {
            Size = 15
        });
        u23:Play();
    end);
    task.delay(1.483 - u5, function() -- Line: 275
        -- upvalues: Folder (copy), u16 (ref), TweenService (ref), DepthOfField (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u16 = TweenService:Create(DepthOfField, TweenInfo.new(0.284, Enum.EasingStyle.Linear), {
            InFocusRadius = 4
        });
        u16:Play();
        task.wait(0.284);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u16 = TweenService:Create(DepthOfField, TweenInfo.new(3.55, Enum.EasingStyle.Linear), {
            InFocusRadius = 4
        });
        u16:Play();
    end);
    task.delay(2.333 - u5, function() -- Line: 292
        -- upvalues: Folder (copy), Highlight2 (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight2.Enabled = true;
        TweenService:Create(Highlight2, TweenInfo.new(0.867, Enum.EasingStyle.Linear), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end);
    TweenService:Create(Highlight3, TweenInfo.new(0.65 - u5, Enum.EasingStyle.Linear), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.delay(0.65 - u5, function() -- Line: 302
        -- upvalues: Folder (copy), TweenService (ref), Highlight3 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight3, TweenInfo.new(0.983, Enum.EasingStyle.Linear), {
            FillTransparency = 0.5,
            OutlineTransparency = 0
        }):Play();
        task.wait(0.983);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight3, TweenInfo.new(0.65, Enum.EasingStyle.Linear), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end);
    task.delay(7.1 - u5, function() -- Line: 315
        -- upvalues: Folder (copy), Highlight (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.Enabled = true;
        Highlight.FillTransparency = 0;
        Highlight.OutlineTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(0.967, Enum.EasingStyle.Linear), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end);
    task.delay(3.85 - u5, function() -- Line: 328
        -- upvalues: Folder (copy), u13 (ref), TweenService (ref), ColorCorrection (copy), u14 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.283, Enum.EasingStyle.Linear), {
            Contrast = 1,
            Saturation = -1
        });
        u13:Play();
        task.wait(0.283);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Contrast = 0.01,
            Saturation = 0.01
        });
        u14:Play();
    end);
    task.delay(10.767 - u5, function() -- Line: 345
        -- upvalues: Folder (copy), u13 (ref), TweenService (ref), ColorCorrection (copy), u14 (ref), u15 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.116, Enum.EasingStyle.Linear), {
            Brightness = 0.3
        });
        u13:Play();
        task.delay(0.05, function() -- Line: 352
            -- upvalues: Folder (ref), u14 (ref), TweenService (ref), ColorCorrection (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.066, Enum.EasingStyle.Linear), {
                TintColor = Color3.fromRGB(255, 115, 115)
            });
            u14:Play();
        end);
        task.wait(0.116);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15 = TweenService:Create(ColorCorrection, TweenInfo.new(0.97, Enum.EasingStyle.Linear), {
            Brightness = 0.01,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u15:Play();
    end);
    task.delay(10.95 - u5, function() -- Line: 369
        -- upvalues: Folder (copy), TweenService (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u20.splat.Decal, TweenInfo.new(0.167, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
    end);
    task.delay(3.983 - u5, function() -- Line: 378
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Sense);
    end);
    task.delay(4.833 - u5, function() -- Line: 385
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Throw1);
    end);
    task.delay(6.717 - u5, function() -- Line: 392
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Hop);
    end);
    task.delay(7.5 - u5, function() -- Line: 399
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Catch);
    end);
    task.delay(9.767 - u5, function() -- Line: 406
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Throw);
    end);
    task.delay(10.767 - u5, function() -- Line: 413
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Splatty);
    end);
    task.delay(10.933 - u5, function() -- Line: 420
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Goal);
    end);
    task.delay(6.5 - u5, function() -- Line: 427
        -- upvalues: Folder (copy), u20 (copy), HumanoidRootPart (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20.Beamz.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.11752700805664062, -22.48345184326172, -0.73431396484375) * CFrame.fromEulerAnglesYXZ(0.7853981256484985, 0, 0);
        TweenService:Create(u20.Beamz, TweenInfo.new(0.417, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.11752700805664062, 18.38355255126953, 0.548686146736145) * CFrame.fromEulerAnglesYXZ(0.7853982448577881, 0, 0)
        }):Play();
        task.wait(1.083);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u20.Beamz, TweenInfo.new(0.034, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.11752700805664062, -22.48345184326172, -0.73431396484375) * CFrame.fromEulerAnglesYXZ(0.7853981256484985, 0, 0)
        }):Play();
    end);

    local function v24() -- Line: 448
        -- upvalues: u12 (ref), Folder (copy), VfxManager (ref), u13 (ref), u14 (ref), u15 (ref), u23 (ref), u16 (ref), u17 (copy), u21 (copy), Highlight (copy), BlurEffect (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy), game_Lighting (copy), ClockTime (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy)
        for _, v in u12 do
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

        if u13 then
            u13:Pause();
        end;

        if u14 then
            u14:Pause();
        end;

        if u15 then
            u15:Pause();
        end;

        if u23 then
            u23:Pause();
        end;

        if u16 then
            u16:Pause();
        end;

        if u17 then
            VfxManager.DestroyEffect(u17, 2);
        end;

        if u21 then
            u21:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if BlurEffect then
            BlurEffect:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        Bloom.Threshold = Threshold;
        Bloom.Size = Size;
        Bloom.Intensity = Intensity;
        game_Lighting.ClockTime = ClockTime;
        Atmosphere.Density = Density;
        Atmosphere.Glare = Glare;
        Atmosphere.Decay = Decay;
        Atmosphere.Offset = Offset;
        Atmosphere.Haze = Haze;
        Atmosphere.Color = Color;
        game_Lighting.ClockTime = ClockTime;
        u12 = nil;
    end;

    table.insert(u12, Folder.AttributeChanged:Connect(v24));
    table.insert(u12, Folder.Destroying:Connect(v24));
end;