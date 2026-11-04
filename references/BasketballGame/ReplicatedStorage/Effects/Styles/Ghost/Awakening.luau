 
 

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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), VfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local Enemy1 = p2.Enemy1;
    local Enemy2 = p2.Enemy2;
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
    local u6 = Character:FindFirstChild(script.Parent.Name .. "Phone");
    local u7 = Character:FindFirstChild(script.Parent.Name .. "Mask1");
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(7.5 - PassedTime, function() -- Line: 37
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\">Wanna play a game?</animation>", 1 }
        });
    end);
    task.delay(11 - PassedTime, function() -- Line: 47
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\">WAAAAAZZZZZZZZZZUUUUUPPPPP!</animation>", 2 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 60
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
    task.delay(14.716 - PassedTime, function() -- Line: 82
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
    task.delay(14.716 - PassedTime, function() -- Line: 95
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Ghost Awakening",
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

    local v14 = script.Cellphone:Clone();
    v14.Parent = Folder;
    v14.Handle.Part0 = Character:FindFirstChild("Left Arm");
    local u15 = nil;
    local u16 = nil;
    local u17;

    if Enemy1 then
        local v18 = Enemy1:FindFirstChild("Right Leg");

        if v18 then
            u16 = script.Leg:Clone();
            u16.Parent = Folder;
            u16.CFrame = v18.CFrame;
            Essentials:Weld(u16, v18);
        end;

        local Head2 = Enemy1:FindFirstChild("Head");

        if Head2 then
            u15 = script.Sweat:Clone();
            u15.CFrame = Head2.CFrame;
            u15.Parent = Folder;
            Essentials:Weld(u15, Head2);
        end;

        u17 = script.BALL:Clone();
        u17.Parent = Enemy1;
        u17.Handle.Part0 = Enemy1:FindFirstChild("Left Arm");
        VfxManager.DestroyEffect(u17, 14.716);
    else
        u17 = nil;
    end;

    local u19 = nil;

    if Enemy2 then
        local v20 = Enemy2:FindFirstChild("Left Leg");

        if v20 then
            u19 = script.Leg:Clone();
            u19.Parent = Folder;
            u19.CFrame = v20.CFrame;
            Essentials:Weld(u19, v20);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u21 = script.Vignette:Clone();
    u21.Parent = PlayerGui;
    u21.Enabled = true;
    local Vignette = u21.Vignette;
    local Vignette1 = u21.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u22 = ColorCorrection:Clone();
    u22.Name = "CC";
    u22.Parent = Lighting;
    u22.Enabled = true;
    task.delay(14.716, function() -- Line: 173
        -- upvalues: u22 (copy), Lighting (ref), ColorCorrection (copy)
        u22:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 180
        -- upvalues: Folder (copy), u16 (ref), VfxManager (ref), u19 (ref), RunService (ref), PassedTime (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u16 then
            VfxManager.Enable(u16, true);
        end;

        if u19 then
            VfxManager.Enable(u19, true);
        end;

        local u23 = RunService.RenderStepped:Connect(function() -- Line: 190
            -- upvalues: u16 (ref), u19 (ref)
            if u16 then
                u16.Attachment.WorldCFrame = CFrame.new(u16.Attachment.WorldCFrame.Position) * CFrame.Angles(0, 1.5707963267948966, 0);
            end;

            if u19 then
                u19.Attachment.WorldCFrame = CFrame.new(u19.Attachment.WorldCFrame.Position) * CFrame.Angles(0, 1.5707963267948966, 0);
            end;
        end);
        task.delay(0.45 - PassedTime + 2, function() -- Line: 199
            -- upvalues: u23 (copy)
            u23:Disconnect();
        end);
    end);
    task.delay(0.45 - PassedTime, function() -- Line: 204
        -- upvalues: Folder (copy), u16 (ref), VfxManager (ref), u19 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u16 then
            VfxManager.Enable(u16, false);
        end;

        if u19 then
            VfxManager.Enable(u19, false);
        end;
    end);
    task.delay(1.0333333333333334 - PassedTime, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), Lighting (ref), TweenService (ref), u22 (copy), ColorCorrection (copy), Vignette1 (copy), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.QuestionMark1);
        VfxManager.Emit(u12.QuestionMark2);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u22.Brightness = 0.45;
        TweenService:Create(u22, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = ColorCorrection.Brightness
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
    end);
    task.delay(1.5333333333333334 - PassedTime, function() -- Line: 234
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 and u6:FindFirstChild("Phone") then
            VfxManager.Enable(u6.Phone, true);
        end;
    end);
    task.delay(1.7833333333333334, function() -- Line: 242
        -- upvalues: TweenService (ref), Vignette1 (copy), Lighting (ref)
        TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Name = script.Parent.Name .. "Blur";
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 8
        }):Play();
    end);
    task.delay(2.716666666666667 - PassedTime, function() -- Line: 251
        -- upvalues: Folder (copy), u15 (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u15 then
            VfxManager.Enable(u15, true);
        end;
    end);
    task.delay(2.7666666666666666 - PassedTime, function() -- Line: 259
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig, true);
        end;
    end);
    task.delay(2.783333333333333 - PassedTime, function() -- Line: 267
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u22 (copy), ColorCorrection (copy), Debris (ref), PassedTime (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(31, 255, 100);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local v24 = Lighting:FindFirstChild(script.Parent.Name .. "Blur") or Instance.new("BlurEffect", Lighting);
        v24.Size = 15;
        TweenService:Create(v24, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(v24, 0.455);
        u22.Brightness = 0.85;
        u22.TintColor = Color3.fromRGB(31, 255, 100);
        TweenService:Create(u22, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u22, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        local v25 = script.CourtAura:Clone();
        v25.Name = script.Name;
        v25.Parent = Debris;
        v25.CFrame = CFrame.new(0, 1 + v25.Size.Y / 2, -297.5) * CFrame.new(0, 1.5707963267948966, 0);
        local v26 = script.FakeAtmo:Clone();
        v26.Parent = Lighting;
        task.wait(12.3 - PassedTime);
        v25:Destroy();
        v26:Destroy();
    end);
    task.delay(4.183333333333334 - PassedTime, function() -- Line: 299
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig, false);
        end;
    end);
    task.delay(5.75 - PassedTime, function() -- Line: 307
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u12 (copy), Lighting (ref), u22 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(31, 255, 100);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u12.Take1);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u22.Brightness = 0.85;
        u22.Saturation = -1;
        u22.TintColor = Color3.fromRGB(31, 255, 100);
        TweenService:Create(u22, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u22, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(5.966666666666667 - PassedTime, function() -- Line: 329
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 and u6:FindFirstChild("Phone") then
            VfxManager.Enable(u6.Phone, false);
        end;
    end);
    task.delay(9 - PassedTime, function() -- Line: 337
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u22 (copy), ColorCorrection (copy), Vignette1 (copy), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u22.Brightness = 0.45;
        TweenService:Create(u22, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = ColorCorrection.Brightness
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
    end);
    task.delay(10.233333333333333 - PassedTime, function() -- Line: 353
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Name = script.Parent.Name .. "Blur";
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 8
        }):Play();
    end);
    task.delay(10.65 - PassedTime, function() -- Line: 362
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), u15 (ref), VfxManager (ref), u13 (ref), u12 (copy), Lighting (ref), u22 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(31, 255, 100);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();

        if u15 then
            VfxManager.Enable(u15, false);
        end;

        if u13 then
            VfxManager.Enable(u13, true);
        end;

        VfxManager.Emit(u12.Take2);
        local v27 = Lighting:FindFirstChild(script.Parent.Name .. "Blur") or Instance.new("BlurEffect", Lighting);
        v27.Size = 35;
        TweenService:Create(v27, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(v27, 0.25);
        u22.Brightness = 0.85;
        u22.Saturation = -1;
        u22.TintColor = Color3.fromRGB(31, 255, 100);
        TweenService:Create(u22, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u22, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(11.383333333333333 - PassedTime, function() -- Line: 392
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Take2);
    end);
    task.delay(13.083333333333334 - PassedTime, function() -- Line: 398
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), u13 (ref), VfxManager (ref), u7 (copy), Lighting (ref), u22 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(31, 255, 100);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();

        if u13 then
            VfxManager.Emit(u13.Throw);
        end;

        if u7 then
            u7:Destroy();
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u22.Brightness = 0.85;
        u22.Saturation = -1;
        u22.TintColor = Color3.fromRGB(31, 255, 100);
        TweenService:Create(u22, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u22, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(15.083333333333334 - PassedTime, function() -- Line: 426
        -- upvalues: Folder (copy), Head (copy), VfxManager (ref), u13 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Head then
            VfxManager.Enable(u13, false);
        end;
    end);
    task.spawn(function() -- Line: 434
        -- upvalues: Folder (copy), BALL (copy)
        for i = 1, 250 do
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if BALL then
                BALL.Transparency = 1;
            end;

            task.wait(0.01);
            local _ = i;
        end;
    end);
    local u28 = {};

    local function v29() -- Line: 447
        -- upvalues: BALL (copy), u28 (ref), Folder (copy), u17 (ref), u21 (copy), u22 (copy), Lighting (ref), ColorCorrection (copy)
        if BALL then
            BALL.Transparency = 0;
        end;

        for _, v in pairs(u28) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        if u21 then
            u21:Destroy();
        end;

        if u22 then
            u22:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u28 = nil;
    end;

    table.insert(u28, Folder.AttributeChanged:Connect(v29));
    table.insert(u28, Folder.Destroying:Connect(v29));
end;