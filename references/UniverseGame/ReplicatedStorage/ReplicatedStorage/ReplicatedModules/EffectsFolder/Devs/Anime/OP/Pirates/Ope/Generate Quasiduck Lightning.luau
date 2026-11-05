  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);
local LightningSparks = require(ReplicatedStorage.ClientModules.LightningBolt.LightningSparks);
local LightningExplosion = require(ReplicatedStorage.ClientModules.LightningBolt.LightningExplosion);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);

return function(p1, p2) -- Line: 9
    -- upvalues: LightningBolt (copy), LightningSparks (copy), LightningExplosion (copy)
    local v3 = p2.CFrames or p1 and { p1.PrimaryPart.CFrame * CFrame.new(0, 20, 0), p1.PrimaryPart.CFrame };
    local v4 = p2.Color or Color3.fromRGB(248, 217, 109);
    local v5 = p2.Curves or { 0, 0 };
    local v6 = p2.Length or 1;
    local v7 = p2.Speed or 3;
    local v8 = p2.Size or 1;
    local v9 = p2.PartCount or 15;
    local v10 = p2.Transparency or NumberRange.new(0, 1);
    local v11 = p2.FadeLength or 0.25;
    local v12 = LightningBolt.new(p2.A1 or {
        WorldAxis = Vector3.new(0, 0, 0),
        WorldPosition = v3[1].Position
    }, p2.A2 or {
        WorldAxis = Vector3.new(0, 0, 0),
        WorldPosition = v3[2].Position
    }, v9, p2.Parent);
    local v13 = v5[2];
    v12.CurveSize0 = v5[1];
    v12.CurveSize1 = v13;
    v12.AnimationSpeed = p2.AnimationSpeed or 14;
    v12.PulseSpeed = v7;
    v12.PulseLength = v6;
    v12.FadeLength = v11;
    v12.Transparency = 0;
    v12.Thickness = v8;
    v12.MinTransparency = v10.Min;
    v12.MaxTransparency = v10.Max;
    v12.MinRadius = p2.MinRadius or 0;
    v12.MaxRadius = p2.MaxRadius or 2.4;
    v12.Color = v4;

    if p2.Sparks then
        LightningSparks.new(v12);
    end;

    if p2.Explosion then
        local Position = p2.Explosion.Position;
        local Size = p2.Explosion.Size;
        local Color = p2.Explosion.Color;
        local Delay = p2.Explosion.Delay;

        if Delay then
            task.wait(Delay);
        end;

        LightningExplosion.new(Position, Size, 15, Color, Color);
    end;

    return v12;
end;