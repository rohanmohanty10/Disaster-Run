  

 

local random = math.random;
local rad = math.rad;
local wrap = coroutine.wrap;
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

local function Lerp(p1, p2, p3) -- Line: 7
    return (p2 - p1) * p3 + p1;
end;

local function tweendeb(p4, p5) -- Line: 11
    p4:Play();
    p4.Completed:Wait();

    if p5 then
        p5:Destroy();
    end;

    return true;
end;

return function(p6, p7, p8) -- Line: 18
    -- upvalues: random (copy), rad (copy), wrap (copy), RunService (copy), TweenService (copy), tweendeb (copy)
    local Umbra = game.ReplicatedStorage["Client Assets"].Umbra;
    local v9 = Umbra.circle:Clone();
    local v10 = Umbra.hit:Clone();
    local UmbraHitData = p8.UmbraHitData;

    if UmbraHitData then
        p8 = UmbraHitData;
    elseif p8.HitName ~= "UmbraData" then
        p8 = false;
    end;

    if not p8 then
        return;
    end;

    local v11 = p8.Amount or 1;
    local u12 = p8.Speed or 10;
    local u13 = p8.Time or 0.5;
    local v14 = p8.Delay or 0;
    local v15 = p8.Color or Color3.new(1, 1, 1);
    local v16 = p8.StartSize or Vector3.new();
    local v17 = p8.FinalSize or Vector3.new(10, 2, 10);
    local Angle = p8.Angle;
    local Negative = p8.Negative;
    v9.Size = v16;
    v10.Size = v16;
    v9.Color = v15;
    v10.Color = v15;
    local v18 = typeof(p6) == "CFrame" and p6 and p6 or p6.HumanoidRootPart.CFrame;

    for _ = 1, v11 do
        local u19 = v9:Clone();
        u19.CFrame = v18 * (Angle or CFrame.Angles(rad((random(-360, 360))), rad((random(-360, 360))), (rad((random(-360, 360))))));
        u19.Parent = workspace.Effects;
        wrap(function() -- Line: 42
            -- upvalues: u12 (copy), u13 (copy), u19 (copy), Negative (copy), rad (ref), RunService (ref)
            local v20 = u12;
            local v21 = 1 / u13;
            tick();
            local v22 = v20;
            local v23 = 0;

            while v23 < 1 do
                local v24 = u19;

                if Negative then
                    v20 = -v20 or v20;
                end;

                v24.CFrame = v24.CFrame * CFrame.Angles(0, rad(v20), 0);
                v23 = v23 + RunService.RenderStepped:Wait() * v21;
                v20 = (0 - v22) * v23 + v22;
            end;
        end)();
        local v25 = TweenService:Create(u19, TweenInfo.new(u13, Enum.EasingStyle.Sine), {
            Transparency = 1,
            Size = v17
        });
        coroutine.wrap(tweendeb)(v25, u19);

        if v14 > 0 then
            wait(v14);
        end;
    end;
end;