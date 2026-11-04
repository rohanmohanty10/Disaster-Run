 
 

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
    workspace:WaitForChild("CamRig", 5);
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

    task.delay(0.2, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "Welcome to Current. Foods<animation style=\"appear\" timeBetweenStep=\"1\">,</animation> your fries are coming right up.", 3.1 },
            { u3, "I hope Chrollo puts me in his next game...", 2 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 53
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
    task.delay(9.3 - u5, function() -- Line: 72
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
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
    task.delay(9.3, function() -- Line: 134
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u13 = SfxManager:playSound({
        Sound = "BBZ LazyWorker awakening",
        Parent = workspace
    });
    local u14 = script.BALL:Clone();
    u14.CFrame = BALL.CFrame;
    u14.Parent = Folder;
    Essentials:Weld(u14, BALL);
    VfxManager.Enable(u14, false);
    local u15 = script.Cutscene_VFX:Clone();
    u15:PivotTo(HumanoidRootPart.CFrame);
    u15.Parent = Folder;
    local u16 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local _ = u16.Vignette;
    local _ = u16.Vignette1;
    local u17 = script["Screen Cover"]:Clone();
    u17.Parent = u16;
    Atmosphere.Density = 0.348;
    Atmosphere.Offset = 1;
    Atmosphere.Color = Color3.fromRGB(216, 255, 250);
    Atmosphere.Decay = Color3.fromRGB(92, 60, 13);
    Atmosphere.Glare = 0.63;
    Atmosphere.Haze = 0;
    Bloom.Intensity = 1;
    Bloom.Size = 9;
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
    VfxManager.DestroyEffect(BlurEffect, 9.3);
    VfxManager.DestroyEffect(u15.Specs, 9.3 - u5);
    VfxManager.Enable(u15.Grilling, true);
    VfxManager.Enable(u15.Specs, true);
    TweenService:Create(u15.Specs.Specs, TweenInfo.new(0.9375, Enum.EasingStyle.Linear), {
        TimeScale = 0
    }):Play();
    u17.BackgroundTransparency = 0;
    TweenService:Create(u17, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        BackgroundTransparency = 1
    }):Play();
    task.delay(1.833 - u5, function() -- Line: 199
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.Throw);
    end);
    task.delay(2.267 - u5, function() -- Line: 206
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.Catch);
    end);
    task.delay(3.317 - u5, function() -- Line: 213
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.BG);
    end);
    task.delay(3.483 - u5, function() -- Line: 220
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.Thought);
    end);
    task.delay(6.3 - u5, function() -- Line: 227
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.Grilling, false);
    end);
    task.delay(6.417 - u5, function() -- Line: 234
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u14, true);
    end);
    task.delay(7.6 - u5, function() -- Line: 241
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.MouthThrow);
    end);
    task.delay(8.017 - u5, function() -- Line: 248
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.MouthCatch);
    end);
    task.delay(8.583 - u5, function() -- Line: 255
        -- upvalues: Folder (copy), TweenService (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u17, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            BackgroundTransparency = 0
        }):Play();
    end);

    local function v18() -- Line: 262
        -- upvalues: u12 (ref), Folder (copy), VfxManager (ref), u13 (copy), u16 (copy), BlurEffect (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy), game_Lighting (copy), ClockTime (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy)
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
            VfxManager.DestroyEffect(u13, 2);
        end;

        if u16 then
            u16:Destroy();
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

    table.insert(u12, Folder.AttributeChanged:Connect(v18));
    table.insert(u12, Folder.Destroying:Connect(v18));
end;