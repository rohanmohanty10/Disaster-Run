  

 

local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 2
    -- upvalues: TweenService (copy)
    local Character = p1.Character;
    local v2 = p1.Color or Color3.new(1, 1, 1);
    local v3 = p1.Time or 0.5;
    local v4 = p1.Reverses or false;
    local v5 = p1.AlwaysOnTop or false;
    local v6 = p1.StartTransparency or 0;
    local v7 = p1.EndTransparency or 1;
    local Highlight = Instance.new("Highlight");
    Highlight.Parent = Character;
    Highlight.FillColor = v2;
    Highlight.OutlineColor = v2;
    Highlight.OutlineTransparency = v6;
    Highlight.FillTransparency = v6;
    Highlight.DepthMode = Enum.HighlightDepthMode[v5 and "AlwaysOnTop" or "Occluded"];
    TweenService:Create(Highlight, TweenInfo.new(v3 / 1.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, v4), {
        FillTransparency = v7
    }):Play();
    TweenService:Create(Highlight, TweenInfo.new(v3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, v4), {
        OutlineTransparency = v7
    }):Play();
    task.delay(v3 * (v4 and 2 or 1), Highlight.Destroy, Highlight);
end;