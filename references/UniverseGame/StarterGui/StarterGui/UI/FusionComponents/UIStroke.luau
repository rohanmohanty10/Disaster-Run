  

 

local ClientLibrary = game:GetService("ReplicatedStorage").ClientLibrary;
local Fusion = require(ClientLibrary.Fusion);
local Children = Fusion.Children;
local New = Fusion.New;
local _ = Fusion.OnEvent;

return function(p1, p2) -- Line: 8
    -- upvalues: New (copy), Children (copy)
    local UIGradient = p1.FusionComponents.UIGradient;

    return New("UIStroke")({
        ApplyStrokeMode = "Border",
        Color = Color3.new(1, 1, 1),
        Thickness = 2,
        Transparency = 0,
        [Children] = { UIGradient({
                Color = (p2 or {}).Color
            }) }
    });
end;