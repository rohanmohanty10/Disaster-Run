 
 

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
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
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

    task.delay(0.25, function() -- Line: 34
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            {
                u3,
                "On this day...",
                1.25,
                0.5
            },
            { u3, "America will make history once again!", 2.5 }
        });
    end);
    task.delay(11, function() -- Line: 50
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "<animation style=\"glitch\"><font color=\"#bf2748\">A</font>M<font color=\"#115184\">E</font>R<font color=\"#bf2748\">I</font>C<font color=\"#115184\">A</font> NEEDS US!</animation>", 2 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 63
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
    task.delay(13.35 - u5, function() -- Line: 82
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
    task.delay(13.35, function() -- Line: 144
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u16 = SfxManager:playSound({
        Sound = "BBZ UncSam Awaken",
        Duration = 15,
        Parent = workspace
    });
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

    local u18 = script.Camera_VFX:Clone();
    u18:PivotTo(CamRig:FindFirstChild("CamPart").CFrame);
    u18.Parent = Folder;
    u18.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u18.PrimaryPart, CamRig.camera);
    local u19 = script.HeadAura:Clone();
    u19.CFrame = Head.CFrame;
    u19.Parent = Folder;
    Essentials:Weld(u19, Head);
    local UncleSamHatRed = Char:FindFirstChild("UncleSamHatRed");

    if UncleSamHatRed ~= nil then
        UncleSamHatRed.Handle.LocalTransparencyModifier = 1;
    end;

    local u20 = script.Cutscene_VFX:Clone();
    u20:PivotTo(HumanoidRootPart.CFrame);
    u20.Parent = Folder;
    local u21 = script.BackgroundCam:Clone();
    u21:PivotTo(HumanoidRootPart.CFrame);
    u21.Parent = Folder;
    local u22 = ReplicatedStorage.Assets.VFX.Vignette:Clone();
    u22.Parent = PlayerGui;
    u22.Enabled = true;
    local _ = u22.Vignette;
    local Vignette1 = u22.Vignette1;
    local AwakHeli = workspace:FindFirstChild("AwakHeli");
    VfxManager.Enable(AwakHeli, true);
    VfxManager.Enable(u18.DunkCameraHorizontal, true);
    VfxManager.Enable(u18.PassCamera1, true);
    VfxManager.Enable(u20.Background, true);
    VfxManager.Enable(Model, true);
    local u23 = {};

    for _, descendant in Model:GetDescendants() do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    u20.Background.Sphere1.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.884289264678955, 73.02800750732422, 27.199935913085938) * CFrame.fromEulerAnglesYXZ(-0, -3.071779489517212, 0);
    u20.Background.Sphere1.Transparency = 0;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 0;
    BlurEffect.Parent = game_Lighting;
    task.delay(5.367 - u5, function() -- Line: 221
        -- upvalues: Folder (copy), VfxManager (ref), u18 (copy), u21 (copy), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u18, false);
        VfxManager.Enable(u21, false);
        VfxManager.Enable(u20.Background2, true);
        VfxManager.Enable(u20.BackgroundMoney, true);
        VfxManager.Enable(u18.FakeCamera3, true);
        u20.Background2.Sphere1.Transparency = 0;
        u20.Background.Sphere1.Transparency = 1;
    end);
    task.delay(7.5 - u5, function() -- Line: 235
        -- upvalues: Folder (copy), u23 (ref), VfxManager (ref), AwakHeli (copy), u18 (copy), u20 (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder == nil then
            MapFolder = workspace:FindFirstChild("Map2");
        end;

        for _, v in { workspace.Courts2, MapFolder } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or descendant:IsA("Decal")) then
                    table.insert(u23, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                end;
            end;

            if workspace:FindFirstChild("Barriers") and workspace:FindFirstChild("Barriers"):FindFirstChild("Ground") then
                local v24 = { workspace:FindFirstChild("Barriers"):FindFirstChild("Ground"), workspace:FindFirstChild("Barriers"):FindFirstChild("Ground").Transparency };
                table.insert(u23, v24);
                workspace:FindFirstChild("Barriers"):FindFirstChild("Ground").Transparency = 1;
            end;
        end;

        VfxManager.Enable(AwakHeli, true);
        VfxManager.Enable(u18, false);
        VfxManager.Enable(u20.Background, true);
        VfxManager.Enable(u20.Background2, false);

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(8.683 - u5, function() -- Line: 287
        -- upvalues: Folder (copy), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20.Background2.Sphere1.Transparency = 1;
        u20.Background.Sphere1.Transparency = 0;
    end);
    task.delay(8.917 - u5, function() -- Line: 296
        -- upvalues: Folder (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in Model:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.15 - u5, function() -- Line: 307
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref), VfxManager (ref), u20 (copy), BlurEffect (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 47, 50);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 47, 50);
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
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u20.Land);
        VfxManager.Enable(u20.Background, true);
        BlurEffect.Size = 24;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
    end);
    task.delay(10.167 - u5, function() -- Line: 334
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19);
    end);
    task.delay(11.6 - u5, function() -- Line: 341
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u13 (ref), TweenService (ref), u14 (ref), u15 (ref), VfxManager (ref), u20 (copy), u18 (copy), AwakHeli (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 112, 29);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 112, 29);
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
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u20.Boom);
        VfxManager.Enable(u18.DunkCameraHorizontal, true);
        VfxManager.Enable(u18.PassCamera1, true);
        VfxManager.Enable(AwakHeli, true);
        VfxManager.Enable(u20.EnableSmoke, true);
    end);

    local function v27() -- Line: 369
        -- upvalues: u12 (ref), Folder (copy), VfxManager (ref), u23 (ref), BlurEffect (copy), u13 (ref), u14 (ref), u15 (ref), u16 (copy), u22 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy), game_Lighting (copy), ClockTime (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy), Char (copy)
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

        for _, v in u23 do
            local v25, v26 = unpack(v);
            v25.Transparency = v26;
        end;

        if BlurEffect then
            BlurEffect:Destroy();
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
            VfxManager.DestroyEffect(u16, 2);
        end;

        if u22 then
            u22:Destroy();
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
        u23 = nil;
        local UncleSamHatRed2 = Char:FindFirstChild("UncleSamHatRed");

        if UncleSamHatRed2 ~= nil then
            UncleSamHatRed2.Handle.LocalTransparencyModifier = 0;
        end;
    end;

    table.insert(u12, Folder.AttributeChanged:Connect(v27));
    table.insert(u12, Folder.Destroying:Connect(v27));
end;