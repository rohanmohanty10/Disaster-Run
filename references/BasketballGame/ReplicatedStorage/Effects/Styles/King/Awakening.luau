 
 

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
    -- upvalues: Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
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

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u5 = workspace:FindFirstChild(script.Parent.Name .. "ThroneRoom");
    local u6 = Character:FindFirstChild(script.Parent.Name .. "Crown");
    local u7 = Character:FindFirstChild(script.Parent.Name .. "Chalk");
    Character:FindFirstChild("BALL", true);
    task.delay(5, function() -- Line: 33
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "Ladies and gentlemen...", 1 }, { "Commentator", "Give it up for the...", 1.5 }, { "Commentator", "<animation style=\"glitch\"><font color=\"#ffcd00\">BASKETBALL KING</font>!</animation>", 3 } });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 56
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
    task.delay(12.85 - PassedTime, function() -- Line: 78
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
    task.delay(12.85 - PassedTime, function() -- Line: 91
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u12 = SfxManager:playSound({
        Sound = "BBZ King Awakening",
        Parent = workspace
    });
    u12.TimePosition = PassedTime;
    local u13 = script.Cutscene_VFX:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = Folder;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v14 = Character:FindFirstChild(child.Name);

        if v14 then
            local v15 = child:Clone();
            v15.CFrame = v14.CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, v14);
        end;
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
    task.delay(12.85 - PassedTime, function() -- Line: 134
        -- upvalues: u17 (copy), Lighting (ref), ColorCorrection (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u18 = Bloom:Clone();
    u18.Name = "B";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(12.85 - PassedTime, function() -- Line: 149
        -- upvalues: u18 (copy), Lighting (ref), Bloom (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.delay(0.13333333333333333 - PassedTime, function() -- Line: 156
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.nr2);
        end;
    end);
    task.delay(1.7333333333333334 - PassedTime, function() -- Line: 164
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u18 (copy), Bloom (copy), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(Model.Head.Attachment);
        Vignette1.ImageColor3 = Color3.fromRGB(228, 255, 130);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u18.Intensity = 15;
        u18.Threshold = 0.5;
        TweenService:Create(u18, TweenInfo.new(0.455, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u17.Brightness = 0.45;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(228, 255, 130);
        TweenService:Create(u17, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(6.15 - PassedTime, function() -- Line: 189
        -- upvalues: Folder (copy), u6 (copy), u5 (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            u6:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;

        if u7 and u7:FindFirstChild("Cylinder1") then
            VfxManager.Emit(u7.Cylinder1.Bone.Attachment);
        end;
    end);
    task.delay(8.4 - PassedTime, function() -- Line: 205
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), Lighting (ref), TweenService (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u13.Clap);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        VfxManager.DestroyEffect(BlurEffect, 1.15);
        TweenService:Create(BlurEffect, TweenInfo.new(0.15), {
            Size = 20
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 255, 255);
        TweenService:Create(Vignette1, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.25
        }):Play();
        task.wait(0.15);
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(9.866666666666667 - PassedTime, function() -- Line: 225
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), Lighting (ref), TweenService (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u13.PowderThrow);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        VfxManager.DestroyEffect(BlurEffect, 1.15);
        TweenService:Create(BlurEffect, TweenInfo.new(0.15), {
            Size = 20
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 255, 255);
        TweenService:Create(Vignette1, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.25
        }):Play();
        task.wait(0.15);
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play();
    end);
    local u19 = {};

    local function v20() -- Line: 246
        -- upvalues: u19 (ref), Folder (copy), u6 (copy), u7 (copy), u5 (copy), u16 (copy), u12 (copy), TweenService (ref), VfxManager (ref), u17 (copy), Lighting (ref), ColorCorrection (copy), u18 (copy), Bloom (copy)
        for _, v in pairs(u19) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;

        if u7 then
            u7:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        if u12 then
            TweenService:Create(u12, TweenInfo.new(0.5), {
                Volume = 0
            }):Play();
            VfxManager.DestroyEffect(u12, 0.5);
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u19 = nil;
    end;

    table.insert(u19, Folder.AttributeChanged:Connect(v20));
    table.insert(u19, Folder.Destroying:Connect(v20));
end;