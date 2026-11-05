  

 

return function(p1, p2) -- Line: 1, Name: setCharacterVisible
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.LocalTransparencyModifier = p2 and 0 or 1;
        end;
    end;
end;