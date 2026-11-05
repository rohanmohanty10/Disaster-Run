  

 

return function(u1) -- Line: 1
    script.Parent.MouseButton1Down:Connect(function() -- Line: 3
        -- upvalues: u1 (copy)
        u1:SetQuotesVisible(not u1.UI.Gameplay.Quotes.Visible);
        u1:PlaySound("Click");
    end);
end;