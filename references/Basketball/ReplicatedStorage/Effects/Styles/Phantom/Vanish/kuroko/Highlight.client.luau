 
 

local Highlight = Instance.new("Highlight");
Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
Highlight.FillColor = Color3.new(1, 0, 0);
Highlight.FillTransparency = 1;
Highlight.OutlineColor = Color3.new(0, 0, 0);
Highlight.OutlineTransparency = 0.4;
Highlight.Name = script.Name;
Highlight.Parent = script.Parent;
script:Destroy();