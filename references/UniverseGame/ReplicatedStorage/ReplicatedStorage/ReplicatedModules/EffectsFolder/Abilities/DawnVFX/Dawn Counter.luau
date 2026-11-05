  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local wrap = coroutine.wrap;
local TweenService = game:GetService("TweenService");
local _ = CFrame.Angles;
local rad = math.rad;

local function tweendeb(p2, p3) -- Line: 7
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

return function(p4, p5) -- Line: 14
    -- upvalues: u1 (copy), TweenService (copy), wrap (copy), rad (copy), tweendeb (copy)
    local u6 = u1.Dawn.ring:Clone();
    u6.CFrame = p5.CFrame * CFrame.Angles(0, 0, 1.5707963267948966);
    u6.Size = Vector3.new(1, 15, 15);
    u6.Color = p4.Color;
    u6.Parent = workspace.Effects;
    local v7 = TweenService:Create(u6, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        Transparency = 1,
        Size = Vector3.new(2, 30, 30)
    });
    local u8 = false;
    wrap(function() -- Line: 23
        -- upvalues: u8 (ref), u6 (copy), rad (ref)
        while not u8 do
            local v9 = u6;
            v9.CFrame = v9.CFrame * CFrame.Angles(rad(10 + 10 * wait()), 0, 0);
        end;
    end)();
    u8 = wrap(tweendeb)(v7, u6);
    local Sound = Instance.new("Sound");
    Sound.Volume = 3;
    Sound.SoundId = "rbxassetid://4580495407";
    Sound.Parent = p5;
    Sound:Play();
    Sound.Ended:Wait();
    Sound:Destroy();
end;