  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");

return function(u1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), TweenService (copy)
    coroutine.wrap(function() -- Line: 5
        -- upvalues: ReplicatedStorage (ref), u1 (copy), TweenService (ref)
        local v2 = ReplicatedStorage["Client Assets"]["The World"].Joestar:Clone();
        v2.Parent = u1.Torso;
        TweenService:Create(v2.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(v2, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1.25, 0, 1.25, 0)
        }):Play();
        TweenService:Create(v2.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Rotation = -50
        }):Play();
        wait(0.4);
        v2:Destroy();
    end)();
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.FillTransparency = 1;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = u1;
    TweenService:Create(Highlight, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FillTransparency = 0,
        OutlineTransparency = 0
    }):Play();
    task.wait(0.5);
    TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.wait(0.2);
    Highlight:Destroy();
end;