  

 

return function(u1) -- Line: 1
    for _, child in pairs(script.Parent:GetChildren()) do
        if child:IsA("TextButton") and child:GetAttribute("Tab") then
            child.MouseButton1Down:Connect(function() -- Line: 4
                -- upvalues: child (copy), u1 (copy)
                local v2 = child:GetAttribute("Tab");

                if v2 == "" then
                    v2 = nil;
                end;

                u1:PlaySound("Click");
                u1:SetSettingsTab(v2);
            end);
        end;
    end;
end;