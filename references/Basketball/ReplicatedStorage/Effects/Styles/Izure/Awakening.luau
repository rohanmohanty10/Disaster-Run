 
 

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
    local _ = p2.Other;
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
    task.delay(2 - u3, function() -- Line: 35
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "If i keep this up...", 1.25 },
            { u6, "...no one...", 0.75 },
            { u6, "...can stop me!", 1.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 83
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
    task.delay(7.667 - u3, function() -- Line: 105
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
    task.delay(7.667 - u3, function() -- Line: 118
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Izure Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local v12 = script.Camera_VFX:Clone();
    v12:PivotTo(CamRig.camera.CFrame);
    v12.Parent = Folder;
    Essentials:Weld(v12.PrimaryPart, CamRig.camera);
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
    local Vignette1 = u15.Vignette1;
    u15.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u16 = ColorCorrection:Clone();
    u16.Name = "CC";
    u16.Parent = Lighting;
    u16.Enabled = true;
    task.delay(7.667, function() -- Line: 166
        -- upvalues: u16 (copy), Lighting (ref), ColorCorrection (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u17 = DepthOfField:Clone();
    u17.Name = "D";
    u17.Parent = Lighting;
    u17.Enabled = true;
    u17.InFocusRadius = 0;
    u17.NearIntensity = 0;
    task.delay(7.667, function() -- Line: 183
        -- upvalues: u17 (copy), Lighting (ref), DepthOfField (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 190
        -- upvalues: Folder (copy), u11 (copy), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Part.Transparency = 0;
        u11.Sphere.Transparency = 0;
        u16.Saturation = -1;
    end);
    task.delay(0.1 - u3, function() -- Line: 199
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(0.5333333333333333 - u3, function() -- Line: 205
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(0.9666666666666667 - u3, function() -- Line: 211
        -- upvalues: Folder (copy), u11 (copy), TweenService (ref), VfxManager (ref), Model (copy), Vignette1 (copy), Lighting (ref), u16 (copy), ColorCorrection (copy), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Part.Transparency = 0.5;
        u11.Sphere.Transparency = 0.5;
        TweenService:Create(u11.Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
        TweenService:Create(u11.Sphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0
        }):Play();
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u11.Space, true);
        shared.vfx.emit(u11.GroundAura);
        Vignette1.ImageColor3 = Color3.fromRGB(55, 101, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        u16.Brightness = 0.45;
        u16.TintColor = Color3.fromRGB(55, 101, 255);
        TweenService:Create(u16, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        u17.FarIntensity = 1;
        u17.FocusDistance = 65;
    end);
    task.delay(1.2666666666666666 - u3, function() -- Line: 244
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
    end);
    task.delay(1.7166666666666666 - u3, function() -- Line: 250
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble3);
    end);
    task.delay(1.9666666666666666 - u3, function() -- Line: 256
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble4);
    end);
    task.delay(2.35 - u3, function() -- Line: 262
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble5);
    end);
    task.delay(2.816666666666667 - u3, function() -- Line: 268
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble6);
    end);
    task.delay(3.8833333333333333 - u3, function() -- Line: 274
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble7);
    end);
    task.delay(4.416666666666667 - u3, function() -- Line: 280
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble7);
    end);
    task.delay(4.683333333333334 - u3, function() -- Line: 286
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble7);
    end);
    task.delay(4.95 - u3, function() -- Line: 292
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble7);
    end);
    task.delay(5.883333333333334 - u3, function() -- Line: 298
        -- upvalues: Folder (copy), u11 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), Character (copy), Essentials (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Initial);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        local v18 = tick();

        while true do
            task.wait(0.05);

            if not (Folder and Folder:GetAttribute("Active")) then
                break;
            end;

            if not (Character and Character.Parent) then
                return;
            end;

            local v19 = Essentials:CreateClone(Character, 1);
            v19.Parent = Folder;
            VfxManager.DestroyEffect(v19, 1);

            if tick() - v18 > 0.08333333333333333 then
                return;
            end;
        end;
    end);
    local u20 = {};

    local function v21() -- Line: 319
        -- upvalues: u20 (ref), Folder (copy), u15 (copy), u16 (copy), Lighting (ref), ColorCorrection (copy), u17 (copy), DepthOfField (copy)
        for _, v in pairs(u20) do
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

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u20 = nil;
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v21));
    table.insert(u20, Folder.Destroying:Connect(v21));
end;