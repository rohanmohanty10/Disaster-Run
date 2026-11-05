  

 

return function(u1) -- Line: 1
    local Parent = script.Parent.Parent;
    script.Parent.MouseButton1Down:Connect(function() -- Line: 3
        -- upvalues: Parent (copy), u1 (copy)
        Parent.Visible = false;
        u1:PlaySound("Click");
    end);
end;