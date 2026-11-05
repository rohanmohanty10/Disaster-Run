  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local wrap = coroutine.wrap;
local TweenService = game:GetService("TweenService");
local Angles = CFrame.Angles;
local rad = math.rad;

local function tweendeb(p2, p3) -- Line: 6
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

return function(u4, p5) -- Line: 13
    -- upvalues: u1 (copy), Angles (copy), wrap (copy), TweenService (copy), rad (copy)
    local CFrame2 = p5.HumanoidRootPart.CFrame;
    local Dawn = u1.Dawn;
    local dawnspike = Dawn.dawnspike;
    local dawnexplode = Dawn.dawnexplode;
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://902204346";
    Sound.Volume = 5;

    for i = 1, 3 do
        local u6 = dawnspike:Clone();
        u6.Color = u4.Color;
        u6.CFrame = CFrame2 * CFrame.new(0, -3, -i * 8) * Angles(-1.5707963267948966, 0, 0);
        local u7 = Sound:Clone();
        u7.SoundId = "rbxassetid://5868574236";
        u7.Parent = u6;
        local u8 = Sound:Clone();
        u8.Volume = 10;
        u8.Parent = u6;
        u6.Parent = workspace.Effects;
        wrap(function() -- Line: 31
            -- upvalues: TweenService (ref), u6 (copy), u4 (copy), u8 (copy), u7 (copy)
            local v9 = TweenService:Create(u6, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Transparency = 1,
                Size = u4.SpikeSize
            });
            u8:Play();
            u7:Play();
            local v10 = u6;
            v9:Play();
            v9.Completed:Wait();

            if v10 then
                v10:Destroy();
            end;

            u6:Destroy();
        end)();
        wait(0.3);
    end;

    local v11 = dawnexplode:Clone();
    local Core = v11.Core;
    Core.CFrame = CFrame2 * CFrame.new(0, -3, -34);
    local v12 = Sound:Clone();
    v12.SoundId = "rbxassetid://5801257793";
    v12.Parent = Core;
    v11.Parent = workspace.Effects;
    local u13 = false;
    wrap(function() -- Line: 48
        -- upvalues: u13 (ref), Core (copy), Angles (ref), rad (ref)
        while not u13 do
            local v14 = Core;
            v14.CFrame = v14.CFrame * Angles(0, rad(10 + 10 * wait()), 0);
        end;
    end)();

    for i, child in ipairs(v11:GetChildren()) do
        if child:IsA("BasePart") then
            local v15 = TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                Transparency = 1,
                Size = child.Size * u4.BallScale
            });
            v12:Play();
            v15:Play();

            if i == 3 then
                v15.Completed:Wait();
                v11:Destroy();
                u13 = true;
            end;
        end;
    end;
end;