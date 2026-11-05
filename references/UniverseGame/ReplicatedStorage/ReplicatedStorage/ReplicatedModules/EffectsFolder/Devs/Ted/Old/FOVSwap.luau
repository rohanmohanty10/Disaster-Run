  

 

local TweenService = game:GetService("TweenService");
local CurrentCamera = workspace.CurrentCamera;

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: TweenService (copy), CurrentCamera (copy)
    local v5 = p4 or {};
    local v6 = v5.EasingStyle or Enum.EasingStyle.Linear;
    local v7 = v5.EasingDirection or Enum.EasingDirection.Out;
    local v8 = v5.WaitTime or p2;
    TweenService:Create(CurrentCamera, TweenInfo.new(p2, v6, v7), {
        FieldOfView = p1
    }):Play();
    task.wait(v8);
    TweenService:Create(CurrentCamera, TweenInfo.new(p3, v6, v7), {
        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
    }):Play();
end;