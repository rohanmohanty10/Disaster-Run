  

 

return function(p1, p2) -- Line: 1
    for _, child in pairs(p2:GetChildren()) do
        if child:IsA("BasePart") then
            local v3 = p2.Stand.Hand1.Heal:Clone();
            v3.Parent = child;
            v3:Emit(1);
            game.Debris:AddItem(v3, 0.5);
        end;
    end;
end;