 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Module = require(script.Mesh.Module);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

local function GoatHornsMode() -- Line: 21
    -- upvalues: Knit (copy), Effects (copy)
    local Controller = Knit.GetController("Network");
    Knit.GetController("AbilityController");
    Knit.GetController("MovementController");
    Effects:Popup("SPEED BOOST! GOATED!", 6);

    while Controller.CharValues.InAwakening do
        task.wait();
    end;

    Effects:Popup("SPEED BOOST ENDED!");
end;

return function(u1, p2) -- Line: 35
    -- upvalues: Players (copy), LocalPlayer (copy), GoatHornsMode (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), Lighting (copy), VfxManager (copy), TweenService (copy), Module (copy)
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

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);

    if not (CamRig or (not u5 or u5 ~= LocalPlayer)) then
        GoatHornsMode();
    end;

    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 58
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * PassedTime;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(6.683 - PassedTime, function() -- Line: 80
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(6.683 - PassedTime, function() -- Line: 93
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Goat Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = script.Vignette:Clone();
    u12.Parent = PlayerGui;
    u12.Enabled = true;
    local Vignette1 = u12.Vignette1;
    u12.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u13 = ColorCorrection:Clone();
    u13.Name = "CC";
    u13.Parent = Lighting;
    u13.Enabled = true;
    task.delay(6.683, function() -- Line: 128
        -- upvalues: u13 (copy), Lighting (ref), ColorCorrection (copy)
        u13:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u14 = Bloom:Clone();
    u14.Name = "B";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(6.683, function() -- Line: 143
        -- upvalues: u14 (copy), Lighting (ref), Bloom (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u15 = DepthOfField:Clone();
    u15.Name = "D";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(6.683, function() -- Line: 158
        -- upvalues: u15 (copy), Lighting (ref), DepthOfField (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 165
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Aura);
        VfxManager.BetterEmit(u11.CamAtmo.black);
    end);
    task.delay(0.1 - PassedTime, function() -- Line: 172
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Step);
    end);
    task.delay(0.36666666666666664 - PassedTime, function() -- Line: 178
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Step);
    end);
    task.delay(0.6333333333333333 - PassedTime, function() -- Line: 184
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition);
    end);
    task.delay(0.6666666666666666 - PassedTime, function() -- Line: 190
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CamAtmo.gold);
    end);
    task.delay(0.6833333333333333 - PassedTime, function() -- Line: 196
        -- upvalues: Folder (copy), u10 (copy), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Parent = u10.GroundWind;
        NumberValue.Value = 1;
        VfxManager.DestroyEffect(NumberValue, 3);
        local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) });
        TweenService:Create(NumberValue, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        task.spawn(function() -- Line: 212
            -- upvalues: u10 (ref), NumberSequence_new_ret (copy), TweenService (ref), NumberValue (copy)
            for _, descendant in pairs(u10.GroundWind:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    descendant.Transparency = NumberSequence_new_ret;
                    descendant.TextureSpeed = 4;
                    TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        TextureSpeed = 0.01
                    }):Play();
                    NumberValue.Changed:Connect(function() -- Line: 221
                        -- upvalues: descendant (copy), NumberValue (ref)
                        task.spawn(function() -- Line: 222
                            -- upvalues: descendant (ref), NumberValue (ref)
                            descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                        end);
                    end);
                    task.delay(0.2, function() -- Line: 231
                        -- upvalues: NumberValue (ref), descendant (copy)
                        NumberValue.Changed:Connect(function() -- Line: 232
                            -- upvalues: descendant (ref), NumberValue (ref)
                            task.spawn(function() -- Line: 233
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                            end);
                        end);
                        task.wait(3);
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end);
        task.delay(0.1, function() -- Line: 249
            -- upvalues: TweenService (ref), NumberValue (copy)
            TweenService:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 1
            }):Play();
        end);
    end);
    task.delay(0.8 - PassedTime, function() -- Line: 254
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 158, 59);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        VfxManager.BetterEmit(u10.Emit);
    end);
    task.delay(0.8333333333333334 - PassedTime, function() -- Line: 264
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CamEmit);
    end);
    task.delay(1.3833333333333333 - PassedTime, function() -- Line: 270
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraAtmosphere);
    end);
    task.delay(1.75 - PassedTime, function() -- Line: 276
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition2);
    end);
    task.delay(1.9166666666666667 - PassedTime, function() -- Line: 282
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy), Module (ref), HumanoidRootPart (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.AuraChar);
        VfxManager.BetterEmit(u11.CamStart);
        Module(HumanoidRootPart.CFrame * CFrame.new(-4.66, -0.065, -9.953), Folder);
    end);
    task.delay(3.2666666666666666 - PassedTime, function() -- Line: 291
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Dribble);
    end);
    task.delay(3.433333333333333 - PassedTime, function() -- Line: 297
        -- upvalues: Folder (copy), TweenService (ref), u13 (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u13, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Brightness = -0.1,
            Saturation = -1
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
    end);
    task.delay(4.3 - PassedTime, function() -- Line: 304
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u13.Brightness = ColorCorrection.Brightness;
        u13.Saturation = ColorCorrection.Saturation;
    end);
    task.delay(5.35 - PassedTime, function() -- Line: 316
        -- upvalues: Folder (copy), Vignette1 (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        u13.Brightness = -0.1;
        u13.Saturation = -1;
    end);
    task.delay(5.383333333333334 - PassedTime, function() -- Line: 326
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.End);
        VfxManager.BetterEmit(u11.DunkCamera);
    end);
    local u16 = {};

    local function v17() -- Line: 334
        -- upvalues: u16 (ref), Folder (copy), u12 (copy), u13 (copy), Lighting (ref), ColorCorrection (copy), u14 (copy), Bloom (copy), u15 (copy), DepthOfField (copy), u5 (copy), LocalPlayer (ref), GoatHornsMode (ref)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u12 then
            u12:Destroy();
        end;

        if u13 then
            u13:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u16 = nil;

        if u5 and u5 == LocalPlayer then
            GoatHornsMode();
        end;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;