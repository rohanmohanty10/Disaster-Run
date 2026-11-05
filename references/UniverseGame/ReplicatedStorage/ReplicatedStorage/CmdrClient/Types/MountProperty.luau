  

 

return function(p1) -- Line: 1
    p1:RegisterType("mountproperty", p1.Cmdr.Util.MakeEnumType(
        "MountProperty",
        { "MaxSpeed", "BackwardMaxSpeed", "RotationalAcceleration", "MotionalAcceleration", "MotionalDeceleration", "HoverHeight" }
    ));
end;