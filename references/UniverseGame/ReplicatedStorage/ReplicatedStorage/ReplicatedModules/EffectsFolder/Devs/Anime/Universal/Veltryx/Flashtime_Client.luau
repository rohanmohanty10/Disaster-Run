  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local FXHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 24
    -- upvalues: LocalPlayer (copy), Trove (copy), ParticleHandler (copy), TweenService (copy), RunService (copy), FXHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local Attribute = v3.Attribute;
    local Range = v3.Range;
    local Character2 = LocalPlayer.Character;
    workspace.Gravity = 175;
    local u4 = Trove.new();
    u4:AttachToInstance(Character2);

    if Character ~= Character2 then
        u4:AttachToInstance(Character);
    end;

    u4:Connect(Character2:GetAttributeChangedSignal(Attribute), function() -- Line: 42
        -- upvalues: Character2 (copy), Attribute (copy), u4 (copy)
        if not Character2:GetAttribute(Attribute) then
            u4:Destroy();
        end;
    end);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = game.Lighting;
    local u5 = {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    };
    local u6 = {
        Brightness = 0.1,
        Contrast = 0.1,
        Saturation = 0.4,
        TintColor = ParticleHandler.TryHSVShift(Color3.fromRGB(101, 155, 255), ParticleHandler.GetUnusualHSVData({
            Character = Character
        }))
    };
    local u7 = {};
    u4:Add(function() -- Line: 67
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), u5 (copy), u7 (copy)
        workspace.Gravity = 196.2;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), u5):Play();
        task.delay(1, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);

        for i, v in u7 do
            if i and i.Parent then
                i.TimeScale = v;
            end;
        end;

        table.clear(u7);
    end);
    u4:Connect(RunService.RenderStepped, function(p8) -- Line: 83
        -- upvalues: Character2 (copy), Character (copy), Range (copy), u6 (copy), u5 (copy), ColorCorrectionEffect (copy), FXHandler (ref), u7 (copy)
        local v9 = (Character2.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude / Range;

        for i, v in u6 do
            local v10 = u5[i];
            local v11 = typeof(v) == "number" and math.lerp(v10, v, v9) or v:Lerp(v10, v9);
            ColorCorrectionEffect[i] = typeof(v11) == "number" and math.lerp(ColorCorrectionEffect[i], v11, 0.2) or ColorCorrectionEffect[i]:Lerp(v11, 0.2);
        end;

        local Position = Character.HumanoidRootPart.Position;

        if FXHandler.GetQualityLevel() >= 5 then
            for _, child in workspace.Effects:GetChildren() do
                for _, v in child:QueryDescendants("ParticleEmitter") do
                    local Parent = v.Parent;

                    if Parent ~= nil then
                        local v12 = Parent:IsA("Attachment") and "WorldPosition" or (Parent:IsA("BasePart") and "Position" or nil);

                        if v12 == nil or Range >= (Parent[v12] - Position).Magnitude then
                            if u7[v] == nil then
                                u7[v] = v.TimeScale;
                            end;

                            local TimeScale = v.TimeScale;
                            local v13 = math.clamp(p8 / 0.75, p8, 0.9);
                            v.TimeScale = math.lerp(TimeScale, 0.15, v13);
                        end;
                    end;
                end;
            end;
        end;
    end);
end;