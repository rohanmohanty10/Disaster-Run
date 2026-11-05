  

 

local _ = CFrame.new;
local Angles = CFrame.Angles;
local _ = math.rad;
local random = math.random;
local rad = math.rad;
local wrap = coroutine.wrap;
local TweenService = game:GetService("TweenService");

local function tweendeb(p1, p2) -- Line: 9
    p1:Play();
    p1.Completed:Wait();

    if p2 then
        p2:Destroy();
    end;

    return true;
end;

local function generatehit(u3, p4, p5) -- Line: 16
    -- upvalues: random (copy), wrap (copy), Angles (copy), rad (copy), TweenService (copy), tweendeb (copy)
    local Hits = game.ReplicatedStorage["Client Assets"].BakEffects.Hits;
    local u6 = Hits.Hit:Clone();
    local v7, u8, v9;

    if p4 then
        v7 = p4.Hit or Hits.Hit2;
        u6.Color = p4.Color or u6.Color;
        v7.Color = p4.Color2 or v7.Color;
        local _ = p4.Size or 1.5;
        u8 = p4.Size2 or random(10, 30);
        v9 = p4.Count or 10;
    else
        v7 = nil;
        v9 = nil;
        u8 = nil;
    end;

    local v10 = v7:Clone();

    for _ = 1, v9 do
        wrap(function() -- Line: 34
            -- upvalues: Angles (ref), random (ref), rad (ref), u3 (copy), u6 (copy), u8 (ref), TweenService (ref)
            local v11 = u3 * Angles(rad((random(360))), 0, (rad((random(360)))));
            local v12 = u6:Clone();
            local v13 = random(3) / 10;
            local v14 = random(3) / 10;
            v12.Size = Vector3.new(v13, u8 / 10, v14) * 1.5;
            v12.CFrame = v11 * CFrame.new(0, v12.Size.Y / 2, 0);
            v12.Parent = workspace.Effects;
            local v15 = TweenService:Create(v12, TweenInfo.new(0.5), {
                Transparency = 1,
                CFrame = v12.CFrame * CFrame.new(0, random(3, 8), 0),
                Size = Vector3.new()
            });
            v15:Play();
            v15.Completed:Wait();

            if v12 then
                v12:Destroy();
            end;
        end)();
    end;

    v10.CFrame = u3 * CFrame.Angles(rad((random(360))), rad((random(360))), (rad((random(360)))));
    v10.Parent = workspace.Effects;
    local v16 = TweenService:Create(v10, TweenInfo.new(0.3), {
        Transparency = 1,
        Size = v10.Size * 1.5
    });
    wrap(tweendeb)(v16, v10);
end;

return function(p17, p18) -- Line: 56
    -- upvalues: generatehit (copy), random (copy)
    generatehit(p17.HumanoidRootPart.CFrame, {
        Size = 2,
        Color = Color3.fromRGB(191, 113, 4),
        Color2 = Color3.fromRGB(138, 79, 2),
        Size2 = random(20, 30)
    });
    generatehit(p17.HumanoidRootPart.CFrame, {
        Size = 2,
        Color = Color3.fromRGB(148, 1, 3),
        Color2 = Color3.fromRGB(171, 0, 2),
        Size2 = random(5, 10)
    });
end;