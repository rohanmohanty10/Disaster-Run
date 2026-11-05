  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function(p2) -- Line: 5
    -- upvalues: u1 (copy), LocalPlayer (copy), TweenService (copy)
    local v3 = u1.BlackScreen:Clone();
    v3.Parent = LocalPlayer.PlayerGui;
    local BlackScreen = v3.BlackScreen;
    TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
        BackgroundTransparency = 0
    }):Play();
    task.wait(p2);
    TweenService:Create(BlackScreen, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play();
end;