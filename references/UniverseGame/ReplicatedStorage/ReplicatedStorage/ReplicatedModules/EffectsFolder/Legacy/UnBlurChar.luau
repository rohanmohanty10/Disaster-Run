  

 

return function(p1) -- Line: 1
    for _, descendant in pairs(p1.Character:GetDescendants()) do
        if descendant.Name:match("blur") then
            descendant:Destroy();
        end;
    end;
end;