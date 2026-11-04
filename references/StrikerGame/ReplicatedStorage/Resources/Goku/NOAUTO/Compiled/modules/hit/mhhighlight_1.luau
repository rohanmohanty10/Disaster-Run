 
 

local HighlightEmit = require(script.Parent.HighlightEmit);

return function(p1) -- Line: 3
    -- upvalues: HighlightEmit (copy)
    HighlightEmit(p1, Color3.fromRGB(74, 0, 0), Color3.fromRGB(74, 0, 0), 0.8, Enum.HighlightDepthMode.Occluded, 0);
end;