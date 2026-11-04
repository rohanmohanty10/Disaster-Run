 
 

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
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local u4 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(0.8, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            {
                u3,
                "My legs...",
                1.5,
                0.3
            },
            { u3, "<animation style=\"glitch\">MY LEGS!!!</animation>", 0.8 },
            { u3, "<animation style=\"glitch\">I\'VE ALWAYS HAD A CONNECTION WITH MY LEGS!!!</animation>", 1.5 },
            { u3, "<animation style=\"glitch\">SPEED, SPEED, SPEED!!!!!!!</animation>", 1.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 64
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
    task.delay(8.667 - u4, function() -- Line: 83
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u12 = nil;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local Color = Atmosphere.Color;
    local Offset = Atmosphere.Offset;
    local Haze = Atmosphere.Haze;
    local Decay = Atmosphere.Decay;
    local Glare = Atmosphere.Glare;
    local u13 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8.667, function() -- Line: 145
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u14 = SfxManager:playSound({
        Sound = "BBZ Quick Awaken",
        Parent = workspace
    });
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u15.Parent = Folder;
    u15.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u15.PrimaryPart, CamRig.camera);
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v17 = child:Clone();
            v17.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v17.Parent = Model;
            Essentials:Weld(v17, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v17, false);
        end;
    end;

    local u18 = script.Cutscene_VFX:Clone();
    u18:PivotTo(HumanoidRootPart.CFrame);
    u18.Parent = Folder;
    local _ = u18.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0;
    Highlight.Parent = Char;
    TweenService:Create(Highlight, TweenInfo.new(0.9166666666666666 - u4, Enum.EasingStyle.Linear), {
        FillTransparency = 1
    }):Play();
    TweenService:Create(Highlight, TweenInfo.new(6.783333333333333 - u4, Enum.EasingStyle.Linear), {
        FillColor = Color3.fromRGB(63, 186, 255)
    }):Play();
    task.delay(6.766666666666667 - u4, function() -- Line: 199
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
            FillTransparency = 0
        }):Play();
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(8.833333333333334 - u4, function() -- Line: 209
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), u4 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.1 - u4, Enum.EasingStyle.Linear), {
            FillColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.05);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.18333333333333332 - u4, Enum.EasingStyle.Linear), {
            FillTransparency = 0
        }):Play();
    end);
    task.delay(3.533333333333333 - u4, function() -- Line: 222
        -- upvalues: Folder (copy), u12 (ref), TweenService (ref), ColorCorrection (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.7166666666666667, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 125, 125)
        });
        u12:Play();
        task.wait(1.4833333333333334);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u12:Play();
    end);
    Bloom.Intensity = 0.4;
    Bloom.Size = 1;
    Bloom.Threshold = 0.8;
    task.delay(6.55 - u4, function() -- Line: 242
        -- upvalues: Folder (copy), TweenService (ref), Bloom (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Bloom, TweenInfo.new(1.2833333333333334, Enum.EasingStyle.Linear), {
            Intensity = 0.9,
            Size = 3,
            Threshold = 0.7
        });
    end);
    local u19 = u16:FindFirstChild("Screen Cover");

    if u19 then
        task.delay(8.633333333333333 - u4, function() -- Line: 253
            -- upvalues: Folder (copy), TweenService (ref), u19 (copy)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            TweenService:Create(u19, TweenInfo.new(0.6166666666666667, Enum.EasingStyle.Linear), {
                BackgroundTransparency = 0
            }):Play();
        end);
    end;

    Atmosphere.Density = 0.348;
    Atmosphere.Offset = 1;
    Atmosphere.Color = Color3.fromRGB(216, 255, 250);
    Atmosphere.Decay = Color3.fromRGB(92, 60, 13);
    Atmosphere.Glare = 0.63;
    Atmosphere.Haze = 0;
    task.delay(6.733333333333333 - u4, function() -- Line: 268
        -- upvalues: Folder (copy), u13 (ref), TweenService (ref), Atmosphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13 = TweenService:Create(Atmosphere, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), {
            Density = 0.61,
            Offset = 2,
            Haze = 2,
            Glare = 2.5,
            Color = Color3.fromRGB(22, 45, 72),
            Decay = Color3.fromRGB(1, 3, 5)
        });
        u13:Play();
        task.wait(0.08333333333333333);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13 = TweenService:Create(Atmosphere, TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), {
            Density = 0.4,
            Offset = 2,
            Haze = 2,
            Glare = 2.5,
            Color = Color3.fromRGB(79, 158, 252),
            Decay = Color3.fromRGB(100, 180, 253)
        });
        u13:Play();
    end);
    DepthOfField.FarIntensity = 0.75;
    DepthOfField.FocusDistance = 0.5;
    DepthOfField.InFocusRadius = 50;
    DepthOfField.NearIntensity = 0.75;
    local u20 = script.customblur:Clone();
    u20.Parent = game_Lighting;
    task.delay(0.6666666666666666 - u4, function() -- Line: 305
        -- upvalues: Folder (copy), VfxManager (ref), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u18.Trap);
    end);
    task.delay(1.6833333333333333 - u4, function() -- Line: 311
        -- upvalues: Folder (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, child in Model["Right Leg"].chains_Beams:GetChildren() do
            if child:IsA("Beam") then
                child.Enabled = true;
            end;
        end;

        task.wait(4.966666666666667);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, child in Model["Right Leg"].chains_Beams:GetChildren() do
            if child:IsA("Beam") then
                child.Enabled = false;
            end;
        end;
    end);
    task.delay(1.8166666666666667 - u4, function() -- Line: 331
        -- upvalues: Folder (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.camera.GoodLines.Enabled = true;
        u15.camera.Lines.Enabled = true;
        u15.camera.f.Enabled = true;
        u15.camera.Speedline.Enabled = true;
        task.wait(3.433333333333333);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.camera.GoodLines.Enabled = false;
        u15.camera.Lines.Enabled = false;
        u15.camera.f.Enabled = false;
        u15.camera.Speedline.Enabled = false;
    end);
    task.delay(1.85 - u4, function() -- Line: 349
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(Model.Head["Question Mark"]);
    end);
    task.delay(178 - u4, function() -- Line: 355
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(Model.Head["Shocked Meme Face"]);
    end);
    task.delay(3.8666666666666667 - u4, function() -- Line: 362
        -- upvalues: Folder (copy), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u18["breakdown enable"].Object7.Enabled = true;
        task.wait(1);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u18["breakdown enable"].Object7.Enabled = false;
    end);
    task.delay(3.783333333333333 - u4, function() -- Line: 374
        -- upvalues: Folder (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.camera.Shard2.Enabled = true;
        task.wait(1.35);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.camera.Shard2.Enabled = false;
    end);
    task.delay(3.9 - u4, function() -- Line: 386
        -- upvalues: Folder (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Model.Head.Object9.Enabled = true;
        Model.Head.Object8.Enabled = true;
        Model.Head.Object7.Enabled = true;
        Model["Left Arm"].Object1.Enabled = true;
        Model["Left Arm"].Object2.Enabled = true;
        Model["Left Arm"].Object3.Enabled = true;
        Model["Right Arm"].Object4.Enabled = true;
        Model["Right Arm"].Object5.Enabled = true;
        Model["Right Arm"].Object6.Enabled = true;
        task.wait(2.966666666666667);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Model.Head.Object9.Enabled = false;
        Model.Head.Object8.Enabled = false;
        Model.Head.Object7.Enabled = false;
        Model["Left Arm"].Object1.Enabled = false;
        Model["Left Arm"].Object2.Enabled = false;
        Model["Left Arm"].Object3.Enabled = false;
        Model["Right Arm"].Object4.Enabled = false;
        Model["Right Arm"].Object5.Enabled = false;
        Model["Right Arm"].Object6.Enabled = false;
        task.wait(0.5666666666666667);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Model.Head.Object9.Enabled = true;
        Model.Head.Object8.Enabled = true;
        Model.Head.Object7.Enabled = true;
    end);
    task.delay(5.266666666666667 - u4, function() -- Line: 427
        -- upvalues: Folder (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.camera["Black liness"].Enabled = true;
        u15.camera["Shard again"].Enabled = true;
        task.delay(0.016666666666666666, function() -- Line: 433
            -- upvalues: Folder (ref), u15 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u15.camera["white lines"].Enabled = true;
            task.wait(1.55);

            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u15.camera["white lines"].Enabled = false;
        end);
        task.wait(1.5);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.camera["Black liness"].Enabled = false;
        u15.camera["Shard again"].Enabled = false;
    end);
    task.delay(6.416666666666667 - u4, function() -- Line: 454
        -- upvalues: Folder (copy), TweenService (ref), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u18.Sphere, TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
    end);
    task.delay(6.55 - u4, function() -- Line: 460
        -- upvalues: Folder (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and (descendant.Name == "a1" or descendant.Name == "a2") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.783333333333333 - u4, function() -- Line: 472
        -- upvalues: Folder (copy), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u18["run enable"].Object7.Enabled = true;
    end);
    task.delay(6.8 - u4, function() -- Line: 479
        -- upvalues: Folder (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.CameraSpeedline.RIGHT.Black.Enabled = true;
        u15.CameraSpeedline.RIGHT.Color2.Enabled = true;
        u15.CameraSpeedline.RIGHT.Shards2.Enabled = true;
        u15.CameraSpeedline.LEFT.Black.Enabled = true;
        u15.CameraSpeedline.LEFT.Color2.Enabled = true;
        u15.CameraSpeedline.LEFT.Shards2.Enabled = true;
    end);
    task.delay(6.883333333333334 - u4, function() -- Line: 491
        -- upvalues: Folder (copy), VfxManager (ref), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u18["bURST emit"]);
    end);
    task.delay(6.916666666666667 - u4, function() -- Line: 497
        -- upvalues: Folder (copy), VfxManager (ref), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u18.Step1);
    end);
    task.delay(7.05 - u4, function() -- Line: 503
        -- upvalues: Folder (copy), VfxManager (ref), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u18.step2);
    end);
    task.delay(7.75 - u4, function() -- Line: 509
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.camera["11"], true);
        task.wait(0.03333333333333333);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.camera["CAM EMIT"]);
    end);

    local function v21() -- Line: 522
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u12 (ref), u16 (copy), Highlight (copy), u14 (copy), u13 (ref), u20 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy), game_Lighting (copy), ClockTime (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy)
        for _, v in u11 do
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

        if u12 then
            u12:Pause();
        end;

        if u16 then
            u16:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u14 then
            VfxManager.DestroyEffect(u14, 2);
        end;

        if u13 then
            u13:Pause();
        end;

        if u20 then
            u20:Destroy();
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
        u11 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v21));
    table.insert(u11, Folder.Destroying:Connect(v21));
end;