  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(145, 164, 207)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(145, 164, 207)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 204, 255)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(137, 153, 207)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(113, 122, 207))
});

return function(p2, p3) -- Line: 14
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy), u1 (copy)
    local v4 = p3 or {};
    local v5 = v4.StartPos or p2.HumanoidRootPart.Position;
    local v6 = v4.EndPos or v5 + p2.HumanoidRootPart.CFrame.LookVector * 25;
    local Magnitude = (v5 - v6).Magnitude;
    local HSVData = v4.HSVData;

    if not HSVData then
        if v4.IgnoreUnusuals == true then
            HSVData = false;
        else
            HSVData = ParticleHandler.GetUnusualHSVData({
                Character = p2
            });
        end;
    end;

    EffectsHandler.CallEffect("Generate Quasiduck Lightning", p2, {
        Color = ParticleHandler.TryHSVShift(v4.Color or u1, HSVData),
        Speed = v4.Speed or 9,
        Length = v4.Length or 1.8,
        A1 = v4.A1 or {
            WorldAxis = Vector3.new(0, 1, 0),
            WorldPosition = v5
        },
        A2 = v4.A2 or p2.HumanoidRootPart:FindFirstChildOfClass("Attachment"),
        Curves = v4.Curves or { Magnitude / 8, -Magnitude / 8 },
        Sparks = v4.Sparks ~= false,
        Size = v4.Size or 1,
        FadeLength = v4.FadeLength or 0.1,
        MinRadius = v4.MinRadius or 0.5 + Magnitude / 50,
        MaxRadius = v4.MaxRadius or 3.75 + Magnitude / 50,
        AnimationSpeed = v4.AnimationSpeed or 20,
        Explosion = v4.Explosion ~= false and ({
            Position = v6,
            Size = v4.ExplosionSize or 3.5,
            Color = v4.Color or u1,
            Delay = v4.ExplosionDelay or 0.1
        } or nil) or nil
    });
end;