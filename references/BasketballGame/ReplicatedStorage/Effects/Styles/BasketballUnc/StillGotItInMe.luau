 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 22
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local v3 = Character.Name .. script.Name;

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
    local u6 = Character:FindFirstChild("Right Arm");
    local u7 = Character:FindFirstChild("Right Leg");
    local u8 = Character:FindFirstChild("Left Leg");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u9 = workspace:FindFirstChild(script.Name .. "LowRider");
    local BALL = Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 41
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Ha.", 0.5 }
        });
    end);
    task.delay(0.5 - PassedTime, function() -- Line: 51
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "They call me <animation style=\"glitch\">UNC</animation> for a reason...", 3 }
        });
    end);
    task.delay(3.5 - PassedTime, function() -- Line: 61
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Steady hands, young man...", 1 }
        });
    end);
    task.delay(6 - PassedTime, function() -- Line: 71
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Respect your elders!", 1 }
        });
    end);
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 84
        -- upvalues: u1 (copy), u11 (ref), u10 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * PassedTime;
        end;

        u10 = u10 + p12 * 60;
        local v13 = script_Fov[math.ceil(u10)];

        if v13 ~= nil then
            if math.ceil(u10) >= #script_Fov then
                u11:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v13, p12 * 6);
        end;
    end);
    task.delay(11.4 - PassedTime, function() -- Line: 106
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(11.4, function() -- Line: 119
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Basketball Unc Still Got It In Me",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u14 = script.Cutscene_VFX:Clone();
    u14:PivotTo(HumanoidRootPart.CFrame);
    u14.Parent = Folder;
    local u15;

    if Head then
        u15 = script.Head:Clone();
        u15.CFrame = Head.CFrame;
        u15.Parent = Folder;
        Essentials:Weld(u15, Head);
    else
        u15 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local _ = u16.Vignette1;
    u16.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u17 = ColorCorrection:Clone();
    u17.Name = "CC";
    u17.Parent = Lighting;
    u17.Enabled = true;
    task.delay(11.4, function() -- Line: 157
        -- upvalues: u17 (copy), Lighting (ref), ColorCorrection (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(0.5166666666666667 - PassedTime, function() -- Line: 164
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            local v18 = script["Right Arm"]:Clone();
            v18.Parent = Folder;
            v18.CFrame = u6.CFrame;
            VfxManager.Emit(v18.Attachment1);
            VfxManager.DestroyEffect(v18, 2);
        end;
    end);
    task.delay(0.9 - PassedTime, function() -- Line: 176
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v19 = script["Right Arm"]:Clone();
        v19.Parent = Folder;
        v19.CFrame = u6.CFrame;
        VfxManager.Emit(v19.Attachment1);
        VfxManager.DestroyEffect(v19, 2);
    end);
    task.delay(2.216666666666667 - PassedTime, function() -- Line: 186
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v20 = script["Right Arm"]:Clone();
        v20.Parent = Folder;
        v20.CFrame = u6.CFrame;
        VfxManager.Emit(v20.Attachment2);
        VfxManager.DestroyEffect(v20, 2);
    end);
    task.delay(3.4 - PassedTime, function() -- Line: 196
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v21 = script.Ball:Clone();
        v21.Parent = Folder;
        v21.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v21);
        VfxManager.DestroyEffect(v21, 2);
    end);
    task.delay(3.783333333333333 - PassedTime, function() -- Line: 206
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v22 = script.Ball:Clone();
        v22.Parent = Folder;
        v22.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v22);
        VfxManager.DestroyEffect(v22, 2);
    end);
    task.delay(4.05 - PassedTime, function() -- Line: 216
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v23 = script.Ball:Clone();
        v23.Parent = Folder;
        v23.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v23);
        VfxManager.DestroyEffect(v23, 2);
    end);
    task.delay(4.366666666666666, function() -- Line: 226
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v24 = script.Ball:Clone();
        v24.Parent = Folder;
        v24.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v24);
        VfxManager.DestroyEffect(v24, 2);
    end);
    task.delay(4.683333333333334 - PassedTime, function() -- Line: 236
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v25 = script.Ball:Clone();
        v25.Parent = Folder;
        v25.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v25);
        VfxManager.DestroyEffect(v25, 2);
    end);
    task.delay(5 - PassedTime, function() -- Line: 246
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v26 = script.Ball:Clone();
        v26.Parent = Folder;
        v26.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v26);
        VfxManager.DestroyEffect(v26, 2);
    end);
    task.delay(5.366666666666666 - PassedTime, function() -- Line: 256
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v27 = script.Ball:Clone();
        v27.Parent = Folder;
        v27.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v27);
        VfxManager.DestroyEffect(v27, 2);
    end);
    task.delay(5.583333333333333 - PassedTime, function() -- Line: 266
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), Lighting (ref), TweenService (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera, true);
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u17.Brightness = 0.45;
        TweenService:Create(u17, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = ColorCorrection.Brightness
        }):Play();
        task.wait(0.616);
        u17.Brightness = 0.85;
        TweenService:Create(u17, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(6.2 - PassedTime, function() -- Line: 288
        -- upvalues: Folder (copy), VfxManager (ref), u15 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u15.Emit);
        VfxManager.Enable(u15.Enable);
    end);
    task.delay(7.216666666666667 - PassedTime, function() -- Line: 295
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u8 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera, false);
        end;

        local v28 = script["Left Leg"]:Clone();
        v28.Parent = Folder;
        v28.CFrame = u8.CFrame;
        VfxManager.Emit(v28);
        VfxManager.DestroyEffect(v28, 2);
    end);
    task.delay(7.25 - PassedTime, function() -- Line: 309
        -- upvalues: CamRig (copy), VfxManager (ref)
        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.LeftCinematicBars, true);
            VfxManager.Enable(CamRig.RightCinematicBars, true);
        end;
    end);
    task.delay(7.4 - PassedTime, function() -- Line: 316
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v29 = script["Right Leg"]:Clone();
        v29.Parent = Folder;
        v29.CFrame = u7.CFrame;
        VfxManager.Emit(v29);
        VfxManager.DestroyEffect(v29, 2);
    end);
    task.delay(7.533333333333333 - PassedTime, function() -- Line: 326
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v30 = script["Left Leg"]:Clone();
        v30.Parent = Folder;
        v30.CFrame = u8.CFrame;
        VfxManager.Emit(v30);
        VfxManager.DestroyEffect(v30, 2);
    end);
    task.delay(7.8 - PassedTime, function() -- Line: 336
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v31 = script["Right Leg"]:Clone();
        v31.Parent = Folder;
        v31.CFrame = u7.CFrame;
        VfxManager.Emit(v31);
        VfxManager.DestroyEffect(v31, 2);
    end);
    task.delay(7.816666666666666 - PassedTime, function() -- Line: 346
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v32 = script.Throw:Clone();
        v32.Parent = Folder;
        v32.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v32);
        VfxManager.DestroyEffect(v32, 2);
    end);
    task.delay(7.933333333333334 - PassedTime, function() -- Line: 356
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v33 = script["Left Leg"]:Clone();
        v33.Parent = Folder;
        v33.CFrame = u8.CFrame;
        VfxManager.Emit(v33);
        VfxManager.DestroyEffect(v33, 2);
    end);
    task.delay(8.116666666666667 - PassedTime, function() -- Line: 366
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v34 = script["Right Leg"]:Clone();
        v34.Parent = Folder;
        v34.CFrame = u7.CFrame;
        VfxManager.Emit(v34);
        VfxManager.DestroyEffect(v34, 2);
    end);
    task.delay(8.25 - PassedTime, function() -- Line: 376
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v35 = script["Left Leg"]:Clone();
        v35.Parent = Folder;
        v35.CFrame = u8.CFrame;
        VfxManager.Emit(v35);
        VfxManager.DestroyEffect(v35, 2);
    end);
    task.delay(8.466666666666667 - PassedTime, function() -- Line: 386
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v36 = script["Right Leg"]:Clone();
        v36.Parent = Folder;
        v36.CFrame = u7.CFrame;
        VfxManager.Emit(v36);
        VfxManager.DestroyEffect(v36, 2);
    end);
    task.delay(8.65 - PassedTime, function() -- Line: 396
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.LeftCinematicBars, false);
            VfxManager.Enable(CamRig.RightCinematicBars, false);
        end;
    end);
    task.delay(8.783333333333333 - PassedTime, function() -- Line: 405
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v37 = script["Left Leg"]:Clone();
        v37.Parent = Folder;
        v37.CFrame = u8.CFrame;
        VfxManager.Emit(v37);
        VfxManager.DestroyEffect(v37, 2);
    end);
    task.delay(9.15 - PassedTime, function() -- Line: 415
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u7 (copy), Lighting (ref), TweenService (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera, true);
        end;

        local v38 = script.Jump:Clone();
        v38.Parent = Folder;
        v38.CFrame = u7.CFrame;
        VfxManager.Emit(v38);
        VfxManager.DestroyEffect(v38, 2);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u17.Brightness = 0.45;
        TweenService:Create(u17, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = ColorCorrection.Brightness
        }):Play();
        task.wait(0.966);
        u17.Brightness = 0.85;
        TweenService:Create(u17, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(10.116666666666667 - PassedTime, function() -- Line: 443
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Dunk);
    end);
    task.delay(10.85 - PassedTime, function() -- Line: 449
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera, false);
        end;
    end);
    local u39 = {};

    local function v40() -- Line: 458
        -- upvalues: u39 (ref), Folder (copy), u9 (copy), u16 (copy), u17 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u39) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u9 then
            u9:Destroy();
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

        u39 = nil;
    end;

    table.insert(u39, Folder.AttributeChanged:Connect(v40));
    table.insert(u39, Folder.Destroying:Connect(v40));
end;