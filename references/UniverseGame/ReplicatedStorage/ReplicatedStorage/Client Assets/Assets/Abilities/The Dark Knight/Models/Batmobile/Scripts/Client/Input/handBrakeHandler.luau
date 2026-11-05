  

 

local Constants = require(script.Parent.Parent.Parent.Constants);
local Inputs = script.Parent.Parent.Parent.Parent.Inputs;

return function(p1, p2) -- Line: 6, Name: handBrakeHandler
    -- upvalues: Inputs (copy), Constants (copy)
    if p2 == Enum.UserInputState.Begin then
        Inputs:SetAttribute(Constants.HAND_BRAKE_INPUT_ATTRIBUTE, true);

        return;
    end;

    Inputs:SetAttribute(Constants.HAND_BRAKE_INPUT_ATTRIBUTE, false);
end;