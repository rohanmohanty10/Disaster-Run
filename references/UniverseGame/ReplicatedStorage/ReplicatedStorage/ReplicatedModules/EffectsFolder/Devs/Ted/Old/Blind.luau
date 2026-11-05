  

 

local LocalPlayer = game.Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: LocalPlayer (copy), TweenService (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.Parent = LocalPlayer.PlayerGui.Core;
    Frame.ZIndex = 2000;
    Frame.BackgroundTransparency = 1;
    Frame.BackgroundColor3 = Color3.new(1, 1, 1);
    TweenService:Create(Frame, TweenInfo.new(0.2), {
        BackgroundTransparency = 0
    }):Play();
    task.delay(p1, function() -- Line: 12
        -- upvalues: TweenService (ref), Frame (copy)
        TweenService:Create(Frame, TweenInfo.new(0.2), {
            BackgroundTransparency = 1
        }):Play();
        task.wait(0.2);
        Frame:Destroy();
    end);
end;