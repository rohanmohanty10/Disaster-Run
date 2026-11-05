  

 

return function(p1) -- Line: 1
    local Parent = script.Parent;
    local Party = Parent.Parent.Parent.Parent:FindFirstChild("Gameplay"):FindFirstChild("Party");
    Parent.MouseButton1Click:Connect(function() -- Line: 5
        -- upvalues: Party (copy)
        local v2 = Party:GetAttribute("CanToggle");

        if v2 == nil then
            return;
        end;

        if not Party.Visible or v2 ~= true then
            if not Party.Visible and v2 == true then
                Party.Visible = true;
                Party:SetAttribute("ForcedState", false);
            end;

            return;
        end;

        Party.Visible = false;
        Party:SetAttribute("ForcedState", true);
    end);
end;