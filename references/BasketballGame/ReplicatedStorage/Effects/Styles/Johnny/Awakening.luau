 
 

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
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
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
    local v5 = workspace:FindFirstChild(script.Parent.Name .. "Tusk");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 35
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
    task.delay(7.5 - PassedTime, function() -- Line: 57
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
    task.delay(7.5 - PassedTime, function() -- Line: 70
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Johnny Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.camera, CamRig.camera);
    local u12 = script.Ball:Clone();
    u12.CFrame = BALL.CFrame;
    u12.Parent = Folder;
    Essentials:Weld(u12, BALL);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local _ = u13.Vignette1;
    u13.Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", v5);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    u14.Saturation = 0.5;
    task.delay(7.5, function() -- Line: 118
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u15 = Bloom:Clone();
    u15.Name = "B";
    u15.Parent = Lighting;
    u15.Enabled = true;
    u15.Intensity = 1.35;
    u15.Threshold = 2;
    task.delay(7.5, function() -- Line: 135
        -- upvalues: u15 (copy), Lighting (ref), Bloom (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.delay(0.6666666666666666 - PassedTime, function() -- Line: 142
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition2);
    end);
    task.delay(0.7333333333333333 - PassedTime, function() -- Line: 148
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Start);
    end);
    task.delay(1.7333333333333334 - PassedTime, function() -- Line: 154
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy), Lighting (ref), TweenService (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Aura);
        VfxManager.BetterEmit(u11.CameraTransition);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u14.Brightness = 1;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u14, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(1.8 - PassedTime, function() -- Line: 172
        -- upvalues: Folder (copy), u10 (copy), VfxManager (ref), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local NumberValue = Instance.new("NumberValue");
        NumberValue.Parent = u10.Aura;
        NumberValue.Value = 1;
        VfxManager.DestroyEffect(NumberValue, 1);
        local NumberSequence_new_ret = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1) });
        TweenService:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Value = 0
        }):Play();
        task.spawn(function() -- Line: 188
            -- upvalues: u10 (ref), NumberSequence_new_ret (copy), TweenService (ref), NumberValue (copy)
            for _, descendant in pairs(u10.Aura:GetDescendants()) do
                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                    descendant.Transparency = NumberSequence_new_ret;
                    descendant.TextureSpeed = 3;
                    TweenService:Create(descendant, TweenInfo.new(2.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        TextureSpeed = 0.01
                    }):Play();
                    NumberValue.Changed:Connect(function() -- Line: 197
                        -- upvalues: descendant (copy), NumberValue (ref)
                        task.spawn(function() -- Line: 198
                            -- upvalues: descendant (ref), NumberValue (ref)
                            descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                        end);
                    end);
                    task.delay(0.2, function() -- Line: 207
                        -- upvalues: NumberValue (ref), descendant (copy)
                        NumberValue.Changed:Connect(function() -- Line: 208
                            -- upvalues: descendant (ref), NumberValue (ref)
                            task.spawn(function() -- Line: 209
                                -- upvalues: descendant (ref), NumberValue (ref)
                                descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                            end);
                        end);
                        task.wait(1);
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end);
        task.delay(0.2, function() -- Line: 225
            -- upvalues: TweenService (ref), NumberValue (copy)
            TweenService:Create(NumberValue, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 1
            }):Play();
        end);
        TweenService:Create(Highlight, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(3.1333333333333333 - PassedTime, function() -- Line: 232
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12);
    end);
    task.delay(3.3666666666666667 - PassedTime, function() -- Line: 238
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Throw1);
    end);
    task.delay(3.533333333333333 - PassedTime, function() -- Line: 244
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Throw2);
    end);
    task.delay(5.233333333333333 - PassedTime, function() -- Line: 250
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Grab);
    end);
    task.delay(6.083333333333333 - PassedTime, function() -- Line: 256
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Lighting (ref), TweenService (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.End);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u14.Brightness = 1;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u14, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    local u16 = {};

    local function v17() -- Line: 274
        -- upvalues: u16 (ref), Folder (copy), u13 (copy), u14 (copy), Lighting (ref), ColorCorrection (copy), u15 (copy), Bloom (copy), Highlight (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;