 
 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p1: userdata, p2, p3, p4: number?, p5: any, p6: number?) -- Line: 4
    -- upvalues: TweenService (copy), Debris (copy)
    local v7 = p4 or 1;
    local Highlight = Instance.new("Highlight");
    Highlight.Adornee = p1;
    Highlight.DepthMode = p5 or Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = p2 or Color3.new(1, 1, 1);
    Highlight.OutlineColor = p3 or Color3.new(1, 1, 1);
    Highlight.FillTransparency = p6 or 0;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = p1;
    TweenService:Create(Highlight, TweenInfo.new(v7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    Debris:AddItem(Highlight, v7);

    return Highlight;
end;