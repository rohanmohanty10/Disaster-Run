  

 

local TweenService = game:GetService("TweenService");

local function tweendeb(p1, p2) -- Line: 2
    p1:Play();
    p1.Completed:Wait();

    if p2 then
        p2:Destroy();
    end;

    return true;
end;

return function(p3, p4, p5) -- Line: 9
    -- upvalues: TweenService (copy)
    local v6 = game.ReplicatedStorage["Client Assets"].Umbra.slash:Clone();
    v6.CFrame = p3.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0) * p4;
    v6.Parent = workspace.Effects;
    local v7 = TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
        Transparency = 1,
        Size = v6.Size * 1.5,
        CFrame = v6.CFrame * p5
    });
    v7:Play();
    v7.Completed:Wait();

    if v6 then
        v6:Destroy();
    end;
end;