  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 3
    -- upvalues: TweenService (copy)
    workspace.CurrentCamera.FieldOfView = p1.FieldOfView;
    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(p1.Time or 0.5, p1.EasingStyle or Enum.EasingStyle.Quad, p1.EasingDirection or Enum.EasingDirection.Out), {
        FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
    }):Play();
end;