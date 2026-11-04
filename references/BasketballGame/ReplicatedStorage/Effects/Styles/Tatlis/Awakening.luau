 
 

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
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local _ = p2.passedTime;
    local u4 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(1.3, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "Heheheheheh...", 1.1 }
        });
    end);
    task.delay(7.2, function() -- Line: 45
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "<animation style=\"glitch\">You lose.</animation>", 1.8 }
        });
    end);
    local Player1 = workspace:FindFirstChild("Player1");
    local Player2 = workspace:FindFirstChild("Player2");
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 61
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
    task.delay(9.633 - u4, function() -- Line: 80
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = {};
    local u12 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local u16 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.633, function() -- Line: 125
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u17 = SfxManager:playSound({
        Sound = "BBZ Tatlis Awaken Cutscene Fix",
        Parent = workspace
    });
    u17.TimePosition = u4;
    local u18 = script.Camera_VFX:Clone();
    u18:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u18.Parent = Folder;
    u18.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u18.PrimaryPart, CamRig.camera);
    local u19 = script.Vignette:Clone();
    u19.Parent = PlayerGui;
    u19.Enabled = true;
    local _ = u19.Vignette;
    local Vignette1 = u19.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v20 = child:Clone();
            v20.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v20.Parent = Model;
            Essentials:Weld(v20, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v20, false);
        end;
    end;

    local u21 = script.HeadAura:Clone();
    u21.CFrame = Head.CFrame;
    u21.Parent = Folder;
    Essentials:Weld(u21, Head);
    VfxManager.Enable(u21, false);
    local u22 = script.Cutscene_VFX:Clone();
    u22:PivotTo(HumanoidRootPart.CFrame);
    u22.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight2.OutlineColor = Color3.new(0, 0, 0);
    Highlight2.OutlineTransparency = 1;
    Highlight2.FillTransparency = 1;
    Highlight2.Parent = Player1;
    local Highlight3 = Instance.new("Highlight");
    Highlight3.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight3.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight3.OutlineColor = Color3.new(0, 0, 0);
    Highlight3.OutlineTransparency = 1;
    Highlight3.FillTransparency = 1;
    Highlight3.Parent = Player2;
    local Highlight4 = Instance.new("Highlight");
    Highlight4.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight4.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight4.FillTransparency = 1;
    Highlight4.OutlineColor = Color3.new(0, 0, 0);
    Highlight4.OutlineTransparency = 1;
    Highlight4.Parent = BALL;
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder == nil then
        MapFolder = workspace:FindFirstChild("Map2");
    end;

    for _, v in { workspace.Courts2, MapFolder } do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("MeshPart") or (descendant:IsA("Part") or descendant:IsA("Decal")) then
                table.insert(u12, { descendant, descendant.Transparency });
                descendant.Transparency = 1;
            end;
        end;
    end;

    local v23 = script.SpaceZone:Clone();
    v23.CFrame = workspace.Courts2.Court.Stripes.CFrame * CFrame.new(0, 0.05, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
    v23.Parent = Folder;
    VfxManager.Enable(v23, true);
    VfxManager.Enable(u22.Enabled, true);
    VfxManager.Enable(u22.Enable2, true);
    VfxManager.Enable(Model, true);
    task.delay(1.3 - u4, function() -- Line: 231
        -- upvalues: Folder (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Model.Torso.Attachment.Star102.Enabled = true;
    end);
    task.delay(3.283 - u4, function() -- Line: 238
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref), VfxManager (ref), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(60, 144, 255);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(60, 144, 255);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u14:Play();
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u15:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u18.CameraAtmosphere, true);
    end);
    task.delay(3.567 - u4, function() -- Line: 260
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Footstep1);
    end);
    task.delay(3.733 - u4, function() -- Line: 267
        -- upvalues: Folder (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Model.Torso.Attachment.Star102.Enabled = false;
    end);
    task.delay(3.817 - u4, function() -- Line: 274
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref), Highlight (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Footstep2);
        TweenService:Create(Highlight, TweenInfo.new(1.2833333333333334, Enum.EasingStyle.Linear), {
            FillTransparency = 0
        }):Play();
        task.wait(2.4833333333333334);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.7333333333333333, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(4.867 - u4, function() -- Line: 289
        -- upvalues: Folder (copy), TweenService (ref), Highlight3 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight3, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            FillTransparency = 0
        }):Play();
    end);
    task.delay(4.883 - u4, function() -- Line: 296
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
        end;
    end);
    task.delay(4.933 - u4, function() -- Line: 316
        -- upvalues: Folder (copy), VfxManager (ref), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u18.Test, true);
    end);
    task.delay(4.95 - u4, function() -- Line: 323
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref), u16 (ref), VfxManager (ref), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(60, 144, 255);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(60, 144, 255);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u14:Play();
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u15:Play();
        u16 = TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        });
        u16:Play();
        VfxManager.Enable(u18.DunkCameraHorizontal, true);
        VfxManager.Enable(u18.CameraAtmosphere, false);
        VfxManager.Emit(u18.Impact);
    end);
    task.delay(6.183 - u4, function() -- Line: 349
        -- upvalues: Folder (copy), VfxManager (ref), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u18.Test, false);
    end);
    task.delay(7.233 - u4, function() -- Line: 356
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21);
        VfxManager.Enable(u21.Enabling);
    end);
    task.delay(9.617 - u4, function() -- Line: 364
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), Model (copy), u21 (copy), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u22, false);
        VfxManager.Enable(Model, false);
        VfxManager.Enable(u21, false);
        VfxManager.Enable(u18, false);
    end);

    local function v26() -- Line: 375
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u19 (copy), Highlight (copy), Highlight4 (copy), Highlight2 (copy), Highlight3 (copy), u17 (copy), u12 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
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

        if Highlight4 then
            Highlight4:Destroy();
        end;

        if Highlight2 then
            Highlight2:Destroy();
        end;

        if Highlight3 then
            Highlight3:Destroy();
        end;

        if u17 then
            VfxManager.DestroyEffect(u17, 2);
        end;

        if u12 then
            for _, v in u12 do
                local v24, v25 = unpack(v);
                v24.Transparency = v25;
            end;
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        game_Lighting.ClockTime = ClockTime;
        u11 = nil;
        u12 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v26));
    table.insert(u11, Folder.Destroying:Connect(v26));
end;