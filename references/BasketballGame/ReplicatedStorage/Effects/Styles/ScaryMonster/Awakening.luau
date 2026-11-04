 
 

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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local _ = p2.Other;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name) or Character.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local u6 = workspace:FindFirstChild(Character.Name .. script.Parent.Name .. "Dinosaur");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(2.5 - PassedTime, function() -- Line: 35
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "What the-", 1 }
        });
    end);
    task.delay(5.25 - PassedTime, function() -- Line: 45
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "What is this feeling in my body?!", 2 }
        });
    end);
    task.delay(7.75 - PassedTime, function() -- Line: 55
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Impossible!", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 68
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * PassedTime;
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
    task.delay(12.333 - PassedTime, function() -- Line: 90
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.333 - PassedTime, function() -- Line: 103
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Scary Monster Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
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

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in pairs(script.Sweat:GetChildren()) do
        local v15 = Character:FindFirstChild(child.Name);

        if v15 then
            local v16 = child:Clone();
            v16.CFrame = v15.CFrame;
            v16.Parent = Model2;
            Essentials:Weld(v16, v15);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette = u17.Vignette;
    local _ = u17.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(12.333, function() -- Line: 164
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
    u19.FarIntensity = 1;
    u19.FocusDistance = 15;
    u19.InFocusRadius = 0;
    u19.NearIntensity = 0;
    task.delay(12.333, function() -- Line: 183
        -- upvalues: u19 (copy), Lighting (ref), DepthOfField (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 190
        -- upvalues: Folder (copy), u17 (copy), u11 (copy), VfxManager (ref), Model2 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u17.Vignette2.ImageTransparency = 0;
        u11.Sphere.Transparency = 0.8;
        u11.Part.Transparency = 0.8;
        VfxManager.Enable(Model2, true);
        VfxManager.Enable(u11.BodyIntensity, true);
        VfxManager.Enable(u11.Crack, true);
        VfxManager.Enable(u11.CrackAoE, true);
        VfxManager.Enable(u11.AuraAoE, true);

        for _, descendant in u11.BodyIntensity:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                TweenService:Create(descendant, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
                    TimeScale = 0
                }):Play();
            end;
        end;

        task.delay(5, function() -- Line: 210
            -- upvalues: u11 (ref)
            for _, descendant in u11.BodyIntensity:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                    descendant.Enabled = false;
                end;
            end;
        end);
    end);
    task.delay(0.4 - PassedTime, function() -- Line: 220
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Start);
    end);
    task.delay(2.1666666666666665 - PassedTime, function() -- Line: 226
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.CamTrans);
    end);
    task.delay(4.716666666666667 - PassedTime, function() -- Line: 232
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), VfxManager (ref), Model (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.75,
            BackgroundTransparency = 1
        }):Play();
        VfxManager.Enable(Model, true);
        shared.vfx.emit(u11.Twirl);
    end);
    task.delay(8.716666666666667 - PassedTime, function() -- Line: 244
        -- upvalues: Folder (copy), u11 (copy), u12 (copy), TweenService (ref), u18 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Sphere.Transparency = 1;
        u11.Part.Transparency = 1;
        shared.vfx.emit(u11.Distortion, u12.Campulse);
        u11.Distortion.Start.Material = Enum.Material.Glass;
        task.delay(1, function() -- Line: 253
            -- upvalues: u11 (ref)
            u11.Distortion.Start.Material = Enum.Material.Neon;
        end);
        task.spawn(function() -- Line: 257
            -- upvalues: TweenService (ref), u18 (ref)
            TweenService:Create(u18, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(120, 255, 57)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u18, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(255, 234, 3)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u18, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(32, 54, 255)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u18, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(255, 39, 39)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u18, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(78, 42, 255)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u18, TweenInfo.new(0.655), {
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
        end);
    end);
    task.delay(9.75 - PassedTime, function() -- Line: 272
        -- upvalues: Folder (copy), VfxManager (ref), u6 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u6, true);
    end);
    task.delay(11.266666666666667 - PassedTime, function() -- Line: 278
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Roar);
    end);
    local u20 = {};

    local function v21() -- Line: 285
        -- upvalues: u20 (ref), Folder (copy), u17 (copy), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), DepthOfField (copy)
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

        u20 = nil;
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v21));
    table.insert(u20, Folder.Destroying:Connect(v21));
end;