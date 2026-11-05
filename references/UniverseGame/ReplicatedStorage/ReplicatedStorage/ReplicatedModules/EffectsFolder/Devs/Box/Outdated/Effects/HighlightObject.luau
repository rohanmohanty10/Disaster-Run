  

 

local TweenService = game:GetService("TweenService");
game:GetService("Debris");

return function(p1, p2) -- Line: 4
    -- upvalues: TweenService (copy)
    if not p2.DepthMode then
        local _ = Enum.HighlightDepthMode.Occluded;
    end;

    local v3 = p2.FillTransparency or 0;
    local v4 = p2.FillColor or Color3.fromRGB(255, 255, 255);
    local v5 = p2.OutlineColor or Color3.fromRGB(255, 255, 255);
    local v6 = p2.OutlineTransparency or 0;
    local v7 = p2.Lifetime or 1;
    local v8 = p2.Name or "CustomHighlight";
    local v9 = p1:FindFirstChild(v8);

    if v9 and p2.Override then
        v9:Destroy();
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = v3;
    Highlight.FillColor = v4;
    Highlight.OutlineColor = v5;
    Highlight.OutlineTransparency = v6;
    Highlight.Name = v8;
    Highlight.Parent = p1;

    if p2.Adornee then
        Highlight.Parent = workspace.Effects;
        Highlight.Adornee = p2.Adornee;
    end;

    task.delay(v7 + 0.25, Highlight.Destroy, Highlight);

    if p2.Tween then
        local v10 = Enum.EasingStyle[p2.Style or "Linear"];
        local v11 = Enum.EasingDirection[p2.Direction or "Out"];
        TweenService:Create(Highlight, TweenInfo.new(v7, v10, v11), {
            OutlineTransparency = p2.Reverse and 0 or 1
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(v7, v10, v11), {
            FillTransparency = p2.Reverse and 0 or 1
        }):Play();
    end;
end;