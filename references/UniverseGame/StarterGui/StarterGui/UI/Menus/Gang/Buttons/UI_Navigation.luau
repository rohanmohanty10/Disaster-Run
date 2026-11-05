  

 

return function(u1) -- Line: 1
    for _, descendant in pairs(script.Parent:GetDescendants()) do
        if descendant:IsA("TextButton") and descendant:GetAttribute("Tab") then
            descendant.MouseButton1Down:Connect(function() -- Line: 4
                -- upvalues: descendant (copy), u1 (copy)
                local _ = descendant:GetAttribute("Tab") == "";

                if not descendant:GetAttribute("PaidRandomItem") or u1.CanBuyPaidRandomItems then
                    u1:PlaySound("Click");
                end;
            end);
        end;
    end;
end;