 
 

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

    task.delay(2, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "Urghhhhhhh<animation style=\"glitch\">AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH!</animation>", 2.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 48
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
    task.delay(5.683 - u4, function() -- Line: 67
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = {};
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
    local u12 = nil;
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
    task.delay(5.683, function() -- Line: 129
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u13 = SfxManager:playSound({
        Sound = "BBZ Quick Unbound Speed",
        Parent = workspace
    });
    local u14 = script.Camera_VFX:Clone();
    u14:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u14.Parent = Folder;
    u14.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u14.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

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
    local u17 = script["CC EFFECT"]:Clone();
    u17.Parent = game_Lighting;
    task.delay(1.9 - u4, function() -- Line: 166
        -- upvalues: Folder (copy), TweenService (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u17, TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear), {
            Brightness = -0.3,
            Contrast = 1,
            Saturation = -1
        }):Play();
        task.wait(0.38333333333333336);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u17, TweenInfo.new(1.0833333333333333, Enum.EasingStyle.Linear), {
            Brightness = 0.001,
            Contrast = 0.001,
            Saturation = 0.001
        }):Play();
    end);
    task.delay(3.966666666666667 - u4, function() -- Line: 185
        -- upvalues: Folder (copy), TweenService (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u16.Sphere, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            Transparency = 0
        }):Play();
    end);
    Atmosphere.Density = 0.348;
    Atmosphere.Offset = 1;
    Atmosphere.Color = Color3.fromRGB(216, 255, 250);
    Atmosphere.Decay = Color3.fromRGB(92, 60, 13);
    Atmosphere.Glare = 0.63;
    Atmosphere.Haze = 0;
    task.delay(3.966666666666667 - u4, function() -- Line: 198
        -- upvalues: Folder (copy), u12 (ref), TweenService (ref), Atmosphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u12 = TweenService:Create(Atmosphere, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            Density = 0.6,
            Offset = 1,
            Haze = 2,
            Glare = 2,
            Color = Color3.fromRGB(80, 159, 255),
            Decay = Color3.fromRGB(101, 181, 255)
        });
        u12:Play();
    end);
    VfxManager.Enable(Model, true);
    task.delay(0.26666666666666666 - u4, function() -- Line: 216
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Trap);
    end);
    task.delay(1.1166666666666667 - u4, function() -- Line: 223
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u14.camera.Attachment);
    end);
    task.delay(1.8833333333333333 - u4, function() -- Line: 229
        -- upvalues: Folder (copy), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u14.camera["Black liness"].Enabled = true;
        u14.camera.GoodLines.Enabled = true;
        u14.camera.Lines.Enabled = true;
        u14.camera.f.Enabled = true;
        u14.camera["white lines"].Enabled = true;
        task.wait(1.75);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u14.camera["Black liness"].Enabled = false;
        u14.camera.GoodLines.Enabled = false;
        u14.camera.Lines.Enabled = false;
        u14.camera.f.Enabled = false;
        u14.camera["white lines"].Enabled = false;
    end);
    task.delay(3.95 - u4, function() -- Line: 250
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16["run enable"]);
    end);
    task.delay(4 - u4, function() -- Line: 256
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16["bURST emit"]);
    end);
    task.delay(4.183333333333334 - u4, function() -- Line: 262
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u14.CameraSpeedline, true);
    end);

    local function v18() -- Line: 268
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u17 (copy), u13 (copy), u12 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy), game_Lighting (copy), ClockTime (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy)
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

        if u17 then
            u17:Destroy();
        end;

        if u13 then
            VfxManager.DestroyEffect(u13, 2);
        end;

        if u12 then
            u12:Pause();
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

    table.insert(u11, Folder.AttributeChanged:Connect(v18));
    table.insert(u11, Folder.Destroying:Connect(v18));
end;