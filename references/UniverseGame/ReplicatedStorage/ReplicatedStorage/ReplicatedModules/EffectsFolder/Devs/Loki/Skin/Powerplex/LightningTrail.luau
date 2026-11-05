  

 

local Petal = _G.Petal;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
Petal("New");
local _ = Petal("Util").Tween;

local function _(p1, p2) -- Line: 16
    return Random.new():NextNumber(p1, p2);
end;

local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;

return function(p3) -- Line: 23
    -- upvalues: ParticleHandler (copy), RunService (copy), EffectsHandler (copy)
    local Reference = p3.Reference;
    local v4 = p3.DurationMultiplier or 1;

    if not (Reference and Reference.Parent) then
        return;
    end;

    local WorldPosition = Reference.WorldPosition;
    local v5 = ParticleHandler.GetUnusualHSVData({
        Player = p3.Player,
        Character = p3.Character
    });
    local v6 = p3.Color or ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(207, 179, 123)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 175, 121)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(218, 188, 117)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 172, 123))
    });

    if v5 ~= nil then
        v6 = ParticleHandler.HSVShift(v6, v5);
    end;

    local v7 = p3.MinLength or 0.07;
    local v8 = 0;

    while Reference and Reference.Parent do
        RunService.Heartbeat:Wait();

        if os.clock() - v8 >= 0.015384615384615385 then
            v8 = os.clock();

            if Reference and (Reference.Parent and (Reference:GetAttribute("Enabled") and v7 < (Reference.WorldPosition - WorldPosition).Magnitude)) then
                EffectsHandler.CallEffect("Generate Quasiduck Lightning", p3.Character, {
                    PartCount = 4,
                    FadeLength = 0.17,
                    MinRadius = 0.1,
                    MaxRadius = 0.6,
                    Color = v6,
                    Speed = 31.5 * v4,
                    Length = 3 / v4,
                    CFrames = { CFrame.new(WorldPosition), CFrame.new(Reference.WorldPosition) },
                    Size = p3.Size or 0.4,
                    AnimationSpeed = 22 * v4
                });
                WorldPosition = Reference.WorldPosition;
            end;
        end;
    end;
end;