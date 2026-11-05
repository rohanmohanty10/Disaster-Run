  

 

local TweenService = game:GetService("TweenService");

return function(u1) -- Line: 3
    -- upvalues: TweenService (copy)
    if type(u1) == "string" then
        local v2 = string.split(u1, "::");
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(tonumber(v2[2]), Enum.EasingStyle[v2[3]], Enum.EasingDirection[v2[4]]), {
            FieldOfView = tonumber(v2[1])
        }):Play();

        return;
    end;

    local FieldOfView = workspace.CurrentCamera.FieldOfView;
    TweenService:Create(workspace.CurrentCamera, TweenInfo.new(u1.Time / 2 or 0.5, u1.EasingStyle or Enum.EasingStyle.Quad, u1.EasingDirection or Enum.EasingDirection.Out), {
        FieldOfView = u1.FOV or 70
    }):Play();
    task.delay(u1.Time / 2 or 0.5, function() -- Line: 11
        -- upvalues: TweenService (ref), u1 (copy), FieldOfView (copy)
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(u1.Time / 2 or 0.5, u1.EasingStyle or Enum.EasingStyle.Quad, u1.EasingDirection or Enum.EasingDirection.Out), {
            FieldOfView = FieldOfView
        }):Play();
    end);
end;