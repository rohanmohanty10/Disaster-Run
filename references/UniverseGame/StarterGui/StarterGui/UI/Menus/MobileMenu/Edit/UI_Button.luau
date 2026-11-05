  

 

return function(u1) -- Line: 1
    script.Parent.MouseButton1Down:Connect(function() -- Line: 2
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
        u1.ToggleMobileEdit(true);
        u1:SetMenu(nil);
    end);
end;