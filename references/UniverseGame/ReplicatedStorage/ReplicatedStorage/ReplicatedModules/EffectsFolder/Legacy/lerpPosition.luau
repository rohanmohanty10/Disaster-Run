  

 

return function(p1, p2, p3) -- Line: 1
    return Vector3.new(p1.X + (p2.X - p1.X) * p3, p1.Y + (p2.Y - p1.Y) * p3, p1.Z + (p2.Z - p1.Z) * p3);
end;