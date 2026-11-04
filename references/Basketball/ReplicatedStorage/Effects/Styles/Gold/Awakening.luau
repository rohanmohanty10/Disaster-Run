 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(0.25 - u3, function() -- Line: 35
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Every single one of you here...", 2 },
            { u6, "no.", 0.5 }
        });
    end);
    task.delay(3.5 - u3, function() -- Line: 50
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Everyone in this country who pretends to play basketball...", 2.5 }
        });
    end);
    task.delay(7 - u3, function() -- Line: 60
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Just give up the sport or...", 1 },
            { u6, "<animation style=\"appear\">DROP <font color=\"#ff0000\">DEAD</font>!</animation>", 1.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 78
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
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
    task.delay(11.667 - u3, function() -- Line: 100
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(11.667 - u3, function() -- Line: 113
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Gold Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.Sweat:GetChildren()) do
        local v13 = Character:FindFirstChild(child.Name);

        if v13 then
            local v14 = child:Clone();
            v14.CFrame = v13.CFrame;
            v14.Parent = Model;
            Essentials:Weld(v14, v13);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v15 = Other:FindFirstChild(child.Name);

            if v15 then
                local v16 = child:Clone();
                v16.CFrame = v15.CFrame;
                v16.Parent = Model2;
                Essentials:Weld(v16, v15);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(11.667, function() -- Line: 176
        -- upvalues: u18 (copy), Lighting (ref), ColorCorrection (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u19 = DepthOfField:Clone();
    u19.Name = "D";
    u19.Parent = Lighting;
    u19.Enabled = true;
    u19.InFocusRadius = 0;
    u19.NearIntensity = 0;
    task.delay(11.667, function() -- Line: 193
        -- upvalues: u19 (copy), Lighting (ref), DepthOfField (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;
    Lighting.ClockTime = 22.532;
    local ExposureCompensation = Lighting.ExposureCompensation;
    task.spawn(function() -- Line: 205
        -- upvalues: Folder (copy), u19 (copy), TweenService (ref), VfxManager (ref), u12 (copy), u11 (copy), Model (copy), Model2 (copy), Lighting (ref), Vignette (copy), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u19.FarIntensity = 1;
        TweenService:Create(u19, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FocusDistance = 25.88
        }):Play();
        VfxManager.Enable(u12.CameraShade, true);
        VfxManager.Enable(u12.CameraSpecs, true);
        VfxManager.Enable(u12.StarsAuraBeginning, true);
        VfxManager.Enable(u11.UserLights, true);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(Model2, true);
        local C = u12.CameraSpecs:FindFirstChild("C");
        C.TimeScale = 1;
        TweenService:Create(C, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.2
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 25;
        TweenService:Create(BlurEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1.5);
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(u17.BottomFrame, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.935, 0)
        }):Play();
        TweenService:Create(u17.TopFrame, TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, -0.094, 0)
        }):Play();
    end);
    task.delay(2.5166666666666666 - u3, function() -- Line: 235
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CameraStarsTransition);
    end);
    task.delay(2.566666666666667 - u3, function() -- Line: 241
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), u12 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Lighting.ClockTime == 22.532 then
            Lighting.ClockTime = 12;
        end;

        Lighting.ExposureCompensation = -1;
        VfxManager.Enable(u12.CameraSpecs, false);
        VfxManager.Enable(u12.Stars, true);
        VfxManager.Enable(u12.StarsAuraBeginning, false);
        VfxManager.Enable(u11.UserLights, false);
    end);
    task.delay(6.25 - u3, function() -- Line: 256
        -- upvalues: Folder (copy), TweenService (ref), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u17.BottomFrame, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.955, 0)
        }):Play();
        TweenService:Create(u17.TopFrame, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, -0.114, 0)
        }):Play();
    end);
    task.delay(8.1 - u3, function() -- Line: 263
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CameraTransition);
    end);
    task.delay(8.266666666666667 - u3, function() -- Line: 269
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u12 (copy), u11 (copy), u18 (copy), DepthOfField (copy), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0.66;
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageColor3 = Color3.fromRGB(249, 122, 19)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 6;
        VfxManager.DestroyEffect(BlurEffect, 3.24);
        VfxManager.Enable(u12.Stars, false);
        VfxManager.Enable(u12.CameraShade, false);
        VfxManager.Enable(u12.CameraShadeV2, true);
        TweenService:Create(u12.CameraShadeV2.Ray.A0.RootSunFX.spec, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.1
        }):Play();
        u11.UserLights.KunigamiLight.UserLight.Attachment.Light.SurfaceLight.Enabled = false;
        u11.UserLights.KunigamiLight.UserLight.Attachment.Light.SurfaceLight1.Enabled = false;
        u11.Part.Transparency = 0.65;
        u11.Sphere.Transparency = 0.65;
        Lighting.ExposureCompensation = -2;
        u18.Contrast = 1;
        u18.Brightness = 0.35;
        Lighting.DepthOfField.FarIntensity = DepthOfField.FarIntensity;
        Lighting.DepthOfField.FocusDistance = DepthOfField.FocusDistance;
        TweenService:Create(u17.BottomFrame, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.975, 0),
            Size = UDim2.new(1, 0, 0.16, 0)
        }):Play();
        TweenService:Create(u17.TopFrame, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, -0.134, 0),
            Size = UDim2.new(1, 0, 0.16, 0)
        }):Play();
    end);
    local u20 = {};

    local function v21() -- Line: 304
        -- upvalues: u20 (ref), Folder (copy), u17 (copy), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), DepthOfField (copy), ClockTime (copy), ExposureCompensation (copy)
        for _, v in pairs(u20) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u19 then
            u19:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        if Lighting.ClockTime ~= ClockTime then
            Lighting.ClockTime = ClockTime;
        end;

        if Lighting.ExposureCompensation ~= ExposureCompensation then
            Lighting.ExposureCompensation = ExposureCompensation;
        end;

        u20 = nil;
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v21));
    table.insert(u20, Folder.Destroying:Connect(v21));
end;