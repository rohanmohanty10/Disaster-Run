  

 

local Parent = script.Parent.Parent.Parent.Parent;
local u1 = {
    Parent.Suspension.WheelFRSuspension,
    Parent.Suspension.WheelFLSuspension,
    Parent.Suspension.WheelRRSuspension,
    Parent.Suspension.WheelRLSuspension
};

return function() -- Line: 11, Name: getSuspensionLength
    -- upvalues: u1 (copy)
    local v2 = 0;

    for _, v in u1 do
        v2 = v2 + v.CurrentLength;
    end;

    return v2;
end;