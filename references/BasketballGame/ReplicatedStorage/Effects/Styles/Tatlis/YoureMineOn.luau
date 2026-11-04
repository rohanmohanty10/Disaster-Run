 
 

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

    task.delay(0.8, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "Playtime\'s over, kids.", 2 }
        });
    end);
    task.delay(6, function() -- Line: 45
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "I\'ll end this for you.", 1.5 }
        });
    end);
    task.delay(8.5, function() -- Line: 55
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "Heh.", 1 }
        });
    end);
    workspace:FindFirstChild("Player1");
    workspace:FindFirstChild("Player2");
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 71
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
    task.delay(14.783 - u4, function() -- Line: 90
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
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u16 = nil;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(14.783, function() -- Line: 135
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u17 = SfxManager:playSound({
        Sound = "BBZ Tatlis Too Easy Cutscene",
        Duration = 15,
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
    local Vignette = u19.Vignette;
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
    local v22 = script.BALL:Clone();
    v22.CFrame = BALL.CFrame;
    v22.Parent = Folder;
    Essentials:Weld(v22, BALL);
    VfxManager.Enable(v22, false);
    local u23 = script.Cutscene_VFX:Clone();
    u23:PivotTo(HumanoidRootPart.CFrame);
    u23.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(255, 255, 255);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    local u24 = {};

    for i = 1, 5 do
        local v25 = workspace:FindFirstChild((`Enemy{tostring(i)}`));
        local Highlight2 = Instance.new("Highlight");
        Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight2.OutlineColor = Color3.new(255, 255, 255);
        Highlight2.OutlineTransparency = 1;
        Highlight2.FillTransparency = 1;
        Highlight2.Parent = v25;
        table.insert(u24, Highlight2);
        local _ = i;
    end;

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

    local v26 = script.SpaceZone:Clone();
    v26.CFrame = workspace.Courts2.Court.Stripes.CFrame * CFrame.new(0, 0.05, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
    v26.Parent = Folder;
    VfxManager.Enable(v26, true);
    VfxManager.Enable(u23.Enabled, true);
    VfxManager.Enable(Model, true);
    VfxManager.Enable(v22, true);
    task.delay(0.183 - u4, function() -- Line: 240
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21);
        VfxManager.Enable(u21.Enabling, true);
    end);
    task.delay(0.533 - u4, function() -- Line: 248
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Dribble1);
    end);
    task.delay(1.8 - u4, function() -- Line: 255
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Dribble2);
    end);
    task.delay(3.283 - u4, function() -- Line: 262
        -- upvalues: Folder (copy), Vignette (copy), Vignette1 (copy), game_Lighting (copy), VfxManager (ref), u23 (copy), u18 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0;
        game_Lighting.ColorCorrection.Saturation = -1;
        game_Lighting.DepthOfField.FocusDistance = 35;
        VfxManager.Enable(u23.AirSpecs, true);
        VfxManager.Enable(u18.Speedlines, true);
        VfxManager.Enable(u18.DunkCameraVertical, true);
        VfxManager.Emit(u23.Warning);
    end);
    task.delay(4.05 - u4, function() -- Line: 277
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
        VfxManager.Enable(u18, false);
    end);
    task.delay(4.833 - u4, function() -- Line: 299
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21, false);
        VfxManager.Enable(u23.AirSpecs, false);
    end);
    task.delay(5.683 - u4, function() -- Line: 308
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21, true);
    end);
    task.delay(6.05 - u4, function() -- Line: 315
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Throw);
    end);
    task.delay(6.933 - u4, function() -- Line: 322
        -- upvalues: Folder (copy), DepthOfField (copy), u16 (ref), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        DepthOfField.FarIntensity = 1;
        DepthOfField.FocusDistance = 25;
        DepthOfField.InFocusRadius = 0;
        DepthOfField.NearIntensity = 0;
        u16 = TweenService:Create(DepthOfField, TweenInfo.new(1.6166666666666667, Enum.EasingStyle.Linear), {
            FocusDistance = 120
        });
        u16:Play();
    end);
    task.delay(7.233 - u4, function() -- Line: 335
        -- upvalues: Folder (copy), u24 (ref), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, v in u24 do
            TweenService:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
                OutlineTransparency = 0
            }):Play();
            task.delay(2.05, function() -- Line: 342
                -- upvalues: Folder (ref), TweenService (ref), v (copy)
                if Folder == nil then
                    return;
                end;

                if Folder:GetAttribute("Active") == nil then
                    return;
                end;

                TweenService:Create(v, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                    OutlineTransparency = 1
                }):Play();
            end);
        end;
    end);
    task.delay(9.267 - u4, function() -- Line: 351
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(58, 111, 255);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(58, 111, 255);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u14:Play();
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u15:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u23.Enable2, true);
        VfxManager.Emit(u23.FallFX);
    end);
    task.delay(11.717 - u4, function() -- Line: 374
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 215, 69);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 215, 69);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u14:Play();
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u15:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u23.Enable2, true);
    end);
    task.delay(13.333 - u4, function() -- Line: 396
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u23.Catch);
    end);

    local function v29() -- Line: 403
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u19 (copy), Highlight (copy), u24 (ref), u17 (copy), u12 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
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

        if BallHighlight then
            BallHighlight:Destroy();
        end;

        for _, v in u24 do
            if v then
                v:Destroy();
            end;
        end;

        if u17 then
            VfxManager.DestroyEffect(u17, 2);
        end;

        if u12 then
            for _, v in u12 do
                local v27, v28 = unpack(v);
                v27.Transparency = v28;
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
        u24 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v29));
    table.insert(u11, Folder.Destroying:Connect(v29));
end;