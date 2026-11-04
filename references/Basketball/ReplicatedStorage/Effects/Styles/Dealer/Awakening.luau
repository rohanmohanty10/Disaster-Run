 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 18
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u6 = workspace:FindFirstChild(script.Parent.Name .. "Cards1");
    local u7 = workspace:FindFirstChild(script.Parent.Name .. "Table");
    Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 35
        -- upvalues: Effects (ref), u5 (copy), PassedTime (copy)
        Effects:SubtitleV2({
            { u5, "I enjoy this part.", 3 }
        });
        task.wait(5.5 - PassedTime);
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\">Don\'t be shy~</animation>", 2 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 58
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * PassedTime;
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
    task.delay(9.483 - PassedTime, function() -- Line: 80
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.483 - PassedTime, function() -- Line: 93
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Dealer Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13;

    if Head then
        u13 = script.Head:Clone();
        u13.CFrame = Head.CFrame;
        u13.Parent = Folder;
        Essentials:Weld(u13, Head);
    else
        u13 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette1 = u14.Vignette1;
    u14.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(9.483, function() -- Line: 131
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u16 = Bloom:Clone();
    u16.Name = "B";
    u16.Parent = Lighting;
    u16.Enabled = true;
    task.delay(9.483 - PassedTime, function() -- Line: 146
        -- upvalues: u16 (copy), Lighting (ref), Bloom (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.delay(2.033333333333333 - PassedTime, function() -- Line: 153
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u13 (ref), Vignette1 (copy), TweenService (ref), Lighting (ref), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.Air, true);
        VfxManager.Enable(u12.Beams, true);

        if u13 then
            VfxManager.Emit(u13.Emit);
            VfxManager.Enable(u13.Enabling, true);
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u15.Brightness = 1;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
        local v17 = script.FakeAtmo:Clone();
        v17.Parent = Lighting;
        local Brightness = Lighting.Brightness;
        local Ambient = Lighting.Ambient;
        local OutdoorAmbient = Lighting.OutdoorAmbient;
        Lighting.Brightness = 2;
        Lighting.Ambient = Color3.fromRGB(184, 47, 227);
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0);
        task.wait(5.383333333333334);
        v17:Destroy();

        if Lighting.Brightness == 2 then
            Lighting.Brightness = Brightness;
        end;

        if Lighting.Ambient == Color3.fromRGB(184, 47, 227) then
            Lighting.Ambient = Ambient;
        end;

        if Lighting.OutdoorAmbient == Color3.fromRGB(0, 0, 0) then
            Lighting.OutdoorAmbient = OutdoorAmbient;
        end;
    end);
    task.delay(2.0833333333333335 - PassedTime, function() -- Line: 206
        -- upvalues: Folder (copy), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 then
            u7:Destroy();
        end;
    end);
    task.delay(3.05 - PassedTime, function() -- Line: 214
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref), CamRig (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u16 (copy), Bloom (copy), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Enable(u6, false);
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.CamTrans);
            VfxManager.Enable(CamRig.camera.CamTrans, true);
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        u16.Intensity = 15;
        u16.Threshold = 0.5;
        TweenService:Create(u16, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u15.Brightness = 1;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(3.2 - PassedTime, function() -- Line: 252
        -- upvalues: Folder (copy), u13 (ref), VfxManager (ref), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u13 then
            VfxManager.Enable(u13.Enabling, false);
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.CamTrans, false);
        end;
    end);
    task.delay(3.5 - PassedTime, function() -- Line: 264
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce1);
    end);
    task.delay(3.65 - PassedTime, function() -- Line: 270
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce2);
    end);
    task.delay(4.133333333333334 - PassedTime, function() -- Line: 276
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce3);
    end);
    task.delay(4.45 - PassedTime, function() -- Line: 282
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce4);
    end);
    task.delay(4.766666666666667 - PassedTime, function() -- Line: 288
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce5);
    end);
    task.delay(5.05 - PassedTime, function() -- Line: 294
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce6);
    end);
    task.delay(5.416666666666667 - PassedTime, function() -- Line: 300
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce7);
    end);
    task.delay(5.683333333333334 - PassedTime, function() -- Line: 306
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.CamTrans);
            VfxManager.Enable(CamRig.camera.CamTrans, true);
        end;
    end);
    task.delay(6.133333333333334 - PassedTime, function() -- Line: 315
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Enable(u6, true);
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.CamTrans, false);
        end;
    end);
    task.delay(7.416666666666667 - PassedTime, function() -- Line: 327
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), CamRig (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.Air, false);
        VfxManager.Enable(u12.Beams, false);

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.Emit);
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u15.Brightness = 1;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(8.383333333333333 - PassedTime, function() -- Line: 354
        -- upvalues: Folder (copy), u13 (ref), VfxManager (ref), CamRig (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u16 (copy), Bloom (copy), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u13 then
            VfxManager.Emit(u13.Emit);
            VfxManager.Enable(u13.Enabling, true);
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.Emit);
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        u16.Intensity = 15;
        u16.Threshold = 0.5;
        TweenService:Create(u16, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u15.Brightness = 1;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(9.483333333333333 - PassedTime, function() -- Line: 392
        -- upvalues: Folder (copy), u13 (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u13 then
            VfxManager.Enable(u13.Enabling, false);
        end;
    end);
    local u18 = {};

    local function v19() -- Line: 401
        -- upvalues: u18 (ref), Folder (copy), u14 (copy), u7 (copy), u15 (copy), Lighting (ref), ColorCorrection (copy), u16 (copy), Bloom (copy)
        for _, v in pairs(u18) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u7 then
            u7:Destroy();
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u18 = nil;
    end;

    table.insert(u18, Folder.AttributeChanged:Connect(v19));
    table.insert(u18, Folder.Destroying:Connect(v19));
end;