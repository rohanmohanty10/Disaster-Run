 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 18
    -- upvalues: Players (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), VfxManager (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy)
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

    Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local v5 = Character:FindFirstChild(script.Parent.Name .. "Ball");
    local u6 = Character:FindFirstChild(script.Parent.Name .. "SeventySeven");
    local u7 = workspace:FindFirstChild(script.Parent.Name .. "Cylinder");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);

    if BALL then
        BALL:Destroy();
    end;

    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 45
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
    task.delay(18.1 - PassedTime, function() -- Line: 67
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
    VfxManager.DestroyEffect(Folder, 18.1);
    task.delay(18.1 - PassedTime, function() -- Line: 81
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ LukaDoncic Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig.camera.CFrame);
    u13.Parent = Folder;
    Essentials:Weld(u13.camera, CamRig.camera);
    local u14;

    if v5 and v5.PrimaryPart then
        u14 = script.Ball:Clone();
        u14.CFrame = v5.PrimaryPart.CFrame;
        u14.Parent = Folder;
        Essentials:Weld(u14, v5.PrimaryPart);
    else
        u14 = nil;
    end;

    local u15;

    if Head then
        u15 = script.Head:Clone();
        u15.CFrame = Head.CFrame;
        u15.Parent = Folder;
        Essentials:Weld(u15, Head);
    else
        u15 = nil;
    end;

    if u6 then
        u12.Domain.Triangles.Part.WeldConstraint.Part1 = u6["1"];
        u6["1"].Transparency = 1;
        u6["1"]["2"].Transparency = 1;
        VfxManager.Enable(u6, false);
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local Vignette1 = u16.Vignette1;
    u16.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u17 = ColorCorrection:Clone();
    u17.Name = "CC";
    u17.Parent = Lighting;
    u17.Enabled = true;
    task.delay(18.1, function() -- Line: 139
        -- upvalues: u17 (copy), Lighting (ref), ColorCorrection (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 146
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u13.Speed_Lines, true);
        VfxManager.Enable(u12.Domain, true);
    end);
    task.delay(2.3333333333333335 - PassedTime, function() -- Line: 153
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Grab_1);
    end);
    task.delay(2.75 - PassedTime, function() -- Line: 159
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u13.CameraTransition);
        VfxManager.Enable(u13.Speed_Lines, false);
    end);
    task.delay(3.183333333333333 - PassedTime, function() -- Line: 166
        -- upvalues: Folder (copy), u7 (copy), u14 (ref), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 then
            u7.Transparency = 1;
        end;

        if u14 then
            VfxManager.BetterEmit(u14);
        end;

        VfxManager.BetterEmit(u12.Ball_Spin);
    end);
    task.delay(5.25 - PassedTime, function() -- Line: 180
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u13.Speed_Lines, true);
    end);
    task.delay(6.016666666666667 - PassedTime, function() -- Line: 186
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Dribble);
    end);
    task.delay(6.5 - PassedTime, function() -- Line: 192
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Dribble_2);
    end);
    task.delay(7.516666666666667 - PassedTime, function() -- Line: 198
        -- upvalues: Folder (copy), VfxManager (ref), u15 (ref), Lighting (ref), TweenService (ref), u17 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u15);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 0.65;
        u17.TintColor = Color3.fromRGB(255, 174, 33);
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 174, 33);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Brightness = -0.1
        }):Play();
    end);
    task.delay(9.833333333333334 - PassedTime, function() -- Line: 221
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), u6 (copy), Essentials (ref), Character (copy), Lighting (ref), TweenService (ref), u17 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u13.Black);

        if u6 then
            u6["1"].Transparency = 0;
            u6["1"]["2"].Transparency = 0;
            VfxManager.Enable(u6, true);
            Essentials:HideCharacter(Character, { u6["1"], u6["1"]["2"] });
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 0.65;
        u17.TintColor = Color3.fromRGB(255, 174, 33);
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 174, 33);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(12.933333333333334 - PassedTime, function() -- Line: 252
        -- upvalues: Folder (copy), TweenService (ref), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u17, TweenInfo.new(0.3), {
            Brightness = 1
        }):Play();
    end);
    task.delay(13.283333333333333 - PassedTime, function() -- Line: 258
        -- upvalues: Folder (copy), TweenService (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u17, TweenInfo.new(0.5), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(13.333333333333334 - PassedTime, function() -- Line: 264
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u13 (copy), u6 (copy), Essentials (ref), Character (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Dribble_3);
        VfxManager.BetterEmit(u13.Triangles);

        if u6 then
            u6["1"].Transparency = 1;
            u6["1"]["2"].Transparency = 1;
            VfxManager.Enable(u6, false);
            Essentials:UnhideCharacter(Character, { u6["1"], u6["1"]["2"] });
        end;
    end);
    task.delay(14.2 - PassedTime, function() -- Line: 279
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Pass);
    end);
    task.delay(15.516666666666667 - PassedTime, function() -- Line: 285
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u13.Speed_Lines, false);
    end);
    task.delay(15.65 - PassedTime, function() -- Line: 291
        -- upvalues: Folder (copy), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 then
            u7.Transparency = 0;
        end;
    end);
    task.delay(16.033333333333335 - PassedTime, function() -- Line: 299
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Impact);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 174, 33);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u17.Brightness = 0.45;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 174, 33);
        TweenService:Create(u17, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    local u18 = {};

    local function v19() -- Line: 321
        -- upvalues: u18 (ref), Folder (copy), u16 (copy), u17 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u18) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u18 = nil;
    end;

    table.insert(u18, Folder.AttributeChanged:Connect(v19));
    table.insert(u18, Folder.Destroying:Connect(v19));
end;