  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 3
    -- upvalues: TweenService (copy)
    local _CFrame = p2._CFrame;
    local Duration = p2.Duration;
    local v3 = p1:Clone();
    v3.Anchored = true;
    v3.Transparency = 1;
    v3.CFrame = _CFrame;
    v3.Parent = workspace.Effects;
    game.Debris:AddItem(v3, Duration);
    TweenService:Create(v3, TweenInfo.new(0.25), {
        Transparency = 0
    }):Play();
end;