  

 

return function(u1) -- Line: 1
    for _, descendant in pairs(script.Parent:GetDescendants()) do
        if descendant:IsA("TextButton") and descendant:GetAttribute("Tab") then
            descendant.MouseButton1Down:Connect(function() -- Line: 4
                -- upvalues: descendant (copy), u1 (copy)
                local v2 = descendant:GetAttribute("Tab");

                if v2 == "" then
                    v2 = nil;
                end;

                if not descendant:GetAttribute("PaidRandomItem") or u1.CanBuyPaidRandomItems then
                    u1:PlaySound("Click");
                    u1:SetShopTab(v2);
                end;
            end);
        end;
    end;
end;