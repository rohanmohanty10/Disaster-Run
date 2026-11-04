 
 

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
    local _ = p2.Teammate;
    local _ = p2.Enemy;
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
    local v6 = Character:FindFirstChild("Left Arm");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u7 = workspace:FindFirstChild(script.Parent.Name .. "LowRider");
    local u8 = workspace:FindFirstChild(script.Parent.Name .. "Cane");
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(3 - PassedTime, function() -- Line: 38
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Still got game in these <animation style=\"glitch\">old</animation> bones.", 3 }
        });
    end);
    task.delay(8.5 - PassedTime, function() -- Line: 48
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "You\'re still hooping out here?", 1.5 },
            { u5, "<animation style=\"glitch\">Ha.</animation>", 0.5 },
            { u5, "It\'s been a minute since I ran this court...", 3 }
        });
    end);
    task.delay(14.5 - PassedTime, function() -- Line: 68
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Let me show these <animation style=\"glitch\">younglings</animation> how it\'s done...", 3 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 81
        -- upvalues: u1 (copy), u10 (ref), u9 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * PassedTime;
        end;

        u9 = u9 + p11 * 60;
        local v12 = script_Fov[math.ceil(u9)];

        if v12 ~= nil then
            if math.ceil(u9) >= #script_Fov then
                u10:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v12, p11 * 6);
        end;
    end);
    task.delay(18.383 - PassedTime, function() -- Line: 103
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(18.383 - PassedTime, function() -- Line: 116
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Basketball Unc Awakening",
        Parent = workspace
    }).TimePosition = 1.5 + PassedTime;
    local u13 = script.Cutscene_VFX:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = Folder;
    local u14 = script.Ball:Clone();
    u14.CFrame = BALL.CFrame;
    u14.Parent = Folder;
    Essentials:Weld(u14, BALL);
    local u15;

    if Head then
        u15 = script.Head:Clone();
        u15.CFrame = Head.CFrame;
        u15.Parent = Folder;
        Essentials:Weld(u15, Head);
    else
        u15 = nil;
    end;

    local u16;

    if v6 then
        u16 = script["Left Arm"]:Clone();
        u16.CFrame = v6.CFrame;
        u16.Parent = Folder;
        Essentials:Weld(u16, v6);
    else
        u16 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette1 = u17.Vignette1;
    u17.Vignette.ImageTransparency = 0;
    Vignette1.ImageColor3 = Color3.fromRGB(255, 135, 44);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(18.383 - PassedTime, function() -- Line: 168
        -- upvalues: u18 (copy), Lighting (ref), ColorCorrection (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u19 = Bloom:Clone();
    u19.Name = "B";
    u19.Parent = Lighting;
    u19.Enabled = true;
    task.delay(18.383, function() -- Line: 183
        -- upvalues: u19 (copy), Lighting (ref), Bloom (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local Atmosphere = Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    task.delay(0 - PassedTime, function() -- Line: 193
        -- upvalues: Folder (copy), VfxManager (ref), u7 (copy), Lighting (ref), TweenService (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u7.RootPart.Bone, true);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u18.Brightness = 0.45;
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(4.316666666666666 - PassedTime, function() -- Line: 208
        -- upvalues: Folder (copy), VfxManager (ref), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u7.RootPart.Bone, false);
    end);
    task.delay(6.616666666666666 - PassedTime, function() -- Line: 214
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u13.Land1);
    end);
    task.delay(6.716666666666667 - PassedTime, function() -- Line: 220
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u13.Land2);
    end);
    task.delay(6.783333333333333 - PassedTime, function() -- Line: 226
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u13 (copy), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0.5;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u13.Boom1);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u18.Brightness = 0.35;
        TweenService:Create(u18, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(7.2 - PassedTime, function() -- Line: 244
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u13 (copy), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0.5;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u13.Boom1);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
    end);
    task.delay(8.033333333333333 - PassedTime, function() -- Line: 258
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u13 (copy), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u13.Boom2);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
    end);
    task.delay(8.983333333333333 - PassedTime, function() -- Line: 272
        -- upvalues: Folder (copy), Vignette1 (copy), VfxManager (ref), u13 (copy), CamRig (copy), u15 (ref), TweenService (ref), u18 (copy), ColorCorrection (copy), u19 (copy), Bloom (copy), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0.5;
        VfxManager.Emit(u13.Show);
        VfxManager.Emit(u13.Boom1);

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Enable(CamRig.CameraPart.W, true);
        end;

        if u15 then
            VfxManager.Enable(u15, true);
        end;

        TweenService:Create(u18, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.4
        }):Play();
        task.delay(0.067, function() -- Line: 290
            -- upvalues: TweenService (ref), u18 (ref), ColorCorrection (ref)
            TweenService:Create(u18, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness
            }):Play();
        end);
        u19.Intensity = 15;
        u19.Threshold = 0.5;
        TweenService:Create(u19, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
    end);
    task.delay(11.633333333333333 - PassedTime, function() -- Line: 304
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Attachment1);
        VfxManager.Enable(u14.Attachment1, true);
    end);
    task.delay(13.55 - PassedTime, function() -- Line: 311
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Attachment1);
        VfxManager.Enable(u14.Attachment1, false);
    end);
    task.delay(14.8 - PassedTime, function() -- Line: 318
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), u13 (copy), VfxManager (ref), CamRig (copy), u16 (ref), u18 (copy), ColorCorrection (copy), u19 (copy), Bloom (copy), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0.5
        }):Play();
        u13.Box.PrimaryPart.Transparency = 0;
        VfxManager.Enable(u13.Box, true);

        if CamRig and CamRig:FindFirstChild("CameraPart") then
            VfxManager.Enable(CamRig.CameraPart.W, false);
        end;

        if u16 then
            VfxManager.Emit(u16);
        end;

        TweenService:Create(u18, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.4
        }):Play();
        task.delay(0.067, function() -- Line: 337
            -- upvalues: TweenService (ref), u18 (ref), ColorCorrection (ref)
            TweenService:Create(u18, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness
            }):Play();
        end);
        u19.Intensity = 15;
        u19.Threshold = 0.5;
        TweenService:Create(u19, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
    end);
    task.delay(15.2 - PassedTime, function() -- Line: 351
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Attachment2);
        VfxManager.Enable(u14.Attachment2, true);
    end);
    task.delay(18.383333333333333 - PassedTime, function() -- Line: 358
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), u15 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u14.Attachment2, false);
        VfxManager.Enable(u15, false);
    end);
    local u20 = {};

    local function v21() -- Line: 366
        -- upvalues: u20 (ref), Folder (copy), u7 (copy), u8 (copy), u17 (copy), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), Bloom (copy), Atmosphere (copy), Density (copy)
        for _, v in pairs(u20) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u7 then
            u7:Destroy();
        end;

        if u8 then
            u8:Destroy();
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

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if Atmosphere then
            Atmosphere.Density = Density;
        end;

        u20 = nil;
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v21));
    table.insert(u20, Folder.Destroying:Connect(v21));
end;