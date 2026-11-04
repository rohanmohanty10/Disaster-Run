 
 

local Highlight = Instance.new("Highlight");
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
Highlight.OutlineColor = Color3.new(1, 1, 1);
Highlight.OutlineTransparency = 0;
Highlight.FillColor = Color3.fromRGB(82, 255, 111);
Highlight.FillTransparency = 0.5;
Highlight.Name = script.Name;
Highlight.Parent = script.Parent;
script:Destroy();