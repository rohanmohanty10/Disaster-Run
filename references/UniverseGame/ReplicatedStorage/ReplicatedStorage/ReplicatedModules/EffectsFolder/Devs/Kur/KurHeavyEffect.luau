  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local wrap = coroutine.wrap;
local _ = math.cos;
local _ = math.sin;
local rad = math.rad;
local random = math.random;
local Angles = CFrame.Angles;

local function tweendeb(p1, p2) -- Line: 9
    p1:Play();
    p1.Completed:Wait();

    if p2 then
        p2:Destroy();
    end;

    return true;
end;

local function generatehit2(p3, p4, p5) -- Line: 16
    -- upvalues: wrap (copy), Angles (copy), random (copy), rad (copy), TweenService (copy), Debris (copy)
    local CFrame2 = p3.CFrame;
    local Kur = game.ReplicatedStorage["Client Assets"].Kur;
    local u6 = Kur.Hit:Clone();
    Kur.Hit2:Clone();
    local v7 = Kur.TestEffect:Clone();
    Kur.HITPE:Clone();

    for _ = 1, 15 do
        wrap(function() -- Line: 25
            -- upvalues: Angles (ref), random (ref), rad (ref), CFrame2 (copy), u6 (copy), TweenService (ref)
            local v8 = CFrame2 * Angles(rad((random(360))), 0, (rad((random(360)))));
            local v9 = u6:Clone();
            local v10 = random(3) / 10;
            local v11 = random(10, 30) / 10;
            local v12 = random(3) / 10;
            v9.Size = Vector3.new(v10, v11, v12) * 1.5;
            v9.CFrame = v8 * CFrame.new(0, v9.Size.Y / 2, 0);
            v9.Parent = workspace.Effects;
            local v13 = TweenService:Create(v9, TweenInfo.new(0.5), {
                Transparency = 1,
                CFrame = v9.CFrame * CFrame.new(0, random(3, 8), 0),
                Size = Vector3.new()
            });
            v13:Play();
            v13.Completed:Wait();

            if v9 then
                v9:Destroy();
            end;
        end)();
    end;

    v7.CFrame = CFrame2;
    v7.Parent = workspace.Effects;

    for _, child in ipairs(v7:GetChildren()) do
        child:Emit(25);
    end;

    Debris:AddItem(v7, 0.5);
end;

return function(p14, p15, p16) -- Line: 47
    -- upvalues: generatehit2 (copy)
    generatehit2(p14.Torso or p14.PrimaryPart, p16.HitData, 25);
end;