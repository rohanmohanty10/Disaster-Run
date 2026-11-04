 
 

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
    workspace:WaitForChild("CamRig", 5);
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
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u10 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u11 = nil;
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local u16 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8.067 - u3, function() -- Line: 94
        -- upvalues: u7 (ref), Folder (copy)
        u7:Disconnect();

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u17 = SfxManager:playSound({
        Sound = "BBZ star cutscene stardunk",
        Parent = workspace
    });
    local u18 = script.BALL:Clone();
    u18.CFrame = BALL.CFrame;
    u18.Parent = Folder;
    Essentials:Weld(u18, BALL);
    VfxManager.Enable(u18, false);
    local u19 = script.Vignette:Clone();
    u19.Parent = PlayerGui;
    u19.Enabled = true;
    local _ = u19.Vignette;
    local Vignette1 = u19.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u20 = {};

    for _, child in script.StarAura.AuraFX:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v21 = child:Clone();
            v21.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v21.Parent = Model;
            Essentials:Weld(v21, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v21, false);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in script.PhantomAura.AuraFX:GetChildren() do
        if otherRig:FindFirstChild(child.Name) then
            local v22 = child:Clone();
            v22.CFrame = otherRig:FindFirstChild(child.Name).CFrame;
            v22.Parent = Model2;
            Essentials:Weld(v22, otherRig:FindFirstChild(child.Name));
            VfxManager.Enable(v22, false);
        end;
    end;

    local u23 = script.Cutscene_VFX:Clone();
    u23:PivotTo(HumanoidRootPart.CFrame);
    u23.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    VfxManager.Enable(Model, true);
    VfxManager.Enable(Model2, true);
    task.delay(0.383 - u3, function() -- Line: 165
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXPhantom.Dribble1);
    end);
    task.delay(0.8 - u3, function() -- Line: 171
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXPhantom.Dribble2);
    end);
    task.delay(1.167 - u3, function() -- Line: 177
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXPhantom.Dribble3);
    end);
    task.delay(1.6 - u3, function() -- Line: 183
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXPhantom.Dribble4);
    end);
    task.delay(1.933 - u3, function() -- Line: 189
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref), Highlight (copy), u23 (copy), VfxManager (ref), u14 (ref), Color3_fromRGB_ret (copy), u15 (ref), u16 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(39, 89, 255);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(47, 109, 255);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(u23.Sphere, TweenInfo.new(0.01, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        task.delay(0.05, function() -- Line: 218
            -- upvalues: u14 (ref), TweenService (ref), game_Lighting (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), u15 (ref), u16 (ref)
            u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u14:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            task.delay(0.01, function() -- Line: 224
                -- upvalues: u15 (ref), TweenService (ref), game_Lighting (ref), u16 (ref)
                u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                    Contrast = 0.2
                });
                u15:Play();
                u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u16:Play();
            end);
        end);
        task.wait(0.03333333333333333);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXPhantom.Dribble5);
    end);
    task.delay(2.417 - u3, function() -- Line: 240
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.Enable.SpaceZone, true);
    end);
    task.delay(2.567 - u3, function() -- Line: 246
        -- upvalues: Folder (copy), u20 (copy), Vignette1 (copy), game_Lighting (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder == nil then
            MapFolder = workspace:FindFirstChild("Map2");
        end;

        for _, v in { workspace.Courts2, MapFolder } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or descendant:IsA("Decal")) then
                    table.insert(u20, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                end;
            end;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(94, 79, 255);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(94, 79, 255);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(u23.Sphere, TweenInfo.new(0.01, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
    end);
    task.delay(2.65 - u3, function() -- Line: 282
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXStarAura.Dribble1);
    end);
    task.delay(2.85 - u3, function() -- Line: 288
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXStarAura.Dribble2);
    end);
    task.delay(3.083 - u3, function() -- Line: 294
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXStarAura.Dribble3);
    end);
    task.delay(3.35 - u3, function() -- Line: 300
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXStarAura.Dribble4);
    end);
    task.delay(3.583 - u3, function() -- Line: 306
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXStarAura.Dribble4);
    end);
    task.delay(4.133 - u3, function() -- Line: 312
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.VFXStarAura.Dribble5);
    end);
    task.delay(4.83 - u3, function() -- Line: 318
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), u18 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Grab);
        VfxManager.Enable(u18, true);
    end);
    task.delay(5.467 - u3, function() -- Line: 326
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.Enable.AirSpecs, true);
        VfxManager.Emit(u23.Jump);
    end);
    task.delay(6.617 - u3, function() -- Line: 333
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Dunk);
    end);

    local function v26() -- Line: 339
        -- upvalues: u10 (copy), u20 (copy), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u19 (copy), Highlight (copy), u17 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy)
        for _, v in u10 do
            v:Disconnect();
        end;

        for _, v in u20 do
            local v24, v25 = unpack(v);
            v24.Transparency = v25;
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

        if u16 then
            u16:Pause();
        end;

        if u19 then
            u19:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u17 then
            VfxManager.DestroyEffect(u17, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v26));
    table.insert(u10, Folder.Destroying:Connect(v26));
end;