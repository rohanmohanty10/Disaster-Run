 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 19
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local _ = p2.other;
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Initial" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 39
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u3;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(3.967 - u3, function() -- Line: 58
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u10 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u11 = nil;
    local u12 = nil;
    local u13 = nil;
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

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3.967, function() -- Line: 113
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u14 = SfxManager:playSound({
        Sound = "ACE PATHING SFX BBZ",
        Duration = 5,
        Parent = workspace
    });
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u15.Parent = Folder;
    Essentials:Weld(CamRig.camera, u15.PrimaryPart);
    local u16 = script.BALL:Clone();
    u16.CFrame = BALL.CFrame;
    u16.Parent = Debris;
    Essentials:Weld(u16, BALL);
    VfxManager.Enable(u16, false);
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local _ = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Debris;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v18 = child:Clone();
            v18.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v18.Parent = Model;
            Essentials:Weld(v18, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v18, false);
        end;
    end;

    local u19 = script.Cutscene_VFX:Clone();
    u19:PivotTo(HumanoidRootPart.CFrame);
    u19.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    VfxManager.Enable(Model, true);
    VfxManager.Enable(u16, true);
    local u20 = TweenService:Create(DepthOfField, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
        FocusDistance = 35
    });
    u20:Play();
    task.delay(1.083 - u3, function() -- Line: 175
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy), Debris (ref), u3 (copy), Model (copy), u16 (copy), HumanoidRootPart (copy), u20 (ref), TweenService (ref), DepthOfField (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.DunkCamera, true);
        local u21 = script.SpaceZone:Clone();
        u21.CFrame = workspace.Courts2.Court.Stripes.CFrame * CFrame.new(0, 0.05, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
        u21.Parent = Debris;
        VfxManager.Enable(u21, true);
        task.delay(3.967 - u3 - 1.083 + 3, function() -- Line: 185
            -- upvalues: VfxManager (ref), Model (ref), u16 (ref), u21 (copy)
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 2);
            VfxManager.Enable(u16, false);
            VfxManager.DestroyEffect(u16, 2);
            VfxManager.Enable(u21, false);
            VfxManager.DestroyEffect(u21, 2);
            u21.Transparency = 1;
        end);
        local v22 = script.Path:Clone();
        v22.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.new(0, 0, -76);
        v22.Parent = Folder;
        VfxManager.Enable(v22, true);
        u20 = TweenService:Create(DepthOfField, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
            FocusDistance = 35
        });
        u20:Play();
    end);
    task.delay(1.133 - u3, function() -- Line: 204
        -- upvalues: Folder (copy), Vignette1 (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(39, 89, 255);
        ColorCorrection.TintColor = Color3.fromRGB(47, 109, 255);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(1.517 - u3, function() -- Line: 224
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Dribbles.Dribble1);
    end);
    task.delay(2.6 - u3, function() -- Line: 231
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Dribbles.Dribble2);
    end);
    task.delay(3.983 - u3, function() -- Line: 238
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Dribbles.Dribble3);
    end);

    local function v23() -- Line: 245
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u20 (ref), u17 (copy), Highlight (copy), u14 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
        for _, v in u10 do
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

        if u11 then
            u11:Pause();
        end;

        if u12 then
            u12:Pause();
        end;

        if u13 then
            u13:Pause();
        end;

        if u20 then
            u20:Pause();
        end;

        if u17 then
            u17:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u14 then
            u14:Destroy();
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
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v23));
    table.insert(u10, Folder.Destroying:Connect(v23));
end;