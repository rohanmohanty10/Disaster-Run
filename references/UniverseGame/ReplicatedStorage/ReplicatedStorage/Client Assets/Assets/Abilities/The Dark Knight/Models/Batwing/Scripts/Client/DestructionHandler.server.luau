  

 

script:WaitForChild("Bindable").Event:Connect(function(p1, u2) -- Line: 3
    p1.AncestryChanged:Connect(function(p3, p4) -- Line: 4
        -- upvalues: u2 (copy)
        if not p4 then
            u2();
            script:Destroy();
        end;
    end);
end);