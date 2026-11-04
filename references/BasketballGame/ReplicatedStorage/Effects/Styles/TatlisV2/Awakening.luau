 
 

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
    -- upvalues: Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Other;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u6 = workspace:FindFirstChild(Character.Name .. script.Parent.Name .. "Skeleton");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(4.5 - u3, function() -- Line: 34
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Death", "Looks like you have a visitor.", 3 } });
    end);
    task.delay(8.75 - u3, function() -- Line: 44
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Death", "Your throne is no longer feared.", 2.25 }, { "Death", "Another has claimed the eyes of this kingdom...", 2 } });
    end);
    task.delay(25 - u3, function() -- Line: 59
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Death", "Remind them who the <animation style=\"glitch\"><font color=\"#4375ff\">TRUE KING</font></animation> is...", 3 } });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 72
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
    task.delay(27.35 - u3, function() -- Line: 94
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
    task.delay(27.35 - u3, function() -- Line: 107
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Tatlis V2 Awakening",
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

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v13 = Character:FindFirstChild(child.Name);

        if v13 then
            local v14 = child:Clone();
            v14.CFrame = v13.CFrame;
            v14.Parent = Model;
            Essentials:Weld(v14, v13);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = true;
    local Vignette = u15.Vignette;
    local _ = u15.Vignette1;
    Vignette.ImageTransparency = 0;
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u16 = Bloom:Clone();
    u16.Name = "B";
    u16.Parent = Lighting;
    u16.Enabled = true;
    u16.Intensity = 1;
    u16.Threshold = 1.75;
    task.delay(27.35, function() -- Line: 157
        -- upvalues: u16 (copy), Lighting (ref), Bloom (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 164
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        VfxManager.Enable(u12.CamShade, true);
        local specs = u12.CamShade:FindFirstChild("specs");
        specs.TimeScale = 1;
        TweenService:Create(specs, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.1
        }):Play();
    end);
    task.delay(2.5166666666666666 - u3, function() -- Line: 178
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.CamShade1, true);
        VfxManager.Enable(u12.CamShade, false);
        local specs = u12.CamShade1:FindFirstChild("specs");
        specs.TimeScale = 1;
        TweenService:Create(specs, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.1
        }):Play();
    end);
    task.delay(3.8666666666666667 - u3, function() -- Line: 189
        -- upvalues: Folder (copy), VfxManager (ref), u6 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u6, true);
        shared.vfx.emit(u11.Emit1);
    end);
    task.delay(5.75 - u3, function() -- Line: 197
        -- upvalues: Folder (copy), TweenService (ref), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u15.Vignette2, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 0.25
        }):Play();
    end);
    task.delay(8.866666666666667 - u3, function() -- Line: 203
        -- upvalues: Folder (copy), TweenService (ref), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u15.Vignette2, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(13.7 - u3, function() -- Line: 209
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.CamTrans.Black, u12.CamTrans.camtrans2, u12.CamTrans.camtrans1, u12.CamTrans.CameraAtmosphereAttachment);
    end);
    task.delay(13.866666666666667 - u3, function() -- Line: 215
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.StompEffect1);
    end);
    task.delay(16.05 - u3, function() -- Line: 221
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.CamTrans.Black, u12.CamTrans.camtrans2, u12.CamTrans.camtrans1, u12.CamTrans.CameraAtmosphereAttachment);
    end);
    task.delay(16.2 - u3, function() -- Line: 227
        -- upvalues: Folder (copy), u11 (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Sphere.Transparency = 0;
        u11.Part.Transparency = 0;
        VfxManager.Enable(u12.CamShade, false);
    end);
    task.delay(17.916666666666668 - u3, function() -- Line: 236
        -- upvalues: Folder (copy), TweenService (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u11.Sphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(u11.Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    task.delay(18.583333333333332 - u3, function() -- Line: 243
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), VfxManager (ref), u11 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        VfxManager.Enable(u11.Space, true);
        VfxManager.Enable(u12.CamShade, true);
    end);
    task.delay(20.783333333333335 - u3, function() -- Line: 254
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.CamShade1, true);
        VfxManager.Enable(u12.CamShade, false);
    end);
    task.delay(22.3 - u3, function() -- Line: 261
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), Model (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        VfxManager.Enable(Model, true);
        shared.vfx.emit(u11.Emit2);
    end);
    task.delay(25.1 - u3, function() -- Line: 274
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.StompEffect2);
    end);
    task.delay(25.516666666666666 - u3, function() -- Line: 280
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.StompEffect3);
    end);
    local u17 = {};

    local function v18() -- Line: 287
        -- upvalues: u17 (ref), Folder (copy), u15 (copy), u16 (copy), Lighting (ref), Bloom (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;