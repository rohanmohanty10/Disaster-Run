  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    local _ = game.ReplicatedStorage["Client Assets"]["Star Platinum"].Rock;
    local v2 = game.ReplicatedStorage["Client Assets"]["Star Platinum"].RingWave:Clone();
    local v3 = game.ReplicatedStorage["Client Assets"]["Star Platinum"].SpikeyWave:Clone();
    v2.CFrame = p1.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, -7);
    v2.Orientation = Vector3.new(-85.31, 180, 180);
    v2.Parent = p1.Character;
    v3.CFrame = p1.Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.2, -7);
    v3.Orientation = Vector3.new(-85.31, 180, 180);
    v3.Parent = p1.Character;
    TweenService:Create(v3, TweenInfo.new(0.5), {
        Size = Vector3.new(17.810999, 23.403, 1.503),
        Transparency = 1
    }):Play();
    TweenService:Create(v2, TweenInfo.new(0.5), {
        Size = Vector3.new(15.320999, 15.185999, 1.503),
        Transparency = 1
    }):Play();
end;