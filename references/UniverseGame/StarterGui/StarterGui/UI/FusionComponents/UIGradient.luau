  

 

local ClientLibrary = game:GetService("ReplicatedStorage").ClientLibrary;
local Fusion = require(ClientLibrary.Fusion);

return function(p1) -- Line: 5
    -- upvalues: Fusion (copy)
    local v2 = p1 or {};

    return Fusion.New("UIGradient")({
        Enabled = true,
        Rotation = 90,
        Parent = v2.Parent,
        Color = v2.Color or ColorSequence.new(Color3.fromRGB(175, 175, 255), Color3.fromRGB(70, 150, 255))
    });
end;