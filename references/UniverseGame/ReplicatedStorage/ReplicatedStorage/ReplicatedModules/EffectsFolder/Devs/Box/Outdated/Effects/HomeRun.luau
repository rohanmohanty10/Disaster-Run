  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");

return function(p2) -- Line: 4
    -- upvalues: u1 (copy), Debris (copy), TweenService (copy)
    local v3 = u1.zaihop.HomeRun:Clone();
    v3.Parent = p2.PlayerGui;
    Debris:AddItem(v3, 3.75);
    local HomeRunIcon = v3.HomeRunIcon;
    TweenService:Create(HomeRunIcon, TweenInfo.new(1), {
        Position = UDim2.new(0.391, 0, 0.022, 0)
    }):Play();
    TweenService:Create(HomeRunIcon, TweenInfo.new(1), {
        Size = UDim2.new(0.218, 0, 0.264, 0)
    }):Play();
    wait(2.5);
    TweenService:Create(HomeRunIcon, TweenInfo.new(1), {
        Position = UDim2.new(0.348, 0, 0.021, 0)
    }):Play();
    TweenService:Create(HomeRunIcon, TweenInfo.new(1), {
        Size = UDim2.new(0.304, 0, 0.367, 0)
    }):Play();
    TweenService:Create(HomeRunIcon, TweenInfo.new(0.5), {
        ImageTransparency = 1
    }):Play();
end;