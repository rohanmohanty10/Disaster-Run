  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");

return function() -- Line: 6
    -- upvalues: LocalPlayer (copy), TweenService (copy)
    local v1 = LocalPlayer.PlayerGui.WhiteScreen:Clone();
    v1.Parent = LocalPlayer.PlayerGui;
    v1.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    v1.Frame.BackgroundTransparency = 0;
    game.Debris:AddItem(v1, 0.5);
    wait(0.05);
    TweenService:Create(v1.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
end;