 

 

local DaggerConfig = require(script.Parent.DaggerConfig);

return table.freeze({
    c0 = function(p1) -- Line: 4, Name: c0
        -- upvalues: DaggerConfig (copy)
        local v2 = p1:GetAttribute("GripC0") or CFrame.identity;
        local Attribute = p1:GetAttribute("GripInwardStuds");
        local v3 = type(Attribute) ~= "number" and (DaggerConfig.GripInwardStuds or 0) or Attribute;

        return CFrame.new(-math.clamp(v3, -1, 1), 0, 0) * v2;
    end
});