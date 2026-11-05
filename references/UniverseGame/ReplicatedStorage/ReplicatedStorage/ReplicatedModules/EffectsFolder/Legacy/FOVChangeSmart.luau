  

 

local TweenService = game:GetService("TweenService");

return function(u1, u2, u3, u4) -- Line: 2
    -- upvalues: TweenService (copy)
    if u2 == nil then
        u2 = game.Players.LocalPlayer.Settings.FieldOfView.Value;
    end;

    coroutine.wrap(function() -- Line: 4
        -- upvalues: TweenService (ref), u3 (copy), u1 (copy), u4 (copy), u2 (ref)
        local v5 = TweenService:Create(workspace.CurrentCamera, TweenInfo.new(u3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            FieldOfView = u1
        });
        v5:Play();
        v5.Completed:Connect(function() -- Line: 7
            -- upvalues: TweenService (ref), u4 (ref), u2 (ref)
            TweenService:Create(workspace.CurrentCamera, TweenInfo.new(u4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                FieldOfView = u2
            }):Play();
        end);
    end)();
end;