  

 

local TweenService = game:GetService("TweenService");

return function(p1, u2, p3) -- Line: 2
    -- upvalues: TweenService (copy)
    local u4 = p3 or workspace.Camera.FieldOfView;
    local v5 = TweenService:Create(workspace.Camera, TweenInfo.new(u2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        FieldOfView = u4 * p1
    });
    v5:Play();
    v5.Completed:connect(function() -- Line: 7
        -- upvalues: TweenService (ref), u2 (copy), u4 (copy)
        TweenService:Create(workspace.Camera, TweenInfo.new(u2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = u4
        }):Play();
    end);
end;