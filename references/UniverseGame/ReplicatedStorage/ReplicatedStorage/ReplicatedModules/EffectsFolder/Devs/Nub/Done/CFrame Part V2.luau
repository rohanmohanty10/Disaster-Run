  

 

return function(p1) -- Line: 1
    if not (p1.Part and p1.Part:IsDescendantOf(workspace)) then
        return;
    end;

    if not (p1.CFrame or p1.RelativePart and p1.RelativePart:IsDescendantOf(workspace)) then
        return;
    end;

    local v2 = p1.CFrame or p1.RelativePart.CFrame;

    if p1.Offset then
        v2 = v2 * p1.Offset;
    end;

    p1.Part.CFrame = v2;
end;