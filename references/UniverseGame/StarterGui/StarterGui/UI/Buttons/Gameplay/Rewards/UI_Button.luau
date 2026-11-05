  

 

return function(u1) -- Line: 1
    script.Parent.MouseButton1Click:Connect(function() -- Line: 4
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
        u1:SetMenu("Rewards");
    end);
end;