  

 

local ClientAssets = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts).ClientAssets;
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p1, p2) -- Line: 9
    -- upvalues: ClientAssets (copy), LocalPlayer (copy), TweenService (copy)
    local v3 = p1 or 0.2;
    local v4 = ClientAssets.BlackScreen:Clone();
    local BlackScreen = v4.BlackScreen;
    v4.Parent = LocalPlayer.PlayerGui;
    local v5 = TweenService:Create(BlackScreen, TweenInfo.new(v3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    });
    v5:Play();
    v5.Completed:Wait();
    local v6 = TweenService:Create(BlackScreen, TweenInfo.new(v3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, p2 or 0), {
        BackgroundTransparency = 1
    });
    v6:Play();
    v6.Completed:Wait();
    v4:Destroy();
end;