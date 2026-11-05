  

 

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

local function _(p1, p2) -- Line: 15
    return Random.new():NextNumber(p1, p2);
end;

local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;

return function(p3) -- Line: 22
    -- upvalues: ParticleHandler (copy), RunService (copy), EffectsHandler (copy)
    local Reference = p3.Reference;
    local _ = p3.DurationMultiplier or 1;

    if not (Reference.Parent and Reference) then
        return;
    end;

    local WorldPosition = Reference.WorldPosition;
    local v4 = ParticleHandler.GetUnusualHSVData({
        Player = p3.Player,
        Character = p3.Character
    });
    local v5 = p3.Color or ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(207, 179, 123)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 175, 121)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(218, 188, 117)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 172, 123))
    });

    if v4 ~= nil then
        v5 = ParticleHandler.HSVShift(v5, v4);
    end;

    local v6 = 0;

    while true do
        repeat
            RunService.Heartbeat:Wait();
        until os.clock() - v6 >= 0.015384615384615385;

        v6 = os.clock();

        if not Reference.Parent then
            return;
        end;

        if (Reference.WorldPosition - WorldPosition).Magnitude > 0.07 and (Reference:GetAttribute("Enabled") and Reference.Parent) then
            EffectsHandler.CallEffect("Generate Quasiduck Lightning", p3.Character, {
                Speed = 31.5,
                PartCount = 4,
                Length = 3,
                Size = 0.4,
                FadeLength = 0.17,
                MinRadius = 0.1,
                MaxRadius = 0.6,
                AnimationSpeed = 22,
                Color = v5,
                CFrames = { CFrame.new(WorldPosition), CFrame.new(Reference.WorldPosition) }
            });
            WorldPosition = Reference.WorldPosition;
        end;
    end;
end;