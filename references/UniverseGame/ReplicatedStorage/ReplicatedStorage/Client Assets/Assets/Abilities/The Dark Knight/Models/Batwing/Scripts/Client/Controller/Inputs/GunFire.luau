  

 

local Parent = script.Parent.Parent.Parent.Parent.Parent;
local _ = Parent.PrimaryPart;

return {
    Bind = Enum.KeyCode.E,

    Execute = function(p1, p2) -- Line: 8
        -- upvalues: Parent (copy)
        Parent:SetAttribute("GunFire", p2 == Enum.UserInputState.Begin);
    end
};