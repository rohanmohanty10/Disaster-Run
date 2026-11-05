  

 

return function(p1) -- Line: 1
    local TweenService = game:GetService("TweenService");
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 0;
    BlurEffect.Enabled = true;
    BlurEffect.Parent = workspace.Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(p1.Transition or 1, Enum.EasingStyle.Linear), {
        Size = p1.BlurSize or 24
    }):Play();
    task.delay(p1.Time, function() -- Line: 8
        -- upvalues: TweenService (copy), BlurEffect (copy)
        local v2 = TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            Size = 0
        });
        v2.Completed:Connect(function() -- Line: 10
            -- upvalues: BlurEffect (ref)
            BlurEffect:Destroy();
        end);
        v2:Play();
    end);
end;