  

 

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

local function ClampColorCorrectionTint(p2) -- Line: 23
    local v3, v4, v5 = p2:ToHSV();

    if v5 < 0.25 then
        v4 = math.min(v4, 0.2);
        v5 = 0.45;
    end;

    return Color3.fromHSV(v3, v4, v5);
end;

local function GetSafeFlashtimeTint(p6, p7) -- Line: 40
    -- upvalues: ParticleHandler (copy), ClampColorCorrectionTint (copy)
    local v8 = ParticleHandler.TryHSVShift(p6, p7);

    if v8 then
        return ClampColorCorrectionTint(v8);
    end;

    return p6;
end;

return function(p9) -- Line: 50
    -- upvalues: ParticleHandler (copy), LocalPlayer (copy), Trove (copy), TweenService (copy), RunService (copy), FXHandler (copy), Players (copy)
    local v10 = p9 or {};

    if not v10.HSVData then
        ParticleHandler.GetUnusualHSVData({
            Player = v10.Player or v10.AttackerPlayer,
            Character = v10.Character or v10.Attacker
        });
    end;

    local Character = v10.Character;
    local Attribute = v10.Attribute;
    local Range = v10.Range;
    local Character2 = LocalPlayer.Character;

    if not (Character2 and Character) then
        return;
    end;

    local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart");
    local HumanoidRootPart2 = Character:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and HumanoidRootPart2) then
        return;
    end;

    workspace.Gravity = 175;
    local u11 = Trove.new();
    u11:AttachToInstance(Character2);

    if Character ~= Character2 then
        u11:AttachToInstance(Character);
    end;

    u11:Connect(Character2:GetAttributeChangedSignal(Attribute), function() -- Line: 84
        -- upvalues: Character2 (copy), Attribute (copy), u11 (copy)
        if not Character2:GetAttribute(Attribute) then
            u11:Destroy();
        end;
    end);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Brightness = 0;
    ColorCorrectionEffect.Contrast = 0;
    ColorCorrectionEffect.Saturation = 0;
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = game.Lighting;
    local u12 = {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    };
    local v13 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    local v14 = Color3.fromRGB(101, 155, 255);
    local v15 = ParticleHandler.TryHSVShift(v14, v13);

    if v15 then
        local v16, v17, v18 = v15:ToHSV();

        if v18 < 0.25 then
            v17 = math.min(v17, 0.2);
            v18 = 0.45;
        end;

        v14 = Color3.fromHSV(v16, v17, v18);
    end;

    local _, _, v19 = v14:ToHSV();
    local v20 = v19 <= 0.5;
    local u21 = {
        Brightness = v20 and 0.03 or 0.1,
        Contrast = v20 and 0.03 or 0.1,
        Saturation = v20 and 0.15 or 0.4,
        TintColor = v14
    };
    local u22 = {};
    u11:Add(function() -- Line: 122
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), u12 (copy), u22 (copy)
        workspace.Gravity = 196.2;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), u12):Play();
        task.delay(1, function() -- Line: 131
            -- upvalues: ColorCorrectionEffect (ref)
            if ColorCorrectionEffect then
                ColorCorrectionEffect:Destroy();
            end;
        end);

        for i, v in u22 do
            if i and i.Parent then
                i.TimeScale = v;
            end;
        end;

        table.clear(u22);
    end);
    u11:Connect(RunService.RenderStepped, function(p23) -- Line: 146
        -- upvalues: HumanoidRootPart (copy), HumanoidRootPart2 (copy), u11 (copy), Range (copy), u21 (copy), u12 (copy), ColorCorrectionEffect (copy), FXHandler (ref), u22 (copy), Players (ref)
        if not (HumanoidRootPart.Parent and HumanoidRootPart2.Parent) then
            u11:Destroy();

            return;
        end;

        local v24 = math.clamp((HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude / Range, 0, 1);

        for i, v in u21 do
            local v25 = u12[i];
            local v26 = typeof(v) == "number" and math.lerp(v, v25, v24) or v:Lerp(v25, v24);
            ColorCorrectionEffect[i] = typeof(v26) == "number" and math.lerp(ColorCorrectionEffect[i], v26, 0.2) or ColorCorrectionEffect[i]:Lerp(v26, 0.2);
        end;

        local Position = HumanoidRootPart2.Position;

        if FXHandler.GetQualityLevel() < 5 then
            return;
        end;

        local u27 = math.min(p23 * 8, 1);

        local function ProcessEmitter(p28) -- Line: 179
            -- upvalues: Position (copy), Range (ref), u22 (ref), u27 (copy)
            if not p28:IsA("ParticleEmitter") then
                return;
            end;

            local Parent = p28.Parent;

            if not Parent then
                return;
            end;

            local v29;

            if Parent:IsA("Attachment") then
                v29 = Parent.WorldPosition;
            else
                if not Parent:IsA("BasePart") then
                    return;
                end;

                v29 = Parent.Position;
            end;

            if Range < (v29 - Position).Magnitude then
                return;
            end;

            if u22[p28] == nil then
                u22[p28] = p28.TimeScale;
            end;

            p28.TimeScale = math.lerp(p28.TimeScale, 0.15, u27);
        end;

        (function(p30) -- Line: 210, Name: ScanContainer
            -- upvalues: ProcessEmitter (copy)
            for _, child in p30:GetChildren() do
                for _, descendant in child:GetDescendants() do
                    ProcessEmitter(descendant);
                end;
            end;
        end)(workspace.Effects);

        for _, v in Players:GetPlayers() do
            local Character3 = v.Character;

            if Character3 and (Character3.PrimaryPart and (Character3.PrimaryPart.Position - Position).Magnitude <= Range + 30) then
                for _, descendant in Character3:GetDescendants() do
                    ProcessEmitter(descendant);
                end;
            end;
        end;
    end);
end;