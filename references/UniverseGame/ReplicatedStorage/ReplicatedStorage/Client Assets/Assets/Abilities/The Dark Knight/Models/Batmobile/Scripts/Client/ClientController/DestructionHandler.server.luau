  

 

script.BindToCar.Event:Connect(function(u1, u2) -- Line: 6
    u1.AncestryChanged:Connect(function() -- Line: 9
        -- upvalues: u1 (copy), u2 (copy)
        if not u1:IsDescendantOf(game) then
            u2();
            script:Destroy();
        end;
    end);
end);