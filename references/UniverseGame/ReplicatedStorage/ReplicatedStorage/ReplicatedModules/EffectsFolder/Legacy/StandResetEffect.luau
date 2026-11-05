  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 7
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), TweenService (copy)
    local v1 = ReplicatedStorage["Client Assets"].StandResetEffect:Clone();
    game.Debris:AddItem(v1, 10);
    v1.Parent = LocalPlayer.PlayerGui;
    TweenService:Create(v1.Image1, TweenInfo.new(2, Enum.EasingStyle.Cubic), {
        ImageTransparency = 0,
        Position = UDim2.new(0.355, 0, 0.2, 0)
    }):Play();
    wait(2);
    TweenService:Create(v1.Image1, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(v1.Image2, TweenInfo.new(1, Enum.EasingStyle.Cubic), {
        ImageTransparency = 0
    }):Play();
end;