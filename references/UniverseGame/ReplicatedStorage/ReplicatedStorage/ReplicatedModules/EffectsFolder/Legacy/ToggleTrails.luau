  

 

return function(p1, p2) -- Line: 1
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = p2;
        end;
    end;
end;