 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), TweenService (copy), Part_Icles (copy), VfxManager (copy), Lighting (copy)
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

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(1.25 - u3, function() -- Line: 36
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "That\'s pretty impressive.", 2 }
        });
    end);
    task.delay(3.75 - u3, function() -- Line: 46
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "From here on...", 0.5 },
            { u6, "<animation style=\"glitch\">...that\'s mine.</animation>", 1 }
        });
    end);
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
    task.delay(13.9 - u3, function() -- Line: 86
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
    task.delay(13.9 - u3, function() -- Line: 99
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Thief Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
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
    task.spawn(function() -- Line: 134
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.15), {
            BackgroundTransparency = 1
        }):Play();
        Part_Icles:AbsoluteEmit(u11.Sphere1);
    end);
    task.delay(0.2 - u3, function() -- Line: 144
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Hit1);
    end);
    task.delay(0.21666666666666667 - u3, function() -- Line: 150
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.MeshFlip1);
    end);
    task.delay(0.7833333333333333 - u3, function() -- Line: 156
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.MeshFlip2);
    end);
    task.delay(0.8 - u3, function() -- Line: 162
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Hit2);
    end);
    task.delay(0.8166666666666667 - u3, function() -- Line: 168
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Sphere1);
    end);
    task.delay(0.85 - u3, function() -- Line: 174
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CamLines);
    end);
    task.delay(0.9166666666666666 - u3, function() -- Line: 180
        -- upvalues: Folder (copy), u11 (copy), TweenService (ref), Lighting (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Spotlight1.SurfaceLight.Enabled = true;
        TweenService:Create(u11.Black, TweenInfo.new(0.5), {
            Transparency = 0
        }):Play();
        TweenService:Create(u11.Ground, TweenInfo.new(0.5), {
            Transparency = 0
        }):Play();
        TweenService:Create(u11.Spotlight1.SurfaceLight, TweenInfo.new(0.5), {
            Brightness = 20
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 0.5833333333333334);
        TweenService:Create(BlurEffect, TweenInfo.new(0.08333333333333333), {
            Size = 30
        }):Play();
        task.wait(0.08333333333333333);
        TweenService:Create(BlurEffect, TweenInfo.new(0.5), {
            Size = 0
        }):Play();
    end);
    task.delay(0.9833333333333333 - u3, function() -- Line: 199
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.MeshFlip3);
    end);
    task.delay(1.3833333333333333 - u3, function() -- Line: 205
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Emiting);
    end);
    task.delay(1.4 - u3, function() -- Line: 211
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Spotlight1.SurfaceLight.Enabled = false;
    end);
    task.delay(1.45 - u3, function() -- Line: 217
        -- upvalues: Folder (copy), u11 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Spotlight2.SurfaceLight.Enabled = true;
        task.wait(2);
        TweenService:Create(u11.Spotlight2.SurfaceLight, TweenInfo.new(0.06666666666666667), {
            Brightness = 50
        }):Play();
        task.wait(0.06666666666666667);
        TweenService:Create(u11.Spotlight2.SurfaceLight, TweenInfo.new(0.03333333333333333), {
            Brightness = 200
        }):Play();
        task.wait(0.03333333333333333);
        TweenService:Create(u11.Spotlight2.SurfaceLight, TweenInfo.new(0.36666666666666664), {
            Brightness = 50
        }):Play();
        task.wait(0.36666666666666664);
        TweenService:Create(u11.Spotlight2.SurfaceLight, TweenInfo.new(0.9333333333333333), {
            Brightness = 10
        }):Play();
        task.wait(0.9333333333333333);
        TweenService:Create(u11.Spotlight2.SurfaceLight, TweenInfo.new(0.5), {
            Brightness = 20
        }):Play();
    end);
    task.delay(2.9, function() -- Line: 243
        -- upvalues: Lighting (ref), VfxManager (ref), TweenService (ref)
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 0.5833333333333334);
        TweenService:Create(BlurEffect, TweenInfo.new(0.08333333333333333), {
            Size = 15
        }):Play();
        task.wait(0.08333333333333333);
        TweenService:Create(BlurEffect, TweenInfo.new(0.5), {
            Size = 0
        }):Play();
    end);
    task.delay(3.3 - u3, function() -- Line: 254
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.CameraShot.Attachment.WindScene1.AtmosphereWind);
    end);
    task.delay(3.316666666666667 - u3, function() -- Line: 260
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.CameraShot.Attachment.WindScene2.AtmosphereWind.Blur);
    end);
    task.delay(3.3333333333333335 - u3, function() -- Line: 266
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13);
    end);
    task.delay(3.35 - u3, function() -- Line: 272
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Emit1);
    end);
    task.delay(3.3666666666666667 - u3, function() -- Line: 278
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.CameraShot.Attachment.WindScene3.AtmosphereWind.Black);
    end);
    task.delay(3.3833333333333333 - u3, function() -- Line: 284
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Sphere2);
    end);
    task.delay(3.4 - u3, function() -- Line: 290
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Emit2);
    end);
    task.delay(3.433333333333333 - u3, function() -- Line: 296
        -- upvalues: Folder (copy), Part_Icles (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u11.Swish);
    end);
    local u15 = {};

    local function v16() -- Line: 303
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