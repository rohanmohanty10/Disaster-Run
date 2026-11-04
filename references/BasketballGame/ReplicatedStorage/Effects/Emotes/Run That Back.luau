 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: LocalPlayer (copy), Players (copy), Effects (copy), SfxManager (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), Part_Icles (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Character.Name == "TemplateRig" and LocalPlayer or Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    task.delay(0.5 - u3, function() -- Line: 35
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Wait, run that back.", 2 }
        });
    end);
    task.delay(4 - u3, function() -- Line: 45
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Did you say something just now?", 3 }
        });
    end);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 64
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
    task.delay(6.35 - u3, function() -- Line: 86
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(6.35 - u3, function() -- Line: 95
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u11 = script.Cutscene_VFX:Clone();
    u11.Name = v4;
    u11.Parent = Folder;
    u11:PivotTo(HumanoidRootPart.CFrame);
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.camera, CamRig.camera);
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
    local Vignette = u14.Vignette;
    local _ = u14.Vignette1;
    Vignette.ImageTransparency = 0;
    task.spawn(function() -- Line: 128
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Sphere1);
        Part_Icles:AbsoluteEmit(u11.MeshFlip1);
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.25), {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(u11.Black, TweenInfo.new(0.5), {
            Transparency = 0
        }):Play();
        TweenService:Create(u11.Ground, TweenInfo.new(0.5), {
            Transparency = 0
        }):Play();
        TweenService:Create(u11.Real.SurfaceLight, TweenInfo.new(0.5), {
            Brightness = 30
        }):Play();
    end);
    task.delay(0.36666666666666664 - u3, function() -- Line: 143
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 0.7666666666666667);
        TweenService:Create(BlurEffect, TweenInfo.new(0.2833333333333333), {
            Size = 15
        }):Play();
        task.wait(0.2833333333333333);
        TweenService:Create(BlurEffect, TweenInfo.new(0.48333333333333334), {
            Size = 0
        }):Play();
    end);
    task.delay(2.05, function() -- Line: 156
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Swish);
    end);
    task.delay(2.1166666666666667, function() -- Line: 162
        -- upvalues: Folder (copy), u13 (ref), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u13 then
            Part_Icles:AbsoluteEmit(u13["1"]);
        end;

        Part_Icles:AbsoluteEmit(u11.Sphere2);
        Part_Icles:AbsoluteEmit(u11.Swish);
    end);
    task.delay(2.05, function() -- Line: 173
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 0.43333333333333335);
        TweenService:Create(BlurEffect, TweenInfo.new(0.15), {
            Size = 20
        }):Play();
        task.wait(0.15);
        TweenService:Create(BlurEffect, TweenInfo.new(0.2833333333333333), {
            Size = 0
        }):Play();
    end);
    task.delay(4.283333333333333, function() -- Line: 186
        -- upvalues: Folder (copy), u11 (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Black.Transparency = 1;
        u11.Ground.Transparency = 1;
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        task.wait(0.5);
        TweenService:Create(Vignette, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(4.666666666666667, function() -- Line: 200
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 1.65);
        TweenService:Create(BlurEffect, TweenInfo.new(0.2833333333333333), {
            Size = 20
        }):Play();
        task.wait(0.2833333333333333);
        TweenService:Create(BlurEffect, TweenInfo.new(1.3666666666666667), {
            Size = 0
        }):Play();
    end);
    task.delay(4.766666666666667, function() -- Line: 213
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.MeshFlip2);
        Part_Icles:AbsoluteEmit(u11.AuraEmit);
    end);
    task.delay(4.85, function() -- Line: 220
        -- upvalues: Folder (copy), u13 (ref), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u13 then
            Part_Icles:AbsoluteEmit(u13["2"]);
        end;
    end);
    task.delay(5.316666666666666, function() -- Line: 228
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.CameraShot.Attachment.WindScene1.AtmosphereWind.Blur);
    end);
    local u15 = {};

    local function v16() -- Line: 235
        -- upvalues: u15 (ref), Folder (copy), u14 (copy)
        for _, v in pairs(u15) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v16));
    table.insert(u15, Folder.Destroying:Connect(v16));
end;