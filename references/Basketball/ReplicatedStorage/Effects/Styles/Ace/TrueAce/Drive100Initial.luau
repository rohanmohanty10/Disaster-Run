 
 

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
    local u4 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Initial" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 41
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
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
    task.delay(3.967 - u3, function() -- Line: 60
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
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

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3.967, function() -- Line: 115
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u15 = SfxManager:playSound({
        Sound = "ACE PATHING SFX BBZ",
        Duration = 5,
        Parent = workspace
    });
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u16.Parent = Folder;
    Essentials:Weld(CamRig.camera, u16.PrimaryPart);
    local u17 = script.BALL:Clone();
    u17.CFrame = BALL.CFrame;
    u17.Parent = Debris;
    Essentials:Weld(u17, BALL);
    VfxManager.Enable(u17, false);
    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = true;
    local _ = u18.Vignette;
    local Vignette1 = u18.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Debris;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v19 = child:Clone();
            v19.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v19.Parent = Model;
            Essentials:Weld(v19, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v19, false);
        end;
    end;

    local u20 = script.Cutscene_VFX:Clone();
    u20:PivotTo(HumanoidRootPart.CFrame);
    u20.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    VfxManager.Enable(Model, true);
    VfxManager.Enable(u17, true);
    local u21 = TweenService:Create(DepthOfField, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
        FocusDistance = 35
    });
    u21:Play();
    task.delay(1.083 - u3, function() -- Line: 177
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), Debris (ref), u3 (copy), Model (copy), u17 (copy), HumanoidRootPart (copy), u21 (ref), TweenService (ref), DepthOfField (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.DunkCamera, true);
        local u22 = script.SpaceZone:Clone();
        u22.CFrame = workspace.Courts2.Court.Stripes.CFrame * CFrame.new(0, 0.05, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
        u22.Parent = Debris;
        VfxManager.Enable(u22, true);
        task.delay(3.967 - u3 - 1.083 + 3, function() -- Line: 187
            -- upvalues: VfxManager (ref), Model (ref), u17 (ref), u22 (copy)
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 2);
            VfxManager.Enable(u17, false);
            VfxManager.DestroyEffect(u17, 2);
            VfxManager.Enable(u22, false);
            VfxManager.DestroyEffect(u22, 2);
            u22.Transparency = 1;
        end);
        local v23 = script.Path:Clone();
        v23.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.new(0, 0, -76);
        v23.Parent = Folder;
        VfxManager.Enable(v23, true);
        u21 = TweenService:Create(DepthOfField, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
            FocusDistance = 35
        });
        u21:Play();
    end);
    task.delay(1.133 - u3, function() -- Line: 206
        -- upvalues: Folder (copy), Vignette1 (copy), u4 (copy), ColorCorrection (copy), u12 (ref), TweenService (ref), u13 (ref), u14 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = u4;
        ColorCorrection.TintColor = u4;
        ColorCorrection.Brightness = 0.75;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u13:Play();
        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u14:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(1.517 - u3, function() -- Line: 226
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble1);
    end);
    task.delay(2.6 - u3, function() -- Line: 233
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble2);
    end);
    task.delay(3.983 - u3, function() -- Line: 240
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble3);
    end);

    local function v24() -- Line: 247
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u12 (ref), u13 (ref), u14 (ref), u21 (ref), u18 (copy), Highlight (copy), u15 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
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

        if u13 then
            u13:Pause();
        end;

        if u14 then
            u14:Pause();
        end;

        if u21 then
            u21:Pause();
        end;

        if u18 then
            u18:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u15 then
            u15:Destroy();
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
        u11 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v24));
    table.insert(u11, Folder.Destroying:Connect(v24));
end;