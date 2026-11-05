  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local LightningBolt = ReplicatedStorage.ClientModules.LightningBolt;
local u1 = require(LightningBolt);
local LightningSparks = require(LightningBolt.LightningSparks);
local LightningExplosion = require(LightningBolt.LightningExplosion);
local u2 = require(ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("debrisSlamFunction");

local function GeneratePartWithAttachment() -- Line: 12
    local Part = Instance.new("Part");
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = Part;

    return Part, Attachment;
end;

return function(u3, u4, p5) -- Line: 22
    -- upvalues: u2 (copy), u1 (copy), LightningSparks (copy), LightningExplosion (copy)
    local v6 = p5 or {};
    local u7 = v6.Sparks or 1;
    local v8 = v6.Explosions or 1;
    local v9 = v6.Debris or 1;
    local v10 = v6.Pause or 0;
    local _ = v6.Range or 0;
    local u11 = v6.Colors or { Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 155, 83), Color3.fromRGB(255, 255, 66) };
    local u12 = v6.Speed or 5;
    local v13 = v6.Bolts or 2;
    local _ = v6.Sound or 1;
    wait(v10);
    local _ = (u3 - u4).magnitude;
    local Part = Instance.new("Part");
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = Part;
    local Part2 = Instance.new("Part");
    Part2.Transparency = 1;
    Part2.Anchored = true;
    Part2.CanCollide = false;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = Part2;
    Part.Parent = workspace.Effects;
    Part2.Parent = workspace.Effects;
    game.Debris:AddItem(Part, 10);
    game.Debris:AddItem(Part2, 10);
    Part.Position = u3;
    Part2.Position = u4;
    local v14;

    if v6.Colors then
        v14 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v6.Colors[1]), ColorSequenceKeypoint.new(0.5, v6.Colors[2]), ColorSequenceKeypoint.new(1, v6.Colors[3]) });
    else
        v14 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 74)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 147, 23)) });
    end;

    if v9 == 1 then
        coroutine.wrap(function() -- Line: 66
            -- upvalues: u2 (ref), u4 (copy), u3 (copy)
            wait(0.2);
            u2(nil, CFrame.new(u4 + Vector3.new(0, 2, 0), u3) * CFrame.Angles(-1.5707963267948966, 0, 0));
        end)();
    end;

    for _ = 1, v13 do
        coroutine.wrap(function() -- Line: 72
            -- upvalues: u11 (copy), u1 (ref), Attachment (copy), Attachment2 (copy), u12 (copy), u7 (copy), LightningSparks (ref)
            local v15 = u11;
            local v16 = u1.new(Attachment, Attachment2, 10);
            v16.CurveSize0 = 5;
            v16.CurveSize1 = 5;
            v16.PulseSpeed = u12;
            v16.PulseLength = 1;
            v16.FadeLength = 0.25;
            v16.MaxRadius = 2;
            v16.Color = v15[math.random(1, #v15)];

            if u7 == 1 then
                LightningSparks.new(v16);
            end;
        end)();
    end;

    if v8 == 1 then
        wait(0.2);
        LightningExplosion.new(u4, 0.2, v6.ExplosionSize or 2, v14, v14);
    end;

    wait(5);
end;