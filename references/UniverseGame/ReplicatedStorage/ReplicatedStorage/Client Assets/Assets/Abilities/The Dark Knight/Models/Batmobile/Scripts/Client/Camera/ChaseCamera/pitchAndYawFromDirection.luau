  

 

return function(p1) -- Line: 1, Name: pitchAndYawFromDirection
    local Unit = p1.Unit;

    return math.asin(Unit.Y), math.atan2(-Unit.Z, Unit.X) - 1.5707963267948966;
end;