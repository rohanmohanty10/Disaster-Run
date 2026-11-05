  

 

return function(u1) -- Line: 1
    script.Parent.MouseButton1Down:Connect(function() -- Line: 2
        -- upvalues: u1 (copy)
        u1:SetMenu(nil);
        script.Parent.Parent.Visible = false;
        u1:PlaySound("Click");
    end);
end;