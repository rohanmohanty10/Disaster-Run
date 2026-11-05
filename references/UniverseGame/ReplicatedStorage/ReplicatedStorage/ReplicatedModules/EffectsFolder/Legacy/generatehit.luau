  

 

local _ = CFrame.new;
local Angles = CFrame.Angles;
local _ = math.rad;
local random = math.random;
local rad = math.rad;
local wrap = coroutine.wrap;
local _ = task.spawn;
local _ = task.delay;
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require(ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("tweendeb");

return function(u2, p3) -- Line: 15
    -- upvalues: random (copy), wrap (copy), Angles (copy), rad (copy), TweenService (copy), u1 (copy)
    local Hits = game.ReplicatedStorage["Client Assets"].BakEffects.Hits;
    local u4 = Hits.Hit:Clone();
    local v5, u6, v7;

    if p3 then
        v5 = p3.Hit or Hits.Hit2;
        u4.Color = p3.Color or u4.Color;
        v5.Color = p3.Color2 or v5.Color;
        local _ = p3.Size or 1.5;
        u6 = p3.Size2 or random(10, 30);
        v7 = p3.Count or 10;
    else
        v5 = nil;
        v7 = nil;
        u6 = nil;
    end;

    local v8 = v5:Clone();

    for _ = 1, v7 do
        wrap(function() -- Line: 33
            -- upvalues: Angles (ref), random (ref), rad (ref), u2 (copy), u4 (copy), u6 (ref), TweenService (ref), u1 (ref)
            local v9 = u2 * Angles(rad((random(360))), 0, (rad((random(360)))));
            local v10 = u4:Clone();
            local v11 = random(3) / 10;
            local v12 = random(3) / 10;
            v10.Size = Vector3.new(v11, u6 / 10, v12) * 1.5;
            v10.CFrame = v9 * CFrame.new(0, v10.Size.Y / 2, 0);
            v10.Parent = workspace.Effects;
            u1(TweenService:Create(v10, TweenInfo.new(0.5), {
                Transparency = 1,
                CFrame = v10.CFrame * CFrame.new(0, random(3, 8), 0),
                Size = Vector3.new()
            }), v10);
        end)();
    end;

    v8.CFrame = u2 * CFrame.Angles(rad((random(360))), rad((random(360))), (rad((random(360)))));
    v8.Parent = workspace.Effects;
    local v13 = TweenService:Create(v8, TweenInfo.new(0.3), {
        Transparency = 1,
        Size = v8.Size * 1.5
    });
    wrap(u1)(v13, v8);
end;