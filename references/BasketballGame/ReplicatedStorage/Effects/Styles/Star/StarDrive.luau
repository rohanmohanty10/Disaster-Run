 
 

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
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 18
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local otherRig = p2.otherRig;
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 38
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
    task.delay(4.517 - u3, function() -- Line: 57
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
    local u14 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u15 = nil;

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(4.517, function() -- Line: 96
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u16 = SfxManager:playSound({
        Sound = "BBZ star awaken",
        Parent = workspace
    });
    local u17 = script.Camera_VFX:Clone();
    u17:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u17.Parent = Folder;
    u17.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u17.PrimaryPart);
    local v18 = script.BALL:Clone();
    v18.CFrame = BALL.CFrame;
    v18.Parent = Folder;
    Essentials:Weld(v18, BALL);
    VfxManager.Enable(v18, true);
    local u19 = script.Vignette:Clone();
    u19.Parent = PlayerGui;
    u19.Enabled = true;
    local Vignette = u19.Vignette;
    local Vignette1 = u19.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.StarAura.AuraFX:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v20 = child:Clone();
            v20.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v20.Parent = Model;
            Essentials:Weld(v20, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v20, false);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in script.Phantom.AuraFX:GetChildren() do
        if otherRig:FindFirstChild(child.Name) then
            local v21 = child:Clone();
            v21.CFrame = otherRig:FindFirstChild(child.Name).CFrame;
            v21.Parent = Model2;
            Essentials:Weld(v21, otherRig:FindFirstChild(child.Name));
            VfxManager.Enable(v21, false);
        end;
    end;

    local u22 = script.Cutscene_VFX:Clone();
    u22:PivotTo(HumanoidRootPart.CFrame);
    u22.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    local BlurEffect = Instance.new("BlurEffect", game_Lighting);
    BlurEffect.Size = 15;
    TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.555);
    task.delay(0.05, function() -- Line: 171
        -- upvalues: u11 (ref), TweenService (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), u12 (ref), Vignette1 (copy), u13 (ref), u14 (ref)
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Brightness = -0.015,
            TintColor = Color3_fromRGB_ret
        });
        u11:Play();
        u12 = TweenService:Create(Vignette1, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        });
        u12:Play();
        task.delay(0.01, function() -- Line: 179
            -- upvalues: u13 (ref), TweenService (ref), ColorCorrection (ref), u14 (ref)
            u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                Contrast = 0.2
            });
            u13:Play();
            u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                Saturation = -1,
                Brightness = -0.1
            });
            u14:Play();
        end);
    end);
    VfxManager.Enable(Model, true);
    VfxManager.Enable(Model2, true);
    VfxManager.Enable(v18, true);
    task.delay(0.016666666666666666 - u3, function() -- Line: 192
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), Vignette1 (copy), Highlight (copy), u15 (ref), DepthOfField (copy), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        u15 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 49.12
        });
        u15:Play();
        TweenService:Create(u22.StarVFX.Sphere, TweenInfo.new(0.01, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
    end);
    task.delay(0.867 - u3, function() -- Line: 206
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u11 (ref), ColorCorrection (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect2 = Instance.new("BlurEffect", game_Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(1.3, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 1.3);
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.65, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u11:Play();
    end);
    task.delay(1.017 - u3, function() -- Line: 218
        -- upvalues: Folder (copy), Vignette1 (copy), ColorCorrection (copy), u12 (ref), TweenService (ref), u13 (ref), u14 (ref), u15 (ref), DepthOfField (copy), u22 (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(113, 47, 255);
        ColorCorrection.TintColor = Color3.fromRGB(113, 47, 255);
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
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15 = TweenService:Create(DepthOfField, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 15.2
        });
        u15:Play();
        TweenService:Create(u22.StarVFX.Sphere, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        VfxManager.Emit(u17.CamImpact);
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u22.Enable, true);
    end);
    task.delay(1.317 - u3, function() -- Line: 252
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Teleport);
    end);
    task.delay(1.85 - u3, function() -- Line: 258
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.PerfectDribble);
    end);
    task.delay(3 - u3, function() -- Line: 264
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.PerfectDribble);
    end);
    task.delay(3.417 - u3, function() -- Line: 270
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u17.DunkCameraSparks, true);
    end);
    task.delay(3.483 - u3, function() -- Line: 276
        -- upvalues: Folder (copy), u19 (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u19:GetDescendants() do
            if descendant:IsA("ImageLabel") then
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    ImageTransparency = 1,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                }):Play();
            end;
        end;
    end);

    local function v23() -- Line: 290
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u19 (copy), Highlight (copy), u16 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy)
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

        if u14 then
            u14:Pause();
        end;

        if u15 then
            u15:Pause();
        end;

        if u19 then
            u19:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u16 then
            VfxManager.DestroyEffect(u16, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v23));
    table.insert(u10, Folder.Destroying:Connect(v23));
end;