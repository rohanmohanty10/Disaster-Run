  

 

return function(p1) -- Line: 1
    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(131, 48, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    Highlight.Parent = p1;

    while p1.Parent and p1:GetAttribute("OutlineEnabled") do
        task.wait(0.1);
    end;

    if Highlight then
        Highlight:Destroy();
    end;
end;