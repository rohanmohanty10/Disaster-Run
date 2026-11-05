  

 

local TweenService = game:GetService("TweenService");

return function(p1, p2, p3, p4) -- Line: 2
    -- upvalues: TweenService (copy)
    local v5 = p1:Clone();
    v5.Parent = workspace.Effects;
    v5.Anchored = true;
    v5.CanCollide = false;
    v5.CFrame = p2;
    v5.Size = p3;
    local ImageLabel = v5.SurfaceGui.ImageLabel;
    local v6 = TweenService:Create(ImageLabel, TweenInfo.new(0.5), {
        Rotation = 360,
        ImageTransparency = p4
    });
    v6:Play();
    v6.Completed:connect(function() -- Line: 16
        -- upvalues: TweenService (ref), ImageLabel (copy)
        wait(1);
        TweenService:Create(ImageLabel, TweenInfo.new(0.5), {
            ImageTransparency = 1,
            Rotation = -360
        }):Play();
        wait(1);
    end);
end;