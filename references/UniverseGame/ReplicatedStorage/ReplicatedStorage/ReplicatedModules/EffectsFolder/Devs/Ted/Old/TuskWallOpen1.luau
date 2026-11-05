  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 2
    -- upvalues: TweenService (copy)
    local v2 = workspace.Effects:FindFirstChild("FrontWall_" .. p1.Name);

    if v2 then
        TweenService:Create(v2.Left, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v2.Left.CFrame * CFrame.new(-1, 0, 0)
        }):Play();
        TweenService:Create(v2.Right, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v2.Right.CFrame * CFrame.new(-1, 0, 0)
        }):Play();
    end;
end;