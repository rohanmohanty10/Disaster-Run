  

 

local Parent = script.Parent.Parent.Parent.Parent;
local Chassis = Parent.Chassis;
local u1 = {
    Parent.Wheels.WheelFR.Wheel,
    Parent.Wheels.WheelFL.Wheel,
    Parent.Wheels.WheelRR.Wheel,
    Parent.Wheels.WheelRL.Wheel
};

return function() -- Line: 13, Name: getAverageWheelSlip
    -- upvalues: Chassis (copy), u1 (copy)
    local UpVector = Chassis.CFrame.UpVector;
    local v2 = 0;

    for _, v in u1 do
        local AssemblyAngularVelocity = v.AssemblyAngularVelocity;
        local AssemblyLinearVelocity = v.AssemblyLinearVelocity;

        if AssemblyAngularVelocity.Magnitude == 0 then
            v2 = v2 + AssemblyLinearVelocity.Magnitude;
        else
            local v3 = v.Size.Y / 2 * AssemblyAngularVelocity.Magnitude;
            v2 = v2 + (AssemblyAngularVelocity.Unit:Cross(UpVector) * v3 - AssemblyLinearVelocity).Magnitude;
        end;
    end;

    return v2 / #u1;
end;