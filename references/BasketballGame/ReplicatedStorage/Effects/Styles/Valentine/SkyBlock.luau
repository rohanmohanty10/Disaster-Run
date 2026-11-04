 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: Knit (copy), TweenService (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), Players (copy), LocalPlayer (copy), CameraShaker (copy), Lighting (copy), RunService (copy), workspace_CurrentCamera (copy)
    local Controller = Knit.GetController("CameraController");
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local D4C = Character:FindFirstChild("D4C");
    Character:FindFirstChild("BALL", true);

    if D4C then
        local Highlight = Instance.new("Highlight", D4C);
        Highlight.Name = script.Name .. "Highlight";
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.OutlineTransparency = 0;
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(0.4166666666666667, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end;

    if p2.Task == "Invert" then
        local u4 = SfxManager:playSound({
            Sound = "BBZ Valentine Inverted World",
            Parent = HumanoidRootPart
        });

        if p2.Duration == 1 then
            task.delay(1, function() -- Line: 45
                -- upvalues: TweenService (ref), u4 (copy)
                TweenService:Create(u4, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
            end);
        end;

        local u5 = script.Aura:Clone();
        u5.Parent = Debris;
        u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
        Essentials:Weld(u5, HumanoidRootPart);
        VfxManager.DestroyEffect(u5, p2.Duration);
        task.delay(p2.Duration - 0.25, function() -- Line: 56
            -- upvalues: u5 (copy), TweenService (ref)
            for _, descendant in u5:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;
        end);
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Character);

        if PlayerFromCharacter and PlayerFromCharacter == LocalPlayer then
            Controller.CamShake:Shake(CameraShaker.Presets.Dunk);
        end;

        if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and (LocalPlayer.Character.HumanoidRootPart.Position * Vector3.new(1, 0, 1) - HumanoidRootPart.Position * Vector3.new(1, 0, 1)).Magnitude <= 50) then
            local u6 = SfxManager:playSound({
                Sound = "BBZ Valentine Inverted World Enemy",
                Parent = workspace
            });
            task.delay(p2.Duration, function() -- Line: 71
                -- upvalues: TweenService (ref), u6 (copy)
                TweenService:Create(u6, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
            end);
            local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
            ColorCorrection.Enabled = false;
            local u7 = ColorCorrection:Clone();
            u7.Name = "CC";
            u7.Parent = Lighting;
            u7.Enabled = true;
            task.delay(p2.Duration, function() -- Line: 83
                -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
                u7:Destroy();

                if not Lighting:FindFirstChild("CC") then
                    ColorCorrection.Enabled = true;
                end;
            end);
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 0;
            TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Value = 180
            }):Play();
            TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Saturation = -1.2
            }):Play();
            task.delay(p2.Duration - 0.25, function() -- Line: 96
                -- upvalues: TweenService (ref), NumberValue (copy), u7 (copy), ColorCorrection (copy)
                TweenService:Create(NumberValue, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Value = 0
                }):Play();
                TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Saturation = ColorCorrection.Saturation
                }):Play();
            end);
            local u8 = RunService.RenderStepped:Connect(function() -- Line: 101
                -- upvalues: workspace_CurrentCamera (ref), NumberValue (copy)
                if workspace_CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                    return;
                end;

                workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame.Angles(0, 0, (math.rad(NumberValue.Value)));
            end);
            task.delay(p2.Duration, function() -- Line: 106
                -- upvalues: u8 (copy), NumberValue (copy)
                u8:Disconnect();
                NumberValue:Destroy();
            end);
        end;
    else
        if p2.Task == "Highlight" then
            local Highlight = Instance.new("Highlight", Character);
            Highlight.Name = script.Name .. "Highlight";
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.FillColor = Color3.fromRGB(0, 0, 0);
            Highlight.OutlineColor = Color3.fromRGB(255, 155, 197);
            Highlight.OutlineTransparency = 0;
            Highlight.FillTransparency = 1;
            VfxManager.DestroyEffect(Highlight, 5 - v3);

            return;
        end;

        if p2.Task == "Block" then
            if not D4C then
                return;
            end;

            if Character:FindFirstChild(script.name .. "Highlight") then
                Character[script.name .. "Highlight"]:Destroy();
            end;

            local v9 = script.Block:Clone();
            v9.Parent = Debris;
            v9.CFrame = D4C.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3.5);
            VfxManager.BetterEmit(v9);
            VfxManager.DestroyEffect(v9, 4);
            SfxManager:playSound({
                Sound = "BBZ Valentine Sky Block",
                Parent = v9
            });
        end;
    end;
end;