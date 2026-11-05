  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");

local function tweendeb(p2, p3) -- Line: 3
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

local Sound = Instance.new("Sound");

local function createsound(p4, p5) -- Line: 10
    -- upvalues: Sound (copy)
    local v6 = Sound:Clone();

    for i, v in pairs(p5) do
        v6[i] = v;
    end;

    v6.SoundId = "rbxassetid://" .. p4;

    return v6;
end;

local rad = math.rad;

return function(p7, p8, p9) -- Line: 19
    -- upvalues: u1 (copy), rad (copy), TweenService (copy), Sound (copy)
    local v10;

    if u1:FindFirstChild(p7.StandName) then
        v10 = u1[p7.StandName];
    else
        v10 = u1["Star Platinum Requiem"];
    end;

    local u11 = v10.spr2:Clone();
    u11.CFrame = p8.CFrame;
    u11.Color = p7.StartColor;
    u11.Parent = workspace.Effects;
    local u12 = nil;
    local u13 = nil;
    coroutine.wrap(function() -- Line: 32
        -- upvalues: u12 (ref), u11 (ref), rad (ref)
        while not u12 do
            local v14 = u11;
            v14.CFrame = v14.CFrame * CFrame.Angles(0, rad(20 + wait()), 0);
        end;
    end)();
    local v15 = TweenService:Create(u11, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
        Transparency = 0,
        Size = Vector3.new()
    });
    local v16 = u11;
    v15:Play();
    v15.Completed:Wait();

    if v16 then
        v16:Destroy();
    end;

    u12 = true;
    u11 = v10.spr2:Clone();
    u11.Color = p7.EndColor;
    u11.Position = p9.Position;
    u11.Parent = workspace.Effects;
    local v17 = Sound:Clone();

    for i, v in pairs({
        Volume = 3,
        PlayOnRemove = true,
        Parent = p8
    }) do
        v17[i] = v;
    end;

    v17.SoundId = "rbxassetid://rbxassetid://2235267442";
    v17:Destroy();
    coroutine.wrap(function() -- Line: 44
        -- upvalues: u13 (ref), u11 (ref), rad (ref)
        while not u13 do
            local v18 = u11;
            v18.CFrame = v18.CFrame * CFrame.Angles(0, rad(20 + wait()), 0);
        end;
    end)();
    local v19 = TweenService:Create(u11, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
        Transparency = 0,
        Size = u11.Size * 2
    });
    local v20 = u11;
    v19:Play();
    v19.Completed:Wait();

    if v20 then
        v20:Destroy();
    end;

    u13 = true;
end;